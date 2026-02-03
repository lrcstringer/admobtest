# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keepnames class com.google.firebase.** { *; }

# Google Play Core (integrity, split install, tasks)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Native channels
-keep class com.example.imalichat.KeystoreChannel { *; }
-keep class com.example.imalichat.PlayIntegrityChannel { *; }

# Kotlin coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# flutter_secure_storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Suppress warnings
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**
