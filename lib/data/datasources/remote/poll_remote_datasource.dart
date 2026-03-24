import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

/// Remote data source for poll operations via Cloud Functions
@lazySingleton
class PollRemoteDataSource {
  final FirebaseFunctions _functions;

  PollRemoteDataSource(this._functions);

  /// Submit a vote (polymorphic data based on questionType)
  Future<Map<String, dynamic>> submitVote({
    required String pollId,
    required Map<String, dynamic> voteData,
  }) async {
    final result = await _functions.httpsCallable('submitPollVote').call({
      'pollId': pollId,
      ...voteData,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Change an existing vote (polymorphic data based on questionType)
  Future<Map<String, dynamic>> changeVote({
    required String pollId,
    required Map<String, dynamic> voteData,
  }) async {
    final result = await _functions.httpsCallable('changePollVote').call({
      'pollId': pollId,
      ...voteData,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Get poll results
  Future<Map<String, dynamic>> getPollResults(String pollId) async {
    final result = await _functions.httpsCallable('getPollResults').call({
      'pollId': pollId,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Create a new poll (admin)
  Future<Map<String, dynamic>> createPoll(Map<String, dynamic> data) async {
    final result = await _functions.httpsCallable('createPoll').call(data);
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Update a poll (admin)
  Future<Map<String, dynamic>> updatePoll(Map<String, dynamic> data) async {
    final result = await _functions.httpsCallable('updatePoll').call(data);
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Open a poll (admin)
  Future<Map<String, dynamic>> openPoll(String pollId) async {
    final result = await _functions.httpsCallable('openPoll').call({
      'pollId': pollId,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Close a poll (admin)
  Future<Map<String, dynamic>> closePoll(String pollId) async {
    final result = await _functions.httpsCallable('closePoll').call({
      'pollId': pollId,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Get admin details for a poll
  Future<Map<String, dynamic>> getPollAdminDetails(String pollId) async {
    final result =
        await _functions.httpsCallable('getPollAdminDetails').call({
      'pollId': pollId,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }

  /// Invalidate a poll response (admin)
  Future<Map<String, dynamic>> invalidatePollResponse({
    required String pollId,
    required String userId,
    required String reason,
  }) async {
    final result =
        await _functions.httpsCallable('invalidatePollResponse').call({
      'pollId': pollId,
      'userId': userId,
      'reason': reason,
    });
    return Map<String, dynamic>.from(result.data as Map);
  }
}
