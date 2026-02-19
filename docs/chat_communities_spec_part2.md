                      ),
                      Text(
                        '$remaining tokens',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
                
                SizedBox(height: 20),
                
                // Amount input
                Text(
                  'YOUR CONTRIBUTION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 0.5,
                  ),
                ),
                
                SizedBox(height: 12),
                
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    suffix: Text(
                      'tokens',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      amount = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                
                SizedBox(height: 12),
                
                // Quick amounts
                Wrap(
                  spacing: 8,
                  children: [50, 100, 200, 500].map((quickAmount) {
                    return ActionChip(
                      label: Text('$quickAmount'),
                      onPressed: () {
                        setState(() {
                          amount = quickAmount;
                        });
                      },
                      backgroundColor: Colors.white.withOpacity(0.1),
                      labelStyle: TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: 12),
                
                // Balance
                Text(
                  'Your Balance: ${currentBalance.value ?? 0} tokens',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
                
                SizedBox(height: 20),
                
                // Leaderboard hint
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Top contributor gets the crown! 👑',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              onPressed: amount >= 10 && amount <= currentBalance.value!
                  ? () {
                      Navigator.pop(context);
                      _contributeToSpray(amount);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandPink,
                disabledBackgroundColor: Colors.grey,
              ),
              child: Text('Contribute'),
            ),
          ],
        );
      },
    ),
  );
}

Future<void> _contributeToSpray(int amount) async {
  try {
    // Show loading
    _showContributingAnimation();
    
    // 1. Debit tokens from user's wallet
    final debitTxId = await ref.read(walletRepositoryProvider)
        .debitTokens(
      amount: amount,
      reason: 'Token Spray for ${spray.recipientName}',
      metadata: {'sprayId': spray.id, 'communityId': spray.communityId},
    );
    
    // 2. Add contribution to spray
    await ref.read(tokenSpraysRepositoryProvider)
        .addContribution(
      sprayId: spray.id,
      userId: _currentUserId,
      userName: _currentUserName,
      amount: amount,
      debitTransactionId: debitTxId,
    );
    
    // 3. Post system message in community
    await ref.read(messagesRepositoryProvider)
        .sendSystemMessage(
      communityId: spray.communityId,
      text: '$_currentUserName contributed $amount tokens to the spray!',
    );
    
    // 4. Show success
    _showSuccessToast('You contributed $amount tokens! 🎉');
    
    // 5. Check if user is now top contributor
    _checkLeaderboardPosition();
    
  } catch (e) {
    _showErrorDialog('Failed to contribute: ${e.toString()}');
  }
}
```

### 8.5 Close Token Spray

**Auto-Close (Cloud Function):**

```javascript
// functions/src/scheduled/closeTokenSprays.js
exports.closeExpiredSprays = functions.pubsub
  .schedule('every 1 hours')
  .onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    
    // Find expired active sprays
    const expiredSprays = await admin.firestore()
      .collection('tokenSprays')
      .where('status', '==', 'active')
      .where('expiresAt', '<', now)
      .get();
    
    if (expiredSprays.empty) {
      console.log('No expired sprays found');
      return null;
    }
    
    console.log(`Found ${expiredSprays.size} expired sprays to close`);
    
    // Process each spray
    for (const doc of expiredSprays.docs) {
      const spray = doc.data();
      
      try {
        await closeTokenSpray(spray, doc.ref);
      } catch (error) {
        console.error(`Error closing spray ${doc.id}:`, error);
      }
    }
    
    return null;
  });

