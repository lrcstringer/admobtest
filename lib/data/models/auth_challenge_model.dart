import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_challenge.dart';

part 'auth_challenge_model.freezed.dart';
part 'auth_challenge_model.g.dart';

@freezed
abstract class AuthChallengeModel with _$AuthChallengeModel {
  const factory AuthChallengeModel({
    required String challengeId,
    required String userId,
    required String nonce,
    required String status,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? deviceId,
    DateTime? respondedAt,
  }) = _AuthChallengeModel;

  const AuthChallengeModel._();

  factory AuthChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$AuthChallengeModelFromJson(json);

  factory AuthChallengeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return AuthChallengeModel(
      challengeId: doc.id,
      userId: data['userId'] as String,
      nonce: data['nonce'] as String,
      status: data['status'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      expiresAt: (data['expiresAt'] as Timestamp).toDate(),
      deviceId: data['deviceId'] as String?,
      respondedAt: data['respondedAt'] != null
          ? (data['respondedAt'] as Timestamp).toDate()
          : null,
    );
  }

  AuthChallenge toEntity() {
    return AuthChallenge(
      challengeId: challengeId,
      userId: userId,
      nonce: nonce,
      status: _parseStatus(status),
      createdAt: createdAt,
      expiresAt: expiresAt,
      deviceId: deviceId,
      respondedAt: respondedAt,
    );
  }

  static ChallengeStatus _parseStatus(String status) {
    switch (status) {
      case 'pending':
        return ChallengeStatus.pending;
      case 'approved':
        return ChallengeStatus.approved;
      case 'denied':
        return ChallengeStatus.denied;
      case 'expired':
        return ChallengeStatus.expired;
      default:
        return ChallengeStatus.pending;
    }
  }
}
