import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/gift_style.dart';
import '../../blocs/gift/gift_bloc.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gift/gift_style_picker.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Screen for composing and sending a gift.
/// Reached via /chat/conversation/:id/send-gift or /chat/community/:id/send-gift
class GiftComposerScreen extends StatefulWidget {
  final String recipientId;
  final String recipientName;
  final String? conversationId;
  final String? communityId;

  const GiftComposerScreen({
    super.key,
    required this.recipientId,
    required this.recipientName,
    this.conversationId,
    this.communityId,
  });

  @override
  State<GiftComposerScreen> createState() => _GiftComposerScreenState();
}

class _GiftComposerScreenState extends State<GiftComposerScreen> {
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GiftStyle _selectedStyle = GiftStyle.celebration;

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onSend() {
    if (!_formKey.currentState!.validate()) return;

    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount < 10) return;

    context.read<GiftBloc>().add(GiftEvent.sendGift(
      recipientId: widget.recipientId,
      amount: amount,
      message: _messageController.text.trim(),
      style: _selectedStyle,
      conversationId: widget.conversationId,
      communityId: widget.communityId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Sasaza ${widget.recipientName}'),
      body: WaveBackground(
        child: BlocConsumer<GiftBloc, GiftState>(
        listener: (context, state) {
          if (state.activeGift != null && !state.isSending) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gift sent!')),
            );
            context.pop();
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
            context.read<GiftBloc>().add(const GiftEvent.clearError());
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                // Gift style picker
                Text(
                  'Choose a style',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                GiftStylePicker(
                  selected: _selectedStyle,
                  onChanged: (style) => setState(() => _selectedStyle = style),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Amount
                Text(
                  'Amount (tokens)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Min 10 tokens',
                    prefixIcon: Icon(Icons.toll),
                  ),
                  validator: (value) {
                    final amount = int.tryParse(value ?? '');
                    if (amount == null || amount < 10) {
                      return 'Minimum gift is 10 tokens';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),

                // Quick amount chips
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [50, 100, 200, 500].map((amount) {
                    return ActionChip(
                      label: Text('$amount'),
                      onPressed: () {
                        _amountController.text = '$amount';
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Personal message
                Text(
                  'Personal message',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: _messageController,
                  maxLines: 3,
                  maxLength: 100,
                  decoration: const InputDecoration(
                    hintText: 'Write a personal message...',
                    prefixIcon: Icon(Icons.message),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please write a message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // Send button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: state.isSending ? null : _onSend,
                    icon: state.isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.card_giftcard),
                    label: Text(state.isSending ? 'Sending...' : 'Sasaza!'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
