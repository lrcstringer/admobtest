import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/group_buy.dart';
import '../../../domain/entities/group_buy_contribution.dart';
import '../../../domain/repositories/group_buy_repository.dart';

part 'group_buy_event.dart';
part 'group_buy_state.dart';
part 'group_buy_bloc.freezed.dart';

@injectable
class GroupBuyBloc extends Bloc<GroupBuyEvent, GroupBuyState> {
  final GroupBuyRepository _repository;

  GroupBuyBloc(this._repository) : super(const GroupBuyState()) {
    on<_LoadActiveGroupBuys>(_onLoadActiveGroupBuys);
    on<_LoadGroupBuy>(_onLoadGroupBuy);
    on<_LoadMyGroupBuys>(_onLoadMyGroupBuys);
    on<_CreateGroupBuy>(_onCreateGroupBuy);
    on<_JoinGroupBuy>(_onJoinGroupBuy);
    on<_LoadHubGroupBuys>(_onLoadHubGroupBuys);
    on<_LeaveGroupBuy>(_onLeaveGroupBuy);
    on<_SuggestDeal>(_onSuggestDeal);
    on<_ConfirmCollection>(_onConfirmCollection);
    on<_CancelGroupBuy>(_onCancelGroupBuy);
    on<_CompleteGroupBuy>(_onCompleteGroupBuy);
    on<_UpdateDeliveryStatus>(_onUpdateDeliveryStatus);
    on<_ExtendDeadline>(_onExtendDeadline);
    on<_ClearMessages>(_onClearMessages);
  }

  Future<void> _onLoadActiveGroupBuys(
    _LoadActiveGroupBuys event,
    Emitter<GroupBuyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repository.getActiveGroupBuys(
      communityId: event.communityId,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (groupBuys) => emit(state.copyWith(
        isLoading: false,
        activeGroupBuys: groupBuys,
      )),
    );
  }

