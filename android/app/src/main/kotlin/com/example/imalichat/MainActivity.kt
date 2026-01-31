package com.example.imalichat

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    private lateinit var keystoreChannel: KeystoreChannel
    private lateinit var playIntegrityChannel: PlayIntegrityChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        keystoreChannel = KeystoreChannel(applicationContext)
        keystoreChannel.register(flutterEngine)
        playIntegrityChannel = PlayIntegrityChannel(applicationContext)
        playIntegrityChannel.register(flutterEngine)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        keystoreChannel.unregister()
        playIntegrityChannel.unregister()
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
