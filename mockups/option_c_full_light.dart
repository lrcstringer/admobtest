// ===========================================================================
// OPTION C: "Full Light + Dark Mode Toggle" — Platform-native approach
// ===========================================================================
//
// CONCEPT:
//   Entire screen is light by default. Brand colors appear as accents
//   on cards, buttons, and badges — not as background fills. The dark
//   theme becomes an opt-in system setting.
//
//   Similar to: M-Pesa, Venmo, PayPal, FNB, TymeBank, Capitec
//
// WHAT CHANGES:
//   1. Scaffold background: #F5F7FA (light grey)
//   2. AppBar: white with dark text, subtle bottom border
//   3. All cards: white (#FFFFFF) with light borders (#E8ECF1)
//   4. All text: dark on light (primary #1A1A2E, secondary #64748B)
//   5. Gradient accents ONLY on: buttons, badges, progress bars, pot top bars
//   6. No wave overlay (clean, minimal)
//   7. Greeting area gets a small brand-colored card instead of full gradient
//
// WHAT STAYS THE SAME:
//   - Accent gradient buttons (Earn Now, Invite Friends)
//   - Gold streak badge
//   - Gold progress card
//   - Pink/purple/gold pot card accents
//   - All functionality and layout
//
// VISUAL EFFECT:
//   Clean, bright, trustworthy — like a banking app. Your vibrant accent
//   colors become focal points rather than competing with a dark background.
//   Excellent readability and accessibility scores.
//   Most work to implement (need a full light theme + dark mode toggle).
// ===========================================================================

import 'package:flutter/material.dart';

// ---------- COLOR TOKENS ----------

class OptionCColors {
  OptionCColors._();

  // Backgrounds
  static const Color scaffoldBg = Color(0xFFF5F7FA);
  static const Color appBarBg = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE8ECF1);
  static const Color divider = Color(0xFFEAECF0);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Brand accents (unchanged)
  static const Color primary = Color(0xFFFF328C);
  static const Color gold = Color(0xFFFFB82C);

  // Shadows
  static const Color shadow = Color(0x0D000000); // 5% black
}

// ---------- HOME SCREEN MOCKUP ----------

Widget buildOptionCHome(BuildContext context) {
  return Scaffold(
    backgroundColor: OptionCColors.scaffoldBg,
    // ---- LIGHT APPBAR ----
    appBar: AppBar(
      backgroundColor: OptionCColors.appBarBg,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: OptionCColors.textPrimary,
          )),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline,
              color: OptionCColors.textSecondary),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: OptionCColors.textSecondary),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE8ECF1),
            child: Icon(Icons.person,
                size: 18, color: OptionCColors.textSecondary),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: OptionCColors.divider),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- GREETING + STREAK ----
          Text('Good Morning,',
              style: TextStyle(
                fontSize: 16,
                color: OptionCColors.textSecondary,
              )),
          const SizedBox(height: 4),
          Row(
            children: [
              const Expanded(
                child: Text('Thabo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: OptionCColors.textPrimary, // <-- dark text
                    )),
              ),
              // Streak badge — still vibrant gold gradient
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

          // ---- TOKEN BALANCE CARD (white card, accent icon) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: OptionCColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: OptionCColors.cardBorder),
              boxShadow: const [
                BoxShadow(
                  color: OptionCColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined,
                        color: OptionCColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text('Tokens Balance:',
                        style: TextStyle(
                          color: OptionCColors.textSecondary,
                        )),
                    const SizedBox(width: 8),
                    const Text('1,250',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: OptionCColors.textPrimary, // <-- dark text
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                // Earn Now button — gradient CTA stands out on white
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF328C), Color(0xFFA011FF)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF328C).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
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

          // ---- DAILY PROGRESS (gold gradient — pops beautifully on white) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB82C), Color(0xFFFF6429)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB82C).withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
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

          // ---- POT CARDS ROW (white cards) ----
          Row(
            children: [
              Expanded(
                child: _buildOptionCPotCard(
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
                child: _buildOptionCPotCard(
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

          // ---- INVITE FRIENDS (gradient CTA with glow shadow) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF328C), Color(0xFFA011FF)],
              ),
              borderRadius: BorderRadius.circular(12),
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
                  color: OptionCColors.primary,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOptionCPotCard(
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
      color: OptionCColors.card, // WHITE
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: OptionCColors.cardBorder),
      boxShadow: const [
        BoxShadow(
          color: OptionCColors.shadow,
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
          // Accent bar
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
                      color: OptionCColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(amount,
                    style: const TextStyle(
                      fontSize: 20,
                      color: OptionCColors.textPrimary, // <-- dark text
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 14, color: OptionCColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(timeLeft,
                        style: const TextStyle(
                          fontSize: 12,
                          color: OptionCColors.textSecondary,
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
                          color: OptionCColors.textSecondary,
                        )),
                    const Icon(Icons.chevron_right,
                        size: 18, color: OptionCColors.textSecondary),
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
