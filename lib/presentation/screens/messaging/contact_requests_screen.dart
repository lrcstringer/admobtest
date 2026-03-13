import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/contact.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Screen showing incoming pending contact requests with accept/decline actions.
class ContactRequestsScreen extends StatelessWidget {
  const ContactRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: const IMaliAppBar(
        title: 'Contact Requests',
        backgroundColor: AppColors.chatAppBar,
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          final requests = state.contactRequests;

          if (requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add_disabled,
                      size: 64, color: AppColors.textHint),
                  const SizedBox(height: 16),
                  Text(
                    'No pending requests',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: requests.length,
            separatorBuilder: (_, _) => Divider(
              height: 0.5,
              thickness: 0.5,
              color: AppColors.chatSurface.withValues(alpha: 0.3),
              indent: 76,
            ),
            itemBuilder: (context, index) {
              return _buildRequestTile(context, requests[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildRequestTile(BuildContext context, Contact contact) {
    return Dismissible(
      key: Key(contact.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.error,
        child: const Icon(Icons.close, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        context
            .read<ContactBloc>()
            .add(ContactEvent.declineContactRequest(contact.id));
        return false; // Let the stream update handle removal
      },
      child: ListTile(
        leading: _buildAvatar(contact),
        title: Text(
          contact.displayName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: contact.username != null
            ? Text(
                '@${contact.username}',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Accept button
            FilledButton.tonal(
              onPressed: () {
                context
                    .read<ContactBloc>()
                    .add(ContactEvent.acceptContactRequest(contact.id));
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                foregroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: Size.zero,
              ),
              child: const Text('Accept'),
            ),
            const SizedBox(width: 8),
            // Decline button
            OutlinedButton(
              onPressed: () {
                context
                    .read<ContactBloc>()
                    .add(ContactEvent.declineContactRequest(contact.id));
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: BorderSide(
                    color: AppColors.chatSurface.withValues(alpha: 0.5)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
              ),
              child: const Text('Decline'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(Contact contact) {
    const double size = 48;
    const double radius = 6;

    final initialsWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _avatarColor(contact.avatarColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        contact.initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );

    if (contact.avatarUrl != null && contact.avatarUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: contact.avatarUrl!,
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, _) => initialsWidget,
        errorWidget: (_, _, _) => initialsWidget,
      );
    }

    return initialsWidget;
  }

  Color _avatarColor(String? colorStr) {
    if (colorStr != null && colorStr.isNotEmpty) {
      try {
        return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return AppColors.primary;
  }
}
