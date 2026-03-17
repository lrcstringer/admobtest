// ===========================================================================
// CHROME OPTION B: "Elevated Glass" — Chrome is distinct but lighter
// ===========================================================================
//
// PROBLEM BEING SOLVED:
//   Current dark theme has a "sandwich effect":
//   - Very dark navy AppBar/status bar
//   - Brighter blue gradient body (#3451B8 → #2C325C)
//   - Very dark navy bottom nav (#2C325C)
//   The chrome is DARKER than the content, creating visual weight at the
//   edges that clamps down on the content.
//
// CONCEPT:
//   Instead of making chrome darker than the body (heavy, claustrophobic),
//   make it SLIGHTLY LIGHTER — like a frosted glass shelf floating over
//   the gradient. The chrome separates from the content via a subtle
//   brightness lift + blur, not via darkness.
//
//   Think: iOS tab bar blur, Telegram dark mode nav, Discord mobile nav
//
// WHAT CHANGES:
//   1. Bottom nav background: semi-transparent blue-grey with backdrop blur
//      OLD: solid #2C325C (opaque, heavy)
//      NEW: #3A4272 at 85% opacity + BackdropFilter blur
//      Effect: glass panel floating over content — lighter, airy, modern
//
//   2. AppBar background: same frosted glass treatment
//      OLD: transparent (picks up gradient — fine, but no separation)
//      NEW: #3A4272 at 60% opacity + blur — gives it presence without weight
//
//   3. Bottom nav top border & AppBar bottom border: subtle frosted edge
//      OLD: Theme divider (too subtle) / none
//      NEW: white at 10% opacity — reads as frost edge on glass
//
//   4. System nav bar: tinted to match the glass
//
// WHAT STAYS THE SAME:
//   - Body gradient colors (#3451B8 → #2C325C)
//   - All accent colors, cards, content
//   - Layout, spacing, everything else
//
// VISUAL EFFECT:
//   Chrome feels elevated and modern — like frosted glass panels floating
//   over the blue gradient. Content is still the hero. The brightness
//   inversion is eliminated: nothing is darker than the body.
//
// COLOR PALETTE (only changed values):
//   AppBar bg:         #3A4272 at 60% opacity (≈ effective #3A4880 on gradient)
//   Bottom nav bg:     #3A4272 at 85% opacity (≈ effective #384068)
//   Chrome border:     rgba(255,255,255, 0.10)
//   Everything else:   UNCHANGED
// ===========================================================================

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------- COLOR TOKENS ----------

class ChromeOptionBColors {
  ChromeOptionBColors._();

  // Body gradient — UNCHANGED
  static const List<Color> bodyGradient = [
    Color(0xFF3451B8), // top
    Color(0xFF2C325C), // bottom
  ];

  // Glass chrome — lighter than the body, semi-transparent
  static const Color chromeBase = Color(0xFF3A4272);
  static const double appBarOpacity = 0.60;
  static const double navOpacity = 0.85;

  // Frost border
  static const Color chromeBorder = Color(0x1AFFFFFF); // white at 10%

  // Cards, text, accents — ALL UNCHANGED
  static const Color surface = Color(0xFF13161D);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8899A6);
  static const Color border = Color(0xFF2A2E3D);
  static const Color primary = Color(0xFFFF328C);
  static const Color gold = Color(0xFFFFB82C);
}

// ---------- FULL SCREEN MOCKUP ----------

