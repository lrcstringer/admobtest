import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/referral_repository.dart';
import 'package:imalichat/presentation/blocs/referral/referral_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockReferralRepository extends Mock implements ReferralRepository {}

void main() {
  late MockReferralRepository mockReferralRepository;

  setUp(() {
    mockReferralRepository = MockReferralRepository();
  });

  group('ReferralBloc', () {
    test('initial state is correct', () {
      final bloc = ReferralBloc(mockReferralRepository);
      expect(bloc.state.isLoading, false);
      expect(bloc.state.referrals, isEmpty);
      expect(bloc.state.stats, isNull);
      bloc.close();
    });

    group('LoadStats', () {
      blocTest<ReferralBloc, ReferralState>(
        'emits [loading, loaded] when getReferralStats succeeds',
        build: () {
          when(() => mockReferralRepository.getReferralStats())
              .thenAnswer((_) async => Right(TestData.testReferralStats));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.loadStats()),
        expect: () => [
          isA<ReferralState>().having((s) => s.isLoading, 'isLoading', true),
          isA<ReferralState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.stats, 'stats', TestData.testReferralStats),
        ],
      );

      blocTest<ReferralBloc, ReferralState>(
        'emits [loading, error] when getReferralStats fails',
        build: () {
          when(() => mockReferralRepository.getReferralStats())
              .thenAnswer((_) async => const Left(Failure.network()));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.loadStats()),
        expect: () => [
          isA<ReferralState>().having((s) => s.isLoading, 'isLoading', true),
          isA<ReferralState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadReferrals', () {
      blocTest<ReferralBloc, ReferralState>(
        'loads referrals successfully',
        build: () {
          when(() => mockReferralRepository.getReferrals(
                status: any(named: 'status'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(TestData.referralList));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.loadReferrals()),
        expect: () => [
          isA<ReferralState>().having((s) => s.isLoadingReferrals, 'isLoadingReferrals', true),
          isA<ReferralState>()
              .having((s) => s.isLoadingReferrals, 'isLoadingReferrals', false)
              .having((s) => s.referrals, 'referrals', TestData.referralList),
        ],
      );
    });

    group('ApplyCode', () {
      blocTest<ReferralBloc, ReferralState>(
        'applies referral code successfully',
        build: () {
          when(() => mockReferralRepository.applyReferralCode(any()))
              .thenAnswer((_) async => Right(TestData.completedReferral));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.applyCode('ABC123')),
        expect: () => [
          isA<ReferralState>().having((s) => s.isApplying, 'isApplying', true),
          isA<ReferralState>()
              .having((s) => s.isApplying, 'isApplying', false)
              .having((s) => s.appliedReferral, 'appliedReferral', TestData.completedReferral)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<ReferralBloc, ReferralState>(
        'emits error when applyReferralCode fails',
        build: () {
          when(() => mockReferralRepository.applyReferralCode(any()))
              .thenAnswer((_) async => const Left(Failure.unknown(message: 'Invalid code')));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.applyCode('INVALID')),
        expect: () => [
          isA<ReferralState>().having((s) => s.isApplying, 'isApplying', true),
          isA<ReferralState>()
              .having((s) => s.isApplying, 'isApplying', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('ValidateCode', () {
      blocTest<ReferralBloc, ReferralState>(
        'validates code successfully',
        build: () {
          when(() => mockReferralRepository.isValidReferralCode(any()))
              .thenAnswer((_) async => const Right(true));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.validateCode('ABC123')),
        expect: () => [
          isA<ReferralState>()
              .having((s) => s.isValidating, 'isValidating', true)
              .having((s) => s.isCodeValid, 'isCodeValid', isNull),
          isA<ReferralState>()
              .having((s) => s.isValidating, 'isValidating', false)
              .having((s) => s.isCodeValid, 'isCodeValid', true),
        ],
      );

      blocTest<ReferralBloc, ReferralState>(
        'returns false for invalid code',
        build: () {
          when(() => mockReferralRepository.isValidReferralCode(any()))
              .thenAnswer((_) async => const Right(false));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.validateCode('INVALID')),
        expect: () => [
          isA<ReferralState>().having((s) => s.isValidating, 'isValidating', true),
          isA<ReferralState>()
              .having((s) => s.isValidating, 'isValidating', false)
              .having((s) => s.isCodeValid, 'isCodeValid', false),
        ],
      );
    });

    group('LoadLeaderboard', () {
      blocTest<ReferralBloc, ReferralState>(
        'loads leaderboard successfully',
        build: () {
          when(() => mockReferralRepository.getReferralLeaderboard(limit: any(named: 'limit')))
              .thenAnswer((_) async => const Right([]));
          return ReferralBloc(mockReferralRepository);
        },
        act: (bloc) => bloc.add(const ReferralEvent.loadLeaderboard()),
        expect: () => [
          isA<ReferralState>().having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', true),
          isA<ReferralState>()
              .having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', false)
              .having((s) => s.leaderboard, 'leaderboard', isEmpty),
        ],
      );
    });

    group('CopyCode', () {
      blocTest<ReferralBloc, ReferralState>(
        'emits success message on copy',
        build: () => ReferralBloc(mockReferralRepository),
        act: (bloc) => bloc.add(const ReferralEvent.copyCode()),
        expect: () => [
          isA<ReferralState>().having((s) => s.successMessage, 'successMessage', 'Referral code copied!'),
        ],
      );
    });

    group('ClearError', () {
      blocTest<ReferralBloc, ReferralState>(
        'clears error message',
        build: () => ReferralBloc(mockReferralRepository),
        seed: () => const ReferralState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const ReferralEvent.clearError()),
        expect: () => [
          isA<ReferralState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    group('ClearSuccess', () {
      blocTest<ReferralBloc, ReferralState>(
        'clears success message',
        build: () => ReferralBloc(mockReferralRepository),
        seed: () => const ReferralState(successMessage: 'Some success'),
        act: (bloc) => bloc.add(const ReferralEvent.clearSuccess()),
        expect: () => [
          isA<ReferralState>().having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );
    });
  });
}
