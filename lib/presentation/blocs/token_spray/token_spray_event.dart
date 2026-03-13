part of 'token_spray_bloc.dart';

@freezed
abstract class TokenSprayEvent with _$TokenSprayEvent {
  const factory TokenSprayEvent.createSpray({
    required String recipientId,
    required SprayOccasion occasion,
    required String message,
    int? targetAmount,
  }) = _CreateSpray;

  const factory TokenSprayEvent.contribute({
    required String sprayId,
    required int amount,
    String? message,
  }) = _Contribute;

  const factory TokenSprayEvent.closeSpray(String sprayId) = _CloseSpray;
  const factory TokenSprayEvent.claimSpray(String sprayId) = _ClaimSpray;

  const factory TokenSprayEvent.watchSpray(String sprayId) = _WatchSpray;
  const factory TokenSprayEvent.sprayUpdated(TokenSpray spray) = _SprayUpdated;

  const factory TokenSprayEvent.loadHistory() = _LoadHistory;

  const factory TokenSprayEvent.clearError() = _ClearError;
}
