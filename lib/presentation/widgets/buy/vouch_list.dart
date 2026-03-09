import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/vouch.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Displays a list of vouches (reviews) for a marketplace provider.
class VouchList extends StatelessWidget {
  final List<Vouch> vouches;

  const VouchList({super.key, required this.vouches});

  @override
  Widget build(BuildContext context) {
    if (vouches.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Center(
          child: Text(
            'No vouches yet',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vouches.length,
      separatorBuilder: (_, __) => const Divider(
        color: AppColors.border,
        height: 1,
      ),
      itemBuilder: (_, index) => _VouchCard(vouch: vouches[index]),
    );
  }
}

class _VouchCard extends StatelessWidget {
  final Vouch vouch;

  const _VouchCard({required this.vouch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceElevated,
            backgroundImage: vouch.voucherPhotoUrl != null
                ? CachedNetworkImageProvider(vouch.voucherPhotoUrl!)
                : null,
            child: vouch.voucherPhotoUrl == null
                ? Text(
                    vouch.voucherName.isNotEmpty
                        ? vouch.voucherName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + rating + date
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        vouch.voucherName,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Stars
                    ...List.generate(
                      5,
                      (i) => Icon(
                        i < vouch.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: 14,
                        color: i < vouch.rating
                            ? AppColors.warning
                            : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                if (vouch.comment != null && vouch.comment!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    vouch.comment!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 2),
                Text(
                  DateFormat.yMMMd().format(vouch.createdAt),
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
