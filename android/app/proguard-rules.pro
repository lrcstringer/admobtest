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
-keep class com.imalichat.app.KeystoreChannel { *; }
-keep class com.imalichat.app.PlayIntegrityChannel { *; }

# Kotlin coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# flutter_secure_storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Google Mobile Ads
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }

# FFmpeg Kit
-keep class com.arthenica.ffmpegkit.** { *; }
-keep class com.arthenica.smartexception.** { *; }

# freeRASP (Talsec)
-keep class com.aheaditec.** { *; }
-keep class com.talsec.** { *; }
-dontwarn com.aheaditec.**

# Pigeon-generated platform channels (Firebase, etc.)
# Pigeon generates native classes in dev.flutter.pigeon.* namespace
-keep class dev.flutter.pigeon.** { *; }
-keep class io.flutter.plugins.firebase.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep all GeneratedPluginRegistrant (ensures plugin registration survives R8)
-keep class com.imalichat.app.GeneratedPluginRegistrant { *; }

# Google Play Services (needed by Firebase, Ads, etc.)
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Suppress warnings
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**
