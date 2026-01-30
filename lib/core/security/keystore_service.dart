import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../error/failures.dart';

/// Result of keypair generation containing public key and hardware info.
class KeyGenerationResult {
  final String publicKeyPem;
  final bool hardwareBacked;
  final bool strongBox;

  const KeyGenerationResult({
    required this.publicKeyPem,
    required this.hardwareBacked,
    required this.strongBox,
  });
}

/// SIM card information for change detection.
class SimInfo {
  final bool available;
  final String operatorName;
  final String simCountryIso;
  final String networkCountryIso;

  const SimInfo({
    required this.available,
    required this.operatorName,
    required this.simCountryIso,
    required this.networkCountryIso,
  });

  String get fingerprint => '$operatorName|$simCountryIso|$networkCountryIso';
}

/// Dart wrapper around native Keystore/Secure Enclave platform channel.
///
/// Provides ECDSA P-256 keypair management with hardware-backed storage
/// on both Android (Keystore/StrongBox/TEE) and iOS (Secure Enclave/Keychain).
@lazySingleton
class KeystoreService {
  static const _channel = MethodChannel('com.imali.chat/keystore');

  /// Generate an ECDSA P-256 keypair.
  ///
  /// The private key is stored in hardware-backed storage.
  /// Returns the public key in PEM format along with hardware info.
  Future<Either<Failure, KeyGenerationResult>> generateKeyPair(
      String alias) async {
    try {
      final result =
          await _channel.invokeMapMethod<String, dynamic>('generateKeyPair', {
        'alias': alias,
      });

      if (result == null) {
        return const Left(Failure.unknown(message: 'No response from keystore'));
      }

      return Right(KeyGenerationResult(
        publicKeyPem: result['publicKey'] as String,
        hardwareBacked: result['hardwareBacked'] as bool,
        strongBox: result['strongBox'] as bool,
      ));
    } on PlatformException catch (e) {
      debugPrint('Keystore generateKeyPair error: ${e.message}');
      return Left(Failure.unknown(message: 'Keystore error: ${e.message}'));
    } catch (e) {
      debugPrint('Keystore generateKeyPair unexpected error: $e');
      return Left(Failure.unknown(message: 'Unexpected keystore error: $e'));
    }
  }

  /// Sign data using the private key stored in hardware.
  ///
  /// [data] must be a base64-encoded string.
  /// Returns the signature as a base64-encoded string.
  Future<Either<Failure, String>> sign(String alias, String data) async {
    try {
      final result = await _channel.invokeMethod<String>('sign', {
        'alias': alias,
        'data': data,
      });

      if (result == null) {
        return const Left(Failure.unknown(message: 'No signature returned'));
      }

      return Right(result);
    } on PlatformException catch (e) {
      debugPrint('Keystore sign error: ${e.message}');
      return Left(Failure.unknown(message: 'Sign error: ${e.message}'));
    } catch (e) {
      debugPrint('Keystore sign unexpected error: $e');
      return Left(Failure.unknown(message: 'Unexpected sign error: $e'));
    }
  }

  /// Delete a keypair from hardware-backed storage.
  Future<Either<Failure, bool>> deleteKey(String alias) async {
    try {
      final result = await _channel.invokeMethod<bool>('deleteKey', {
        'alias': alias,
      });
      return Right(result ?? true);
    } on PlatformException catch (e) {
      debugPrint('Keystore deleteKey error: ${e.message}');
      return Left(Failure.unknown(message: 'Delete error: ${e.message}'));
    } catch (e) {
      debugPrint('Keystore deleteKey unexpected error: $e');
      return Left(Failure.unknown(message: 'Unexpected delete error: $e'));
    }
  }

  /// Check if a keypair exists in hardware-backed storage.
  Future<Either<Failure, bool>> hasKey(String alias) async {
    try {
      final result = await _channel.invokeMethod<bool>('hasKey', {
        'alias': alias,
      });
      return Right(result ?? false);
    } on PlatformException catch (e) {
      debugPrint('Keystore hasKey error: ${e.message}');
      return Left(Failure.unknown(message: 'HasKey error: ${e.message}'));
    } catch (e) {
      debugPrint('Keystore hasKey unexpected error: $e');
      return Left(Failure.unknown(message: 'Unexpected hasKey error: $e'));
    }
  }

  /// Get the public key for an existing keypair in PEM format.
  Future<Either<Failure, String>> getPublicKey(String alias) async {
    try {
      final result = await _channel.invokeMethod<String>('getPublicKey', {
        'alias': alias,
      });

      if (result == null) {
        return const Left(
            Failure.unknown(message: 'No public key returned'));
      }

      return Right(result);
    } on PlatformException catch (e) {
      debugPrint('Keystore getPublicKey error: ${e.message}');
      return Left(
          Failure.unknown(message: 'GetPublicKey error: ${e.message}'));
    } catch (e) {
      debugPrint('Keystore getPublicKey unexpected error: $e');
      return Left(
          Failure.unknown(message: 'Unexpected getPublicKey error: $e'));
    }
  }

  /// Get SIM card info for change detection.
  /// Uses operator name (no special permission required).
  Future<Either<Failure, SimInfo>> getSimInfo() async {
    try {
      final result = await _channel
          .invokeMapMethod<String, dynamic>('getSimInfo');

      if (result == null) {
        return const Left(
            Failure.unknown(message: 'No SIM info returned'));
      }

      return Right(SimInfo(
        available: result['available'] as bool,
        operatorName: result['operatorName'] as String,
        simCountryIso: result['simCountryIso'] as String,
        networkCountryIso: result['networkCountryIso'] as String,
      ));
    } on PlatformException catch (e) {
      debugPrint('Keystore getSimInfo error: ${e.message}');
      return Left(
          Failure.unknown(message: 'SIM info error: ${e.message}'));
    } catch (e) {
      debugPrint('Keystore getSimInfo unexpected error: $e');
      return Left(
          Failure.unknown(message: 'Unexpected SIM info error: $e'));
    }
  }

  /// Get the key alias for a given user.
  static String keyAlias(String userId) => 'imali_device_key_$userId';
}
