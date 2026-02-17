package com.imalichat

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private lateinit var keystoreChannel: KeystoreChannel
    private lateinit var playIntegrityChannel: PlayIntegrityChannel
    private val SCREENSHOT_CHANNEL = "com.imalichat/screenshot"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO: Re-enable screenshot prevention before production release
        // Prevent screenshots and screen recording in release builds only
        // val isDebug = (applicationInfo.flags and android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0
        // if (!isDebug) {
        //     window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        // }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        keystoreChannel = KeystoreChannel(applicationContext)
        keystoreChannel.register(flutterEngine)
        playIntegrityChannel = PlayIntegrityChannel(applicationContext)
        playIntegrityChannel.register(flutterEngine)

        // Screenshot prevention method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SCREENSHOT_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "enableSecure" -> {
                        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(null)
                    }
                    "disableSecure" -> {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        keystoreChannel.unregister()
        playIntegrityChannel.unregister()
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
