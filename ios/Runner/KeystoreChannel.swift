import Flutter
import UIKit
import Security
import CoreTelephony

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
