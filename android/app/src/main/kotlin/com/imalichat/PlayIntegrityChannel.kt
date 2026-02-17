package com.imalichat

import com.google.android.play.core.integrity.IntegrityManagerFactory
import com.google.android.play.core.integrity.IntegrityTokenRequest
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import android.content.Context

/**
 * Platform channel for Google Play Integrity API.
 *
 * Requests an integrity token from the Play Integrity API using a nonce,
 * and returns the raw token string to Flutter for server-side verification.
 */
class PlayIntegrityChannel(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        private const val CHANNEL_NAME = "com.imali.chat/play_integrity"
    }

    private var channel: MethodChannel? = null
    private val scope = CoroutineScope(Dispatchers.Main)

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
            "requestIntegrityToken" -> {
                val nonce = call.argument<String>("nonce")
                if (nonce == null) {
                    result.error("INVALID_ARGUMENT", "nonce is required", null)
                    return
                }
                val cloudProjectNumber = call.argument<Long>("cloudProjectNumber")
                requestIntegrityToken(nonce, cloudProjectNumber, result)
            }
            else -> result.notImplemented()
        }
    }

    /**
     * Request an integrity token from the Play Integrity API.
     *
     * @param nonce A base64-encoded nonce for request binding
     * @param cloudProjectNumber Optional GCP project number for classic API requests
     * @param result The Flutter method channel result callback
     */
    private fun requestIntegrityToken(
        nonce: String,
        cloudProjectNumber: Long?,
        result: MethodChannel.Result
    ) {
        scope.launch {
            try {
                val integrityManager = IntegrityManagerFactory.create(context)

                val requestBuilder = IntegrityTokenRequest.builder()
                    .setNonce(nonce)

                if (cloudProjectNumber != null) {
                    requestBuilder.setCloudProjectNumber(cloudProjectNumber)
                }

                val tokenResponse = integrityManager.requestIntegrityToken(requestBuilder.build())

                tokenResponse.addOnSuccessListener { response ->
                    result.success(response.token())
                }

                tokenResponse.addOnFailureListener { exception ->
                    result.error(
                        "INTEGRITY_ERROR",
                        "Failed to get integrity token: ${exception.message}",
                        exception.stackTraceToString()
                    )
                }
            } catch (e: Exception) {
                result.error(
                    "INTEGRITY_ERROR",
                    "Play Integrity request failed: ${e.message}",
                    e.stackTraceToString()
                )
            }
        }
    }
}
