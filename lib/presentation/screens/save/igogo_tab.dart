import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Static iGoGo savings mockup — purely visual, no live data.
class IGoGoTab extends StatelessWidget {
  const IGoGoTab({super.key});

  // ── iGoGo palette ──
  static const _black = Color(0xFF0A0A0A);
  static const _gold = Color(0xFFC9A84C);
  static const _goldLight = Color(0xFFE8C96A);
  static const _goldDim = Color(0xFF7A6430);
  static const _greenBright = Color(0xFF2E7D32);
  static const _greenLight = Color(0xFF4CAF50);
  static const _white = Color(0xFFF5F0E8);
  static const _whiteDim = Color(0x99F5F0E8); // 60% opacity
  static const _cardBorder = Color(0x40C9A84C); // 25% opacity

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _black,
      child: Stack(
        children: [
          // Background glows
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _gold.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _greenBright.withValues(alpha: 0.10),
              ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildGreeting(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),
                _buildBalanceCard(),
                const SizedBox(height: 24),
                _buildNudgeCard(),
                const SizedBox(height: 28),
                _buildActions(),
                const SizedBox(height: 28),
                _buildQuote(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header: logo + streak badge ──
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'i',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: _whiteDim,
                ),
              ),
              TextSpan(
                text: 'Go',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: _gold,
                ),
              ),
              TextSpan(
                text: 'Go',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: _greenLight,
                ),
              ),
            ],
          ),
        ),

        // Streak badge
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _gold.withValues(alpha: 0.12),
            border: Border.all(color: _gold.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                '80 day streak',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _goldLight,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Greeting section ──
  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HEY THERE',
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: _whiteDim,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Nomsa 👋',
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: _white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '80 days',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _goldLight,
                ),
              ),
              TextSpan(
                text: ' of saving with zero withdrawals.',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _whiteDim,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Gogo would be proud. 🙌',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _greenLight,
          ),
        ),
      ],
    );
  }

  // ── Gold divider ──
  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            _gold.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  // ── Balance card ──
  Widget _buildBalanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top gradient line
          Container(
            height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_greenBright, _gold, _greenBright],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                Text(
                  'SAVINGS ACCOUNT',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: _whiteDim,
                  ),
                ),
                const SizedBox(height: 20),

                // Balance rows
                _buildBalanceRow('Capital', 'R 350.00'),
                const SizedBox(height: 10),
                _buildBalanceRow('Interest earned', '+ R 10.00',
                    valueColor: _greenLight),
                const SizedBox(height: 14),

                // Total row with top border
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: _gold.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Balance',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _white,
                        ),
                      ),
                      Text(
                        'R 360.00',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _goldLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Goal section
                _buildGoalSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _whiteDim,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: valueColor ?? _white,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalSection() {
    return Column(
      children: [
        // Goal header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SAVINGS GOAL',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: _whiteDim,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'R360',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _white,
                    ),
                  ),
                  TextSpan(
                    text: ' of R1 000',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: _whiteDim,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Progress bar
        SizedBox(
          height: 8,
          child: Stack(
            children: [
              // Track
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              // Fill (36%)
              FractionallySizedBox(
                widthFactor: 0.36,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        gradient: const LinearGradient(
                          colors: [_greenBright, _goldLight],
                        ),
                      ),
                    ),
                    // Glowing dot at end
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _goldLight,
                          boxShadow: [
                            BoxShadow(
                              color: _goldLight.withValues(alpha: 0.8),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Percentage
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '36% there',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _goldLight,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  // ── Motivational nudge card ──
  Widget _buildNudgeCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1B5E20).withValues(alpha: 0.25),
            _greenBright.withValues(alpha: 0.15),
          ],
        ),
        border: Border.all(color: _greenLight.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text('⚡', style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: GoogleFonts.dmSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: _whiteDim,
                  height: 1.55,
                ),
                children: [
                  const TextSpan(text: 'Save just '),
                  TextSpan(
                    text: 'R150 more',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _greenLight,
                      height: 1.55,
                    ),
                  ),
                  const TextSpan(
                      text: ' and your interest rate jumps from '),
                  TextSpan(
                    text: '2%',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _goldLight,
                      height: 1.55,
                    ),
                  ),
                  const TextSpan(text: ' to '),
                  TextSpan(
                    text: '3%',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _goldLight,
                      height: 1.55,
                    ),
                  ),
                  const TextSpan(
                      text: '. Your money starts working harder.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Action buttons ──
  Widget _buildActions() {
    return Row(
      children: [
        // Save Now — primary gold
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_gold, _goldDim],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              'Save Now',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _black,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // View History — outline
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: _gold.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              'View History',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _goldLight,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Bottom quote ──
  Widget _buildQuote() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Text(
              '"',
              style: GoogleFonts.playfairDisplay(
                fontSize: 36,
                color: _gold.withValues(alpha: 0.2),
                height: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Imali ayilali — money never sleeps.\nNeither does gogo\'s tin.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: _white.withValues(alpha: 0.35),
                letterSpacing: 0.3,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
