import Flutter
import UIKit
import Security
import CoreTelephony
import CryptoKit

/// Platform channel for iOS Secure Enclave / Keychain operations.
///
/// Provides ECDSA P-256 keypair generation and signing using
/// Secure Enclave (when available) or Keychain fallback.
class KeystoreChannel: NSObject {
    static let channelName = "com.imali.chat/keystore"

    private var channel: FlutterMethodChannel?

    func register(with messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: KeystoreChannel.channelName, binaryMessenger: messenger)
        channel?.setMethodCallHandler(handle)
    }

    func unregister() {
        channel?.setMethodCallHandler(nil)
        channel = nil
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            if call.method == "getSimInfo" {
                getSimInfo(result: result)
                return
            }
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Arguments required", details: nil))
            return
        }

        switch call.method {
        case "generateKeyPair":
            guard let alias = args["alias"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias is required", details: nil))
                return
            }
            generateKeyPair(alias: alias, result: result)

        case "sign":
            guard let alias = args["alias"] as? String,
                  let data = args["data"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias and data are required", details: nil))
                return
            }
            sign(alias: alias, data: data, result: result)

        case "deleteKey":
            guard let alias = args["alias"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias is required", details: nil))
                return
            }
            deleteKey(alias: alias, result: result)

        case "hasKey":
            guard let alias = args["alias"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias is required", details: nil))
                return
            }
            hasKey(alias: alias, result: result)

        case "getPublicKey":
            guard let alias = args["alias"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias is required", details: nil))
                return
            }
            getPublicKey(alias: alias, result: result)

        case "getSimInfo":
            getSimInfo(result: result)

        case "generateWrappingKey":
            guard let alias = args["alias"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias is required", details: nil))
                return
            }
            generateWrappingKey(alias: alias, result: result)

        case "hasWrappingKey":
            guard let alias = args["alias"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias is required", details: nil))
                return
            }
            hasWrappingKey(alias: alias, result: result)

        case "wrapData":
            guard let alias = args["alias"] as? String,
                  let data = args["data"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias and data are required", details: nil))
                return
            }
            wrapData(alias: alias, data: data, result: result)

        case "unwrapData":
            guard let alias = args["alias"] as? String,
                  let ciphertext = args["ciphertext"] as? String,
                  let iv = args["iv"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "alias, ciphertext, and iv are required", details: nil))
                return
            }
            unwrapData(alias: alias, ciphertext: ciphertext, iv: iv, result: result)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Key Generation

    private func generateKeyPair(alias: String, result: @escaping FlutterResult) {
        // Delete existing key first
        deleteKeyFromKeychain(alias: alias)

        let tag = alias.data(using: .utf8)!
        var useSecureEnclave = false

        // Try Secure Enclave first (physical devices with SE)
        if isSecureEnclaveAvailable() {
            let accessControl = SecAccessControlCreateWithFlags(
                kCFAllocatorDefault,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                .privateKeyUsage,
                nil
            )

            var attributes: [String: Any] = [
                kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
                kSecAttrKeySizeInBits as String: 256,
                kSecAttrTokenID as String: kSecAttrTokenIDSecureEnclave,
                kSecPrivateKeyAttrs as String: [
                    kSecAttrIsPermanent as String: true,
                    kSecAttrApplicationTag as String: tag,
                    kSecAttrAccessControl as String: accessControl as Any,
                ] as [String: Any]
            ]

            var error: Unmanaged<CFError>?
            if let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) {
                guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
                    result(FlutterError(code: "KEYSTORE_ERROR", message: "Failed to get public key", details: nil))
                    return
                }

                let publicKeyPem = publicKeyToPem(publicKey)
                result([
                    "publicKey": publicKeyPem,
                    "hardwareBacked": true,
                    "strongBox": true
                ] as [String: Any])
                return
            }
            // Secure Enclave failed, fall through to Keychain
        }

        // Fallback: standard Keychain (simulators, older devices)
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrKeySizeInBits as String: 256,
            kSecPrivateKeyAttrs as String: [
                kSecAttrIsPermanent as String: true,
                kSecAttrApplicationTag as String: tag,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            ] as [String: Any]
        ]

        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            let errMsg = error?.takeRetainedValue().localizedDescription ?? "Unknown error"
            result(FlutterError(code: "KEYSTORE_ERROR", message: "Failed to generate keypair: \(errMsg)", details: nil))
            return
        }

        guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
            result(FlutterError(code: "KEYSTORE_ERROR", message: "Failed to get public key", details: nil))
            return
        }

        let publicKeyPem = publicKeyToPem(publicKey)
        result([
            "publicKey": publicKeyPem,
            "hardwareBacked": false,
            "strongBox": false
        ] as [String: Any])
    }

    // MARK: - Signing

    private func sign(alias: String, data: String, result: @escaping FlutterResult) {
        guard let privateKey = getPrivateKey(alias: alias) else {
            result(FlutterError(code: "KEY_NOT_FOUND", message: "No key found with alias: \(alias)", details: nil))
            return
        }

        guard let dataBytes = Data(base64Encoded: data) else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "data must be valid base64", details: nil))
            return
        }

        var error: Unmanaged<CFError>?
        guard let signature = SecKeyCreateSignature(
            privateKey,
            .ecdsaSignatureMessageX962SHA256,
            dataBytes as CFData,
            &error
        ) else {
            let errMsg = error?.takeRetainedValue().localizedDescription ?? "Unknown error"
            result(FlutterError(code: "SIGN_ERROR", message: "Failed to sign: \(errMsg)", details: nil))
            return
        }

        let signedBase64 = (signature as Data).base64EncodedString()
        result(signedBase64)
    }

    // MARK: - Key Management

    private func deleteKey(alias: String, result: @escaping FlutterResult) {
        deleteKeyFromKeychain(alias: alias)
        result(true)
    }

    private func hasKey(alias: String, result: @escaping FlutterResult) {
        let exists = getPrivateKey(alias: alias) != nil
        result(exists)
    }

    private func getPublicKey(alias: String, result: @escaping FlutterResult) {
        guard let privateKey = getPrivateKey(alias: alias) else {
            result(FlutterError(code: "KEY_NOT_FOUND", message: "No key found with alias: \(alias)", details: nil))
            return
        }

        guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
            result(FlutterError(code: "KEYSTORE_ERROR", message: "Failed to get public key", details: nil))
            return
        }

        let publicKeyPem = publicKeyToPem(publicKey)
        result(publicKeyPem)
    }

    // MARK: - SIM Info

    private func getSimInfo(result: @escaping FlutterResult) {
        let networkInfo = CTTelephonyNetworkInfo()

        if let carrier = networkInfo.serviceSubscriberCellularProviders?.values.first {
            result([
                "available": true,
                "operatorName": carrier.carrierName ?? "",
                "simCountryIso": carrier.isoCountryCode ?? "",
                "networkCountryIso": carrier.isoCountryCode ?? ""
            ] as [String: Any])
        } else {
            result([
                "available": false,
                "operatorName": "",
                "simCountryIso": "",
                "networkCountryIso": ""
            ] as [String: Any])
        }
    }

    // MARK: - AES-256-GCM Wrapping Key Operations (for E2EE payload recovery)

    /// Generate a random AES-256 key and store it in the iOS Keychain.
    ///
    /// Uses `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly` which
    /// **survives app reinstall** on iOS (unlike Android SharedPreferences).
    ///
    /// IMPORTANT: Never overwrites an existing key.
    private func generateWrappingKey(alias: String, result: @escaping FlutterResult) {
        // Check if key already exists — NEVER overwrite
        if loadWrappingKeyBytes(alias: alias) != nil {
            result(FlutterError(code: "KEY_EXISTS", message: "Wrapping key already exists: \(alias)", details: nil))
            return
        }

        // Generate random 256-bit key
        let key = SymmetricKey(size: .bits256)
        let keyData = key.withUnsafeBytes { Data($0) }

        // Store in Keychain with accessibility that survives reinstall
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.imalichat.wrapping",
            kSecAttrAccount as String: alias,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
            kSecValueData as String: keyData,
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            result(true)
        } else {
            result(FlutterError(code: "KEYSTORE_ERROR", message: "Failed to store wrapping key: OSStatus \(status)", details: nil))
        }
    }

    /// Check if a wrapping key exists in the Keychain.
    private func hasWrappingKey(alias: String, result: @escaping FlutterResult) {
        result(loadWrappingKeyBytes(alias: alias) != nil)
    }

    /// Wrap (encrypt) data using the Keychain AES-256-GCM key.
    ///
    /// Returns `{ciphertext: base64, iv: base64}` where ciphertext includes the GCM tag.
    private func wrapData(alias: String, data: String, result: @escaping FlutterResult) {
        guard let keyData = loadWrappingKeyBytes(alias: alias) else {
            result(FlutterError(code: "KEY_NOT_FOUND", message: "Wrapping key not found: \(alias)", details: nil))
            return
        }
        guard let plaintext = Data(base64Encoded: data) else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "data must be valid base64", details: nil))
            return
        }

        let key = SymmetricKey(data: keyData)
        do {
            let sealedBox = try AES.GCM.seal(plaintext, using: key)
            let nonce = Data(sealedBox.nonce)
            // ciphertext + tag (combined = nonce + ciphertext + tag, so skip nonce)
            let ctAndTag = sealedBox.combined!.dropFirst(12)
            result([
                "ciphertext": Data(ctAndTag).base64EncodedString(),
                "iv": nonce.base64EncodedString(),
            ] as [String: Any])
        } catch {
            result(FlutterError(code: "WRAP_ERROR", message: "Failed to wrap data: \(error)", details: nil))
        }
    }

    /// Unwrap (decrypt) data using the Keychain AES-256-GCM key.
    ///
    /// Returns the decrypted plaintext as a base64-encoded string.
    private func unwrapData(alias: String, ciphertext: String, iv: String, result: @escaping FlutterResult) {
        guard let keyData = loadWrappingKeyBytes(alias: alias) else {
            result(FlutterError(code: "KEY_NOT_FOUND", message: "Wrapping key not found: \(alias)", details: nil))
            return
        }
        guard let ctData = Data(base64Encoded: ciphertext),
              let ivData = Data(base64Encoded: iv) else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "ciphertext and iv must be valid base64", details: nil))
            return
        }

        let key = SymmetricKey(data: keyData)
        do {
            let nonce = try AES.GCM.Nonce(data: ivData)
            // Reconstruct SealedBox: nonce + ciphertext + tag
            let combined = ivData + ctData
            let sealedBox = try AES.GCM.SealedBox(combined: combined)
            let plaintext = try AES.GCM.open(sealedBox, using: key)
            result(plaintext.base64EncodedString())
        } catch {
            result(FlutterError(code: "UNWRAP_ERROR", message: "Failed to unwrap data: \(error)", details: nil))
        }
    }

    /// Load the raw AES key bytes from the Keychain.
    private func loadWrappingKeyBytes(alias: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.imalichat.wrapping",
            kSecAttrAccount as String: alias,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return data
    }

    // MARK: - Helpers

    private func isSecureEnclaveAvailable() -> Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        // Secure Enclave available on A7+ (iPhone 5s and later)
        return true
        #endif
    }

    private func getPrivateKey(alias: String) -> SecKey? {
        let tag = alias.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            kSecReturnRef as String: true,
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return nil
        }

        return (item as! SecKey)
    }

    private func deleteKeyFromKeychain(alias: String) {
        let tag = alias.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
        ]
        SecItemDelete(query as CFDictionary)
    }

    private func publicKeyToPem(_ publicKey: SecKey) -> String {
        guard let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, nil) as Data? else {
            return ""
        }

        // Add ASN.1 header for EC public key (P-256)
        let ecHeader: [UInt8] = [
            0x30, 0x59, 0x30, 0x13, 0x06, 0x07, 0x2A, 0x86,
            0x48, 0xCE, 0x3D, 0x02, 0x01, 0x06, 0x08, 0x2A,
            0x86, 0x48, 0xCE, 0x3D, 0x03, 0x01, 0x07, 0x03,
            0x42, 0x00
        ]

        var fullKeyData = Data(ecHeader)
        fullKeyData.append(publicKeyData)

        let base64 = fullKeyData.base64EncodedString()
        return "-----BEGIN PUBLIC KEY-----\n\(base64)\n-----END PUBLIC KEY-----"
    }
}