  Future<void> _onLoadGroupBuy(
    _LoadGroupBuy event,
    Emitter<GroupBuyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Fetch in parallel with proper typing (no unsafe dynamic casts)
    final groupBuyFuture = _repository.getGroupBuy(event.id);
    final contribsFuture = _repository.getContributions(event.id);

    final Either<Failure, GroupBuy> groupBuyResult = await groupBuyFuture;
    final Either<Failure, List<GroupBuyContribution>> contribsResult =
        await contribsFuture;

    groupBuyResult.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (groupBuy) {
        final contributions = contribsResult.getOrElse(() => []);
        emit(state.copyWith(
          isLoading: false,
          selectedGroupBuy: groupBuy,
          contributions: contributions,
        ));
      },
    );
  }

  Future<void> _onLoadMyGroupBuys(
    _LoadMyGroupBuys event,
    Emitter<GroupBuyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repository.getMyGroupBuys();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (groupBuys) => emit(state.copyWith(
        isLoading: false,
        myGroupBuys: groupBuys,
      )),
    );
  }

  Future<void> _onCreateGroupBuy(
    _CreateGroupBuy event,
    Emitter<GroupBuyState> emit,
  ) async {
    // Double-submit guard
    if (state.isCreating) return;

    emit(state.copyWith(isCreating: true, errorMessage: null));
    final result = await _repository.createGroupBuy(
      title: event.title,
      description: event.description,
      targetAmount: event.targetAmount,
      deadline: event.deadline,
      linkedListingId: event.linkedListingId,
      minParticipants: event.minParticipants,
      maxParticipants: event.maxParticipants,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isCreating: false,
        errorMessage: failure.displayMessage,
      )),
      (id) => emit(state.copyWith(
        isCreating: false,
        successId: id,
        successMessage: 'Group buy created!',
      )),
    );
  }

  Future<void> _onJoinGroupBuy(
    _JoinGroupBuy event,
    Emitter<GroupBuyState> emit,
  ) async {
    // Double-submit guard
    if (state.isJoining) return;

    emit(state.copyWith(isJoining: true, errorMessage: null));
    final result = await _repository.joinGroupBuy(
      groupBuyId: event.groupBuyId,
      amount: event.amount,
      walletId: event.walletId,
      deliveryAddress: event.deliveryAddress,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isJoining: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isJoining: false,
        successMessage: 'Successfully joined the group buy!',
      )),
    );
  }

  Future<void> _onLoadHubGroupBuys(
    _LoadHubGroupBuys event,
    Emitter<GroupBuyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repository.getHubGroupBuys(
      userClusters: event.userClusters,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (groupBuys) => emit(state.copyWith(
        isLoading: false,
        hubGroupBuys: groupBuys,
      )),
    );
  }

  Future<void> _onLeaveGroupBuy(
    _LeaveGroupBuy event,
    Emitter<GroupBuyState> emit,
  ) async {
    if (state.isLeaving) return;

    emit(state.copyWith(isLeaving: true, errorMessage: null));
    final result = await _repository.leaveGroupBuy(
      groupBuyId: event.groupBuyId,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isLeaving: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isLeaving: false,
        successMessage: 'You have left the group buy. Your contribution has been refunded.',
        shouldPopOnSuccess: true,
      )),
    );
  }

  Future<void> _onSuggestDeal(
    _SuggestDeal event,
    Emitter<GroupBuyState> emit,
  ) async {
    if (state.isSuggestingDeal) return;

    emit(state.copyWith(isSuggestingDeal: true, errorMessage: null));
    final result = await _repository.suggestGroupBuyDeal(
      description: event.description,
      brandOrStore: event.brandOrStore,
      estimatedPrice: event.estimatedPrice,
      sourceUrl: event.sourceUrl,
      imageUrl: event.imageUrl,
      wantsToJoin: event.wantsToJoin,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isSuggestingDeal: false,
        errorMessage: failure.displayMessage,
      )),
      (id) => emit(state.copyWith(
        isSuggestingDeal: false,
        successId: id,
        successMessage: 'Deal suggestion submitted!',
      )),
    );
  }

  Future<void> _onConfirmCollection(
    _ConfirmCollection event,
    Emitter<GroupBuyState> emit,
  ) async {
    if (state.isConfirmingCollection) return;

    emit(state.copyWith(isConfirmingCollection: true, errorMessage: null));
    final result = await _repository.confirmCollection(
      groupBuyId: event.groupBuyId,
      contributionId: event.contributionId,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isConfirmingCollection: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isConfirmingCollection: false,
          successMessage: 'Collection confirmed!',
        ));
        // Reload to reflect updated contribution status
        add(GroupBuyEvent.loadGroupBuy(event.groupBuyId));
      },
    );
  }

  Future<void> _onCancelGroupBuy(
    _CancelGroupBuy event,
    Emitter<GroupBuyState> emit,
  ) async {
    if (state.isCancelling) return;

    emit(state.copyWith(isCancelling: true, errorMessage: null));
    final result = await _repository.cancelGroupBuy(
      groupBuyId: event.groupBuyId,
      reason: event.reason,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isCancelling: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isCancelling: false,
        successMessage: 'Group buy cancelled. Contributions will be refunded.',
      )),
    );
  }

  Future<void> _onCompleteGroupBuy(
    _CompleteGroupBuy event,
    Emitter<GroupBuyState> emit,
  ) async {
    // Double-submit guard
    if (state.isCompleting) return;

    emit(state.copyWith(isCompleting: true, errorMessage: null));
    final result = await _repository.completeGroupBuy(
      groupBuyId: event.groupBuyId,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isCompleting: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isCompleting: false,
          successMessage: 'Group buy completed! Funds released.',
        ));
        // Reload to reflect updated status
        add(GroupBuyEvent.loadGroupBuy(event.groupBuyId));
      },
    );
  }

  Future<void> _onUpdateDeliveryStatus(
    _UpdateDeliveryStatus event,
    Emitter<GroupBuyState> emit,
  ) async {
    if (state.isUpdatingDelivery) return;

    emit(state.copyWith(isUpdatingDelivery: true, errorMessage: null));
    final result = await _repository.updateDeliveryStatus(
      groupBuyId: event.groupBuyId,
      deliveryStatus: event.deliveryStatus,
      trackingInfo: event.trackingInfo,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isUpdatingDelivery: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isUpdatingDelivery: false,
          successMessage: 'Delivery status updated',
        ));
        // Reload to reflect updated status
        add(GroupBuyEvent.loadGroupBuy(event.groupBuyId));
      },
    );
  }

  Future<void> _onExtendDeadline(
    _ExtendDeadline event,
    Emitter<GroupBuyState> emit,
  ) async {
    if (state.isExtendingDeadline) return;

    emit(state.copyWith(isExtendingDeadline: true, errorMessage: null));
    final result = await _repository.extendDeadline(
      groupBuyId: event.groupBuyId,
      newDeadline: event.newDeadline,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isExtendingDeadline: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isExtendingDeadline: false,
          successMessage: 'Deadline extended',
        ));
        // Reload to reflect updated deadline
        add(GroupBuyEvent.loadGroupBuy(event.groupBuyId));
      },
    );
  }

  void _onClearMessages(
    _ClearMessages event,
    Emitter<GroupBuyState> emit,
  ) {
    emit(state.copyWith(
      errorMessage: null,
      successId: null,
      successMessage: null,
      shouldPopOnSuccess: false,
    ));
  }
}
