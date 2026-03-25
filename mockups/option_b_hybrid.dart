// ignore_for_file: deprecated_member_use
// ===========================================================================
// OPTION B: "Light Default, Dark Header" — Modern hybrid (RECOMMENDED)
// ===========================================================================
//
// CONCEPT:
//   Top hero section keeps the dark gradient (brand identity, striking accents)
//   Content area below transitions to a light surface (high readability)
//   Similar to: Revolut home, M-Pesa dashboard, Chipper Cash, TymeBank
//
// WHAT CHANGES:
//   1. Screen splits into two zones:
//      - HERO ZONE (top ~200px): dark gradient with greeting, balance, streak
//      - CONTENT ZONE (scrollable body): light background (#F5F7FA)
//
//   2. Cards switch from dark surface to white (#FFFFFF) with subtle borders
//
//   3. Text in content zone switches to dark text on light:
//      - Primary: #1A1A2E
//      - Secondary: #64748B
//
//   4. Gradient accent cards (progress bar, invite, pot tops) keep their
//      vibrant colors — they pop even MORE on a light background
//
//   5. Smooth visual transition from dark hero → light content via a
//      subtle gradient fade
//
// WHAT STAYS THE SAME:
//   - Brand gradient in the hero (greeting + balance area)
//   - All accent gradients (gold, pink-purple, etc.)
//   - Wave overlay in the hero section
//   - Layout, spacing, widget structure
//
// VISUAL EFFECT:
//   Premium dark header gives brand identity and "wow factor"
//   Light content area is easy on the eyes, great readability
//   Feels like a modern fintech app — professional and trustworthy
//   Reuses your existing Buy tab light tokens — consistent design language
// ===========================================================================

import 'package:flutter/material.dart';

// ---------- COLOR TOKENS ----------

class OptionBColors {
  OptionBColors._();

  // Hero zone (dark — keeps brand identity)
  static const Color heroTop = Color(0xFF142978);
  static const Color heroBottom = Color(0xFF0C1124);
  static const Color heroText = Color(0xFFFFFFFF);
  static const Color heroTextSecondary = Color(0xFFA0AEC0);

  // Content zone (light — high readability)
  static const Color contentBg = Color(0xFFF5F7FA);
  static const Color contentCard = Color(0xFFFFFFFF);
  static const Color contentCardBorder = Color(0xFFE8ECF1);
  static const Color contentTextPrimary = Color(0xFF1A1A2E);
  static const Color contentTextSecondary = Color(0xFF64748B);
  static const Color contentDivider = Color(0xFFEAECF0);

  // Shared accents (unchanged)
  static const Color primary = Color(0xFFFF328C);
  static const Color gold = Color(0xFFFFB82C);
}

// ---------- HOME SCREEN MOCKUP ----------

Widget buildOptionBHome(BuildContext context) {
  return Scaffold(
    backgroundColor: OptionBColors.contentBg,
    body: SingleChildScrollView(
      child: Column(
        children: [
          // ============================================================
          // HERO ZONE — Dark gradient (brand identity)
          // ============================================================
          _buildHeroZone(context),

          // ============================================================
          // CONTENT ZONE — Light background (readability)
          // ============================================================
          _buildContentZone(context),
        ],
      ),
    ),
  );
}

Widget _buildHeroZone(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          OptionBColors.heroTop,
          OptionBColors.heroBottom,
        ],
      ),
    ),
    child: Stack(
      children: [
        // Wave overlay (same as current)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Transform.scale(
            scale: 1.2,
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/wave_feather_fixed_r7.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        // Hero content
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- AppBar row (same as current IMaliAppBar) ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Home',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: OptionBColors.heroText,
                        )),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.help_outline,
                              color: OptionBColors.heroText),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined,
                              color: OptionBColors.heroText),
                          onPressed: () {},
                        ),
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFF2A2E3D),
                          child: Icon(Icons.person,
                              size: 18, color: OptionBColors.heroText),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ---- Greeting + Streak Badge ----
                const Text('Good Morning,',
                    style: TextStyle(
                      fontSize: 16,
                      color: OptionBColors.heroTextSecondary,
                    )),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Thabo',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: OptionBColors.heroText,
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

                const SizedBox(height: 16),

                // ---- Token Balance Card (still on dark background) ----
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08), // frosted glass effect
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.account_balance_wallet_outlined,
                              color: OptionBColors.primary, size: 20),
                          SizedBox(width: 8),
                          Text('Tokens Balance:',
                              style: TextStyle(
                                color: OptionBColors.heroTextSecondary,
                              )),
                          SizedBox(width: 8),
                          Text('1,250',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: OptionBColors.heroText,
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildContentZone(BuildContext context) {
  return Container(
    width: double.infinity,
    // Overlap slightly with hero for smooth transition
    transform: Matrix4.translationValues(0, -12, 0),
    decoration: const BoxDecoration(
      color: OptionBColors.contentBg,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- DAILY PROGRESS CARD (accent gradient — pops on light!) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  valueColor:
                      const AlwaysStoppedAnimation(Color(0xFF0C1124)),
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

          const SizedBox(height: 20),

          // ---- POT CARDS ROW (white cards with accent tops) ----
          Row(
            children: [
              Expanded(
                child: _buildOptionBPotCard(
                  context,
                  label: 'DAILY',
                  title: "TODAY'S POT",
                  amount: 'R 45.20',
                  timeLeft: 'about 6 hours',
                  rank: 12,
                  accentColors: const [Color(0xFFFFB82C), Color(0xFFFF6429)],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOptionBPotCard(
                  context,
                  label: 'WEEKLY',
                  title: "THIS WEEK'S POT",
                  amount: 'R 312.50',
                  timeLeft: '3 days',
                  rank: 8,
                  accentColors: const [Color(0xFFFF328C), Color(0xFFA011FF)],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ---- INVITE FRIENDS (gradient button — vibrant on light) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF328C), Color(0xFFA011FF)],
              ),
              borderRadius: BorderRadius.circular(12),
              // Subtle shadow on light background — adds depth
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF328C).withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
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

          // ---- HOW IT WORKS LINK ----
          const Center(
            child: Text('How iMaliChat works',
                style: TextStyle(
                  color: OptionBColors.primary,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOptionBPotCard(
  BuildContext context, {
  required String label,
  required String title,
  required String amount,
  required String timeLeft,
  required int rank,
  required List<Color> accentColors,
}) {
  return Container(
    decoration: BoxDecoration(
      color: OptionBColors.contentCard, // <-- WHITE card
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: OptionBColors.contentCardBorder),
      // Subtle shadow for elevation on light background
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D000000), // 5% black
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top accent bar (same vibrant gradient)
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
                      color: OptionBColors
                          .contentTextSecondary, // <-- dark secondary text
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(amount,
                    style: const TextStyle(
                      fontSize: 20,
                      color: OptionBColors
                          .contentTextPrimary, // <-- dark primary text
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 14,
                        color: OptionBColors.contentTextSecondary),
                    const SizedBox(width: 4),
                    Text(timeLeft,
                        style: const TextStyle(
                          fontSize: 12,
                          color: OptionBColors.contentTextSecondary,
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
                          color: OptionBColors.contentTextSecondary,
                        )),
                    const Icon(Icons.chevron_right,
                        size: 18,
                        color: OptionBColors.contentTextSecondary),
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
