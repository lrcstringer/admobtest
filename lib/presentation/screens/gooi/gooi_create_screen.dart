import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/gooi_cycle_frequency.dart';
import '../../../domain/enums/gooi_roster_method.dart';
import '../../blocs/gooi/gooi_formation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiCreateScreen extends StatefulWidget {
  const GooiCreateScreen({super.key});

  @override
  State<GooiCreateScreen> createState() => _GooiCreateScreenState();
}

class _GooiCreateScreenState extends State<GooiCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _cyclesController = TextEditingController();
  final _gracePeriodController = TextEditingController(text: '48');
  final _lateFeeController = TextEditingController(text: '5');

  GooiCycleFrequency _frequency = GooiCycleFrequency.monthly;
  GooiRosterMethod _rosterMethod = GooiRosterMethod.agreed;
  bool _recipientContributes = true;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _cyclesController.dispose();
    _gracePeriodController.dispose();
    _lateFeeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amountRands = double.tryParse(_amountController.text) ?? 0;
    final amountTokens = (amountRands * 100).round();

    context.read<GooiFormationBloc>().add(GooiFormationEvent.createGroup(
      name: _nameController.text.trim(),
      contributionAmount: amountTokens,
      cycleFrequency: _frequency,
      totalCycles: int.tryParse(_cyclesController.text) ?? 1,
      rosterMethod: _rosterMethod,
      gracePeriodHours: int.tryParse(_gracePeriodController.text) ?? 48,
      lateFeePercent: int.tryParse(_lateFeeController.text) ?? 5,
      recipientContributes: _recipientContributes,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Gooi-Gooi')),
      body: BlocConsumer<GooiFormationBloc, GooiFormationState>(
        listener: (context, state) {
          if (state.createdGroupId != null) {
            context.go('/chat/gooi/${state.createdGroupId}/invite');
          }
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Group Name',
                      hintText: 'e.g. Family Monthly',
                    ),
                    validator: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Contribution Amount (ZAR)',
                      prefixText: 'R ',
                      hintText: 'e.g. 500',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
                    validator: (v) {
                      final amount = double.tryParse(v ?? '');
                      if (amount == null || amount < 10) return 'Minimum R10';
                      if (amount > 10000) return 'Maximum R10,000';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<GooiCycleFrequency>(
                    initialValue: _frequency,
                    decoration: const InputDecoration(labelText: 'Cycle Frequency'),
                    items: GooiCycleFrequency.values
                        .map((f) => DropdownMenuItem(value: f, child: Text(f.name.toUpperCase())))
                        .toList(),
                    onChanged: (v) => setState(() => _frequency = v!),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _cyclesController,
                    decoration: InputDecoration(
                      labelText: 'Total Cycles',
                      helperText: _buildDurationHint(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n < 1) return 'Minimum 1';
                      if (n > 12) return 'Maximum 12';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<GooiRosterMethod>(
                    initialValue: _rosterMethod,
                    decoration: const InputDecoration(labelText: 'Roster Method'),
                    items: GooiRosterMethod.values
                        .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text('${m.name.toUpperCase()} — ${m.description}'),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _rosterMethod = v!),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _gracePeriodController,
                          decoration: const InputDecoration(labelText: 'Grace Period (hours)'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: TextFormField(
                          controller: _lateFeeController,
                          decoration: const InputDecoration(
                            labelText: 'Late Fee %',
                            suffixText: '%',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (v) {
                            final n = int.tryParse(v ?? '');
                            if (n != null && n > 10) return 'Max 10%';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SwitchListTile(
                    title: const Text('Recipient Also Contributes'),
                    subtitle: const Text('If off, the recipient skips their contribution for that cycle'),
                    value: _recipientContributes,
                    onChanged: (v) => setState(() => _recipientContributes = v),
                    activeThumbColor: AppColors.teal,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    onPressed: state.isActionInProgress ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: state.isActionInProgress
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Create Group'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _buildDurationHint() {
    final cycles = int.tryParse(_cyclesController.text) ?? 0;
    if (cycles <= 0) return 'How many rounds?';
    final days = cycles * _frequency.approximateDays;
    if (days < 30) return '~$days days';
    final months = (days / 30).round();
    return '~$months month${months == 1 ? '' : 's'}';
  }
}
