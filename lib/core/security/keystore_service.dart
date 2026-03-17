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
      return Left(Failure.unknown(message: 'Keystore error: ${e.message}'));
    } catch (e) {
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
      return Left(Failure.unknown(message: 'Sign error: ${e.message}'));
    } catch (e) {
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
      return Left(Failure.unknown(message: 'Delete error: ${e.message}'));
    } catch (e) {
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
      return Left(Failure.unknown(message: 'HasKey error: ${e.message}'));
    } catch (e) {
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
      return Left(
          Failure.unknown(message: 'GetPublicKey error: ${e.message}'));
    } catch (e) {
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
      return Left(
          Failure.unknown(message: 'SIM info error: ${e.message}'));
    } catch (e) {
      return Left(
          Failure.unknown(message: 'Unexpected SIM info error: $e'));
    }
  }

  /// Get the key alias for a given user.
  static String keyAlias(String userId) => 'imali_device_key_$userId';

  /// Get the wrapping key alias for a given user's recovery key.
  static String wrappingKeyAlias(String userId) => 'imali_recovery_$userId';

  // ===========================================================================
  // AES-256-GCM Wrapping Key Operations (for E2EE payload recovery)
  // ===========================================================================

  /// Generate an AES-256-GCM wrapping key in hardware-backed storage.
  ///
  /// This key is used to wrap the media recovery key so it can be stored
  /// safely on Firestore. The key never leaves the TEE (Android) or
  /// Keychain (iOS) and survives app reinstall.
  ///
  /// IMPORTANT: This key MUST NOT be overwritten. Use [hasWrappingKey] first.
  Future<Either<Failure, bool>> generateWrappingKey(String alias) async {
    try {
      final result = await _channel.invokeMethod<bool>('generateWrappingKey', {
        'alias': alias,
      });
      return Right(result ?? false);
    } on PlatformException catch (e) {
      if (e.code == 'KEY_EXISTS') {
        // Key already exists — this is expected, not an error
        return const Right(true);
      }
      return Left(
          Failure.unknown(message: 'Wrapping key error: ${e.message}'));
    } catch (e) {
      return Left(
          Failure.unknown(message: 'Unexpected wrapping key error: $e'));
    }
  }

  /// Check if a wrapping key exists in hardware-backed storage.
  Future<Either<Failure, bool>> hasWrappingKey(String alias) async {
    try {
      final result = await _channel.invokeMethod<bool>('hasWrappingKey', {
        'alias': alias,
      });
      return Right(result ?? false);
    } on PlatformException catch (e) {
      return Left(
          Failure.unknown(message: 'HasWrappingKey error: ${e.message}'));
    } catch (e) {
      return Left(Failure.unknown(message: 'Unexpected error: $e'));
    }
  }

  /// Wrap (encrypt) data using the TEE/Keychain AES wrapping key.
  ///
  /// [data] is base64-encoded plaintext.
  /// Returns a map with `ciphertext` and `iv`, both base64-encoded.
  Future<Either<Failure, Map<String, String>>> wrapData(
      String alias, String data) async {
    try {
      final result =
          await _channel.invokeMapMethod<String, dynamic>('wrapData', {
        'alias': alias,
        'data': data,
      });
      if (result == null) {
        return const Left(Failure.unknown(message: 'No wrap result'));
      }
      return Right({
        'ciphertext': result['ciphertext'] as String,
        'iv': result['iv'] as String,
      });
    } on PlatformException catch (e) {
      return Left(Failure.unknown(message: 'Wrap error: ${e.message}'));
    } catch (e) {
      return Left(
          Failure.unknown(message: 'Unexpected wrap error: $e'));
    }
  }

  /// Unwrap (decrypt) data using the TEE/Keychain AES wrapping key.
  ///
  /// Returns the decrypted plaintext as a base64-encoded string.
  Future<Either<Failure, String>> unwrapData(
      String alias, String ciphertext, String iv) async {
    try {
      final result = await _channel.invokeMethod<String>('unwrapData', {
        'alias': alias,
        'ciphertext': ciphertext,
        'iv': iv,
      });
      if (result == null) {
        return const Left(Failure.unknown(message: 'No unwrap result'));
      }
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Failure.unknown(message: 'Unwrap error: ${e.message}'));
    } catch (e) {
      return Left(
          Failure.unknown(message: 'Unexpected unwrap error: $e'));
    }
  }
}
