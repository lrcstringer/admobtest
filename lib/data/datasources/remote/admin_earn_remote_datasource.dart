import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

/// Admin earn remote data source for managing earn threads, opportunities, and clients
@lazySingleton
class AdminEarnRemoteDataSource {
  final FirebaseFunctions _functions;

  AdminEarnRemoteDataSource(this._functions);

  // ============================================================================
  // STATISTICS
  // ============================================================================

  /// Get overall earn statistics
  Future<Map<String, dynamic>> getEarnStatistics() async {
    final callable = _functions.httpsCallable('getEarnStatistics');
    final result = await callable.call<Map<String, dynamic>>({});
    return result.data;
  }

  /// Get targeting options for admin UI dropdowns
  Future<Map<String, dynamic>> getTargetingOptions() async {
    final callable = _functions.httpsCallable('getTargetingOptions');
    final result = await callable.call<Map<String, dynamic>>({});
    return result.data['options'] as Map<String, dynamic>;
  }

  /// Get detailed statistics for a specific client
  Future<Map<String, dynamic>> getClientStats(String clientId) async {
    final callable = _functions.httpsCallable('getClientStats');
    final result = await callable.call<Map<String, dynamic>>({
      'clientId': clientId,
    });
    return result.data;
  }

  /// Get engagement analytics for a specific thread
  Future<Map<String, dynamic>> getThreadAnalytics(
    String threadId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final callable = _functions.httpsCallable('getThreadAnalytics');
    final result = await callable.call<Map<String, dynamic>>({
      'threadId': threadId,
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    return result.data;
  }

  // ============================================================================
  // THREAD MANAGEMENT
  // ============================================================================

  /// Create or update an earn thread
  Future<String> createOrUpdateThread({
    String? id,
    required String clientId,
    required String title,
    String? description,
    required String tokenSourceSubAccountId,
    String? tokenDestAccountTypeId,
    bool isPinned = false,
    bool isFeatured = false,
    bool isActive = true,
    DateTime? activeFrom,
    DateTime? activeTo,
    Map<String, dynamic>? targeting,
  }) async {
    final callable = _functions.httpsCallable('createEarnThread');
    final result = await callable.call<Map<String, dynamic>>({
      if (id != null) 'id': id,
      'clientId': clientId,
      'title': title,
      if (description != null) 'description': description,
      'tokenSourceSubAccountId': tokenSourceSubAccountId,
      if (tokenDestAccountTypeId != null)
        'tokenDestAccountTypeId': tokenDestAccountTypeId,
      'isPinned': isPinned,
      'isFeatured': isFeatured,
      'isActive': isActive,
      if (activeFrom != null) 'activeFrom': activeFrom.toIso8601String(),
      if (activeTo != null) 'activeTo': activeTo.toIso8601String(),
      if (targeting != null) 'targeting': targeting,
    });
    return result.data['threadId'] as String;
  }

  // ============================================================================
  // OPPORTUNITY MANAGEMENT
  // ============================================================================

  /// Create or update an earn opportunity
  Future<String> createOrUpdateOpportunity({
    String? id,
    required String threadId,
    required String title,
    String? description,
    required String earningType,
    required int tokenReward,
    String mediaType = 'video',
    String? mediaUrl,
    List<Map<String, dynamic>> questions = const [],
    required int durationSeconds,
    DateTime? expiresAt,
    bool isActive = true,
    Map<String, dynamic>? targeting,
  }) async {
    final callable = _functions.httpsCallable('createEarnOpportunity');
    final result = await callable.call<Map<String, dynamic>>({
      if (id != null) 'id': id,
      'threadId': threadId,
      'title': title,
      if (description != null) 'description': description,
      'earningType': earningType,
      'tokenReward': tokenReward,
      'mediaType': mediaType,
      if (mediaUrl != null) 'mediaUrl': mediaUrl,
      'questions': questions,
      'durationSeconds': durationSeconds,
      if (expiresAt != null) 'expiresAt': expiresAt.toIso8601String(),
      'isActive': isActive,
      if (targeting != null) 'targeting': targeting,
    });
    return result.data['opportunityId'] as String;
  }

  // ============================================================================
  // CLIENT MANAGEMENT
  // ============================================================================

  /// Create a new client
  Future<String> createClient({
    String? id,
    required String companyName,
    required String displayName,
    String? contactEmail,
    String? contactPhone,
    String? avatarImage,
    String? avatarColor,
    String? industry,
    String? companyRegistration,
    String? vatNumber,
    bool isActive = true,
  }) async {
    final callable = _functions.httpsCallable('adminCreateClient');
    final result = await callable.call<Map<String, dynamic>>({
      if (id != null) 'id': id,
      'companyName': companyName,
      'displayName': displayName,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (contactPhone != null) 'contactPhone': contactPhone,
      if (avatarImage != null) 'avatarImage': avatarImage,
      if (avatarColor != null) 'avatarColor': avatarColor,
      if (industry != null) 'industry': industry,
      if (companyRegistration != null)
        'companyRegistration': companyRegistration,
      if (vatNumber != null) 'vatNumber': vatNumber,
      'isActive': isActive,
    });
    return result.data['clientId'] as String;
  }

  /// Update a client
  Future<void> updateClient({
    required String clientId,
    String? companyName,
    String? displayName,
    String? contactEmail,
    String? contactPhone,
    String? avatarImage,
    String? avatarColor,
    String? industry,
    String? companyRegistration,
    String? vatNumber,
    bool? isActive,
  }) async {
    final callable = _functions.httpsCallable('adminUpdateClient');
    await callable.call<Map<String, dynamic>>({
      'clientId': clientId,
      if (companyName != null) 'companyName': companyName,
      if (displayName != null) 'displayName': displayName,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (contactPhone != null) 'contactPhone': contactPhone,
      if (avatarImage != null) 'avatarImage': avatarImage,
      if (avatarColor != null) 'avatarColor': avatarColor,
      if (industry != null) 'industry': industry,
      if (companyRegistration != null)
        'companyRegistration': companyRegistration,
      if (vatNumber != null) 'vatNumber': vatNumber,
      if (isActive != null) 'isActive': isActive,
    });
  }

  /// List all clients
  Future<List<Map<String, dynamic>>> listClients({
    bool? activeOnly,
    int? limit,
  }) async {
    final callable = _functions.httpsCallable('adminListClients');
    final result = await callable.call<Map<String, dynamic>>({
      if (activeOnly != null) 'activeOnly': activeOnly,
      if (limit != null) 'limit': limit,
    });
    return (result.data['clients'] as List).cast<Map<String, dynamic>>();
  }

  /// Get client by ID
  Future<Map<String, dynamic>> getClient(String clientId) async {
    final callable = _functions.httpsCallable('adminGetClient');
    final result = await callable.call<Map<String, dynamic>>({
      'clientId': clientId,
    });
    return result.data['client'] as Map<String, dynamic>;
  }

  /// Delete (deactivate) a client
  Future<void> deleteClient(String clientId) async {
    final callable = _functions.httpsCallable('adminDeleteClient');
    await callable.call<Map<String, dynamic>>({
      'clientId': clientId,
    });
  }

  /// Fund a client sub-account
  Future<void> fundClientSubAccount({
    required String clientId,
    required String subAccountId,
    required int amount,
    String? note,
  }) async {
    final callable = _functions.httpsCallable('adminFundClientSubAccount');
    await callable.call<Map<String, dynamic>>({
      'clientId': clientId,
      'subAccountId': subAccountId,
      'amount': amount,
      if (note != null) 'note': note,
    });
  }
}
