import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/step_up_auth_service.dart';
import 'package:imalichat/domain/entities/purchase.dart';
import 'package:imalichat/domain/repositories/purchase_repository.dart';
import 'package:imalichat/presentation/blocs/purchase/purchase_bloc.dart';

class MockPurchaseRepository extends Mock implements PurchaseRepository {}
class MockStepUpAuthService extends Mock implements StepUpAuthService {}

void main() {
  late MockPurchaseRepository mockPurchaseRepository;
  late MockStepUpAuthService mockStepUpAuthService;

  setUpAll(() {
    registerFallbackValue(PurchaseCategory.airtime);
  });

  setUp(() {
    mockPurchaseRepository = MockPurchaseRepository();
    mockStepUpAuthService = MockStepUpAuthService();
  });

  group('PurchaseBloc', () {
    test('initial state is correct', () {
      final bloc = PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
      expect(bloc.state.providers, isEmpty);
      expect(bloc.state.selectedProvider, isNull);
      expect(bloc.state.selectedProduct, isNull);
      expect(bloc.state.isPurchasing, false);
      bloc.close();
    });

    group('LoadProviders', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'emits [loading, loaded] when getServiceProviders succeeds',
        build: () {
          when(() => mockPurchaseRepository.getServiceProviders())
              .thenAnswer((_) async => const Right([]));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        act: (bloc) => bloc.add(const PurchaseEvent.loadProviders()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', true),
          isA<PurchaseState>()
              .having((s) => s.isLoadingProviders, 'isLoadingProviders', false)
              .having((s) => s.providers, 'providers', isEmpty),
        ],
      );

      blocTest<PurchaseBloc, PurchaseState>(
        'emits [loading, error] when getServiceProviders fails',
        build: () {
          when(() => mockPurchaseRepository.getServiceProviders())
              .thenAnswer((_) async => const Left(Failure.network()));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        act: (bloc) => bloc.add(const PurchaseEvent.loadProviders()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', true),
          isA<PurchaseState>()
              .having((s) => s.isLoadingProviders, 'isLoadingProviders', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadProvidersByCategory', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'loads providers by category successfully',
        build: () {
          when(() => mockPurchaseRepository.getProvidersByCategory(any()))
              .thenAnswer((_) async => const Right([]));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        act: (bloc) => bloc.add(const PurchaseEvent.loadProvidersByCategory(PurchaseCategory.airtime)),
        expect: () => [
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', true),
          isA<PurchaseState>()
              .having((s) => s.isLoadingProviders, 'isLoadingProviders', false)
              .having((s) => s.selectedCategory, 'selectedCategory', PurchaseCategory.airtime),
        ],
      );
    });

    group('SelectCategory', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'selects category and loads providers',
        build: () {
          when(() => mockPurchaseRepository.getProvidersByCategory(any()))
              .thenAnswer((_) async => const Right([]));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        act: (bloc) => bloc.add(const PurchaseEvent.selectCategory(PurchaseCategory.electricity)),
        expect: () => [
          isA<PurchaseState>()
              .having((s) => s.selectedCategory, 'selectedCategory', PurchaseCategory.electricity)
              .having((s) => s.selectedProvider, 'selectedProvider', isNull)
              .having((s) => s.selectedProduct, 'selectedProduct', isNull),
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', true),
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', false),
        ],
      );

      blocTest<PurchaseBloc, PurchaseState>(
        'selects null category and loads all providers',
        build: () {
          when(() => mockPurchaseRepository.getServiceProviders())
              .thenAnswer((_) async => const Right([]));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        act: (bloc) => bloc.add(const PurchaseEvent.selectCategory(null)),
        expect: () => [
          isA<PurchaseState>().having((s) => s.selectedCategory, 'selectedCategory', isNull),
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', true),
          isA<PurchaseState>().having((s) => s.isLoadingProviders, 'isLoadingProviders', false),
        ],
      );
    });

    group('SetRecipientNumber', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'sets recipient number and clears validation',
        build: () => PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService),
        act: (bloc) => bloc.add(const PurchaseEvent.setRecipientNumber('0612345678')),
        expect: () => [
          isA<PurchaseState>()
              .having((s) => s.recipientNumber, 'recipientNumber', '0612345678')
              .having((s) => s.isRecipientValid, 'isRecipientValid', isNull),
        ],
      );
    });

    group('ValidateRecipient', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'returns false for empty recipient',
        build: () => PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService),
        seed: () => const PurchaseState(recipientNumber: null),
        act: (bloc) => bloc.add(const PurchaseEvent.validateRecipient()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.isRecipientValid, 'isRecipientValid', false),
        ],
      );

      blocTest<PurchaseBloc, PurchaseState>(
        'validates recipient successfully',
        build: () {
          when(() => mockPurchaseRepository.validateRecipientNumber(
                number: any(named: 'number'),
                category: any(named: 'category'),
              )).thenAnswer((_) async => const Right(true));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        seed: () => const PurchaseState(recipientNumber: '0612345678'),
        act: (bloc) => bloc.add(const PurchaseEvent.validateRecipient()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.isValidating, 'isValidating', true),
          isA<PurchaseState>()
              .having((s) => s.isValidating, 'isValidating', false)
              .having((s) => s.isRecipientValid, 'isRecipientValid', true),
        ],
      );
    });

    group('LoadHistory', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'loads purchase history successfully',
        build: () {
          when(() => mockPurchaseRepository.getPurchaseHistory(
                category: any(named: 'category'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => const Right([]));
          return PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService);
        },
        act: (bloc) => bloc.add(const PurchaseEvent.loadHistory()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<PurchaseState>()
              .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
              .having((s) => s.history, 'history', isEmpty),
        ],
      );
    });

    group('SelectRecentRecipient', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'selects recent recipient and marks as valid',
        build: () => PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService),
        act: (bloc) => bloc.add(const PurchaseEvent.selectRecentRecipient('0712345678')),
        expect: () => [
          isA<PurchaseState>()
              .having((s) => s.recipientNumber, 'recipientNumber', '0712345678')
              .having((s) => s.isRecipientValid, 'isRecipientValid', true),
        ],
      );
    });

    group('ResetSelection', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'resets all selection state',
        build: () => PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService),
        seed: () => const PurchaseState(
          recipientNumber: '0612345678',
          isRecipientValid: true,
        ),
        act: (bloc) => bloc.add(const PurchaseEvent.resetSelection()),
        expect: () => [
          isA<PurchaseState>()
              .having((s) => s.selectedProvider, 'selectedProvider', isNull)
              .having((s) => s.selectedProduct, 'selectedProduct', isNull)
              .having((s) => s.recipientNumber, 'recipientNumber', isNull)
              .having((s) => s.isRecipientValid, 'isRecipientValid', isNull),
        ],
      );
    });

    group('ClearError', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'clears error message',
        build: () => PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService),
        seed: () => const PurchaseState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const PurchaseEvent.clearError()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    group('ClearSuccess', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'clears success message',
        build: () => PurchaseBloc(mockPurchaseRepository, mockStepUpAuthService),
        seed: () => const PurchaseState(successMessage: 'Purchase successful!'),
        act: (bloc) => bloc.add(const PurchaseEvent.clearSuccess()),
        expect: () => [
          isA<PurchaseState>().having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );
    });
  });
}