Widget buildChromeOptionBHome(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF384068),
  ));

  return Scaffold(
    backgroundColor: ChromeOptionBColors.bodyGradient.last,
    extendBodyBehindAppBar: true,
    extendBody: true,

    // ---- APP BAR: frosted glass ----
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: ChromeOptionBColors.chromeBase
                  .withOpacity(ChromeOptionBColors.appBarOpacity),
              border: const Border(
                bottom: BorderSide(
                  color: ChromeOptionBColors.chromeBorder,
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    // Mascot
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Image(
                        image:
                            AssetImage('assets/icons/iMaliCrown4.png'),
                        width: 48,
                        height: 48,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text('Home',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ChromeOptionBColors.textPrimary,
                            )),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline,
                          color: ChromeOptionBColors.textSecondary
                              .withOpacity(0.8)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_outlined,
                          color: ChromeOptionBColors.textSecondary
                              .withOpacity(0.8)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.person_outline,
                          color: ChromeOptionBColors.textSecondary
                              .withOpacity(0.8)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),

    // ---- BODY: gradient ----
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ChromeOptionBColors.bodyGradient,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              const Text('Good Afternoon,',
                  style: TextStyle(
                    fontSize: 16,
                    color: ChromeOptionBColors.textSecondary,
                  )),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Expanded(
                    child: Text('Lance',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ChromeOptionBColors.textPrimary,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFB82C), Color(0xFFFF6429)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 18, color: Color(0xFF0C1124)),
                        SizedBox(width: 6),
                        Text('STREAK: 1 DAYS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color(0xFF0C1124),
                              letterSpacing: 1.0,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Token Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: ChromeOptionBColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ChromeOptionBColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined,
                            color: ChromeOptionBColors.primary,
                            size: 20),
                        SizedBox(width: 8),
                        Text('Tokens Balance:',
                            style: TextStyle(
                              color: ChromeOptionBColors.textSecondary,
                            )),
                        SizedBox(width: 8),
                        Text('66',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ChromeOptionBColors.textPrimary,
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF328C), Color(0xFFA011FF)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Earn Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Progress Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB82C), Color(0xFFFF6429)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Today's Progress",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C1124))),
                        Text('0 / 30',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C1124))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.0,
                      backgroundColor:
                          const Color(0xFF0C1124).withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation(
                          Color(0xFF0C1124)),
                    ),
                    const SizedBox(height: 6),
                    Text('0% of daily earn limit',
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              const Color(0xFF0C1124).withOpacity(0.8),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Pot Cards
              Row(
                children: [
                  Expanded(
                    child: _buildChromeBPotCard(
                      label: 'DAILY',
                      title: "TODAY'S POT",
                      amount: 'R 0.00',
                      timeLeft: '--',
                      rank: 0,
                      accentColors: const [
                        Color(0xFFFFB82C),
                        Color(0xFFFF6429),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildChromeBPotCard(
                      label: 'WEEKLY',
                      title: "THIS WEEK'S POT",
                      amount: 'R 0.00',
                      timeLeft: '--',
                      rank: 0,
                      accentColors: const [
                        Color(0xFFFF328C),
                        Color(0xFFA011FF),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Invite Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF328C), Color(0xFFA011FF)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_outlined,
                        color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text('Invite Friends & Earn',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('How iMaliChat works',
                    style: TextStyle(
                      color: ChromeOptionBColors.primary,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        ),
      ),
    ),

    // ---- BOTTOM NAV: frosted glass ----
    bottomNavigationBar: const _ChromeOptionBBottomNav(currentIndex: 0),
  );
}

// ---------- FROSTED GLASS BOTTOM NAV ----------

class _ChromeOptionBBottomNav extends StatelessWidget {
  final int currentIndex;
  const _ChromeOptionBBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        // Frosted glass blur — content behind nav is blurred
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            // Semi-transparent blue-grey — lighter than the gradient below
            color: ChromeOptionBColors.chromeBase
                .withOpacity(ChromeOptionBColors.navOpacity),
            border: const Border(
              top: BorderSide(
                color: ChromeOptionBColors.chromeBorder, // white 10%
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem('Home', Icons.home_outlined, 0),
                  _navItem('Earn', Icons.emoji_events_outlined, 1),
                  _navItem('Chat', Icons.chat_bubble_outline, 2),
                  _navItem('Buy', Icons.shopping_cart_outlined, 3),
                  _navItem('Wallet',
                      Icons.account_balance_wallet_outlined, 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, IconData icon, int index) {
    final isActive = index == currentIndex;
    return SizedBox(
      width: 64,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(6),
            decoration: isActive
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ChromeOptionBColors.primary
                            .withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  )
                : null,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isActive ? 1.0 : 0.45,
              child: Icon(icon, size: 28, color: Colors.white),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive
                  ? ChromeOptionBColors.textPrimary
                  : ChromeOptionBColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildChromeBPotCard({
  required String label,
  required String title,
  required String amount,
  required String timeLeft,
  required int rank,
  required List<Color> accentColors,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        color: ChromeOptionBColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChromeOptionBColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: accentColors),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label,
                        style: TextStyle(
                          fontSize: 11,
                          color: accentColors.first,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        )),
                    Icon(Icons.emoji_events,
                        color: accentColors.first, size: 18),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                      fontSize: 11,
                      color: ChromeOptionBColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(amount,
                    style: const TextStyle(
                      fontSize: 20,
                      color: ChromeOptionBColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 14,
                        color: ChromeOptionBColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(timeLeft,
                        style: const TextStyle(
                          fontSize: 12,
                          color: ChromeOptionBColors.textSecondary,
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Rank: #$rank',
                        style: const TextStyle(
                          fontSize: 12,
                          color: ChromeOptionBColors.textSecondary,
                        )),
                    const Icon(Icons.chevron_right,
                        size: 18,
                        color: ChromeOptionBColors.textSecondary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
