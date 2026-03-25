import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_result.freezed.dart';
part 'user_search_result.g.dart';

@freezed
abstract class UserSearchResult with _$UserSearchResult {
  const factory UserSearchResult({
    required String userId,
    required String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String? phoneNumber,
  }) = _UserSearchResult;

  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultFromJson(json);
}
