import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/gooi/gooi_formation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiBiddingScreen extends StatefulWidget {
  final String groupId;
  const GooiBiddingScreen({super.key, required this.groupId});

  @override
  State<GooiBiddingScreen> createState() => _GooiBiddingScreenState();
}

class _GooiBiddingScreenState extends State<GooiBiddingScreen> {
  final _bidPercentController = TextEditingController(text: '90');
  int _targetPosition = 1;

  @override
  void initState() {
    super.initState();
    context.read<GooiFormationBloc>().add(GooiFormationEvent.loadGroup(widget.groupId));
  }

  @override
  void dispose() {
    _bidPercentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place Bid')),
      body: BlocConsumer<GooiFormationBloc, GooiFormationState>(
        listener: (context, state) {
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionSuccess!)),
            );
          }
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final memberCount = state.members.length;
          final contributionZar = (state.group?.contributionAmount ?? 0) / 100;

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        Text(
                          'Bidding Auction',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Bid for an earlier position by accepting a smaller payout. '
                          'Lower bid % = better chance to win the position. '
                          'Minimum: 80%.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Target Position', style: Theme.of(context).textTheme.titleMedium),
                Slider(
                  value: _targetPosition.toDouble(),
                  min: 1,
                  max: memberCount.toDouble().clamp(1, 12),
                  divisions: (memberCount - 1).clamp(1, 11),
                  label: 'Position $_targetPosition',
                  activeColor: AppColors.teal,
                  onChanged: (v) => setState(() => _targetPosition = v.round()),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _bidPercentController,
                  decoration: InputDecoration(
                    labelText: 'Bid Percentage',
                    suffixText: '%',
                    helperText: 'You will receive ${_bidPercentController.text}% of the full pot '
                        '(R${(contributionZar * memberCount * (int.tryParse(_bidPercentController.text) ?? 90) / 100).toStringAsFixed(0)})',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => setState(() {}),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: state.isActionInProgress
                      ? null
                      : () {
                          final percent = int.tryParse(_bidPercentController.text);
                          if (percent == null || percent < 80 || percent > 100) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Bid must be between 80% and 100%')),
                            );
                            return;
                          }
                          context.read<GooiFormationBloc>().add(GooiFormationEvent.submitBid(
                                targetPosition: _targetPosition,
                                bidPercent: percent,
                              ));
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: state.isActionInProgress
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Submit Bid'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
