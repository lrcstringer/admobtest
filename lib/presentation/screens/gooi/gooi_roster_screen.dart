import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/gooi_member.dart';
import '../../blocs/gooi/gooi_formation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiRosterScreen extends StatefulWidget {
  final String groupId;
  const GooiRosterScreen({super.key, required this.groupId});

  @override
  State<GooiRosterScreen> createState() => _GooiRosterScreenState();
}

class _GooiRosterScreenState extends State<GooiRosterScreen> {
  List<GooiMember> _orderedMembers = [];

  @override
  void initState() {
    super.initState();
    context.read<GooiFormationBloc>().add(GooiFormationEvent.loadGroup(widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: AppBar(
        backgroundColor: AppColors.chatBackground,
        title: const Text('Roster Order'),
      ),
      body: BlocConsumer<GooiFormationBloc, GooiFormationState>(
        listener: (context, state) {
          if (state.members.isNotEmpty && _orderedMembers.isEmpty) {
            setState(() => _orderedMembers = List.from(state.members));
          }
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionSuccess!)),
            );
            if (state.rosterOrder.isNotEmpty) {
              context.push('/chat/gooi/${widget.groupId}/confirm');
            }
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

          final isAgreed = state.group?.rosterMethod.name == 'agreed';

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isAgreed
                      ? 'Drag to reorder the roster'
                      : 'The roster will be assigned by ${state.group?.rosterMethod.name.toUpperCase() ?? "system"}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: isAgreed
                      ? ReorderableListView.builder(
                          itemCount: _orderedMembers.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex--;
                              final item = _orderedMembers.removeAt(oldIndex);
                              _orderedMembers.insert(newIndex, item);
                            });
                          },
                          itemBuilder: (context, index) {
                            final member = _orderedMembers[index];
                            return ListTile(
                              key: ValueKey(member.id),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.teal,
                                child: Text('${index + 1}'),
                              ),
                              title: Text(member.displayName),
                              trailing: const Icon(Icons.drag_handle),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: state.members.length,
                          itemBuilder: (context, index) {
                            final member = state.members[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.teal.withValues(alpha: 0.3),
                                child: Text('${index + 1}'),
                              ),
                              title: Text(member.displayName),
                            );
                          },
                        ),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: state.isActionInProgress
                      ? null
                      : () {
                          final order = isAgreed
                              ? _orderedMembers.map((m) => m.userId).toList()
                              : null;
                          context.read<GooiFormationBloc>().add(
                                GooiFormationEvent.lockRoster(proposedOrder: order),
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: state.isActionInProgress
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Lock Roster'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
