import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/wallet.dart';

void main() {
  group('Wallet Entity', () {
    late Wallet wallet;

    setUp(() {
      wallet = Wallet(
        id: 'wallet123',
        userId: 'user123',
        name: 'Main Wallet',
        type: WalletType.main,
        balanceTokens: 10000,
        lifetimeEarned: 50000,
        lifetimeWithdrawn: 20000,
        canWithdraw: true,
        version: 1,
        updatedAt: DateTime.now(),
      );
    });

    test('should create wallet with correct properties', () {
      expect(wallet.id, equals('wallet123'));
      expect(wallet.userId, equals('user123'));
      expect(wallet.balanceTokens, equals(10000));
      expect(wallet.type, equals(WalletType.main));
    });

    test('should calculate ZAR balance correctly', () {
      // 10000 tokens * R0.01 = R100
      expect(wallet.balanceZar, equals(100.0));
    });

    test('should check if can cashout correctly', () {
      expect(wallet.canCashout, isTrue);

      final poorWallet = Wallet(
        id: 'wallet456',
        userId: 'user456',
        name: 'Poor Wallet',
        type: WalletType.main,
        balanceTokens: 300, // Below minimum (500 tokens)
        lifetimeEarned: 300,
        lifetimeWithdrawn: 0,
        canWithdraw: true,
        version: 1,
        updatedAt: DateTime.now(),
      );

      expect(poorWallet.canCashout, isFalse);
    });

    test('should check if is main wallet correctly', () {
      expect(wallet.isMainWallet, isTrue);

      final brandWallet = Wallet(
        id: 'wallet789',
        userId: 'user789',
        name: 'Brand Wallet',
        type: WalletType.brand,
        balanceTokens: 5000,
        lifetimeEarned: 5000,
        lifetimeWithdrawn: 0,
        canWithdraw: false,
        brandId: 'brand123',
        version: 1,
        updatedAt: DateTime.now(),
      );

      expect(brandWallet.isMainWallet, isFalse);
    });

    test('copyWith should create new wallet with updated values', () {
      final updatedWallet = wallet.copyWith(balanceTokens: 15000);

      expect(updatedWallet.balanceTokens, equals(15000));
      expect(updatedWallet.id, equals(wallet.id));
      expect(updatedWallet.userId, equals(wallet.userId));
    });

    test('should get balance as TokenAmount', () {
      expect(wallet.balance.value, equals(10000));
    });
  });

  group('WalletType', () {
    test('should have main and brand types', () {
      expect(WalletType.values, contains(WalletType.main));
      expect(WalletType.values, contains(WalletType.brand));
    });
  });
}
