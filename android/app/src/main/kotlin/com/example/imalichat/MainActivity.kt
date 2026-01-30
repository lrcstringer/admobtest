package com.example.imalichat

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    private lateinit var keystoreChannel: KeystoreChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        keystoreChannel = KeystoreChannel(applicationContext)
        keystoreChannel.register(flutterEngine)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        keystoreChannel.unregister()
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
