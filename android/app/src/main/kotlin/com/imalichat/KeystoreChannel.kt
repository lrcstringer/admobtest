package com.imalichat

import android.os.Build
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.telephony.TelephonyManager
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.*
import java.security.spec.ECGenParameterSpec
import java.util.Base64

/**
 * Platform channel for Android Keystore operations.
 *
 * Provides ECDSA P-256 keypair generation and signing using hardware-backed
 * Android Keystore (StrongBox/TEE when available).
 */
class KeystoreChannel(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        private const val CHANNEL_NAME = "com.imali.chat/keystore"
        private const val KEYSTORE_PROVIDER = "AndroidKeyStore"
    }

    private var channel: MethodChannel? = null

    fun register(flutterEngine: FlutterEngine) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        channel?.setMethodCallHandler(this)
    }

    fun unregister() {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "generateKeyPair" -> {
                val alias = call.argument<String>("alias")
                if (alias == null) {
                    result.error("INVALID_ARGUMENT", "alias is required", null)
                    return
                }
                generateKeyPair(alias, result)
            }
            "sign" -> {
                val alias = call.argument<String>("alias")
                val data = call.argument<String>("data")
                if (alias == null || data == null) {
                    result.error("INVALID_ARGUMENT", "alias and data are required", null)
                    return
                }
                sign(alias, data, result)
            }
            "deleteKey" -> {
                val alias = call.argument<String>("alias")
                if (alias == null) {
                    result.error("INVALID_ARGUMENT", "alias is required", null)
                    return
                }
                deleteKey(alias, result)
            }
            "hasKey" -> {
                val alias = call.argument<String>("alias")
                if (alias == null) {
                    result.error("INVALID_ARGUMENT", "alias is required", null)
                    return
                }
                hasKey(alias, result)
            }
            "getPublicKey" -> {
                val alias = call.argument<String>("alias")
                if (alias == null) {
                    result.error("INVALID_ARGUMENT", "alias is required", null)
                    return
                }
                getPublicKey(alias, result)
            }
            "getSimInfo" -> {
                getSimInfo(result)
            }
            else -> result.notImplemented()
        }
    }

    /**
     * Generate an ECDSA P-256 keypair in the Android Keystore.
     * Uses hardware-backed storage (StrongBox/TEE) when available.
     * Returns the public key in PEM format.
     */
    private fun generateKeyPair(alias: String, result: MethodChannel.Result) {
        try {
            // Delete existing key if present
            val keyStore = KeyStore.getInstance(KEYSTORE_PROVIDER)
            keyStore.load(null)
            if (keyStore.containsAlias(alias)) {
                keyStore.deleteEntry(alias)
            }

            val keyPairGenerator = KeyPairGenerator.getInstance(
                KeyProperties.KEY_ALGORITHM_EC, KEYSTORE_PROVIDER
            )

            val paramBuilder = KeyGenParameterSpec.Builder(
                alias,
                KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY
            )
                .setAlgorithmParameterSpec(ECGenParameterSpec("secp256r1"))
                .setDigests(KeyProperties.DIGEST_SHA256)

            // Try StrongBox first (API 28+), fall back to TEE
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                try {
                    paramBuilder.setIsStrongBoxBacked(true)
                    keyPairGenerator.initialize(paramBuilder.build())
                    val keyPair = keyPairGenerator.generateKeyPair()
                    val publicKeyPem = publicKeyToPem(keyPair.public)
                    result.success(mapOf(
                        "publicKey" to publicKeyPem,
                        "hardwareBacked" to true,
                        "strongBox" to true
                    ))
                    return
                } catch (e: Exception) {
                    // StrongBox not available, fall back
                    val fallbackBuilder = KeyGenParameterSpec.Builder(
                        alias,
                        KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY
                    )
                        .setAlgorithmParameterSpec(ECGenParameterSpec("secp256r1"))
                        .setDigests(KeyProperties.DIGEST_SHA256)

                    keyPairGenerator.initialize(fallbackBuilder.build())
                    val keyPair = keyPairGenerator.generateKeyPair()
                    val publicKeyPem = publicKeyToPem(keyPair.public)
                    result.success(mapOf(
                        "publicKey" to publicKeyPem,
                        "hardwareBacked" to true,
                        "strongBox" to false
                    ))
                    return
                }
            }

            // Pre-API 28: standard Keystore
            keyPairGenerator.initialize(paramBuilder.build())
            val keyPair = keyPairGenerator.generateKeyPair()
            val publicKeyPem = publicKeyToPem(keyPair.public)
            result.success(mapOf(
                "publicKey" to publicKeyPem,
                "hardwareBacked" to false,
                "strongBox" to false
            ))

        } catch (e: Exception) {
            result.error("KEYSTORE_ERROR", "Failed to generate keypair: ${e.message}", null)
        }
    }

    /**
     * Sign data with the private key stored in Android Keystore.
     * Uses SHA256withECDSA signature algorithm.
     */
    private fun sign(alias: String, data: String, result: MethodChannel.Result) {
        try {
            val keyStore = KeyStore.getInstance(KEYSTORE_PROVIDER)
            keyStore.load(null)

            if (!keyStore.containsAlias(alias)) {
                result.error("KEY_NOT_FOUND", "No key found with alias: $alias", null)
                return
            }

            val privateKey = keyStore.getKey(alias, null) as PrivateKey
            val signature = Signature.getInstance("SHA256withECDSA")
            signature.initSign(privateKey)
            signature.update(Base64.getDecoder().decode(data))
            val signedBytes = signature.sign()
            val signedBase64 = Base64.getEncoder().encodeToString(signedBytes)

            result.success(signedBase64)

        } catch (e: Exception) {
            result.error("SIGN_ERROR", "Failed to sign data: ${e.message}", null)
        }
    }

    /**
     * Delete a keypair from the Android Keystore.
     */
    private fun deleteKey(alias: String, result: MethodChannel.Result) {
        try {
            val keyStore = KeyStore.getInstance(KEYSTORE_PROVIDER)
            keyStore.load(null)

            if (keyStore.containsAlias(alias)) {
                keyStore.deleteEntry(alias)
            }

            result.success(true)

        } catch (e: Exception) {
            result.error("DELETE_ERROR", "Failed to delete key: ${e.message}", null)
        }
    }

    /**
     * Check if a keypair exists in the Android Keystore.
     */
    private fun hasKey(alias: String, result: MethodChannel.Result) {
        try {
            val keyStore = KeyStore.getInstance(KEYSTORE_PROVIDER)
            keyStore.load(null)
            result.success(keyStore.containsAlias(alias))

        } catch (e: Exception) {
            result.error("KEYSTORE_ERROR", "Failed to check key: ${e.message}", null)
        }
    }

    /**
     * Get the public key for an existing keypair in PEM format.
     */
    private fun getPublicKey(alias: String, result: MethodChannel.Result) {
        try {
            val keyStore = KeyStore.getInstance(KEYSTORE_PROVIDER)
            keyStore.load(null)

            if (!keyStore.containsAlias(alias)) {
                result.error("KEY_NOT_FOUND", "No key found with alias: $alias", null)
                return
            }

            val certificate = keyStore.getCertificate(alias)
            val publicKeyPem = publicKeyToPem(certificate.publicKey)
            result.success(publicKeyPem)

        } catch (e: Exception) {
            result.error("KEYSTORE_ERROR", "Failed to get public key: ${e.message}", null)
        }
    }

    /**
     * Get SIM operator info for SIM change detection.
     * Uses operator name (no permission required).
     */
    private fun getSimInfo(result: MethodChannel.Result) {
        try {
            val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager

            if (telephonyManager == null) {
                result.success(mapOf(
                    "available" to false,
                    "operatorName" to "",
                    "simCountryIso" to "",
                    "networkCountryIso" to ""
                ))
                return
            }

            result.success(mapOf(
                "available" to true,
                "operatorName" to (telephonyManager.simOperatorName ?: ""),
                "simCountryIso" to (telephonyManager.simCountryIso ?: ""),
                "networkCountryIso" to (telephonyManager.networkCountryIso ?: "")
            ))

        } catch (e: Exception) {
            result.error("SIM_INFO_ERROR", "Failed to get SIM info: ${e.message}", null)
        }
    }

    /**
     * Convert a PublicKey to PEM format string.
     */
    private fun publicKeyToPem(publicKey: PublicKey): String {
        val encoded = Base64.getEncoder().encodeToString(publicKey.encoded)
        return "-----BEGIN PUBLIC KEY-----\n$encoded\n-----END PUBLIC KEY-----"
    }
}
