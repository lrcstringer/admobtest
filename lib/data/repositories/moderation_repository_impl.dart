import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/enums/report_reason.dart';
import '../../domain/enums/report_type.dart';
import '../../domain/repositories/moderation_repository.dart';
import '../datasources/remote/moderation_remote_datasource.dart';

@LazySingleton(as: ModerationRepository)
class ModerationRepositoryImpl implements ModerationRepository {
  final ModerationRemoteDatasource _datasource;

  ModerationRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, void>> blockUser(String userId) async {
    try {
      await _datasource.blockUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unblockUser(String userId) async {
    try {
      await _datasource.unblockUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getBlockedUserIds() async {
    try {
      final ids = await _datasource.getBlockedUserIds();
      return Right(ids);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitReport({
    required ReportType type,
    required String targetId,
    required ReportReason reason,
    String? additionalInfo,
  }) async {
    try {
      await _datasource.submitReport(
        type: type.name,
        targetId: targetId,
        reason: _reasonToString(reason),
        additionalInfo: additionalInfo,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessageForMe({
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    try {
      await _datasource.deleteMessageForMe(
        parentCollection: parentCollection,
        parentId: parentId,
        messageId: messageId,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessageForEveryone({
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    try {
      await _datasource.deleteMessageForEveryone(
        parentCollection: parentCollection,
        parentId: parentId,
        messageId: messageId,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  String _reasonToString(ReportReason reason) => switch (reason) {
        ReportReason.spam => 'spam',
        ReportReason.harassment => 'harassment',
        ReportReason.inappropriateContent => 'inappropriate_content',
        ReportReason.scam => 'scam',
        ReportReason.other => 'other',
      };
}
