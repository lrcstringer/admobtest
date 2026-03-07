import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Static iZiko stokvel mockup — purely visual, no live data.
class IStokvelTab extends StatelessWidget {
  const IStokvelTab({super.key});

  // ── iZiko palette ──
  static const _black = Color(0xFF0A0A0A);
  static const _gold = Color(0xFFC9A84C);
  static const _goldLight = Color(0xFFE8C96A);
  static const _goldDim = Color(0xFF7A6430);
  static const _greenBright = Color(0xFF2E7D32);
  static const _greenLight = Color(0xFF4CAF50);
  static const _ember = Color(0xFFE65100);
  static const _emberLight = Color(0xFFFF8A50);
  static const _white = Color(0xFFF5F0E8);
  static const _whiteDim = Color(0x8CF5F0E8); // 55% opacity
  static const _cardBorder = Color(0x33C9A84C); // 20% opacity

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _black,
      child: Stack(
        children: [
          // Background glows
          Positioned(
            top: -60,
            left: -60,
            child: _glow(280, _ember.withValues(alpha: 0.10)),
          ),
          Positioned(
            top: 100,
            right: -80,
            child: _glow(240, _gold.withValues(alpha: 0.09)),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: _glow(300, _greenBright.withValues(alpha: 0.08)),
          ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildGroupIdentity(),
                const SizedBox(height: 20),
                _buildDivider(),
                const SizedBox(height: 20),
                _buildPotCard(),
                const SizedBox(height: 20),
                _buildTurnCard(),
                const SizedBox(height: 20),
                _buildContribCard(),
                const SizedBox(height: 20),
                _buildHealthCard(),
                const SizedBox(height: 20),
                _buildMeetingRow(),
                const SizedBox(height: 20),
                _buildQuote(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  // ── Header: logo + members badge ──
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: 'i',
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: _whiteDim,
              ),
            ),
            TextSpan(
              text: 'Zi',
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: _emberLight,
              ),
            ),
            TextSpan(
              text: 'ko',
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: _gold,
              ),
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _ember.withValues(alpha: 0.12),
            border: Border.all(color: _ember.withValues(alpha: 0.25)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('👥', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              Text(
                '16 members',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _emberLight,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Group identity ──
  Widget _buildGroupIdentity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR STOKVEL',
          style: GoogleFonts.dmSans(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            color: _whiteDim,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Iziko laseKhayelitsha',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: 'Together since ',
              style: GoogleFonts.dmSans(fontSize: 12, color: _whiteDim),
            ),
            TextSpan(
              text: 'January 2024',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _emberLight,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  // ── Divider ──
  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.transparent,
          _ember.withValues(alpha: 0.3),
          _gold.withValues(alpha: 0.3),
          Colors.transparent,
        ]),
      ),
    );
  }

  // ── Pot card — centrepiece ──
  Widget _buildPotCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Top gradient line
          Container(
            height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_ember, _gold, _emberLight],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Flame hearth
                _buildHearth(),
                const SizedBox(height: 16),

