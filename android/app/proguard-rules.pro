## Keep BouncyCastle classes
#-keep class org.bouncycastle.jsse.** { *; }
#-keep class org.conscrypt.** { *; }
#-keep class org.openjsse.** { *; }
# Keep BouncyCastle classes
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# Keep Conscrypt classes
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**

# Keep OpenJSSE classes
-keep class org.openjsse.** { *; }
-dontwarn org.openjsse.**

# Keep OkHttp internal classes
-keep class okhttp3.internal.** { *; }
-dontwarn okhttp3.internal.**
