import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/gooi/gooi_formation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiInviteScreen extends StatefulWidget {
  final String groupId;
  const GooiInviteScreen({super.key, required this.groupId});

  @override
  State<GooiInviteScreen> createState() => _GooiInviteScreenState();
}

class _GooiInviteScreenState extends State<GooiInviteScreen> {
  final _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GooiFormationBloc>().add(GooiFormationEvent.loadGroup(widget.groupId));
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _invite() {
    final userId = _userIdController.text.trim();
    if (userId.isEmpty) return;
    context.read<GooiFormationBloc>().add(GooiFormationEvent.inviteMember(inviteeUserId: userId));
    _userIdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invite Members')),
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
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.group != null) ...[
                  Text(
                    state.group!.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'R${(state.group!.contributionAmount / 100).toStringAsFixed(0)} per cycle',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                Text(
                  'Members (${state.members.length})',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                if (state.members.isNotEmpty)
                  ...state.members.map((m) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.teal.withValues(alpha: 0.2),
                          child: Text(m.displayName.isNotEmpty ? m.displayName[0] : '?'),
                        ),
                        title: Text(m.displayName),
                        subtitle: Text(m.status.name.toUpperCase()),
                        trailing: m.role.name == 'INITIATOR'
                            ? const Chip(label: Text('Initiator'))
                            : null,
                      )),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _userIdController,
                        decoration: const InputDecoration(
                          hintText: 'Enter user ID to invite',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton.filled(
                      onPressed: state.isActionInProgress ? null : _invite,
                      icon: const Icon(Icons.person_add),
                      style: IconButton.styleFrom(backgroundColor: AppColors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: state.members.length >= 2
                      ? () => context.push('/chat/gooi/${widget.groupId}/roster')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Continue to Roster'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