                // Pot label
                Text(
                  'THE POT THIS CYCLE',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: _whiteDim,
                  ),
                ),
                const SizedBox(height: 6),

                // Pot value
                Text(
                  'R 3 200',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: _goldLight,
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 4),

                // Sub text
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'of ',
                      style:
                          GoogleFonts.dmSans(fontSize: 12, color: _whiteDim),
                    ),
                    TextSpan(
                      text: 'R 4 000',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _white,
                      ),
                    ),
                    TextSpan(
                      text: ' expected total',
                      style:
                          GoogleFonts.dmSans(fontSize: 12, color: _whiteDim),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),

                // Stats row
                _buildPotStats(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHearth() {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _ember.withValues(alpha: 0.25),
                  Colors.transparent,
                ],
                stops: const [0, 0.7],
              ),
            ),
          ),
          const Text('🔥', style: TextStyle(fontSize: 32)),
        ],
      ),
    );
  }

  Widget _buildPotStats() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _potStat('R200', 'Per member'),
            _statDivider(),
            _potStat('Cycle 4', 'Current'),
            _statDivider(),
            _potStat('12 left', 'Cycles'),
          ],
        ),
      ),
    );
  }

  Widget _potStat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        color: Colors.white.withValues(alpha: 0.02),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _white,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 10,
                letterSpacing: 0.8,
                color: _whiteDim,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      width: 1,
      color: Colors.white.withValues(alpha: 0.06),
    );
  }

  // ── My Turn card ──
  Widget _buildTurnCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _ember.withValues(alpha: 0.12),
            _gold.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: _ember.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MY TURN',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  color: _whiteDim,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: _ember.withValues(alpha: 0.15),
                  border: Border.all(color: _ember.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '#7 of 16',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _emberLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rotation arc
          _buildRotationArc(),
          const SizedBox(height: 14),

          // Detail row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Left: cycles away
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: '3 ',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _white,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: 'cycles away',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: _whiteDim,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '~September 2025',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _emberLight,
                    ),
                  ),
                ],
              ),

              // Right: payout
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'YOU\'LL RECEIVE',
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: _whiteDim,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'R 4 000',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _goldLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRotationArc() {
    // Node types: done (1-4), next (5), future (6), mine (YOU), future (8), future (•••)
    final nodes = <_RotNode>[
      const _RotNode('1', _RotType.done),
      const _RotNode('2', _RotType.done),
      const _RotNode('3', _RotType.done),
      const _RotNode('4', _RotType.done),
      const _RotNode('5', _RotType.next),
      const _RotNode('6', _RotType.future),
      const _RotNode('YOU', _RotType.mine),
      const _RotNode('8', _RotType.future),
      const _RotNode('•••', _RotType.future),
    ];

    final widgets = <Widget>[];
    for (var i = 0; i < nodes.length; i++) {
      widgets.add(_buildRotNode(nodes[i]));
      if (i < nodes.length - 1) {
        // Connector line — green if both sides are done
        final isDoneLine =
            nodes[i].type == _RotType.done && nodes[i + 1].type == _RotType.done;
        widgets.add(
          Expanded(
            child: Container(
              height: 1,
              color: isDoneLine
                  ? _greenLight.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
        );
      }
    }

    return Row(children: widgets);
  }

  Widget _buildRotNode(_RotNode node) {
    BoxDecoration decoration;
    TextStyle textStyle;

    switch (node.type) {
      case _RotType.done:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          color: _greenLight.withValues(alpha: 0.2),
          border: Border.all(color: _greenLight.withValues(alpha: 0.4)),
        );
        textStyle = GoogleFonts.dmSans(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: _greenLight,
        );
      case _RotType.next:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          color: _gold.withValues(alpha: 0.25),
          border: Border.all(color: _goldLight, width: 2),
        );
        textStyle = GoogleFonts.dmSans(
          fontSize: 8,
          fontWeight: FontWeight.w700,
          color: _goldLight,
        );
      case _RotType.mine:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_ember, _goldDim],
          ),
          border: Border.all(color: _goldLight, width: 2),
          boxShadow: [
            BoxShadow(
              color: _ember.withValues(alpha: 0.4),
              blurRadius: 12,
            ),
          ],
        );
        textStyle = GoogleFonts.dmSans(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          color: _black,
        );
      case _RotType.future:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        );
        textStyle = GoogleFonts.dmSans(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: _whiteDim,
        );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: decoration,
      alignment: Alignment.center,
      child: Text(node.label, style: textStyle),
    );
  }

  // ── Contribution card ──
  Widget _buildContribCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MY CONTRIBUTION',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  letterSpacing: 1.5,
                  color: _whiteDim,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'R 200',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _white,
                ),
              ),
              const SizedBox(height: 2),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Due ',
                    style: GoogleFonts.dmSans(fontSize: 12, color: _whiteDim),
                  ),
                  TextSpan(
                    text: '1st of every month',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _goldLight,
                    ),
                  ),
                ]),
              ),
            ],
          ),

          // Right — paid badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _greenLight.withValues(alpha: 0.15),
              border: Border.all(color: _greenLight.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _greenLight,
                    boxShadow: [
                      BoxShadow(
                        color: _greenLight.withValues(alpha: 0.6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Paid ✓',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _greenLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Group health card ──
  Widget _buildHealthCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Left info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GROUP HEALTH',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  letterSpacing: 1.5,
                  color: _whiteDim,
                ),
              ),
              const SizedBox(height: 3),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: '14',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _greenLight,
                    ),
                  ),
                  TextSpan(
                    text: ' of 16 paid',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _white,
                    ),
                  ),
                ]),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Right — bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 6,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.875, // 14/16
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            gradient: const LinearGradient(
                              colors: [_greenBright, _greenLight],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '2 pending',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: _whiteDim,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Next meeting row ──
  Widget _buildMeetingRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: _white.withValues(alpha: 0.12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Text('📍', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: _whiteDim,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: 'Next meeting '),
                  TextSpan(
                    text: 'Saturday 5 July',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _white,
                    ),
                  ),
                  const TextSpan(text: ' at Nomsa\'s place · 14:00'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom quote ──
  Widget _buildQuote() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          'Umlilo awucimi — the fire does not go out.\nEveryone adds wood.',
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: _white.withValues(alpha: 0.3),
            letterSpacing: 0.3,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}

// ── Rotation node model ──
enum _RotType { done, next, mine, future }

class _RotNode {
  const _RotNode(this.label, this.type);
  final String label;
  final _RotType type;
}
