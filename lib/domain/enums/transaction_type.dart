import 'package:json_annotation/json_annotation.dart';

/// Financial transaction types within a community.
enum CommunityTransactionType {
  @JsonValue('contribution')
  contribution,
  @JsonValue('withdrawal')
  withdrawal,
  @JsonValue('transfer_in')
  transferIn,
  @JsonValue('transfer_out')
  transferOut,
  @JsonValue('penalty')
  penalty,
  @JsonValue('payout')
  payout;

  String get displayName => switch (this) {
        contribution => 'Contribution',
        withdrawal => 'Withdrawal',
        transferIn => 'Transfer In',
        transferOut => 'Transfer Out',
        penalty => 'Penalty',
        payout => 'Payout',
      };
}
