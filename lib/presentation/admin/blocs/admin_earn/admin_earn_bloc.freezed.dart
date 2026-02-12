// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_earn_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminEarnEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminEarnEventCopyWith<$Res> {
  factory $AdminEarnEventCopyWith(
    AdminEarnEvent value,
    $Res Function(AdminEarnEvent) then,
  ) = _$AdminEarnEventCopyWithImpl<$Res, AdminEarnEvent>;
}

/// @nodoc
class _$AdminEarnEventCopyWithImpl<$Res, $Val extends AdminEarnEvent>
    implements $AdminEarnEventCopyWith<$Res> {
  _$AdminEarnEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadStatisticsImplCopyWith<$Res> {
  factory _$$LoadStatisticsImplCopyWith(
    _$LoadStatisticsImpl value,
    $Res Function(_$LoadStatisticsImpl) then,
  ) = __$$LoadStatisticsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadStatisticsImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadStatisticsImpl>
    implements _$$LoadStatisticsImplCopyWith<$Res> {
  __$$LoadStatisticsImplCopyWithImpl(
    _$LoadStatisticsImpl _value,
    $Res Function(_$LoadStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadStatisticsImpl implements _LoadStatistics {
  const _$LoadStatisticsImpl();

  @override
  String toString() {
    return 'AdminEarnEvent.loadStatistics()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadStatisticsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadStatistics();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadStatistics?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadStatistics != null) {
      return loadStatistics();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadStatistics(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadStatistics?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadStatistics != null) {
      return loadStatistics(this);
    }
    return orElse();
  }
}

abstract class _LoadStatistics implements AdminEarnEvent {
  const factory _LoadStatistics() = _$LoadStatisticsImpl;
}

/// @nodoc
abstract class _$$LoadTargetingOptionsImplCopyWith<$Res> {
  factory _$$LoadTargetingOptionsImplCopyWith(
    _$LoadTargetingOptionsImpl value,
    $Res Function(_$LoadTargetingOptionsImpl) then,
  ) = __$$LoadTargetingOptionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadTargetingOptionsImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadTargetingOptionsImpl>
    implements _$$LoadTargetingOptionsImplCopyWith<$Res> {
  __$$LoadTargetingOptionsImplCopyWithImpl(
    _$LoadTargetingOptionsImpl _value,
    $Res Function(_$LoadTargetingOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadTargetingOptionsImpl implements _LoadTargetingOptions {
  const _$LoadTargetingOptionsImpl();

  @override
  String toString() {
    return 'AdminEarnEvent.loadTargetingOptions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTargetingOptionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadTargetingOptions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadTargetingOptions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadTargetingOptions != null) {
      return loadTargetingOptions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadTargetingOptions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadTargetingOptions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadTargetingOptions != null) {
      return loadTargetingOptions(this);
    }
    return orElse();
  }
}

abstract class _LoadTargetingOptions implements AdminEarnEvent {
  const factory _LoadTargetingOptions() = _$LoadTargetingOptionsImpl;
}

/// @nodoc
abstract class _$$LoadClientStatsImplCopyWith<$Res> {
  factory _$$LoadClientStatsImplCopyWith(
    _$LoadClientStatsImpl value,
    $Res Function(_$LoadClientStatsImpl) then,
  ) = __$$LoadClientStatsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId});
}

/// @nodoc
class __$$LoadClientStatsImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadClientStatsImpl>
    implements _$$LoadClientStatsImplCopyWith<$Res> {
  __$$LoadClientStatsImplCopyWithImpl(
    _$LoadClientStatsImpl _value,
    $Res Function(_$LoadClientStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null}) {
    return _then(
      _$LoadClientStatsImpl(
        null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadClientStatsImpl implements _LoadClientStats {
  const _$LoadClientStatsImpl(this.clientId);

  @override
  final String clientId;

  @override
  String toString() {
    return 'AdminEarnEvent.loadClientStats(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadClientStatsImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadClientStatsImplCopyWith<_$LoadClientStatsImpl> get copyWith =>
      __$$LoadClientStatsImplCopyWithImpl<_$LoadClientStatsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadClientStats(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadClientStats?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadClientStats != null) {
      return loadClientStats(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadClientStats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadClientStats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadClientStats != null) {
      return loadClientStats(this);
    }
    return orElse();
  }
}

abstract class _LoadClientStats implements AdminEarnEvent {
  const factory _LoadClientStats(final String clientId) = _$LoadClientStatsImpl;

  String get clientId;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadClientStatsImplCopyWith<_$LoadClientStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadThreadAnalyticsImplCopyWith<$Res> {
  factory _$$LoadThreadAnalyticsImplCopyWith(
    _$LoadThreadAnalyticsImpl value,
    $Res Function(_$LoadThreadAnalyticsImpl) then,
  ) = __$$LoadThreadAnalyticsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId, DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$$LoadThreadAnalyticsImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadThreadAnalyticsImpl>
    implements _$$LoadThreadAnalyticsImplCopyWith<$Res> {
  __$$LoadThreadAnalyticsImplCopyWithImpl(
    _$LoadThreadAnalyticsImpl _value,
    $Res Function(_$LoadThreadAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(
      _$LoadThreadAnalyticsImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$LoadThreadAnalyticsImpl implements _LoadThreadAnalytics {
  const _$LoadThreadAnalyticsImpl({
    required this.threadId,
    this.startDate,
    this.endDate,
  });

  @override
  final String threadId;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'AdminEarnEvent.loadThreadAnalytics(threadId: $threadId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadThreadAnalyticsImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId, startDate, endDate);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadThreadAnalyticsImplCopyWith<_$LoadThreadAnalyticsImpl> get copyWith =>
      __$$LoadThreadAnalyticsImplCopyWithImpl<_$LoadThreadAnalyticsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadThreadAnalytics(threadId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadThreadAnalytics?.call(threadId, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadThreadAnalytics != null) {
      return loadThreadAnalytics(threadId, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadThreadAnalytics(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadThreadAnalytics?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadThreadAnalytics != null) {
      return loadThreadAnalytics(this);
    }
    return orElse();
  }
}

abstract class _LoadThreadAnalytics implements AdminEarnEvent {
  const factory _LoadThreadAnalytics({
    required final String threadId,
    final DateTime? startDate,
    final DateTime? endDate,
  }) = _$LoadThreadAnalyticsImpl;

  String get threadId;
  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadThreadAnalyticsImplCopyWith<_$LoadThreadAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadClientsImplCopyWith<$Res> {
  factory _$$LoadClientsImplCopyWith(
    _$LoadClientsImpl value,
    $Res Function(_$LoadClientsImpl) then,
  ) = __$$LoadClientsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool? activeOnly});
}

/// @nodoc
class __$$LoadClientsImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadClientsImpl>
    implements _$$LoadClientsImplCopyWith<$Res> {
  __$$LoadClientsImplCopyWithImpl(
    _$LoadClientsImpl _value,
    $Res Function(_$LoadClientsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? activeOnly = freezed}) {
    return _then(
      _$LoadClientsImpl(
        activeOnly: freezed == activeOnly
            ? _value.activeOnly
            : activeOnly // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$LoadClientsImpl implements _LoadClients {
  const _$LoadClientsImpl({this.activeOnly});

  @override
  final bool? activeOnly;

  @override
  String toString() {
    return 'AdminEarnEvent.loadClients(activeOnly: $activeOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadClientsImpl &&
            (identical(other.activeOnly, activeOnly) ||
                other.activeOnly == activeOnly));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeOnly);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadClientsImplCopyWith<_$LoadClientsImpl> get copyWith =>
      __$$LoadClientsImplCopyWithImpl<_$LoadClientsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadClients(activeOnly);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadClients?.call(activeOnly);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadClients != null) {
      return loadClients(activeOnly);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadClients(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadClients?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadClients != null) {
      return loadClients(this);
    }
    return orElse();
  }
}

abstract class _LoadClients implements AdminEarnEvent {
  const factory _LoadClients({final bool? activeOnly}) = _$LoadClientsImpl;

  bool? get activeOnly;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadClientsImplCopyWith<_$LoadClientsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateClientImplCopyWith<$Res> {
  factory _$$CreateClientImplCopyWith(
    _$CreateClientImpl value,
    $Res Function(_$CreateClientImpl) then,
  ) = __$$CreateClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String? id,
    String companyName,
    String displayName,
    String? contactEmail,
    String? contactPhone,
    String? avatarImage,
    String? avatarColor,
    String? industry,
    String? companyRegistration,
    String? vatNumber,
  });
}

/// @nodoc
class __$$CreateClientImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$CreateClientImpl>
    implements _$$CreateClientImplCopyWith<$Res> {
  __$$CreateClientImplCopyWithImpl(
    _$CreateClientImpl _value,
    $Res Function(_$CreateClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? companyName = null,
    Object? displayName = null,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? avatarImage = freezed,
    Object? avatarColor = freezed,
    Object? industry = freezed,
    Object? companyRegistration = freezed,
    Object? vatNumber = freezed,
  }) {
    return _then(
      _$CreateClientImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        contactEmail: freezed == contactEmail
            ? _value.contactEmail
            : contactEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactPhone: freezed == contactPhone
            ? _value.contactPhone
            : contactPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarImage: freezed == avatarImage
            ? _value.avatarImage
            : avatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        industry: freezed == industry
            ? _value.industry
            : industry // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyRegistration: freezed == companyRegistration
            ? _value.companyRegistration
            : companyRegistration // ignore: cast_nullable_to_non_nullable
                  as String?,
        vatNumber: freezed == vatNumber
            ? _value.vatNumber
            : vatNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CreateClientImpl implements _CreateClient {
  const _$CreateClientImpl({
    this.id,
    required this.companyName,
    required this.displayName,
    this.contactEmail,
    this.contactPhone,
    this.avatarImage,
    this.avatarColor,
    this.industry,
    this.companyRegistration,
    this.vatNumber,
  });

  @override
  final String? id;
  @override
  final String companyName;
  @override
  final String displayName;
  @override
  final String? contactEmail;
  @override
  final String? contactPhone;
  @override
  final String? avatarImage;
  @override
  final String? avatarColor;
  @override
  final String? industry;
  @override
  final String? companyRegistration;
  @override
  final String? vatNumber;

  @override
  String toString() {
    return 'AdminEarnEvent.createClient(id: $id, companyName: $companyName, displayName: $displayName, contactEmail: $contactEmail, contactPhone: $contactPhone, avatarImage: $avatarImage, avatarColor: $avatarColor, industry: $industry, companyRegistration: $companyRegistration, vatNumber: $vatNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.avatarImage, avatarImage) ||
                other.avatarImage == avatarImage) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.companyRegistration, companyRegistration) ||
                other.companyRegistration == companyRegistration) &&
            (identical(other.vatNumber, vatNumber) ||
                other.vatNumber == vatNumber));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    companyName,
    displayName,
    contactEmail,
    contactPhone,
    avatarImage,
    avatarColor,
    industry,
    companyRegistration,
    vatNumber,
  );

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateClientImplCopyWith<_$CreateClientImpl> get copyWith =>
      __$$CreateClientImplCopyWithImpl<_$CreateClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return createClient(
      id,
      companyName,
      displayName,
      contactEmail,
      contactPhone,
      avatarImage,
      avatarColor,
      industry,
      companyRegistration,
      vatNumber,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return createClient?.call(
      id,
      companyName,
      displayName,
      contactEmail,
      contactPhone,
      avatarImage,
      avatarColor,
      industry,
      companyRegistration,
      vatNumber,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (createClient != null) {
      return createClient(
        id,
        companyName,
        displayName,
        contactEmail,
        contactPhone,
        avatarImage,
        avatarColor,
        industry,
        companyRegistration,
        vatNumber,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return createClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return createClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (createClient != null) {
      return createClient(this);
    }
    return orElse();
  }
}

abstract class _CreateClient implements AdminEarnEvent {
  const factory _CreateClient({
    final String? id,
    required final String companyName,
    required final String displayName,
    final String? contactEmail,
    final String? contactPhone,
    final String? avatarImage,
    final String? avatarColor,
    final String? industry,
    final String? companyRegistration,
    final String? vatNumber,
  }) = _$CreateClientImpl;

  String? get id;
  String get companyName;
  String get displayName;
  String? get contactEmail;
  String? get contactPhone;
  String? get avatarImage;
  String? get avatarColor;
  String? get industry;
  String? get companyRegistration;
  String? get vatNumber;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateClientImplCopyWith<_$CreateClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateClientImplCopyWith<$Res> {
  factory _$$UpdateClientImplCopyWith(
    _$UpdateClientImpl value,
    $Res Function(_$UpdateClientImpl) then,
  ) = __$$UpdateClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String clientId,
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
  });
}

/// @nodoc
class __$$UpdateClientImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$UpdateClientImpl>
    implements _$$UpdateClientImplCopyWith<$Res> {
  __$$UpdateClientImplCopyWithImpl(
    _$UpdateClientImpl _value,
    $Res Function(_$UpdateClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? companyName = freezed,
    Object? displayName = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? avatarImage = freezed,
    Object? avatarColor = freezed,
    Object? industry = freezed,
    Object? companyRegistration = freezed,
    Object? vatNumber = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _$UpdateClientImpl(
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactEmail: freezed == contactEmail
            ? _value.contactEmail
            : contactEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactPhone: freezed == contactPhone
            ? _value.contactPhone
            : contactPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarImage: freezed == avatarImage
            ? _value.avatarImage
            : avatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        industry: freezed == industry
            ? _value.industry
            : industry // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyRegistration: freezed == companyRegistration
            ? _value.companyRegistration
            : companyRegistration // ignore: cast_nullable_to_non_nullable
                  as String?,
        vatNumber: freezed == vatNumber
            ? _value.vatNumber
            : vatNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$UpdateClientImpl implements _UpdateClient {
  const _$UpdateClientImpl({
    required this.clientId,
    this.companyName,
    this.displayName,
    this.contactEmail,
    this.contactPhone,
    this.avatarImage,
    this.avatarColor,
    this.industry,
    this.companyRegistration,
    this.vatNumber,
    this.isActive,
  });

  @override
  final String clientId;
  @override
  final String? companyName;
  @override
  final String? displayName;
  @override
  final String? contactEmail;
  @override
  final String? contactPhone;
  @override
  final String? avatarImage;
  @override
  final String? avatarColor;
  @override
  final String? industry;
  @override
  final String? companyRegistration;
  @override
  final String? vatNumber;
  @override
  final bool? isActive;

  @override
  String toString() {
    return 'AdminEarnEvent.updateClient(clientId: $clientId, companyName: $companyName, displayName: $displayName, contactEmail: $contactEmail, contactPhone: $contactPhone, avatarImage: $avatarImage, avatarColor: $avatarColor, industry: $industry, companyRegistration: $companyRegistration, vatNumber: $vatNumber, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateClientImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.avatarImage, avatarImage) ||
                other.avatarImage == avatarImage) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.companyRegistration, companyRegistration) ||
                other.companyRegistration == companyRegistration) &&
            (identical(other.vatNumber, vatNumber) ||
                other.vatNumber == vatNumber) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    clientId,
    companyName,
    displayName,
    contactEmail,
    contactPhone,
    avatarImage,
    avatarColor,
    industry,
    companyRegistration,
    vatNumber,
    isActive,
  );

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateClientImplCopyWith<_$UpdateClientImpl> get copyWith =>
      __$$UpdateClientImplCopyWithImpl<_$UpdateClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return updateClient(
      clientId,
      companyName,
      displayName,
      contactEmail,
      contactPhone,
      avatarImage,
      avatarColor,
      industry,
      companyRegistration,
      vatNumber,
      isActive,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return updateClient?.call(
      clientId,
      companyName,
      displayName,
      contactEmail,
      contactPhone,
      avatarImage,
      avatarColor,
      industry,
      companyRegistration,
      vatNumber,
      isActive,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (updateClient != null) {
      return updateClient(
        clientId,
        companyName,
        displayName,
        contactEmail,
        contactPhone,
        avatarImage,
        avatarColor,
        industry,
        companyRegistration,
        vatNumber,
        isActive,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return updateClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return updateClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (updateClient != null) {
      return updateClient(this);
    }
    return orElse();
  }
}

abstract class _UpdateClient implements AdminEarnEvent {
  const factory _UpdateClient({
    required final String clientId,
    final String? companyName,
    final String? displayName,
    final String? contactEmail,
    final String? contactPhone,
    final String? avatarImage,
    final String? avatarColor,
    final String? industry,
    final String? companyRegistration,
    final String? vatNumber,
    final bool? isActive,
  }) = _$UpdateClientImpl;

  String get clientId;
  String? get companyName;
  String? get displayName;
  String? get contactEmail;
  String? get contactPhone;
  String? get avatarImage;
  String? get avatarColor;
  String? get industry;
  String? get companyRegistration;
  String? get vatNumber;
  bool? get isActive;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateClientImplCopyWith<_$UpdateClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteClientImplCopyWith<$Res> {
  factory _$$DeleteClientImplCopyWith(
    _$DeleteClientImpl value,
    $Res Function(_$DeleteClientImpl) then,
  ) = __$$DeleteClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId});
}

/// @nodoc
class __$$DeleteClientImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$DeleteClientImpl>
    implements _$$DeleteClientImplCopyWith<$Res> {
  __$$DeleteClientImplCopyWithImpl(
    _$DeleteClientImpl _value,
    $Res Function(_$DeleteClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null}) {
    return _then(
      _$DeleteClientImpl(
        null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteClientImpl implements _DeleteClient {
  const _$DeleteClientImpl(this.clientId);

  @override
  final String clientId;

  @override
  String toString() {
    return 'AdminEarnEvent.deleteClient(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteClientImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteClientImplCopyWith<_$DeleteClientImpl> get copyWith =>
      __$$DeleteClientImplCopyWithImpl<_$DeleteClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return deleteClient(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return deleteClient?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (deleteClient != null) {
      return deleteClient(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return deleteClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return deleteClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (deleteClient != null) {
      return deleteClient(this);
    }
    return orElse();
  }
}

abstract class _DeleteClient implements AdminEarnEvent {
  const factory _DeleteClient(final String clientId) = _$DeleteClientImpl;

  String get clientId;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteClientImplCopyWith<_$DeleteClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectClientImplCopyWith<$Res> {
  factory _$$SelectClientImplCopyWith(
    _$SelectClientImpl value,
    $Res Function(_$SelectClientImpl) then,
  ) = __$$SelectClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? clientId});
}

/// @nodoc
class __$$SelectClientImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$SelectClientImpl>
    implements _$$SelectClientImplCopyWith<$Res> {
  __$$SelectClientImplCopyWithImpl(
    _$SelectClientImpl _value,
    $Res Function(_$SelectClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = freezed}) {
    return _then(
      _$SelectClientImpl(
        freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SelectClientImpl implements _SelectClient {
  const _$SelectClientImpl(this.clientId);

  @override
  final String? clientId;

  @override
  String toString() {
    return 'AdminEarnEvent.selectClient(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectClientImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectClientImplCopyWith<_$SelectClientImpl> get copyWith =>
      __$$SelectClientImplCopyWithImpl<_$SelectClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return selectClient(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return selectClient?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectClient != null) {
      return selectClient(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return selectClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return selectClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectClient != null) {
      return selectClient(this);
    }
    return orElse();
  }
}

abstract class _SelectClient implements AdminEarnEvent {
  const factory _SelectClient(final String? clientId) = _$SelectClientImpl;

  String? get clientId;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectClientImplCopyWith<_$SelectClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FundClientSubAccountImplCopyWith<$Res> {
  factory _$$FundClientSubAccountImplCopyWith(
    _$FundClientSubAccountImpl value,
    $Res Function(_$FundClientSubAccountImpl) then,
  ) = __$$FundClientSubAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId, String subAccountId, int amount, String? note});
}

/// @nodoc
class __$$FundClientSubAccountImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$FundClientSubAccountImpl>
    implements _$$FundClientSubAccountImplCopyWith<$Res> {
  __$$FundClientSubAccountImplCopyWithImpl(
    _$FundClientSubAccountImpl _value,
    $Res Function(_$FundClientSubAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? subAccountId = null,
    Object? amount = null,
    Object? note = freezed,
  }) {
    return _then(
      _$FundClientSubAccountImpl(
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        subAccountId: null == subAccountId
            ? _value.subAccountId
            : subAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FundClientSubAccountImpl implements _FundClientSubAccount {
  const _$FundClientSubAccountImpl({
    required this.clientId,
    required this.subAccountId,
    required this.amount,
    this.note,
  });

  @override
  final String clientId;
  @override
  final String subAccountId;
  @override
  final int amount;
  @override
  final String? note;

  @override
  String toString() {
    return 'AdminEarnEvent.fundClientSubAccount(clientId: $clientId, subAccountId: $subAccountId, amount: $amount, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FundClientSubAccountImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.subAccountId, subAccountId) ||
                other.subAccountId == subAccountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, clientId, subAccountId, amount, note);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FundClientSubAccountImplCopyWith<_$FundClientSubAccountImpl>
  get copyWith =>
      __$$FundClientSubAccountImplCopyWithImpl<_$FundClientSubAccountImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return fundClientSubAccount(clientId, subAccountId, amount, note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return fundClientSubAccount?.call(clientId, subAccountId, amount, note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (fundClientSubAccount != null) {
      return fundClientSubAccount(clientId, subAccountId, amount, note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return fundClientSubAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return fundClientSubAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (fundClientSubAccount != null) {
      return fundClientSubAccount(this);
    }
    return orElse();
  }
}

abstract class _FundClientSubAccount implements AdminEarnEvent {
  const factory _FundClientSubAccount({
    required final String clientId,
    required final String subAccountId,
    required final int amount,
    final String? note,
  }) = _$FundClientSubAccountImpl;

  String get clientId;
  String get subAccountId;
  int get amount;
  String? get note;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FundClientSubAccountImplCopyWith<_$FundClientSubAccountImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadThreadsForClientImplCopyWith<$Res> {
  factory _$$LoadThreadsForClientImplCopyWith(
    _$LoadThreadsForClientImpl value,
    $Res Function(_$LoadThreadsForClientImpl) then,
  ) = __$$LoadThreadsForClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId});
}

/// @nodoc
class __$$LoadThreadsForClientImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadThreadsForClientImpl>
    implements _$$LoadThreadsForClientImplCopyWith<$Res> {
  __$$LoadThreadsForClientImplCopyWithImpl(
    _$LoadThreadsForClientImpl _value,
    $Res Function(_$LoadThreadsForClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null}) {
    return _then(
      _$LoadThreadsForClientImpl(
        null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadThreadsForClientImpl implements _LoadThreadsForClient {
  const _$LoadThreadsForClientImpl(this.clientId);

  @override
  final String clientId;

  @override
  String toString() {
    return 'AdminEarnEvent.loadThreadsForClient(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadThreadsForClientImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadThreadsForClientImplCopyWith<_$LoadThreadsForClientImpl>
  get copyWith =>
      __$$LoadThreadsForClientImplCopyWithImpl<_$LoadThreadsForClientImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadThreadsForClient(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadThreadsForClient?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadThreadsForClient != null) {
      return loadThreadsForClient(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadThreadsForClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadThreadsForClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadThreadsForClient != null) {
      return loadThreadsForClient(this);
    }
    return orElse();
  }
}

abstract class _LoadThreadsForClient implements AdminEarnEvent {
  const factory _LoadThreadsForClient(final String clientId) =
      _$LoadThreadsForClientImpl;

  String get clientId;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadThreadsForClientImplCopyWith<_$LoadThreadsForClientImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateThreadImplCopyWith<$Res> {
  factory _$$CreateThreadImplCopyWith(
    _$CreateThreadImpl value,
    $Res Function(_$CreateThreadImpl) then,
  ) = __$$CreateThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String? id,
    String clientId,
    String title,
    String? description,
    String tokenSourceAccountId,
    String? tokenDestAccountTypeId,
    bool isPinned,
    bool isFeatured,
    bool isActive,
    DateTime? activeFrom,
    DateTime? activeTo,
    Map<String, dynamic>? targeting,
  });
}

/// @nodoc
class __$$CreateThreadImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$CreateThreadImpl>
    implements _$$CreateThreadImplCopyWith<$Res> {
  __$$CreateThreadImplCopyWithImpl(
    _$CreateThreadImpl _value,
    $Res Function(_$CreateThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clientId = null,
    Object? title = null,
    Object? description = freezed,
    Object? tokenSourceAccountId = null,
    Object? tokenDestAccountTypeId = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? isActive = null,
    Object? activeFrom = freezed,
    Object? activeTo = freezed,
    Object? targeting = freezed,
  }) {
    return _then(
      _$CreateThreadImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenSourceAccountId: null == tokenSourceAccountId
            ? _value.tokenSourceAccountId
            : tokenSourceAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenDestAccountTypeId: freezed == tokenDestAccountTypeId
            ? _value.tokenDestAccountTypeId
            : tokenDestAccountTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeFrom: freezed == activeFrom
            ? _value.activeFrom
            : activeFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        activeTo: freezed == activeTo
            ? _value.activeTo
            : activeTo // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        targeting: freezed == targeting
            ? _value._targeting
            : targeting // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$CreateThreadImpl implements _CreateThread {
  const _$CreateThreadImpl({
    this.id,
    required this.clientId,
    required this.title,
    this.description,
    required this.tokenSourceAccountId,
    this.tokenDestAccountTypeId,
    this.isPinned = false,
    this.isFeatured = false,
    this.isActive = true,
    this.activeFrom,
    this.activeTo,
    final Map<String, dynamic>? targeting,
  }) : _targeting = targeting;

  @override
  final String? id;
  @override
  final String clientId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String tokenSourceAccountId;
  @override
  final String? tokenDestAccountTypeId;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? activeFrom;
  @override
  final DateTime? activeTo;
  final Map<String, dynamic>? _targeting;
  @override
  Map<String, dynamic>? get targeting {
    final value = _targeting;
    if (value == null) return null;
    if (_targeting is EqualUnmodifiableMapView) return _targeting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AdminEarnEvent.createThread(id: $id, clientId: $clientId, title: $title, description: $description, tokenSourceAccountId: $tokenSourceAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, activeFrom: $activeFrom, activeTo: $activeTo, targeting: $targeting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.tokenSourceAccountId, tokenSourceAccountId) ||
                other.tokenSourceAccountId == tokenSourceAccountId) &&
            (identical(other.tokenDestAccountTypeId, tokenDestAccountTypeId) ||
                other.tokenDestAccountTypeId == tokenDestAccountTypeId) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.activeFrom, activeFrom) ||
                other.activeFrom == activeFrom) &&
            (identical(other.activeTo, activeTo) ||
                other.activeTo == activeTo) &&
            const DeepCollectionEquality().equals(
              other._targeting,
              _targeting,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clientId,
    title,
    description,
    tokenSourceAccountId,
    tokenDestAccountTypeId,
    isPinned,
    isFeatured,
    isActive,
    activeFrom,
    activeTo,
    const DeepCollectionEquality().hash(_targeting),
  );

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateThreadImplCopyWith<_$CreateThreadImpl> get copyWith =>
      __$$CreateThreadImplCopyWithImpl<_$CreateThreadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return createThread(
      id,
      clientId,
      title,
      description,
      tokenSourceAccountId,
      tokenDestAccountTypeId,
      isPinned,
      isFeatured,
      isActive,
      activeFrom,
      activeTo,
      targeting,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return createThread?.call(
      id,
      clientId,
      title,
      description,
      tokenSourceAccountId,
      tokenDestAccountTypeId,
      isPinned,
      isFeatured,
      isActive,
      activeFrom,
      activeTo,
      targeting,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (createThread != null) {
      return createThread(
        id,
        clientId,
        title,
        description,
        tokenSourceAccountId,
        tokenDestAccountTypeId,
        isPinned,
        isFeatured,
        isActive,
        activeFrom,
        activeTo,
        targeting,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return createThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return createThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (createThread != null) {
      return createThread(this);
    }
    return orElse();
  }
}

abstract class _CreateThread implements AdminEarnEvent {
  const factory _CreateThread({
    final String? id,
    required final String clientId,
    required final String title,
    final String? description,
    required final String tokenSourceAccountId,
    final String? tokenDestAccountTypeId,
    final bool isPinned,
    final bool isFeatured,
    final bool isActive,
    final DateTime? activeFrom,
    final DateTime? activeTo,
    final Map<String, dynamic>? targeting,
  }) = _$CreateThreadImpl;

  String? get id;
  String get clientId;
  String get title;
  String? get description;
  String get tokenSourceAccountId;
  String? get tokenDestAccountTypeId;
  bool get isPinned;
  bool get isFeatured;
  bool get isActive;
  DateTime? get activeFrom;
  DateTime? get activeTo;
  Map<String, dynamic>? get targeting;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateThreadImplCopyWith<_$CreateThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectThreadImplCopyWith<$Res> {
  factory _$$SelectThreadImplCopyWith(
    _$SelectThreadImpl value,
    $Res Function(_$SelectThreadImpl) then,
  ) = __$$SelectThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? threadId});
}

/// @nodoc
class __$$SelectThreadImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$SelectThreadImpl>
    implements _$$SelectThreadImplCopyWith<$Res> {
  __$$SelectThreadImplCopyWithImpl(
    _$SelectThreadImpl _value,
    $Res Function(_$SelectThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = freezed}) {
    return _then(
      _$SelectThreadImpl(
        freezed == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SelectThreadImpl implements _SelectThread {
  const _$SelectThreadImpl(this.threadId);

  @override
  final String? threadId;

  @override
  String toString() {
    return 'AdminEarnEvent.selectThread(threadId: $threadId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectThreadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectThreadImplCopyWith<_$SelectThreadImpl> get copyWith =>
      __$$SelectThreadImplCopyWithImpl<_$SelectThreadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return selectThread(threadId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return selectThread?.call(threadId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectThread != null) {
      return selectThread(threadId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return selectThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return selectThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectThread != null) {
      return selectThread(this);
    }
    return orElse();
  }
}

abstract class _SelectThread implements AdminEarnEvent {
  const factory _SelectThread(final String? threadId) = _$SelectThreadImpl;

  String? get threadId;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectThreadImplCopyWith<_$SelectThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadOpportunitiesForThreadImplCopyWith<$Res> {
  factory _$$LoadOpportunitiesForThreadImplCopyWith(
    _$LoadOpportunitiesForThreadImpl value,
    $Res Function(_$LoadOpportunitiesForThreadImpl) then,
  ) = __$$LoadOpportunitiesForThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId});
}

/// @nodoc
class __$$LoadOpportunitiesForThreadImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$LoadOpportunitiesForThreadImpl>
    implements _$$LoadOpportunitiesForThreadImplCopyWith<$Res> {
  __$$LoadOpportunitiesForThreadImplCopyWithImpl(
    _$LoadOpportunitiesForThreadImpl _value,
    $Res Function(_$LoadOpportunitiesForThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null}) {
    return _then(
      _$LoadOpportunitiesForThreadImpl(
        null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadOpportunitiesForThreadImpl implements _LoadOpportunitiesForThread {
  const _$LoadOpportunitiesForThreadImpl(this.threadId);

  @override
  final String threadId;

  @override
  String toString() {
    return 'AdminEarnEvent.loadOpportunitiesForThread(threadId: $threadId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadOpportunitiesForThreadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadOpportunitiesForThreadImplCopyWith<_$LoadOpportunitiesForThreadImpl>
  get copyWith =>
      __$$LoadOpportunitiesForThreadImplCopyWithImpl<
        _$LoadOpportunitiesForThreadImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadOpportunitiesForThread(threadId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadOpportunitiesForThread?.call(threadId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadOpportunitiesForThread != null) {
      return loadOpportunitiesForThread(threadId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadOpportunitiesForThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadOpportunitiesForThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadOpportunitiesForThread != null) {
      return loadOpportunitiesForThread(this);
    }
    return orElse();
  }
}

abstract class _LoadOpportunitiesForThread implements AdminEarnEvent {
  const factory _LoadOpportunitiesForThread(final String threadId) =
      _$LoadOpportunitiesForThreadImpl;

  String get threadId;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadOpportunitiesForThreadImplCopyWith<_$LoadOpportunitiesForThreadImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateOpportunityImplCopyWith<$Res> {
  factory _$$CreateOpportunityImplCopyWith(
    _$CreateOpportunityImpl value,
    $Res Function(_$CreateOpportunityImpl) then,
  ) = __$$CreateOpportunityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String? id,
    String threadId,
    String title,
    String? description,
    String earningType,
    int tokenReward,
    String? mediaType,
    String? mediaUrl,
    List<Map<String, dynamic>>? questions,
    int durationSeconds,
    DateTime? expiresAt,
    bool? isActive,
    Map<String, dynamic>? targeting,
  });
}

/// @nodoc
class __$$CreateOpportunityImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$CreateOpportunityImpl>
    implements _$$CreateOpportunityImplCopyWith<$Res> {
  __$$CreateOpportunityImplCopyWithImpl(
    _$CreateOpportunityImpl _value,
    $Res Function(_$CreateOpportunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? threadId = null,
    Object? title = null,
    Object? description = freezed,
    Object? earningType = null,
    Object? tokenReward = null,
    Object? mediaType = freezed,
    Object? mediaUrl = freezed,
    Object? questions = freezed,
    Object? durationSeconds = null,
    Object? expiresAt = freezed,
    Object? isActive = freezed,
    Object? targeting = freezed,
  }) {
    return _then(
      _$CreateOpportunityImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        earningType: null == earningType
            ? _value.earningType
            : earningType // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenReward: null == tokenReward
            ? _value.tokenReward
            : tokenReward // ignore: cast_nullable_to_non_nullable
                  as int,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String?,
        mediaUrl: freezed == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        questions: freezed == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>?,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        targeting: freezed == targeting
            ? _value._targeting
            : targeting // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$CreateOpportunityImpl implements _CreateOpportunity {
  const _$CreateOpportunityImpl({
    this.id,
    required this.threadId,
    required this.title,
    this.description,
    required this.earningType,
    required this.tokenReward,
    this.mediaType,
    this.mediaUrl,
    final List<Map<String, dynamic>>? questions,
    required this.durationSeconds,
    this.expiresAt,
    this.isActive,
    final Map<String, dynamic>? targeting,
  }) : _questions = questions,
       _targeting = targeting;

  @override
  final String? id;
  @override
  final String threadId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String earningType;
  @override
  final int tokenReward;
  @override
  final String? mediaType;
  @override
  final String? mediaUrl;
  final List<Map<String, dynamic>>? _questions;
  @override
  List<Map<String, dynamic>>? get questions {
    final value = _questions;
    if (value == null) return null;
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int durationSeconds;
  @override
  final DateTime? expiresAt;
  @override
  final bool? isActive;
  final Map<String, dynamic>? _targeting;
  @override
  Map<String, dynamic>? get targeting {
    final value = _targeting;
    if (value == null) return null;
    if (_targeting is EqualUnmodifiableMapView) return _targeting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AdminEarnEvent.createOpportunity(id: $id, threadId: $threadId, title: $title, description: $description, earningType: $earningType, tokenReward: $tokenReward, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, targeting: $targeting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOpportunityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.earningType, earningType) ||
                other.earningType == earningType) &&
            (identical(other.tokenReward, tokenReward) ||
                other.tokenReward == tokenReward) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(
              other._targeting,
              _targeting,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    threadId,
    title,
    description,
    earningType,
    tokenReward,
    mediaType,
    mediaUrl,
    const DeepCollectionEquality().hash(_questions),
    durationSeconds,
    expiresAt,
    isActive,
    const DeepCollectionEquality().hash(_targeting),
  );

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOpportunityImplCopyWith<_$CreateOpportunityImpl> get copyWith =>
      __$$CreateOpportunityImplCopyWithImpl<_$CreateOpportunityImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return createOpportunity(
      id,
      threadId,
      title,
      description,
      earningType,
      tokenReward,
      mediaType,
      mediaUrl,
      questions,
      durationSeconds,
      expiresAt,
      isActive,
      targeting,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return createOpportunity?.call(
      id,
      threadId,
      title,
      description,
      earningType,
      tokenReward,
      mediaType,
      mediaUrl,
      questions,
      durationSeconds,
      expiresAt,
      isActive,
      targeting,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (createOpportunity != null) {
      return createOpportunity(
        id,
        threadId,
        title,
        description,
        earningType,
        tokenReward,
        mediaType,
        mediaUrl,
        questions,
        durationSeconds,
        expiresAt,
        isActive,
        targeting,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return createOpportunity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return createOpportunity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (createOpportunity != null) {
      return createOpportunity(this);
    }
    return orElse();
  }
}

abstract class _CreateOpportunity implements AdminEarnEvent {
  const factory _CreateOpportunity({
    final String? id,
    required final String threadId,
    required final String title,
    final String? description,
    required final String earningType,
    required final int tokenReward,
    final String? mediaType,
    final String? mediaUrl,
    final List<Map<String, dynamic>>? questions,
    required final int durationSeconds,
    final DateTime? expiresAt,
    final bool? isActive,
    final Map<String, dynamic>? targeting,
  }) = _$CreateOpportunityImpl;

  String? get id;
  String get threadId;
  String get title;
  String? get description;
  String get earningType;
  int get tokenReward;
  String? get mediaType;
  String? get mediaUrl;
  List<Map<String, dynamic>>? get questions;
  int get durationSeconds;
  DateTime? get expiresAt;
  bool? get isActive;
  Map<String, dynamic>? get targeting;

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateOpportunityImplCopyWith<_$CreateOpportunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'AdminEarnEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements AdminEarnEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
abstract class _$$ClearSuccessImplCopyWith<$Res> {
  factory _$$ClearSuccessImplCopyWith(
    _$ClearSuccessImpl value,
    $Res Function(_$ClearSuccessImpl) then,
  ) = __$$ClearSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSuccessImplCopyWithImpl<$Res>
    extends _$AdminEarnEventCopyWithImpl<$Res, _$ClearSuccessImpl>
    implements _$$ClearSuccessImplCopyWith<$Res> {
  __$$ClearSuccessImplCopyWithImpl(
    _$ClearSuccessImpl _value,
    $Res Function(_$ClearSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSuccessImpl implements _ClearSuccess {
  const _$ClearSuccessImpl();

  @override
  String toString() {
    return 'AdminEarnEvent.clearSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStatistics,
    required TResult Function() loadTargetingOptions,
    required TResult Function(String clientId) loadClientStats,
    required TResult Function(
      String threadId,
      DateTime? startDate,
      DateTime? endDate,
    )
    loadThreadAnalytics,
    required TResult Function(bool? activeOnly) loadClients,
    required TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )
    createClient,
    required TResult Function(
      String clientId,
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
    )
    updateClient,
    required TResult Function(String clientId) deleteClient,
    required TResult Function(String? clientId) selectClient,
    required TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )
    fundClientSubAccount,
    required TResult Function(String clientId) loadThreadsForClient,
    required TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )
    createThread,
    required TResult Function(String? threadId) selectThread,
    required TResult Function(String threadId) loadOpportunitiesForThread,
    required TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )
    createOpportunity,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return clearSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStatistics,
    TResult? Function()? loadTargetingOptions,
    TResult? Function(String clientId)? loadClientStats,
    TResult? Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult? Function(bool? activeOnly)? loadClients,
    TResult? Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult? Function(
      String clientId,
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
    )?
    updateClient,
    TResult? Function(String clientId)? deleteClient,
    TResult? Function(String? clientId)? selectClient,
    TResult? Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult? Function(String clientId)? loadThreadsForClient,
    TResult? Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult? Function(String? threadId)? selectThread,
    TResult? Function(String threadId)? loadOpportunitiesForThread,
    TResult? Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return clearSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStatistics,
    TResult Function()? loadTargetingOptions,
    TResult Function(String clientId)? loadClientStats,
    TResult Function(String threadId, DateTime? startDate, DateTime? endDate)?
    loadThreadAnalytics,
    TResult Function(bool? activeOnly)? loadClients,
    TResult Function(
      String? id,
      String companyName,
      String displayName,
      String? contactEmail,
      String? contactPhone,
      String? avatarImage,
      String? avatarColor,
      String? industry,
      String? companyRegistration,
      String? vatNumber,
    )?
    createClient,
    TResult Function(
      String clientId,
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
    )?
    updateClient,
    TResult Function(String clientId)? deleteClient,
    TResult Function(String? clientId)? selectClient,
    TResult Function(
      String clientId,
      String subAccountId,
      int amount,
      String? note,
    )?
    fundClientSubAccount,
    TResult Function(String clientId)? loadThreadsForClient,
    TResult Function(
      String? id,
      String clientId,
      String title,
      String? description,
      String tokenSourceAccountId,
      String? tokenDestAccountTypeId,
      bool isPinned,
      bool isFeatured,
      bool isActive,
      DateTime? activeFrom,
      DateTime? activeTo,
      Map<String, dynamic>? targeting,
    )?
    createThread,
    TResult Function(String? threadId)? selectThread,
    TResult Function(String threadId)? loadOpportunitiesForThread,
    TResult Function(
      String? id,
      String threadId,
      String title,
      String? description,
      String earningType,
      int tokenReward,
      String? mediaType,
      String? mediaUrl,
      List<Map<String, dynamic>>? questions,
      int durationSeconds,
      DateTime? expiresAt,
      bool? isActive,
      Map<String, dynamic>? targeting,
    )?
    createOpportunity,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearSuccess != null) {
      return clearSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStatistics value) loadStatistics,
    required TResult Function(_LoadTargetingOptions value) loadTargetingOptions,
    required TResult Function(_LoadClientStats value) loadClientStats,
    required TResult Function(_LoadThreadAnalytics value) loadThreadAnalytics,
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_CreateClient value) createClient,
    required TResult Function(_UpdateClient value) updateClient,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_SelectClient value) selectClient,
    required TResult Function(_FundClientSubAccount value) fundClientSubAccount,
    required TResult Function(_LoadThreadsForClient value) loadThreadsForClient,
    required TResult Function(_CreateThread value) createThread,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadOpportunitiesForThread value)
    loadOpportunitiesForThread,
    required TResult Function(_CreateOpportunity value) createOpportunity,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return clearSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStatistics value)? loadStatistics,
    TResult? Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult? Function(_LoadClientStats value)? loadClientStats,
    TResult? Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_CreateClient value)? createClient,
    TResult? Function(_UpdateClient value)? updateClient,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_SelectClient value)? selectClient,
    TResult? Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult? Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult? Function(_CreateThread value)? createThread,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult? Function(_CreateOpportunity value)? createOpportunity,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return clearSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStatistics value)? loadStatistics,
    TResult Function(_LoadTargetingOptions value)? loadTargetingOptions,
    TResult Function(_LoadClientStats value)? loadClientStats,
    TResult Function(_LoadThreadAnalytics value)? loadThreadAnalytics,
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_CreateClient value)? createClient,
    TResult Function(_UpdateClient value)? updateClient,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_SelectClient value)? selectClient,
    TResult Function(_FundClientSubAccount value)? fundClientSubAccount,
    TResult Function(_LoadThreadsForClient value)? loadThreadsForClient,
    TResult Function(_CreateThread value)? createThread,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadOpportunitiesForThread value)?
    loadOpportunitiesForThread,
    TResult Function(_CreateOpportunity value)? createOpportunity,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearSuccess != null) {
      return clearSuccess(this);
    }
    return orElse();
  }
}

abstract class _ClearSuccess implements AdminEarnEvent {
  const factory _ClearSuccess() = _$ClearSuccessImpl;
}

/// @nodoc
mixin _$AdminEarnState {
  // Status
  AdminEarnStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage =>
      throw _privateConstructorUsedError; // Statistics
  Map<String, dynamic>? get statistics => throw _privateConstructorUsedError;
  Map<String, dynamic>? get targetingOptions =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get clientStats => throw _privateConstructorUsedError;
  Map<String, dynamic>? get threadAnalytics =>
      throw _privateConstructorUsedError; // Clients
  List<Map<String, dynamic>> get clients => throw _privateConstructorUsedError;
  String? get selectedClientId => throw _privateConstructorUsedError; // Threads
  List<Map<String, dynamic>> get threads => throw _privateConstructorUsedError;
  String? get selectedThreadId =>
      throw _privateConstructorUsedError; // Opportunities
  List<Map<String, dynamic>> get opportunities =>
      throw _privateConstructorUsedError; // Loading states
  bool get isLoadingStatistics => throw _privateConstructorUsedError;
  bool get isLoadingClients => throw _privateConstructorUsedError;
  bool get isLoadingThreads => throw _privateConstructorUsedError;
  bool get isLoadingOpportunities => throw _privateConstructorUsedError;
  bool get isLoadingClientStats => throw _privateConstructorUsedError;
  bool get isLoadingThreadAnalytics => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;

  /// Create a copy of AdminEarnState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminEarnStateCopyWith<AdminEarnState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminEarnStateCopyWith<$Res> {
  factory $AdminEarnStateCopyWith(
    AdminEarnState value,
    $Res Function(AdminEarnState) then,
  ) = _$AdminEarnStateCopyWithImpl<$Res, AdminEarnState>;
  @useResult
  $Res call({
    AdminEarnStatus status,
    String? errorMessage,
    String? successMessage,
    Map<String, dynamic>? statistics,
    Map<String, dynamic>? targetingOptions,
    Map<String, dynamic>? clientStats,
    Map<String, dynamic>? threadAnalytics,
    List<Map<String, dynamic>> clients,
    String? selectedClientId,
    List<Map<String, dynamic>> threads,
    String? selectedThreadId,
    List<Map<String, dynamic>> opportunities,
    bool isLoadingStatistics,
    bool isLoadingClients,
    bool isLoadingThreads,
    bool isLoadingOpportunities,
    bool isLoadingClientStats,
    bool isLoadingThreadAnalytics,
    bool isSaving,
  });
}

/// @nodoc
class _$AdminEarnStateCopyWithImpl<$Res, $Val extends AdminEarnState>
    implements $AdminEarnStateCopyWith<$Res> {
  _$AdminEarnStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminEarnState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? statistics = freezed,
    Object? targetingOptions = freezed,
    Object? clientStats = freezed,
    Object? threadAnalytics = freezed,
    Object? clients = null,
    Object? selectedClientId = freezed,
    Object? threads = null,
    Object? selectedThreadId = freezed,
    Object? opportunities = null,
    Object? isLoadingStatistics = null,
    Object? isLoadingClients = null,
    Object? isLoadingThreads = null,
    Object? isLoadingOpportunities = null,
    Object? isLoadingClientStats = null,
    Object? isLoadingThreadAnalytics = null,
    Object? isSaving = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AdminEarnStatus,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            statistics: freezed == statistics
                ? _value.statistics
                : statistics // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            targetingOptions: freezed == targetingOptions
                ? _value.targetingOptions
                : targetingOptions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            clientStats: freezed == clientStats
                ? _value.clientStats
                : clientStats // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            threadAnalytics: freezed == threadAnalytics
                ? _value.threadAnalytics
                : threadAnalytics // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            clients: null == clients
                ? _value.clients
                : clients // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            selectedClientId: freezed == selectedClientId
                ? _value.selectedClientId
                : selectedClientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            threads: null == threads
                ? _value.threads
                : threads // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            selectedThreadId: freezed == selectedThreadId
                ? _value.selectedThreadId
                : selectedThreadId // ignore: cast_nullable_to_non_nullable
                      as String?,
            opportunities: null == opportunities
                ? _value.opportunities
                : opportunities // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            isLoadingStatistics: null == isLoadingStatistics
                ? _value.isLoadingStatistics
                : isLoadingStatistics // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingClients: null == isLoadingClients
                ? _value.isLoadingClients
                : isLoadingClients // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingThreads: null == isLoadingThreads
                ? _value.isLoadingThreads
                : isLoadingThreads // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingOpportunities: null == isLoadingOpportunities
                ? _value.isLoadingOpportunities
                : isLoadingOpportunities // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingClientStats: null == isLoadingClientStats
                ? _value.isLoadingClientStats
                : isLoadingClientStats // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingThreadAnalytics: null == isLoadingThreadAnalytics
                ? _value.isLoadingThreadAnalytics
                : isLoadingThreadAnalytics // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminEarnStateImplCopyWith<$Res>
    implements $AdminEarnStateCopyWith<$Res> {
  factory _$$AdminEarnStateImplCopyWith(
    _$AdminEarnStateImpl value,
    $Res Function(_$AdminEarnStateImpl) then,
  ) = __$$AdminEarnStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AdminEarnStatus status,
    String? errorMessage,
    String? successMessage,
    Map<String, dynamic>? statistics,
    Map<String, dynamic>? targetingOptions,
    Map<String, dynamic>? clientStats,
    Map<String, dynamic>? threadAnalytics,
    List<Map<String, dynamic>> clients,
    String? selectedClientId,
    List<Map<String, dynamic>> threads,
    String? selectedThreadId,
    List<Map<String, dynamic>> opportunities,
    bool isLoadingStatistics,
    bool isLoadingClients,
    bool isLoadingThreads,
    bool isLoadingOpportunities,
    bool isLoadingClientStats,
    bool isLoadingThreadAnalytics,
    bool isSaving,
  });
}

/// @nodoc
class __$$AdminEarnStateImplCopyWithImpl<$Res>
    extends _$AdminEarnStateCopyWithImpl<$Res, _$AdminEarnStateImpl>
    implements _$$AdminEarnStateImplCopyWith<$Res> {
  __$$AdminEarnStateImplCopyWithImpl(
    _$AdminEarnStateImpl _value,
    $Res Function(_$AdminEarnStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminEarnState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? statistics = freezed,
    Object? targetingOptions = freezed,
    Object? clientStats = freezed,
    Object? threadAnalytics = freezed,
    Object? clients = null,
    Object? selectedClientId = freezed,
    Object? threads = null,
    Object? selectedThreadId = freezed,
    Object? opportunities = null,
    Object? isLoadingStatistics = null,
    Object? isLoadingClients = null,
    Object? isLoadingThreads = null,
    Object? isLoadingOpportunities = null,
    Object? isLoadingClientStats = null,
    Object? isLoadingThreadAnalytics = null,
    Object? isSaving = null,
  }) {
    return _then(
      _$AdminEarnStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AdminEarnStatus,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        statistics: freezed == statistics
            ? _value._statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        targetingOptions: freezed == targetingOptions
            ? _value._targetingOptions
            : targetingOptions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        clientStats: freezed == clientStats
            ? _value._clientStats
            : clientStats // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        threadAnalytics: freezed == threadAnalytics
            ? _value._threadAnalytics
            : threadAnalytics // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        clients: null == clients
            ? _value._clients
            : clients // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        selectedClientId: freezed == selectedClientId
            ? _value.selectedClientId
            : selectedClientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        threads: null == threads
            ? _value._threads
            : threads // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        selectedThreadId: freezed == selectedThreadId
            ? _value.selectedThreadId
            : selectedThreadId // ignore: cast_nullable_to_non_nullable
                  as String?,
        opportunities: null == opportunities
            ? _value._opportunities
            : opportunities // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        isLoadingStatistics: null == isLoadingStatistics
            ? _value.isLoadingStatistics
            : isLoadingStatistics // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingClients: null == isLoadingClients
            ? _value.isLoadingClients
            : isLoadingClients // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingThreads: null == isLoadingThreads
            ? _value.isLoadingThreads
            : isLoadingThreads // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingOpportunities: null == isLoadingOpportunities
            ? _value.isLoadingOpportunities
            : isLoadingOpportunities // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingClientStats: null == isLoadingClientStats
            ? _value.isLoadingClientStats
            : isLoadingClientStats // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingThreadAnalytics: null == isLoadingThreadAnalytics
            ? _value.isLoadingThreadAnalytics
            : isLoadingThreadAnalytics // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$AdminEarnStateImpl extends _AdminEarnState {
  const _$AdminEarnStateImpl({
    this.status = AdminEarnStatus.initial,
    this.errorMessage,
    this.successMessage,
    final Map<String, dynamic>? statistics,
    final Map<String, dynamic>? targetingOptions,
    final Map<String, dynamic>? clientStats,
    final Map<String, dynamic>? threadAnalytics,
    final List<Map<String, dynamic>> clients = const [],
    this.selectedClientId,
    final List<Map<String, dynamic>> threads = const [],
    this.selectedThreadId,
    final List<Map<String, dynamic>> opportunities = const [],
    this.isLoadingStatistics = false,
    this.isLoadingClients = false,
    this.isLoadingThreads = false,
    this.isLoadingOpportunities = false,
    this.isLoadingClientStats = false,
    this.isLoadingThreadAnalytics = false,
    this.isSaving = false,
  }) : _statistics = statistics,
       _targetingOptions = targetingOptions,
       _clientStats = clientStats,
       _threadAnalytics = threadAnalytics,
       _clients = clients,
       _threads = threads,
       _opportunities = opportunities,
       super._();

  // Status
  @override
  @JsonKey()
  final AdminEarnStatus status;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;
  // Statistics
  final Map<String, dynamic>? _statistics;
  // Statistics
  @override
  Map<String, dynamic>? get statistics {
    final value = _statistics;
    if (value == null) return null;
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _targetingOptions;
  @override
  Map<String, dynamic>? get targetingOptions {
    final value = _targetingOptions;
    if (value == null) return null;
    if (_targetingOptions is EqualUnmodifiableMapView) return _targetingOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _clientStats;
  @override
  Map<String, dynamic>? get clientStats {
    final value = _clientStats;
    if (value == null) return null;
    if (_clientStats is EqualUnmodifiableMapView) return _clientStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _threadAnalytics;
  @override
  Map<String, dynamic>? get threadAnalytics {
    final value = _threadAnalytics;
    if (value == null) return null;
    if (_threadAnalytics is EqualUnmodifiableMapView) return _threadAnalytics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Clients
  final List<Map<String, dynamic>> _clients;
  // Clients
  @override
  @JsonKey()
  List<Map<String, dynamic>> get clients {
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clients);
  }

  @override
  final String? selectedClientId;
  // Threads
  final List<Map<String, dynamic>> _threads;
  // Threads
  @override
  @JsonKey()
  List<Map<String, dynamic>> get threads {
    if (_threads is EqualUnmodifiableListView) return _threads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threads);
  }

  @override
  final String? selectedThreadId;
  // Opportunities
  final List<Map<String, dynamic>> _opportunities;
  // Opportunities
  @override
  @JsonKey()
  List<Map<String, dynamic>> get opportunities {
    if (_opportunities is EqualUnmodifiableListView) return _opportunities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opportunities);
  }

  // Loading states
  @override
  @JsonKey()
  final bool isLoadingStatistics;
  @override
  @JsonKey()
  final bool isLoadingClients;
  @override
  @JsonKey()
  final bool isLoadingThreads;
  @override
  @JsonKey()
  final bool isLoadingOpportunities;
  @override
  @JsonKey()
  final bool isLoadingClientStats;
  @override
  @JsonKey()
  final bool isLoadingThreadAnalytics;
  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'AdminEarnState(status: $status, errorMessage: $errorMessage, successMessage: $successMessage, statistics: $statistics, targetingOptions: $targetingOptions, clientStats: $clientStats, threadAnalytics: $threadAnalytics, clients: $clients, selectedClientId: $selectedClientId, threads: $threads, selectedThreadId: $selectedThreadId, opportunities: $opportunities, isLoadingStatistics: $isLoadingStatistics, isLoadingClients: $isLoadingClients, isLoadingThreads: $isLoadingThreads, isLoadingOpportunities: $isLoadingOpportunities, isLoadingClientStats: $isLoadingClientStats, isLoadingThreadAnalytics: $isLoadingThreadAnalytics, isSaving: $isSaving)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminEarnStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            const DeepCollectionEquality().equals(
              other._statistics,
              _statistics,
            ) &&
            const DeepCollectionEquality().equals(
              other._targetingOptions,
              _targetingOptions,
            ) &&
            const DeepCollectionEquality().equals(
              other._clientStats,
              _clientStats,
            ) &&
            const DeepCollectionEquality().equals(
              other._threadAnalytics,
              _threadAnalytics,
            ) &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            (identical(other.selectedClientId, selectedClientId) ||
                other.selectedClientId == selectedClientId) &&
            const DeepCollectionEquality().equals(other._threads, _threads) &&
            (identical(other.selectedThreadId, selectedThreadId) ||
                other.selectedThreadId == selectedThreadId) &&
            const DeepCollectionEquality().equals(
              other._opportunities,
              _opportunities,
            ) &&
            (identical(other.isLoadingStatistics, isLoadingStatistics) ||
                other.isLoadingStatistics == isLoadingStatistics) &&
            (identical(other.isLoadingClients, isLoadingClients) ||
                other.isLoadingClients == isLoadingClients) &&
            (identical(other.isLoadingThreads, isLoadingThreads) ||
                other.isLoadingThreads == isLoadingThreads) &&
            (identical(other.isLoadingOpportunities, isLoadingOpportunities) ||
                other.isLoadingOpportunities == isLoadingOpportunities) &&
            (identical(other.isLoadingClientStats, isLoadingClientStats) ||
                other.isLoadingClientStats == isLoadingClientStats) &&
            (identical(
                  other.isLoadingThreadAnalytics,
                  isLoadingThreadAnalytics,
                ) ||
                other.isLoadingThreadAnalytics == isLoadingThreadAnalytics) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    status,
    errorMessage,
    successMessage,
    const DeepCollectionEquality().hash(_statistics),
    const DeepCollectionEquality().hash(_targetingOptions),
    const DeepCollectionEquality().hash(_clientStats),
    const DeepCollectionEquality().hash(_threadAnalytics),
    const DeepCollectionEquality().hash(_clients),
    selectedClientId,
    const DeepCollectionEquality().hash(_threads),
    selectedThreadId,
    const DeepCollectionEquality().hash(_opportunities),
    isLoadingStatistics,
    isLoadingClients,
    isLoadingThreads,
    isLoadingOpportunities,
    isLoadingClientStats,
    isLoadingThreadAnalytics,
    isSaving,
  ]);

  /// Create a copy of AdminEarnState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminEarnStateImplCopyWith<_$AdminEarnStateImpl> get copyWith =>
      __$$AdminEarnStateImplCopyWithImpl<_$AdminEarnStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AdminEarnState extends AdminEarnState {
  const factory _AdminEarnState({
    final AdminEarnStatus status,
    final String? errorMessage,
    final String? successMessage,
    final Map<String, dynamic>? statistics,
    final Map<String, dynamic>? targetingOptions,
    final Map<String, dynamic>? clientStats,
    final Map<String, dynamic>? threadAnalytics,
    final List<Map<String, dynamic>> clients,
    final String? selectedClientId,
    final List<Map<String, dynamic>> threads,
    final String? selectedThreadId,
    final List<Map<String, dynamic>> opportunities,
    final bool isLoadingStatistics,
    final bool isLoadingClients,
    final bool isLoadingThreads,
    final bool isLoadingOpportunities,
    final bool isLoadingClientStats,
    final bool isLoadingThreadAnalytics,
    final bool isSaving,
  }) = _$AdminEarnStateImpl;
  const _AdminEarnState._() : super._();

  // Status
  @override
  AdminEarnStatus get status;
  @override
  String? get errorMessage;
  @override
  String? get successMessage; // Statistics
  @override
  Map<String, dynamic>? get statistics;
  @override
  Map<String, dynamic>? get targetingOptions;
  @override
  Map<String, dynamic>? get clientStats;
  @override
  Map<String, dynamic>? get threadAnalytics; // Clients
  @override
  List<Map<String, dynamic>> get clients;
  @override
  String? get selectedClientId; // Threads
  @override
  List<Map<String, dynamic>> get threads;
  @override
  String? get selectedThreadId; // Opportunities
  @override
  List<Map<String, dynamic>> get opportunities; // Loading states
  @override
  bool get isLoadingStatistics;
  @override
  bool get isLoadingClients;
  @override
  bool get isLoadingThreads;
  @override
  bool get isLoadingOpportunities;
  @override
  bool get isLoadingClientStats;
  @override
  bool get isLoadingThreadAnalytics;
  @override
  bool get isSaving;

  /// Create a copy of AdminEarnState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminEarnStateImplCopyWith<_$AdminEarnStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
