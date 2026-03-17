// ===========================================================================
// CHROME OPTION A: "Seamless Gradient" — Chrome dissolves into content
// ===========================================================================
//
// PROBLEM BEING SOLVED:
//   Current dark theme has a "sandwich effect":
//   - Dark navy AppBar/status bar area
//   - Brighter blue gradient body (#3451B8 → #2C325C)
//   - Dark navy bottom nav (#2C325C)
//   This creates three visual bands that fight each other.
//
// WHAT CHANGES:
//   1. Bottom nav background: match the BOTTOM of the body gradient
//      OLD: #2C325C (same as gradient bottom — but reads flat/heavy)
//      NEW: gradient from #2C325C → #252B52 with 4% white overlay
//      Effect: bottom nav feels like it "continues" the gradient downward
//
//   2. AppBar: stays transparent (already is) — the gradient behind it
//      already provides the right color. But we ensure the gradient
//      extends ABOVE SafeArea so the status bar region is also colored.
//
//   3. Bottom nav top border: soften from solid divider to a very subtle
//      gradient-matching separator
//      OLD: Theme divider color (visible line)
//      NEW: White at 6% opacity (barely there — just enough to hint at edge)
//
//   4. Status bar style: ensure light icons on the blue gradient
//
// WHAT STAYS THE SAME:
//   - Body gradient colors (#3451B8 → #2C325C)
//   - All accent colors, cards, content
//   - AppBar is already transparent
//   - Layout, spacing, everything else
//
// VISUAL EFFECT:
//   The entire screen reads as ONE continuous blue gradient surface.
//   AppBar, body, and bottom nav all feel unified. The chrome "disappears"
//   into the content. Accent colors (pink, gold, orange) do all the work
//   of defining interactive zones.
//
//   Similar to: Cash App (single dark surface), Monzo dark mode
//
// COLOR PALETTE (only changed values):
//   Bottom nav bg:     #2C325C with white 4% overlay → effective #303661
//   Bottom nav border: rgba(255,255,255, 0.06)
//   Everything else:   UNCHANGED
// ===========================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------- COLOR TOKENS ----------

class ChromeOptionAColors {
  ChromeOptionAColors._();

  // Body gradient — UNCHANGED
  static const List<Color> bodyGradient = [
    Color(0xFF3451B8), // top
    Color(0xFF2C325C), // bottom
  ];

  // Bottom nav — matches gradient bottom with subtle glass overlay
  static const Color navBackground = Color(0xFF2C325C);
  static const double navWhiteOverlay = 0.04; // 4% white blend

  // Nav border — barely-there separator
  static const Color navBorder = Color(0x0FFFFFFF); // white at 6%

  // Cards, text, accents — ALL UNCHANGED from current theme
  static const Color surface = Color(0xFF13161D);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8899A6);
  static const Color border = Color(0xFF2A2E3D);
  static const Color primary = Color(0xFFFF328C);
  static const Color gold = Color(0xFFFFB82C);
}

// ---------- FULL SCREEN MOCKUP ----------

Widget buildChromeOptionAHome(BuildContext context) {
  // Force light status bar icons on dark background
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF2C325C),
  ));

  return Scaffold(
    // No backgroundColor — gradient fills everything
    backgroundColor: ChromeOptionAColors.bodyGradient.last,
    extendBodyBehindAppBar: true,
    extendBody: true, // Content extends behind bottom nav

    // ---- APP BAR: transparent, dissolves into gradient ----
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(4),
        child: Image(
          image: AssetImage('assets/icons/iMaliCrown4.png'),
          width: 48,
          height: 48,
        ),
      ),
      title: const Text(
        'Home',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ChromeOptionAColors.textPrimary,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline,
              color: ChromeOptionAColors.textSecondary),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: ChromeOptionAColors.textSecondary),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person_outline,
              color: ChromeOptionAColors.textSecondary),
          onPressed: () {},
        ),
      ],
    ),

    // ---- BODY: gradient extends full screen ----
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ChromeOptionAColors.bodyGradient,
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
                    color: ChromeOptionAColors.textSecondary,
                  )),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Expanded(
                    child: Text('Lance',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ChromeOptionAColors.textPrimary,
                        )),
                  ),
                  // Streak badge
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
                  color: ChromeOptionAColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ChromeOptionAColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined,
                            color: ChromeOptionAColors.primary, size: 20),
                        SizedBox(width: 8),
                        Text('Tokens Balance:',
                            style: TextStyle(
                              color: ChromeOptionAColors.textSecondary,
                            )),
                        SizedBox(width: 8),
                        Text('66',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ChromeOptionAColors.textPrimary,
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
                    child: _buildChromeAPotCard(
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
                    child: _buildChromeAPotCard(
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
                      color: ChromeOptionAColors.primary,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        ),
      ),
    ),

    // ---- BOTTOM NAV: seamless gradient continuation ----
    bottomNavigationBar: _ChromeOptionABottomNav(currentIndex: 0),
  );
}

// ---------- SEAMLESS BOTTOM NAV ----------

class _ChromeOptionABottomNav extends StatelessWidget {
  final int currentIndex;
  const _ChromeOptionABottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    // KEY CHANGE: Bottom nav uses the gradient bottom color with a very
    // subtle white overlay — it reads as "slightly elevated" but still
    // part of the same gradient surface.
    return Container(
      decoration: BoxDecoration(
        // Base: same as gradient bottom
        color: ChromeOptionAColors.navBackground,
        // Subtle border — barely visible, just hints at the edge
        border: const Border(
          top: BorderSide(
            color: ChromeOptionAColors.navBorder, // white 6%
            width: 0.5,
          ),
        ),
      ),
      // Glass overlay: 4% white blend on top of the base color
      child: ColoredBox(
        color: Colors.white.withOpacity(ChromeOptionAColors.navWhiteOverlay),
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
                _navItem('Wallet', Icons.account_balance_wallet_outlined, 4),
              ],
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
                        color: ChromeOptionAColors.primary
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
                  ? ChromeOptionAColors.textPrimary
                  : ChromeOptionAColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildChromeAPotCard({
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
        color: ChromeOptionAColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChromeOptionAColors.border),
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
                      color: ChromeOptionAColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(amount,
                    style: const TextStyle(
                      fontSize: 20,
                      color: ChromeOptionAColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 14,
                        color: ChromeOptionAColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(timeLeft,
                        style: const TextStyle(
                          fontSize: 12,
                          color: ChromeOptionAColors.textSecondary,
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
                          color: ChromeOptionAColors.textSecondary,
                        )),
                    const Icon(Icons.chevron_right,
                        size: 18,
                        color: ChromeOptionAColors.textSecondary),
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
