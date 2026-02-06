/**
 * Earn Overhaul Data Migration
 *
 * This migration script handles:
 * 1. Creating clients from existing brandId references in earnThreads
 * 2. Updating earnThreads with clientId (from brandId)
 * 3. Updating earnOpportunities with earningType (defaulting to 'video')
 * 4. Updating engagements with threadId and clientId denormalization
 *
 * Run this migration ONCE after deploying the earn overhaul changes.
 */

import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

const db = admin.firestore();

interface MigrationStats {
  clientsCreated: number;
  threadsUpdated: number;
  opportunitiesUpdated: number;
  engagementsUpdated: number;
  errors: string[];
}

/**
 * Migration function to update existing data for the earn overhaul
 */
export const runEarnOverhaulMigration = functions.https.onRequest(async (req, res) => {
  // Verify admin token
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith('Bearer ')) {
    res.status(401).json({ error: 'Missing authorization header' });
    return;
  }

  const idToken = authHeader.split('Bearer ')[1];
  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const adminDoc = await db.collection('admins').doc(decodedToken.uid).get();
    if (!adminDoc.exists) {
      res.status(403).json({ error: 'Admin access required' });
      return;
    }
  } catch {
    res.status(401).json({ error: 'Invalid token' });
    return;
  }

  const stats: MigrationStats = {
    clientsCreated: 0,
    threadsUpdated: 0,
    opportunitiesUpdated: 0,
    engagementsUpdated: 0,
    errors: [],
  };

  try {
    // Step 1: Collect unique brandIds from earnThreads
    console.log('Step 1: Collecting unique brands from threads...');
    const threadsSnapshot = await db.collection('earnThreads').get();
    const brandMap = new Map<string, { name: string; avatarImage?: string; avatarColor?: string }>();

    for (const doc of threadsSnapshot.docs) {
      const data = doc.data();
      const brandId = data.brandId;
      const brandName = data.brandName;

      if (brandId && !brandMap.has(brandId)) {
        brandMap.set(brandId, {
          name: brandName || 'Unknown Brand',
          avatarImage: data.avatarImage,
          avatarColor: data.avatarColor,
        });
      }
    }

    console.log(`Found ${brandMap.size} unique brands`);

    // Step 2: Create clients for each unique brand
    console.log('Step 2: Creating clients from brands...');
    const brandToClientMap = new Map<string, string>();

    for (const [brandId, brandData] of brandMap) {
      // Check if client already exists with this brandId as legacyBrandId
      const existingClient = await db.collection('clients')
        .where('legacyBrandId', '==', brandId)
        .limit(1)
        .get();

      if (!existingClient.empty) {
        brandToClientMap.set(brandId, existingClient.docs[0].id);
        console.log(`Client already exists for brand ${brandId}`);
        continue;
      }

      // Create new client
      const clientRef = db.collection('clients').doc();
      await clientRef.set({
        id: clientRef.id,
        companyName: brandData.name,
        displayName: brandData.name,
        contactEmail: null,
        contactPhone: null,
        avatarImage: brandData.avatarImage || null,
        avatarColor: brandData.avatarColor || null,
        isActive: true,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        legacyBrandId: brandId, // Track the old brandId
      });

      brandToClientMap.set(brandId, clientRef.id);
      stats.clientsCreated++;
      console.log(`Created client ${clientRef.id} for brand ${brandId}`);
    }

    // Step 3: Update earnThreads with clientId
    console.log('Step 3: Updating earnThreads with clientId...');
    const threadBatch = db.batch();
    let threadBatchCount = 0;

    for (const doc of threadsSnapshot.docs) {
      const data = doc.data();

      // Skip if already has clientId
      if (data.clientId) {
        continue;
      }

      const brandId = data.brandId;
      const clientId = brandToClientMap.get(brandId);

      if (!clientId) {
        stats.errors.push(`No client found for thread ${doc.id} with brandId ${brandId}`);
        continue;
      }

      threadBatch.update(doc.ref, {
        clientId: clientId,
        clientName: data.brandName || 'Unknown',
        clientAvatarImage: data.avatarImage || null,
        clientAvatarColor: data.avatarColor || null,
        // Set title to brandName if not present
        title: data.title || data.brandName || 'Campaign',
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      threadBatchCount++;
      stats.threadsUpdated++;

      // Commit batch every 500 operations
      if (threadBatchCount >= 500) {
        await threadBatch.commit();
        threadBatchCount = 0;
      }
    }

    if (threadBatchCount > 0) {
      await threadBatch.commit();
    }

    // Step 4: Update earnOpportunities with earningType
    console.log('Step 4: Updating earnOpportunities with earningType...');
    const opportunitiesSnapshot = await db.collection('earnOpportunities').get();
    const oppBatch = db.batch();
    let oppBatchCount = 0;

    for (const doc of opportunitiesSnapshot.docs) {
      const data = doc.data();

      // Skip if already has earningType
      if (data.earningType) {
        continue;
      }

      // Determine earningType from mediaType or questions
      let earningType = 'video';
      if (data.questions && data.questions.length > 0) {
        earningType = 'survey';
      } else if (data.mediaType === 'text') {
        earningType = 'survey';
      }

      oppBatch.update(doc.ref, {
        earningType: earningType,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      oppBatchCount++;
      stats.opportunitiesUpdated++;

      if (oppBatchCount >= 500) {
        await oppBatch.commit();
        oppBatchCount = 0;
      }
    }

    if (oppBatchCount > 0) {
      await oppBatch.commit();
    }

    // Step 5: Update engagements with threadId and clientId
    console.log('Step 5: Updating engagements with threadId and clientId...');
    const engagementsSnapshot = await db.collection('engagements').get();

    // Build opportunity to thread/client map
    const oppToThreadMap = new Map<string, { threadId: string; clientId: string }>();
    const updatedOpportunitiesSnapshot = await db.collection('earnOpportunities').get();
    const updatedThreadsSnapshot = await db.collection('earnThreads').get();

    const threadClientMap = new Map<string, string>();
    for (const doc of updatedThreadsSnapshot.docs) {
      const data = doc.data();
      threadClientMap.set(doc.id, data.clientId);
    }

    for (const doc of updatedOpportunitiesSnapshot.docs) {
      const data = doc.data();
      const threadId = data.threadId;
      const clientId = threadClientMap.get(threadId);

      if (threadId && clientId) {
        oppToThreadMap.set(doc.id, { threadId, clientId });
      }
    }

    const engBatch = db.batch();
    let engBatchCount = 0;

    for (const doc of engagementsSnapshot.docs) {
      const data = doc.data();

      // Skip if already has threadId and clientId
      if (data.threadId && data.clientId) {
        continue;
      }

      const oppId = data.earnOpportunityId;
      const mapping = oppToThreadMap.get(oppId);

      if (!mapping) {
        stats.errors.push(`No thread/client mapping for engagement ${doc.id} with opportunity ${oppId}`);
        continue;
      }

      engBatch.update(doc.ref, {
        threadId: mapping.threadId,
        clientId: mapping.clientId,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      engBatchCount++;
      stats.engagementsUpdated++;

      if (engBatchCount >= 500) {
        await engBatch.commit();
        engBatchCount = 0;
      }
    }

    if (engBatchCount > 0) {
      await engBatch.commit();
    }

    console.log('Migration complete!', stats);
    res.status(200).json({
      success: true,
      message: 'Earn overhaul migration completed successfully',
      stats,
    });
  } catch (error) {
    console.error('Migration failed:', error);
    stats.errors.push(String(error));
    res.status(500).json({
      success: false,
      message: 'Migration failed',
      error: String(error),
      stats,
    });
  }
});

/**
 * Rollback function (for emergencies)
 * This restores brandId fields from clientId mappings
 */
export const rollbackEarnOverhaulMigration = functions.https.onRequest(async (req, res) => {
  // Verify admin token
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith('Bearer ')) {
    res.status(401).json({ error: 'Missing authorization header' });
    return;
  }

  const idToken = authHeader.split('Bearer ')[1];
  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const adminDoc = await db.collection('admins').doc(decodedToken.uid).get();
    if (!adminDoc.exists) {
      res.status(403).json({ error: 'Admin access required' });
      return;
    }
  } catch {
    res.status(401).json({ error: 'Invalid token' });
    return;
  }

  // Rollback: restore brandId from client's legacyBrandId
  try {
    const clientsSnapshot = await db.collection('clients').get();
    const clientToBrandMap = new Map<string, string>();

    for (const doc of clientsSnapshot.docs) {
      const data = doc.data();
      if (data.legacyBrandId) {
        clientToBrandMap.set(doc.id, data.legacyBrandId);
      }
    }

    // Update threads
    const threadsSnapshot = await db.collection('earnThreads').get();
    const batch = db.batch();
    let count = 0;

    for (const doc of threadsSnapshot.docs) {
      const data = doc.data();
      const brandId = clientToBrandMap.get(data.clientId);

      if (brandId) {
        batch.update(doc.ref, {
          brandId: brandId,
          brandName: data.clientName,
          avatarImage: data.clientAvatarImage,
          avatarColor: data.clientAvatarColor,
        });
        count++;
      }

      if (count >= 500) {
        await batch.commit();
        count = 0;
      }
    }

    if (count > 0) {
      await batch.commit();
    }

    res.status(200).json({
      success: true,
      message: 'Rollback completed',
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: String(error),
    });
  }
});