async function closeTokenSpray(spray, sprayRef) {
  const batch = admin.firestore().batch();
  
  // 1. Update spray status
  batch.update(sprayRef, {
    status: 'closed',
    closedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  // 2. Credit tokens to recipient
  const recipientWalletRef = admin.firestore()
    .collection('users')
    .doc(spray.recipientId)
    .collection('wallet')
    .doc('main');
  
  batch.update(recipientWalletRef, {
    balance: admin.firestore.FieldValue.increment(spray.currentTotal),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  // 3. Create credit transaction for recipient
  const creditTxRef = admin.firestore()
    .collection('users')
    .doc(spray.recipientId)
    .collection('transactions')
    .doc();
  
  batch.set(creditTxRef, {
    type: 'token_spray_received',
    amount: spray.currentTotal,
    from: spray.communityId,
    sprayId: spray.id,
    contributorCount: spray.contributorCount,
    occasion: spray.occasion,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  // Save credit transaction ID
  batch.update(sprayRef, {
    creditTransactionId: creditTxRef.id,
  });
  
  // 4. Update spray message in community
  const messageRef = admin.firestore()
    .collection('communities')
    .doc(spray.communityId)
    .collection('messages')
    .doc(spray.messageId);
  
  batch.update(messageRef, {
    'tokenSpray.status': 'closed',
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  // Commit all updates
  await batch.commit();
  
  // 5. Post system message
  await admin.firestore()
    .collection('communities')
    .doc(spray.communityId)
    .collection('messages')
    .add({
      type: 'system',
      text: `Token Spray closed! ${spray.recipientName} received ${spray.currentTotal} tokens from ${spray.contributorCount} contributors 🎉`,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  
  // 6. Send notifications
  await sendSprayClosedNotifications(spray);
}

async function sendSprayClosedNotifications(spray) {
  // Notify recipient
  await admin.messaging().send({
    token: await getUserFCMToken(spray.recipientId),
    notification: {
      title: 'You received a Token Spray! 🎊',
      body: `The community celebrated your ${spray.occasionText} with ${spray.currentTotal} tokens!`,
    },
    data: {
      type: 'token_spray_received',
      sprayId: spray.id,
      communityId: spray.communityId,
      amount: spray.currentTotal.toString(),
    },
  });
  
  // Notify all contributors
  const contributorIds = Object.keys(spray.contributions);
  for (const userId of contributorIds) {
    await admin.messaging().send({
      token: await getUserFCMToken(userId),
      notification: {
        title: 'Token Spray Complete! 🎉',
        body: `${spray.recipientName} received ${spray.currentTotal} tokens. Thank you for contributing!`,
      },
      data: {
        type: 'token_spray_closed',
        sprayId: spray.id,
        communityId: spray.communityId,
      },
    });
  }
  
  // Special notification for top contributor
  if (spray.topContributors.length > 0) {
    const topContributor = spray.topContributors[0];
    await admin.messaging().send({
      token: await getUserFCMToken(topContributor.userId),
      notification: {
        title: "You're the Top Donor! 👑",
        body: `You contributed the most (${topContributor.amount} tokens) to ${spray.recipientName}'s celebration!`,
      },
      data: {
        type: 'token_spray_top_contributor',
        sprayId: spray.id,
      },
    });
  }
}
```

---

## 9. Sharing & Deep Linking

### 9.1 Share to External Platforms

**Share Message/Achievement:**

```dart
class ShareService {
  Future<void> shareAchievement({
    required String achievement,
    required int amount,
    String? imageUrl,
  }) async {
    final text = _buildShareText(achievement, amount);
    final referralCode = await _getReferralCode();
    final deepLink = await _generateDeepLink(referralCode);
    
    // Share via platform sheet
    await Share.share(
      text,
      subject: 'Check out what I earned on iMaliChat!',
    );
  }
  
  String _buildShareText(String achievement, int amount) {
    return '''
🎉 I just earned $amount tokens on iMaliChat!

$achievement

Join me and start earning rewards:
https://imalichat.app/join?ref=$_referralCode

💰 Earn tokens by watching videos
🎁 Send gifts to friends
💼 Save together in Stokvels
🛒 Redeem for real rewards
''';
  }
}
```

**Deep Link Handling:**

```dart
// lib/core/services/deep_link_service.dart
class DeepLinkService {
  Future<void> initialize() async {
    // Handle initial link (app opened from terminated state)
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }
    
    // Handle links while app is running
    linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    });
  }
  
  Future<void> _handleDeepLink(String link) async {
    final uri = Uri.parse(link);
    
    // https://imalichat.app/join/community/{communityId}
    if (uri.path.startsWith('/join/community/')) {
      final communityId = uri.pathSegments.last;
      final inviterId = uri.queryParameters['inviter'];
      await _joinCommunityFlow(communityId, inviterId);
    }
    
    // https://imalichat.app/chat/{userId}
    else if (uri.path.startsWith('/chat/')) {
      final userId = uri.pathSegments.last;
      await _openConversation(userId);
    }
    
    // https://imalichat.app/join?ref={referralCode}
    else if (uri.path == '/join') {
      final referralCode = uri.queryParameters['ref'];
      await _handleReferral(referralCode);
    }
  }
  
  Future<void> _joinCommunityFlow(String communityId, String? inviterId) async {
    // Check if user is authenticated
    if (!_authService.isAuthenticated) {
      await _authService.signIn();
    }
    
    // Show community preview
    final community = await _communitiesRepository.getCommunityById(communityId);
    
    // Show join confirmation dialog
    final shouldJoin = await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => CommunityJoinDialog(
        community: community,
        inviterName: inviterId != null 
            ? await _getUserName(inviterId) 
            : null,
      ),
    );
    
    if (shouldJoin == true) {
      await _communitiesRepository.joinCommunity(communityId);
      _navigationService.navigateToCommunity(communityId);
    }
  }
}
```

**Community Invite Link Generation:**

```dart
Future<String> generateCommunityInviteLink(String communityId) async {
  final currentUserId = await getCurrentUserId();
  
  // Use Firebase Dynamic Links
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://imalichat.page.link',
    link: Uri.parse('https://imalichat.app/join/community/$communityId?inviter=$currentUserId'),
    androidParameters: AndroidParameters(
      packageName: 'com.imalichat.app',
      minimumVersion: 1,
    ),
    iosParameters: IOSParameters(
      bundleId: 'com.imalichat.app',
      minimumVersion: '1.0.0',
      appStoreId: '123456789',
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: 'Join ${community.name} on iMaliChat',
      description: community.description ?? 'Connect with our community!',
      imageUrl: community.imageUrl != null 
          ? Uri.parse(community.imageUrl!) 
          : null,
    ),
  );
  
  final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance
      .buildShortLink(parameters);
  
  return shortLink.shortUrl.toString();
}
```

### 9.2 QR Code System

**Generate QR Code:**

```dart
class QRCodeGenerator {
  Widget buildUserQRCode(String userId, String userName) {
    final qrData = 'imalichat://user/$userId';
    
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // QR Code
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 280,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            embeddedImage: AssetImage('assets/images/logo.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(60, 60),
            ),
          ),
          
          SizedBox(height: 24),
          
          // User info
          Text(
            userName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: 8),
          
          Text(
            'Scan to start chatting',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          
          SizedBox(height: 24),
          
          // Share button
          ElevatedButton.icon(
            onPressed: () => _shareQRCode(qrData),
            icon: Icon(Icons.share),
            label: Text('Share QR Code'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandPink,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buildCommunityQRCode(Community community) {
    final qrData = 'imalichat://community/${community.id}';
    
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 280,
            backgroundColor: Colors.white,
          ),
          
          SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                community.icon,
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(width: 12),
              Text(
                community.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8),
          
          Text(
            'Scan to join community',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
```

**Scan QR Code:**

```dart
class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: AppColors.brandPink,
              borderRadius: 16,
              borderLength: 40,
              borderWidth: 8,
              cutOutSize: 300,
            ),
          ),
          
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Point camera at QR code',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      _handleScannedData(scanData.code);
    });
  }
  
  Future<void> _handleScannedData(String? data) async {
    if (data == null) return;
    
    final uri = Uri.parse(data);
    
    // imalichat://user/{userId}
    if (uri.scheme == 'imalichat' && uri.host == 'user') {
      final userId = uri.pathSegments.first;
      await _startConversation(userId);
    }
    
    // imalichat://community/{communityId}
    else if (uri.scheme == 'imalichat' && uri.host == 'community') {
      final communityId = uri.pathSegments.first;
      await _joinCommunity(communityId);
    }
    
    // Invalid QR
    else {
      _showInvalidQRDialog();
    }
  }
  
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
```

---

## 10. Notifications System

### 10.1 Notification Types

```dart
enum NotificationType {
  // Messages
  newMessage,
  newMessageInCommunity,
  mentionedInMessage,
  
  // Gifts
  giftReceived,
  giftOpened,
  giftExpired,
  giftExpiringSoon,
  
  // Token Spray
  tokenSprayStarted,
  tokenSprayContribution,
  tokenSprayClosed,
  tokenSprayReceived,
  tokenSprayTopContributor,
  
  // Communities
  communityInvite,
  addedToCommunity,
  removedFromCommunity,
  promotedToAdmin,
  
  // Stokvels
  contributionDue,
  contributionOverdue,
  allContributionsReceived,
  payoutDay,
  payoutReceived,
  
  // System
  announcement,
}
```

### 10.2 Push Notification Handling

```dart
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  Future<void> initialize() async {
    // Request permission
    await _requestPermission();
    
    // Get FCM token
    final token = await _messaging.getToken();
    await _saveTokenToFirestore(token);
    
    // Listen for token refresh
    _messaging.onTokenRefresh.listen(_saveTokenToFirestore);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    
    // Handle initial message (app opened from notification)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }
  
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Foreground message: ${message.notification?.title}');
    
    // Show in-app notification banner
    _showInAppNotification(message);
    
    // Update badge count
    await _updateBadgeCount();
    
    // Play sound
    if (message.notification?.android?.sound != null ||
        message.notification?.apple?.sound != null) {
      await _playNotificationSound();
    }
  }
  
  void _handleNotificationTap(RemoteMessage message) {
    final type = message.data['type'] as String?;
    
    switch (type) {
      case 'new_message':
        final conversationId = message.data['conversationId'];
        _navigationService.navigateToConversation(conversationId);
        break;
        
      case 'new_community_message':
        final communityId = message.data['communityId'];
        _navigationService.navigateToCommunity(communityId);
        break;
        
      case 'gift_received':
        final conversationId = message.data['conversationId'];
        final messageId = message.data['messageId'];
        _navigationService.navigateToMessage(conversationId, messageId);
        break;
        
      case 'token_spray_received':
        final communityId = message.data['communityId'];
        final sprayId = message.data['sprayId'];
        _navigationService.navigateToCommunity(communityId);
        break;
        
      case 'stokvel_contribution_due':
        final communityId = message.data['communityId'];
        _navigationService.navigateToStokvel(communityId);
        break;
        
      default:
        _navigationService.navigateToHome();
    }
  }
}

// Background message handler (must be top-level function)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.notification?.title}');
}
```

### 10.3 Local Notifications

```dart
class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  
  Future<void> initialize() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }
  
  Future<void> showMessageNotification({
    required String senderName,
    required String message,
    required String conversationId,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'messages',
      'Messages',
      channelDescription: 'New message notifications',
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('message_sound'),
    );
    
    const iosDetails = DarwinNotificationDetails(
      sound: 'message_sound.aiff',
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _plugin.show(
      conversationId.hashCode,
      senderName,
      message,
      details,
      payload: jsonEncode({
        'type': 'message',
        'conversationId': conversationId,
      }),
    );
  }
  
  Future<void> scheduleContributionReminder({
    required String stokvellName,
    required int amount,
    required DateTime scheduledDate,
    required String communityId,
  }) async {
    final tz.TZDateTime scheduledTZ = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );
    
    await _plugin.zonedSchedule(
      communityId.hashCode,
      'Stokvel Contribution Due',
      'R$amount due for $stokvellName',
      scheduledTZ,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'stokvels',
          'Stokvel Reminders',
          channelDescription: 'Contribution reminders',
          importance: Importance.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: jsonEncode({
        'type': 'stokvel_contribution',
        'communityId': communityId,
      }),
    );
  }
}
```

### 10.4 Notification Preferences

```dart
class NotificationPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('All Notifications'),
            subtitle: Text('Enable or disable all notifications'),
            value: true,
            onChanged: (value) {},
          ),
          
          Divider(),
          
          ListTile(
            title: Text(
              'MESSAGES',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          
          SwitchListTile(
            title: Text('Direct Messages'),
            subtitle: Text('Notify for new 1-on-1 messages'),
            value: true,
            onChanged: (value) {},
          ),
          
          SwitchListTile(
            title: Text('Community Messages'),
            subtitle: Text('Notify for community messages'),
            value: true,
            onChanged: (value) {},
          ),
          
          SwitchListTile(
            title: Text('Mentions Only'),
            subtitle: Text('Only notify when mentioned in communities'),
            value: false,
            onChanged: (value) {},
          ),
          
          Divider(),
          
          ListTile(
            title: Text(
              'GIFTS & CELEBRATIONS',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          
          SwitchListTile(
            title: Text('Gift Received'),
            value: true,
            onChanged: (value) {},
          ),
          
          SwitchListTile(
            title: Text('Token Spray Events'),
            value: true,
            onChanged: (value) {},
          ),
          
          Divider(),
          
          ListTile(
            title: Text(
              'STOKVELS',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          
          SwitchListTile(
            title: Text('Contribution Reminders'),
            value: true,
            onChanged: (value) {},
          ),
          
          SwitchListTile(
            title: Text('Payout Notifications'),
            value: true,
            onChanged: (value) {},
          ),
          
          Divider(),
          
          ListTile(
            title: Text(
              'QUIET HOURS',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          
          SwitchListTile(
            title: Text('Enable Quiet Hours'),
            subtitle: Text('Silence notifications during these hours'),
            value: false,
            onChanged: (value) {},
          ),
          
          ListTile(
            title: Text('Start Time'),
            subtitle: Text('10:00 PM'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          
          ListTile(
            title: Text('End Time'),
            subtitle: Text('7:00 AM'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
```

---

## 11. Security & Privacy

### 11.1 Encryption

**Message Encryption (Future Enhancement):**

```dart
// Note: Currently messages are stored in plaintext in Firestore
// For end-to-end encryption, would need to implement:

class E2EEncryptionService {
  // Generate key pair for user
  Future<KeyPair> generateKeyPair() async {
    final rsa = RSA();
    final keyPair = await rsa.generate(2048);
    return keyPair;
  }
  
  // Encrypt message before sending
  Future<String> encryptMessage(String message, String recipientPublicKey) async {
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
      encrypt.RSA(publicKey: recipientPublicKey),
    );
    final encrypted = encrypter.encrypt(message);
    return encrypted.base64;
  }
  
  // Decrypt received message
  Future<String> decryptMessage(String encryptedMessage, String privateKey) async {
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
      encrypt.RSA(privateKey: privateKey),
    );
    final decrypted = encrypter.decrypt64(encryptedMessage);
    return decrypted;
  }
}
```

### 11.2 Block User

```dart
Future<void> blockUser(String userId, String userToBlockId) async {
  final batch = FirebaseFirestore.instance.batch();
  
  // 1. Add to blocked list
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  batch.update(userRef, {
    'chat.blockedUserIds': FieldValue.arrayUnion([userToBlockId]),
  });
  
  // 2. Delete any existing conversation
  final conversations = await FirebaseFirestore.instance
      .collection('conversations')
      .where('participantIds', arrayContains: userId)
      .get();
  
  for (final conv in conversations.docs) {
    final participantIds = List<String>.from(conv.data()['participantIds']);
    if (participantIds.contains(userToBlockId)) {
      batch.delete(conv.reference);
    }
  }
  
  // 3. Remove from all shared communities (if desired)
  // ... implementation
  
  await batch.commit();
  
  // 4. Show confirmation
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('User blocked successfully')),
  );
}
```

### 11.3 Report User/Message

```dart
Future<void> reportMessage({
  required String messageId,
  required String reporterId,
  required String reason,
  required String? additionalInfo,
}) async {
  await FirebaseFirestore.instance.collection('reports').add({
    'type': 'message',
    'messageId': messageId,
    'reporterId': reporterId,
    'reason': reason,
    'additionalInfo': additionalInfo,
    'status': 'pending',
    'createdAt': FieldValue.serverTimestamp(),
  });
  
  // Trigger Cloud Function for admin review
}
```

### 11.4 Data Privacy

**POPIA Compliance:**

```yaml
User Data Collected:
  - Name, email, phone (required for account)
  - Profile photo (optional)
  - Messages, media (encrypted at rest)
  - Token transaction history
  - Community membership
  - Device tokens (for notifications)

User Rights:
  - Access their data (export functionality)
  - Delete their data (account deletion)
  - Control sharing (privacy settings)
  - Opt out of notifications

Data Retention:
  - Active accounts: Indefinite
  - Deleted accounts: 30 days then purged
  - Messages in deleted conversations: 90 days
  - Analytics data: Anonymized, 24 months
```

**Account Deletion:**

```dart
Future<void> deleteAccount(String userId) async {
  // 1. Anonymize messages (don't delete, breaks conversation history)
  await _anonymizeUserMessages(userId);
  
  // 2. Remove from all communities
  await _removeFromAllCommunities(userId);
  
  // 3. Refund pending gifts
  await _refundPendingGifts(userId);
  
  // 4. Cancel pending transactions
  await _cancelPendingTransactions(userId);
  
  // 5. Mark account as deleted (soft delete)
  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'status': 'deleted',
    'deletedAt': FieldValue.serverTimestamp(),
    'email': null,
    'phoneNumber': null,
    'displayName': 'Deleted User',
    'profilePicUrl': null,
  });
  
  // 6. Schedule permanent deletion after 30 days
  await _schedulePermanentDeletion(userId);
}
```

---

## 12. Media Handling

### 12.1 Image Processing

```dart
class ImageProcessingService {
  Future<File> compressImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    
    if (image == null) throw Exception('Failed to decode image');
    
    // Resize if too large
    img.Image resized = image;
    if (image.width > 1920 || image.height > 1920) {
      resized = img.copyResize(
        image,
        width: image.width > image.height ? 1920 : null,
        height: image.height > image.width ? 1920 : null,
      );
    }
    
    // Compress
    final compressed = img.encodeJpg(resized, quality: 85);
    
    // Save to temporary file
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(compressed);
    
    return tempFile;
  }
  
  Future<File> generateThumbnail(File imageFile, {int size = 150}) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    
    if (image == null) throw Exception('Failed to decode image');
    
    // Create square thumbnail
    final thumbnail = img.copyResizeCropSquare(image, size: size);
    final thumbnailBytes = img.encodeJpg(thumbnail, quality: 80);
    
    final tempDir = await getTemporaryDirectory();
    final thumbFile = File('${tempDir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await thumbFile.writeAsBytes(thumbnailBytes);
    
    return thumbFile;
  }
}
```

### 12.2 Voice Message Recording

```dart
class VoiceRecorderService {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  
  Future<void> startRecording() async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    
    await _recorder.openRecorder();
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacMP4,
    );
    
    _isRecording = true;
  }
  
  Future<File?> stopRecording() async {
    if (!_isRecording) return null;
    
    final path = await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    
    _isRecording = false;
    
    return path != null ? File(path) : null;
  }
  
  Stream<RecordingDisposition> get onProgress => _recorder.onProgress!;
}
```

### 12.3 Cloud Storage Upload

```dart
class MediaStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  Future<MediaUploadResult> uploadImage({
    required File imageFile,
    required String chatId,
    required String messageId,
    required bool isConversation,
  }) async {
    // Compress image
    final compressed = await ImageProcessingService().compressImage(imageFile);
    
    // Generate thumbnail
    final thumbnail = await ImageProcessingService().generateThumbnail(compressed);
    
    // Upload full image
    final fullPath = isConversation
        ? 'conversations/$chatId/images/${messageId}_full.jpg'
        : 'communities/$chatId/images/${messageId}_full.jpg';
    
    final fullRef = _storage.ref().child(fullPath);
    await fullRef.putFile(compressed);
    final fullUrl = await fullRef.getDownloadURL();
    
    // Upload thumbnail
    final thumbPath = fullPath.replaceAll('_full', '_thumb');
    final thumbRef = _storage.ref().child(thumbPath);
    await thumbRef.putFile(thumbnail);
    final thumbUrl = await thumbRef.getDownloadURL();
    
    // Clean up temp files
    await compressed.delete();
    await thumbnail.delete();
    
    return MediaUploadResult(
      url: fullUrl,
      thumbnailUrl: thumbUrl,
      fileName: '${messageId}_full.jpg',
      fileSize: await imageFile.length(),
      mimeType: 'image/jpeg',
    );
  }
  
  Future<MediaUploadResult> uploadVoiceMessage({
    required File voiceFile,
    required String chatId,
    required String messageId,
    required bool isConversation,
  }) async {
    final path = isConversation
        ? 'conversations/$chatId/voice/$messageId.m4a'
        : 'communities/$chatId/voice/$messageId.m4a';
    
    final ref = _storage.ref().child(path);
    await ref.putFile(voiceFile);
    final url = await ref.getDownloadURL();
    
    // Get duration
    final player = AudioPlayer();
    await player.setFilePath(voiceFile.path);
    final duration = player.duration;
    await player.dispose();
    
    return MediaUploadResult(
      url: url,
      fileName: '$messageId.m4a',
      fileSize: await voiceFile.length(),
      mimeType: 'audio/mp4',
      duration: duration?.inSeconds,
    );
  }
}
```

---

## 13. Performance Optimization

### 13.1 Message Pagination

```dart
class MessagesPaginationService {
  static const int PAGE_SIZE = 50;
  
  Future<List<Message>> loadInitialMessages(String chatId) async {
    final query = FirebaseFirestore.instance
        .collection(_getCollectionPath(chatId))
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(PAGE_SIZE);
    
    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Message.fromFirestore(doc))
        .toList()
        .reversed
        .toList();
  }
  
  Future<List<Message>> loadMoreMessages(
    String chatId,
    DocumentSnapshot lastDocument,
  ) async {
    final query = FirebaseFirestore.instance
        .collection(_getCollectionPath(chatId))
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .startAfterDocument(lastDocument)
        .limit(PAGE_SIZE);
    
    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Message.fromFirestore(doc))
        .toList()
        .reversed
        .toList();
  }
}
```

### 13.2 Image Caching

```dart
class ImageCacheManager {
  static final CachedNetworkImageProvider _provider =
      CachedNetworkImageProvider('');
  
