// ===========================================================================
// OPTION A: "Lighten the Dark" — Modernised dark theme
// ===========================================================================
//
// WHAT CHANGES:
//   1. Background gradient: saturated navy → neutral charcoal
//      OLD: #142978 → #0C1124 (heavy saturated navy)
//      NEW: #0F1119 → #0A0C14 (neutral, premium charcoal)
//
//   2. Home tab gets a subtle BLUE tint in the top of its gradient
//      (Earn would get green, Wallet would get gold — each tab has identity)
//      NEW home gradient: #111830 → #0A0C14
//
//   3. Card surface contrast bumped up
//      OLD: #13161D (almost invisible against #0C1124)
//      NEW: #1A1E2E (clearly elevated, ~3x more contrast)
//
//   4. Secondary text readability improved
//      OLD: #8899A6 (~4.5:1 contrast — borderline)
//      NEW: #A0AEC0 (~6.5:1 contrast — comfortably AA)
//
//   5. Borders get slightly more presence
//      OLD: #2A2E3D
//      NEW: #2E3347
//
// WHAT STAYS THE SAME:
//   - All accent colors (pink, gold, cyan) — they pop even better on neutral dark
//   - Layout, spacing, widget tree
//   - Wave overlay
//   - Gradient cards (streak badge, progress bar, invite button, pot cards)
//
// VISUAL EFFECT:
//   Feels like a premium dark mode (think Revolut dark, Crypto.com).
//   Less heavy/claustrophobic. Each tab has a subtle color identity.
//   Minimal code change — mostly AppColors constants.
// ===========================================================================

import 'package:flutter/material.dart';

// ---------- COLOR CHANGES (AppColors patch) ----------

class OptionAColors {
  OptionAColors._();

  // Background: neutral charcoal instead of saturated navy
  static const Color background = Color(0xFF0A0C14);

  // Per-tab gradient tops (subtle tint for identity)
  static const List<Color> homeGradient = [
    Color(0xFF111830), // subtle blue tint at top
    Color(0xFF0A0C14), // neutral bottom
  ];
  // (For comparison — Earn would be:)
  static const List<Color> earnGradient = [
    Color(0xFF0F1F18), // subtle green tint
    Color(0xFF0A0C14),
  ];
  // (Wallet would be:)
  static const List<Color> walletGradient = [
    Color(0xFF1A1508), // subtle gold tint
    Color(0xFF0A0C14),
  ];

  // Elevated surface: more contrast against background
  static const Color surface = Color(0xFF1A1E2E);
  static const Color card = Color(0xFF1A1E2E);

  // Better text readability
  static const Color textSecondary = Color(0xFFA0AEC0); // was #8899A6

  // Slightly more visible borders
  static const Color border = Color(0xFF2E3347); // was #2A2E3D

  // Everything else unchanged
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFFFF328C);
  static const Color gold = Color(0xFFFFB82C);
}

// ---------- HOME SCREEN MOCKUP (only changed lines highlighted) ----------

Widget buildOptionAHome(BuildContext context) {
  return Scaffold(
    backgroundColor: OptionAColors.background,
    body: SingleChildScrollView(
      child: _OptionATabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: OptionAColors.homeGradient, // <-- CHANGED: neutral + blue tint
        ),
        overlayAsset: 'assets/images/wave_feather_fixed_r7.png',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- HEADER (same layout, better text contrast) ----
              Text(
                'Good Morning,',
                style: TextStyle(
                  fontSize: 16,
                  color: OptionAColors.textSecondary, // <-- CHANGED: brighter
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Thabo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: OptionAColors.textPrimary, // unchanged
                      ),
                    ),
                  ),
                  // Streak badge — unchanged (gold gradient pops on neutral dark)
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
                        Text('STREAK: 5 DAYS',
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

              // ---- TOKEN BALANCE CARD ----
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: OptionAColors.surface, // <-- CHANGED: brighter card
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: OptionAColors.border), // <-- CHANGED: more visible
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            color: OptionAColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Text('Tokens Balance:',
                            style: TextStyle(
                              color: OptionAColors
                                  .textSecondary, // <-- CHANGED: brighter
                            )),
                        const SizedBox(width: 8),
                        const Text('1,250',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: OptionAColors.textPrimary,
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Earn Now button — unchanged
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

              // ---- DAILY PROGRESS CARD (unchanged — gold gradient) ----
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        Text('3 / 10',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C1124))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: const Color(0xFF0C1124).withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF0C1124)),
                    ),
                    const SizedBox(height: 6),
                    Text('30% of daily earn limit',
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color(0xFF0C1124).withOpacity(0.8),
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ---- POT CARDS ROW ----
              Row(
                children: [
                  Expanded(
                    child: _buildOptionAPotCard(
                      context,
                      label: 'DAILY',
                      title: "TODAY'S POT",
                      amount: 'R 45.20',
                      timeLeft: 'about 6 hours',
                      rank: 12,
                      accentColors: const [
                        Color(0xFFFFB82C),
                        Color(0xFFFF6429),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildOptionAPotCard(
                      context,
                      label: 'WEEKLY',
                      title: "THIS WEEK'S POT",
                      amount: 'R 312.50',
                      timeLeft: '3 days',
                      rank: 8,
                      accentColors: const [
                        Color(0xFFFF328C),
                        Color(0xFFA011FF),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ---- INVITE FRIENDS BUTTON (unchanged) ----
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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

              // ---- HOW IT WORKS LINK (unchanged) ----
              const Center(
                child: Text('How iMaliChat works',
                    style: TextStyle(
                      color: OptionAColors.primary,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildOptionAPotCard(
  BuildContext context, {
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
        color: OptionAColors.surface, // <-- CHANGED: brighter card
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: OptionAColors.border), // <-- CHANGED
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top accent bar
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
                      color: OptionAColors.textSecondary, // <-- CHANGED
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(amount,
                    style: const TextStyle(
                      fontSize: 20,
                      color: OptionAColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 14, color: OptionAColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(timeLeft,
                        style: const TextStyle(
                          fontSize: 12,
                          color: OptionAColors.textSecondary,
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
                          color: OptionAColors.textSecondary,
                        )),
                    const Icon(Icons.chevron_right,
                        size: 18, color: OptionAColors.textSecondary),
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

// Simplified TabBackground for mockup
class _OptionATabBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final String? overlayAsset;
  const _OptionATabBackground({
    required this.child,
    this.gradient,
    this.overlayAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (gradient != null)
          Positioned.fill(
            child: DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
          ),
        if (overlayAsset != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.2,
              alignment: Alignment.topCenter,
              child: Image.asset(overlayAsset!, fit: BoxFit.fitWidth),
            ),
          ),
        child,
      ],
    );
  }
}
