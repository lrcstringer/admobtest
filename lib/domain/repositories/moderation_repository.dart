import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../enums/report_reason.dart';
import '../enums/report_type.dart';

/// Repository for block/report/message-deletion moderation operations.
abstract class ModerationRepository {
  /// Block a user — hides conversations, prevents new messages.
  Future<Either<Failure, void>> blockUser(String userId);

  /// Unblock a previously blocked user.
  Future<Either<Failure, void>> unblockUser(String userId);

  /// Get the current user's list of blocked user IDs.
  Future<Either<Failure, List<String>>> getBlockedUserIds();

  /// Submit a report against a user, message, or community.
  Future<Either<Failure, void>> submitReport({
    required ReportType type,
    required String targetId,
    required ReportReason reason,
    String? additionalInfo,
  });

  /// Delete a message for the current user only.
  Future<Either<Failure, void>> deleteMessageForMe({
    required String parentCollection,
    required String parentId,
    required String messageId,
  });

  /// Delete a message for everyone (sender only, within 1 hour).
  Future<Either<Failure, void>> deleteMessageForEveryone({
    required String parentCollection,
    required String parentId,
    required String messageId,
  });
}