  Widget buildCachedImage(String imageUrl, {double? width, double? height}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => Container(
        color: Colors.grey[800],
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
      maxWidthDiskCache: 1000,
      maxHeightDiskCache: 1000,
    );
  }
  
  Future<void> precacheImages(List<String> imageUrls, BuildContext context) async {
    for (final url in imageUrls) {
      await precacheImage(CachedNetworkImageProvider(url), context);
    }
  }
  
  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }
}
```

### 13.3 Firestore Query Optimization

```dart
// Use composite indexes for complex queries
// firestore.indexes.json
{
  "indexes": [
    {
      "collectionGroup": "conversations",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "participantIds", "arrayConfig": "CONTAINS"},
        {"fieldPath": "lastMessageAt", "order": "DESCENDING"}
      ]
    },
    {
      "collectionGroup": "communities",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "memberIds", "arrayConfig": "CONTAINS"},
        {"fieldPath": "type", "order": "ASCENDING"},
        {"fieldPath": "lastMessageAt", "order": "DESCENDING"}
      ]
    },
    {
      "collectionGroup": "messages",
      "queryScope": "COLLECTION_GROUP",
      "fields": [
        {"fieldPath": "createdAt", "order": "DESCENDING"}
      ]
    }
  ]
}

// Efficient queries
Future<List<Conversation>> getUserConversations(String userId) async {
  // Single compound query with index
  final query = await FirebaseFirestore.instance
      .collection('conversations')
      .where('participantIds', arrayContains: userId)
      .orderBy('lastMessageAt', descending: true)
      .limit(20)
      .get();
  
  return query.docs.map((doc) => Conversation.fromFirestore(doc)).toList();
}
```

---

## 14. Testing Strategy

### 14.1 Unit Tests

```dart
// test/features/chat/repositories/messages_repository_test.dart
void main() {
  group('MessagesRepository', () {
    late MessagesRepository repository;
    late MockFirestore mockFirestore;
    late MockStorage mockStorage;
    
    setUp(() {
      mockFirestore = MockFirestore();
      mockStorage = MockStorage();
      repository = MessagesRepositoryImpl(
        firestore: mockFirestore,
        storage: mockStorage,
      );
    });
    
    test('sendMessage creates message document', () async {
      final message = Message(
        id: 'test_message_1',
        senderId: 'user_1',
        senderName: 'Test User',
        type: MessageType.text,
        text: 'Hello world',
        createdAt: DateTime.now(),
        status: MessageStatus.sent,
      );
      
      when(mockFirestore.collection('conversations')
          .doc('conv_1')
          .collection('messages')
          .add(any))
          .thenAnswer((_) async => MockDocumentReference());
      
      await repository.sendMessage('conv_1', message);
      
      verify(mockFirestore.collection('conversations')
          .doc('conv_1')
          .collection('messages')
          .add(message.toFirestore())).called(1);
    });
    
    test('getMessagesStream returns stream of messages', () async {
      final mockSnapshot = MockQuerySnapshot();
      when(mockSnapshot.docs).thenReturn([
        MockDocumentSnapshot(data: {
          'id': 'msg_1',
          'senderId': 'user_1',
          'text': 'Hello',
          'type': 'text',
          'createdAt': Timestamp.now(),
        }),
      ]);
      
      when(mockFirestore.collection('conversations')
          .doc('conv_1')
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .snapshots())
          .thenAnswer((_) => Stream.value(mockSnapshot));
      
      final stream = repository.getMessagesStream('conv_1');
      final messages = await stream.first;
      
      expect(messages, hasLength(1));
      expect(messages[0].text, 'Hello');
    });
  });
}
```

### 14.2 Widget Tests

```dart
// test/features/chat/presentation/widgets/message_bubble_test.dart
void main() {
  testWidgets('MessageBubble displays text message', (tester) async {
    final message = Message(
      id: 'test_1',
      senderId: 'user_1',
      senderName: 'John',
      type: MessageType.text,
      text: 'Hello world',
      createdAt: DateTime.now(),
      status: MessageStatus.sent,
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isSentByCurrentUser: true,
          ),
        ),
      ),
    );
    
    expect(find.text('Hello world'), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
  });
  
  testWidgets('GiftBubble shows gift details', (tester) async {
    final message = Message(
      id: 'gift_1',
      senderId: 'user_1',
      senderName: 'Jane',
      type: MessageType.gift,
      gift: GiftMessageData(
        amount: 200,
        message: 'Thanks!',
        style: GiftStyle.ndlovukazi,
        status: GiftStatus.pending,
      ),
      createdAt: DateTime.now(),
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GiftBubble(message: message),
        ),
      ),
    );
    
    expect(find.text('200 tokens'), findsOneWidget);
    expect(find.text('"Thanks!"'), findsOneWidget);
    expect(find.text('Tap to Open'), findsOneWidget);
  });
}
```

### 14.3 Integration Tests

```dart
// integration_test/chat_flow_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Chat Flow Integration Tests', () {
    testWidgets('Send message and receive confirmation', (tester) async {
      await tester.pumpWidget(MyApp());
      
      // Navigate to chat
      await tester.tap(find.byIcon(Icons.chat));
      await tester.pumpAndSettle();
      
      // Open conversation
      await tester.tap(find.text('Test User'));
      await tester.pumpAndSettle();
      
      // Type message
      await tester.enterText(find.byType(TextField), 'Hello from test!');
      await tester.pumpAndSettle();
      
      // Send message
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();
      
      // Verify message appears
      expect(find.text('Hello from test!'), findsOneWidget);
      
      // Verify sent status
      expect(find.byIcon(Icons.done), findsOneWidget);
    });
    
    testWidgets('Send gift flow', (tester) async {
      // ... full gift flow test
    });
  });
}
```

---

## 15. Implementation Phases

### Phase 1: Core Chat (Weeks 1-3)

**Week 1: Foundation**
- ✅ Firebase schema setup
- ✅ Security rules
- ✅ Flutter project structure
- ✅ Data models
- ✅ Repositories

**Week 2: Messages Feature**
- ✅ Conversation list screen
- ✅ Direct message screen
- ✅ Text messages
- ✅ Message bubbles
- ✅ Real-time updates

**Week 3: Media & Polish**
- ✅ Image messages
- ✅ Voice messages
- ✅ Message reactions
- ✅ Reply feature
- ✅ Basic notifications

**Deliverable:** Working 1-on-1 messaging

### Phase 2: Communities (Weeks 4-6)

**Week 4: Regular Communities**
- ✅ Create community flow
- ✅ Community list
- ✅ Community chat
- ✅ Member management
- ✅ Invite system

**Week 5: Stokvel Features**
- ✅ Stokvel creation flow
- ✅ Financial dashboard
- ✅ Contribution tracking
- ✅ Payout schedule
- ✅ Reminders

**Week 6: Community Polish**
- ✅ Admin controls
- ✅ Settings screens
- ✅ Community info
- ✅ Leave/delete flows
- ✅ Edge cases

**Deliverable:** Full community features

### Phase 3: Gifts & Celebrations (Weeks 7-9)

**Week 7: iMali Gifts**
- ✅ Gift composer
- ✅ Gift messages
- ✅ Opening animation
- ✅ Wallet integration
- ✅ Expiry handling

**Week 8: Token Spray**
- ✅ Spray creation
- ✅ Contributions
- ✅ Leaderboard
- ✅ Auto-close
- ✅ Recipient claiming

**Week 9: Celebrations Polish**
- ✅ All gift styles
- ✅ Sound effects
- ✅ Notifications
- ✅ Analytics
- ✅ Edge cases

**Deliverable:** Complete gifting system

### Phase 4: Polish & Launch (Weeks 10-12)

**Week 10: Sharing & Deep Links**
- ✅ External sharing
- ✅ Deep linking
- ✅ QR codes
- ✅ Invite flows
- ✅ Referral tracking

**Week 11: Testing & Fixes**
- ✅ Integration tests
- ✅ Bug fixes
- ✅ Performance tuning
- ✅ Security audit
- ✅ POPIA compliance

**Week 12: Launch Prep**
- ✅ Documentation
- ✅ Support materials
- ✅ Beta testing
- ✅ App store prep
- ✅ Marketing assets

**Deliverable:** Production-ready chat system

---

## 16. Complete Code Examples

### 16.1 Send Message (Complete Flow)

```dart
// complete_message_flow.dart
class MessageSendingService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final WalletRepository _walletRepository;
  
  Future<void> sendTextMessage({
    required String chatId,
    required bool isConversation,
    required String text,
    String? replyToMessageId,
  }) async {
    final currentUser = await _getCurrentUser();
    
    // Create message
    final message = Message(
      id: Uuid().v4(),
      senderId: currentUser.id,
      senderName: currentUser.displayName,
      senderAvatarThumbUrl: currentUser.profilePicUrl,
      type: MessageType.text,
      text: text,
      replyTo: replyToMessageId != null 
          ? await _getReplyContext(chatId, replyToMessageId, isConversation)
          : null,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      reactions: {},
      deletedFor: [],
      deletedForEveryone: false,
    );
    
    // Add to local cache (optimistic UI)
    _addToLocalCache(message);
    
    try {
      // Upload to Firestore
      final collectionPath = isConversation ? 'conversations' : 'communities';
      final docRef = await _firestore
          .collection(collectionPath)
          .doc(chatId)
          .collection('messages')
          .add(message.toFirestore());
      
      message.id = docRef.id;
      message.status = MessageStatus.sent;
      
      // Update conversation/community last message
      await _updateLastMessage(chatId, isConversation, message);
      
      // Increment unread counts for other participants
      await _incrementUnreadCounts(chatId, isConversation, currentUser.id);
      
      // Update local cache
      _updateLocalCache(message);
      
    } catch (e) {
      message.status = MessageStatus.failed;
      _updateLocalCache(message);
      throw e;
    }
  }
  
  Future<void> sendImageMessage({
    required String chatId,
    required bool isConversation,
    required File imageFile,
    String? caption,
  }) async {
    final currentUser = await _getCurrentUser();
    
    // Create placeholder message
    final messageId = Uuid().v4();
    final message = Message(
      id: messageId,
      senderId: currentUser.id,
      senderName: currentUser.displayName,
      type: MessageType.image,
      text: caption,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
    );
    
    _addToLocalCache(message);
    
    try {
      // Upload image
      final mediaResult = await _uploadImage(
        imageFile: imageFile,
        chatId: chatId,
        messageId: messageId,
        isConversation: isConversation,
      );
      
      message.media = mediaResult;
      
      // Save to Firestore
      await _saveMessage(chatId, isConversation, message);
      
      message.status = MessageStatus.sent;
      _updateLocalCache(message);
      
    } catch (e) {
      message.status = MessageStatus.failed;
      _updateLocalCache(message);
      throw e;
    }
  }
  
  Future<MediaData> _uploadImage({
    required File imageFile,
    required String chatId,
    required String messageId,
    required bool isConversation,
  }) async {
    // Compress
    final compressedFile = await _compressImage(imageFile);
    
    // Generate thumbnail
    final thumbnailFile = await _generateThumbnail(compressedFile);
    
    // Upload full
    final fullPath = '${isConversation ? "conversations" : "communities"}/$chatId/images/${messageId}_full.jpg';
    final fullRef = _storage.ref(fullPath);
    await fullRef.putFile(compressedFile);
    final fullUrl = await fullRef.getDownloadURL();
    
    // Upload thumbnail
    final thumbPath = fullPath.replaceAll('_full', '_thumb');
    final thumbRef = _storage.ref(thumbPath);
    await thumbRef.putFile(thumbnailFile);
    final thumbUrl = await thumbRef.getDownloadURL();
    
    // Get dimensions
    final decodedImage = img.decodeImage(await imageFile.readAsBytes());
    
    return MediaData(
      url: fullUrl,
      thumbnailUrl: thumbUrl,
      fileName: '${messageId}_full.jpg',
      fileSize: await imageFile.length(),
      mimeType: 'image/jpeg',
      width: decodedImage?.width,
      height: decodedImage?.height,
    );
  }
}
```

---

## 17. Analytics & Tracking

### 17.1 Key Metrics

```dart
class ChatAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  // Message metrics
  Future<void> trackMessageSent({
    required MessageType type,
    required bool isConversation,
    bool hasMedia = false,
  }) async {
    await _analytics.logEvent(
      name: 'message_sent',
      parameters: {
        'type': type.toString(),
        'is_conversation': isConversation,
        'has_media': hasMedia,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
  
  // Gift metrics
  Future<void> trackGiftSent({
    required int amount,
    required GiftStyle style,
    required bool isInCommunity,
  }) async {
    await _analytics.logEvent(
      name: 'gift_sent',
      parameters: {
        'amount': amount,
        'style': style.toString(),
        'in_community': isInCommunity,
      },
    );
  }
  
  // Community metrics
  Future<void> trackCommunityCreated({
    required CommunityType type,
    required int memberCount,
  }) async {
    await _analytics.logEvent(
      name: 'community_created',
      parameters: {
        'type': type.toString(),
        'initial_members': memberCount,
      },
    );
  }
  
  // Engagement metrics
  Future<void> trackScreenView(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }
}
```

---

## 18. Troubleshooting & Common Issues

### 18.1 Common Issues

```yaml
Issue: Messages not appearing in real-time
Solution:
  - Check Firestore connection
  - Verify StreamProvider setup
  - Check security rules
  - Ensure indexes are created

Issue: Images not uploading
Solution:
  - Check Cloud Storage permissions
  - Verify file size limits
  - Check network connectivity
  - Review compression settings

Issue: Push notifications not received
Solution:
  - Verify FCM token saved
  - Check notification permissions
  - Review Cloud Function logs
  - Test on physical device

Issue: Gift expiry not working
Solution:
  - Check Cloud Function deployment
  - Verify scheduled job configuration
  - Review Firestore timestamps
  - Check timezone settings
```

---

**END OF PART 2**

## Summary

This document completes the comprehensive implementation specification for iMaliChat's Chat & Communities feature, covering:

✅ iMali Gift integration (complete flow)
✅ Token Spray feature (group celebrations)
✅ Sharing & deep linking system
✅ Complete notifications infrastructure
✅ Security & privacy measures
✅ Media handling (images, voice)
✅ Performance optimization strategies
✅ Full testing strategy
✅ 12-week implementation roadmap
✅ Production-ready code examples
✅ Analytics tracking
✅ Troubleshooting guide

**Total Documentation Package:**
- Part 1: Foundation & Core Features (Firebase, Flutter, Messages, Communities, Stokvels)
- Part 2: Advanced Features (Gifts, Sprays, Notifications, Security, Implementation)

**Ready for Development!** 🚀

