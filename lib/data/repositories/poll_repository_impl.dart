import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/poll.dart';
import '../../domain/repositories/poll_repository.dart';
import '../datasources/remote/poll_remote_datasource.dart';
import '../models/poll_model.dart';

@LazySingleton(as: PollRepository)
class PollRepositoryImpl implements PollRepository {
  final PollRemoteDataSource _remoteDataSource;
  final FirebaseFirestore _firestore;

  PollRepositoryImpl(this._remoteDataSource, this._firestore);

  @override
  Future<Either<Failure, PollResponse>> submitVote({
    required String pollId,
    required Map<String, dynamic> voteData,
  }) async {
    try {
      final result = await _remoteDataSource.submitVote(
        pollId: pollId,
        voteData: voteData,
      );
      final response =
          PollResponseModel.fromJson(Map<String, dynamic>.from(result['response'] as Map? ?? {}));
      return Right(response.toEntity());
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to submit vote'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PollResponse>> changeVote({
    required String pollId,
    required Map<String, dynamic> voteData,
  }) async {
    try {
      final result = await _remoteDataSource.changeVote(
        pollId: pollId,
        voteData: voteData,
      );
      final response =
          PollResponseModel.fromJson(Map<String, dynamic>.from(result['response'] as Map? ?? {}));
      return Right(response.toEntity());
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to change vote'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PollResults>> getPollResults(String pollId) async {
    try {
      final result = await _remoteDataSource.getPollResults(pollId);
      final results = result['results'] as Map? ?? {};
      return Right(PollResults(
        totalRespondents: results['totalRespondents'] as int? ?? 0,
        optionCounts: (results['optionCounts'] as Map?)?.map(
                (k, v) => MapEntry(k as String, (v as num).toInt())) ??
            {},
        percentages: (results['percentages'] as Map?)?.map(
                (k, v) => MapEntry(k as String, (v as num).toDouble())) ??
            {},
      ));
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get poll results'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Poll>> getPollById(String pollId) async {
    try {
      final doc = await _firestore.collection('polls').doc(pollId).get();
      if (!doc.exists) {
        return const Left(ServerFailure(message: 'Poll not found'));
      }
      final model = PollModel.fromJson({...doc.data()!, 'id': doc.id});
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PollResponse?>> getUserResponse(
      String pollId) async {
    try {
      // Results function returns user's response if they voted
      final result = await _remoteDataSource.getPollResults(pollId);
      final userResponse = result['userResponse'] as Map?;
      if (userResponse == null) return const Right(null);
      final model = PollResponseModel.fromJson(
          Map<String, dynamic>.from(userResponse));
      return Right(model.toEntity());
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get user response'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // --- Admin functions ---

  @override
  Future<Either<Failure, Poll>> createPoll({
    required String threadId,
    required String question,
    required List<String> options,
    bool isAnonymous = false,
    bool showResultsAfterVote = true,
    bool allowChangeVote = true,
    int tokenReward = 10,
    int durationSeconds = 15,
    Map<String, dynamic>? targeting,
    int? tokenBudget,
    int? dailyLimitPerUser,
    String? opportunityImage,
  }) async {
    try {
      final result = await _remoteDataSource.createPoll({
        'threadId': threadId,
        'question': question,
        'options': options.map((text) => {'text': text}).toList(),
        'isAnonymous': isAnonymous,
        'showResultsAfterVote': showResultsAfterVote,
        'allowChangeVote': allowChangeVote,
        'tokenReward': tokenReward,
        'durationSeconds': durationSeconds,
        if (targeting != null) 'targeting': targeting,
        if (tokenBudget != null) 'tokenBudget': tokenBudget,
        if (dailyLimitPerUser != null) 'dailyLimitPerUser': dailyLimitPerUser,
        if (opportunityImage != null) 'opportunityImage': opportunityImage,
      });

      // Fetch the created poll
      final pollId = result['pollId'] as String;
      return getPollById(pollId);
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to create poll'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePoll({
    required String pollId,
    String? question,
    List<String>? options,
    bool? isAnonymous,
    bool? showResultsAfterVote,
    bool? allowChangeVote,
  }) async {
    try {
      await _remoteDataSource.updatePoll({
        'pollId': pollId,
        if (question != null) 'question': question,
        if (options != null)
          'options': options.map((text) => {'text': text}).toList(),
        if (isAnonymous != null) 'isAnonymous': isAnonymous,
        if (showResultsAfterVote != null)
          'showResultsAfterVote': showResultsAfterVote,
        if (allowChangeVote != null) 'allowChangeVote': allowChangeVote,
      });
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to update poll'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openPoll(String pollId) async {
    try {
      await _remoteDataSource.openPoll(pollId);
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to open poll'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> closePoll(String pollId) async {
    try {
      await _remoteDataSource.closePoll(pollId);
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to close poll'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPollAdminDetails(
      String pollId) async {
    try {
      final result = await _remoteDataSource.getPollAdminDetails(pollId);
      return Right(result);
    } on FirebaseFunctionsException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to get poll admin details'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> invalidatePollResponse({
    required String pollId,
    required String userId,
    required String reason,
  }) async {
    try {
      await _remoteDataSource.invalidatePollResponse(
        pollId: pollId,
        userId: userId,
        reason: reason,
      );
      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to invalidate poll response'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
