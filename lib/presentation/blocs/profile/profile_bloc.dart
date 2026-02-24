import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/privacy_settings.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/enums/privacy_enums.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/wallet_repository.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final WalletRepository _walletRepository;

  StreamSubscription? _userSubscription;

  ProfileBloc(
    this._userRepository,
    this._walletRepository,
  ) : super(const ProfileState()) {
    on<_LoadProfile>(_onLoadProfile);
    on<_WatchProfile>(_onWatchProfile);
    on<_UserUpdated>(_onUserUpdated);
    on<_UpdateProfile>(_onUpdateProfile);
    on<_UpdateUsername>(_onUpdateUsername);
    on<_CheckUsername>(_onCheckUsername);
    on<_AcceptTerms>(_onAcceptTerms);
    on<_UpdatePrivacySetting>(_onUpdatePrivacySetting);
  }

  Future<void> _onLoadProfile(
    _LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final userResult = await _userRepository.getCurrentUser();

      await userResult.fold(
        (failure) async {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: failure.displayMessage,
          ));
        },
        (user) async {
          // Load engagement stats to get lifetime earned tokens
          final statsResult = await _walletRepository.getEngagementStats();

          int lifetimeEarned = 0;

          statsResult.fold(
            (failure) => null,
            (stats) {
              lifetimeEarned = stats.totalTokensEarned;
            },
          );

          emit(state.copyWith(
            status: ProfileStatus.loaded,
            user: user,
            lifetimeEarned: lifetimeEarned,
            lifetimeWithdrawn: 0, // Withdrawn amount tracked separately via cashout history
          ));

          // Start watching user updates
          add(const ProfileEvent.watchProfile());
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onWatchProfile(
    _WatchProfile event,
    Emitter<ProfileState> emit,
  ) {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.watchCurrentUser().listen(
      (result) {
        result.fold(
          (failure) => null,
          (user) => add(ProfileEvent.userUpdated(user)),
        );
      },
    );
  }

  void _onUserUpdated(
    _UserUpdated event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  Future<void> _onUpdateProfile(
    _UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.user == null) return;

    emit(state.copyWith(isUpdating: true, updateError: null));

    final result = await _userRepository.updateProfile(
      userId: state.user!.id,
      displayName: event.displayName,
      firstName: event.firstName,
      lastName: event.lastName,
      gender: event.gender,
      dateOfBirth: event.dateOfBirth,
      province: event.province,
      avatarUrl: event.avatarUrl,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isUpdating: false,
          updateError: failure.displayMessage,
        ));
      },
      (user) {
        emit(state.copyWith(
          isUpdating: false,
          user: user,
          updateSuccess: true,
        ));
        // Reset success flag after a short delay
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!isClosed) {
            // ignore: invalid_use_of_visible_for_testing_member
            emit(state.copyWith(updateSuccess: false));
          }
        });
      },
    );
  }

  Future<void> _onUpdateUsername(
    _UpdateUsername event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.user == null) return;

    emit(state.copyWith(isUpdating: true, updateError: null));

    final result = await _userRepository.updateProfile(
      userId: state.user!.id,
      username: event.username,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isUpdating: false,
          updateError: failure.displayMessage,
        ));
      },
      (user) {
        emit(state.copyWith(
          isUpdating: false,
          user: user,
          updateSuccess: true,
        ));
      },
    );
  }

  Future<void> _onCheckUsername(
    _CheckUsername event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isCheckingUsername: true,
      usernameAvailable: null,
    ));

    final result = await _userRepository.isUsernameAvailable(event.username);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isCheckingUsername: false,
          usernameAvailable: null,
        ));
      },
      (available) {
        emit(state.copyWith(
          isCheckingUsername: false,
          usernameAvailable: available,
        ));
      },
    );
  }

  Future<void> _onAcceptTerms(
    _AcceptTerms event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true));

    final result = await _userRepository.acceptTerms();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isUpdating: false,
          updateError: failure.displayMessage,
        ));
      },
      (_) {
        // Reload profile to get updated state
        add(const ProfileEvent.loadProfile());
      },
    );
  }

  Future<void> _onUpdatePrivacySetting(
    _UpdatePrivacySetting event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.user == null) return;

    final currentPrivacy =
        state.user!.profile?.privacySettings ?? const PrivacySettings();

    // Build updated privacy settings from the key/value pair
    final updated = _applyPrivacySetting(currentPrivacy, event.key, event.value);
    if (updated == null) return;

    // Optimistic update
    final updatedProfile = state.user!.profile?.copyWith(
      privacySettings: updated,
    );
    final updatedUser = state.user!.copyWith(profile: updatedProfile);
    emit(state.copyWith(user: updatedUser, isUpdating: true, updateError: null));

    final result = await _userRepository.updatePrivacySettings(updated);

    result.fold(
      (failure) {
        // Revert optimistic update
        emit(state.copyWith(
          user: state.user!.copyWith(
            profile: state.user!.profile?.copyWith(
              privacySettings: currentPrivacy,
            ),
          ),
          isUpdating: false,
          updateError: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(isUpdating: false));
      },
    );
  }

  PrivacySettings? _applyPrivacySetting(
    PrivacySettings current,
    String key,
    dynamic value,
  ) {
    switch (key) {
      case 'discoverability':
        return current.copyWith(
          discoverability: Discoverability.values.firstWhere(
            (e) => e.name == value,
            orElse: () => current.discoverability,
          ),
        );
      case 'phoneNumberVisibility':
        return current.copyWith(
          phoneNumberVisibility: PhoneNumberVisibility.values.firstWhere(
            (e) => e.name == value,
            orElse: () => current.phoneNumberVisibility,
          ),
        );
      case 'profilePhotoVisibility':
        return current.copyWith(
          profilePhotoVisibility: ProfilePhotoVisibility.values.firstWhere(
            (e) => e.name == value,
            orElse: () => current.profilePhotoVisibility,
          ),
        );
      case 'lastSeenVisibility':
        return current.copyWith(
          lastSeenVisibility: LastSeenVisibility.values.firstWhere(
            (e) => e.name == value,
            orElse: () => current.lastSeenVisibility,
          ),
        );
      case 'readReceipts':
        return current.copyWith(readReceipts: value as bool);
      case 'groupAddPermission':
        return current.copyWith(
          groupAddPermission: GroupAddPermission.values.firstWhere(
            (e) => e.name == value,
            orElse: () => current.groupAddPermission,
          ),
        );
      case 'brandMessaging':
        return current.copyWith(
          brandMessaging: BrandMessaging.values.firstWhere(
            (e) => e.name == value,
            orElse: () => current.brandMessaging,
          ),
        );
      default:
        return null;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
