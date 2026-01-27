import { db } from "./db";
import { earnThreads, earnOpportunities, prizePots } from "@shared/schema";

async function seed() {
  console.log("🌱 Starting seed...");

  // Seed Earn Threads (Brand Channels)
  console.log("Creating earn threads...");
  
  const [imalichatThread] = await db.insert(earnThreads).values({
    brandId: "imalichat",
    brandName: "iMaliChat Daily",
    avatarColor: "bg-primary",
    avatarImage: "/assets/iMali_Logo_transp_bg_1765285511027.png",
    isPinned: true,
    isActive: true,
  }).returning();

  const [nikeThread] = await db.insert(earnThreads).values({
    brandId: "nike",
    brandName: "Nike SA",
    avatarColor: "bg-blue-600",
    isPinned: false,
    isActive: true,
  }).returning();

  const [checkersThread] = await db.insert(earnThreads).values({
    brandId: "checkers",
    brandName: "Checkers Sixty60",
    avatarColor: "bg-teal-600",
    isPinned: false,
    isActive: true,
  }).returning();

  const [fnbThread] = await db.insert(earnThreads).values({
    brandId: "fnb",
    brandName: "FNB",
    avatarColor: "bg-cyan-600",
    isPinned: false,
    isActive: true,
  }).returning();

  console.log(`✅ Created ${4} earn threads`);

  // Seed Earn Opportunities
  console.log("Creating earn opportunities...");

  // iMaliChat opportunities
  await db.insert(earnOpportunities).values([
    {
      threadId: imalichatThread.id,
      title: "Daily Trivia Challenge",
      description: "Answer 5 quick trivia questions and win tokens!",
      tokenReward: 10,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 5), // 5 hours
      isActive: true,
    },
    {
      threadId: imalichatThread.id,
      title: "Watch: How iMaliChat Works",
      description: "Watch a short video about earning on iMaliChat",
      tokenReward: 5,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24), // 24 hours
      isActive: true,
    },
    {
      threadId: imalichatThread.id,
      title: "Rate Your Experience",
      description: "Tell us what you think about the app",
      tokenReward: 5,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 48), // 48 hours
      isActive: true,
    },
  ]);

  // Nike opportunities
  await db.insert(earnOpportunities).values([
    {
      threadId: nikeThread.id,
      title: "New Air Max Launch Survey",
      description: "Share your thoughts on the new Air Max collection",
      tokenReward: 10,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 48), // 2 days
      isActive: true,
    },
  ]);

  // Checkers opportunities
  await db.insert(earnOpportunities).values([
    {
      threadId: checkersThread.id,
      title: "Rate Your Recent Delivery",
      description: "How was your Sixty60 delivery experience?",
      tokenReward: 5,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 12), // 12 hours
      isActive: true,
    },
  ]);

  // FNB opportunities
  await db.insert(earnOpportunities).values([
    {
      threadId: fnbThread.id,
      title: "Watch: New Budget Tool Demo",
      description: "Learn about FNB's latest budgeting feature",
      tokenReward: 5,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24), // 24 hours
      isActive: true,
    },
    {
      threadId: fnbThread.id,
      title: "Banking Habits Survey",
      description: "Tell us about your banking preferences",
      tokenReward: 10,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24), // 24 hours
      isActive: true,
    },
  ]);

  console.log(`✅ Created earn opportunities`);

  // Seed Prize Pots
  console.log("Creating prize pots...");

  const today = new Date();
  const dailyPeriod = `daily_${today.toISOString().split('T')[0]}`;
  
  // Get week number
  const startOfYear = new Date(today.getFullYear(), 0, 1);
  const pastDaysOfYear = (today.getTime() - startOfYear.getTime()) / 86400000;
  const weekNumber = Math.ceil((pastDaysOfYear + startOfYear.getDay() + 1) / 7);
  const weeklyPeriod = `weekly_${today.getFullYear()}-${String(weekNumber).padStart(2, '0')}`;

  await db.insert(prizePots).values([
    {
      period: dailyPeriod,
      totalAmount: "5000.00",
      closesAt: new Date(today.setHours(23, 59, 59, 999)),
      isDistributed: false,
    },
    {
      period: weeklyPeriod,
      totalAmount: "25000.00",
      closesAt: new Date(today.setDate(today.getDate() - today.getDay() + 7)),
      isDistributed: false,
    },
  ]);

  console.log(`✅ Created prize pots for ${dailyPeriod} and ${weeklyPeriod}`);

  console.log("✅ Seed completed!");
}

seed()
  .catch((error) => {
    console.error("❌ Seed failed:", error);
    process.exit(1);
  })
  .finally(() => {
    process.exit(0);
  });
