import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/call_status.dart';
import '../../../domain/enums/call_type.dart';
import '../../blocs/call/call_bloc.dart';

/// Floating banner shown at the top of the app when the user navigates away
/// from an active call screen. Tapping it returns to the call.
///
/// Placed inside [MainShell] so it appears above all tab content.
class ActiveCallOverlay extends StatelessWidget {
  const ActiveCallOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.callDuration != curr.callDuration,
      builder: (context, state) {
        // Only show when there's an active/reconnecting call
        final isInCall = state.status == CallStatus.active ||
            state.status == CallStatus.reconnecting ||
            state.status == CallStatus.connecting;
        if (!isInCall || state.callId == null) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => _returnToCall(context, state),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: state.status == CallStatus.reconnecting
                  ? Colors.orange
                  : Colors.green,
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Icon(
                    state.callType == CallType.video
                        ? Icons.videocam
                        : Icons.call,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.status == CallStatus.reconnecting
                          ? 'Reconnecting...'
                          : 'Tap to return to call',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    _formatDuration(state.callDuration),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _returnToCall(BuildContext context, CallState state) {
    if (state.callId == null || state.conversationId == null) return;
    context.push(
      '/chat/conversation/${state.conversationId}/call/${state.callId}',
      extra: {'isVideo': state.callType == CallType.video},
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = d.inHours;
    if (hours > 0) return '$hours:$minutes:$seconds';
    return '$minutes:$seconds';
  }
}
