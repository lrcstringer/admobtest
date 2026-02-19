import 'package:freezed_annotation/freezed_annotation.dart';

/// Type of community
enum CommunityType {
  /// Standard community group
  @JsonValue('regular')
  regular,

  /// Stokvel community with full financial lifecycle
  @JsonValue('stokvel')
  stokvel,
}

extension CommunityTypeX on CommunityType {
  String get displayName {
    switch (this) {
      case CommunityType.regular:
        return 'Community';
      case CommunityType.stokvel:
        return 'Stokvel';
    }
  }
}
