mkdir -p Plugins/Android/libs/x86

cd lua53/src

# Android/x86, x86 (i686 SSE3), Android 4.0+ (ICS)
NDK=D:/android/android-ndk-r16b
NDKABI=21
NDKVER=$NDK/toolchains/x86-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/i686-linux-android-
NDKF="-isystem $NDK/sysroot/usr/include/i686-linux-android -D__ANDROID_API__=$NDKABI -D_FILE_OFFSET_BITS=32"
NDK_SYSROOT_BUILD=$NDK/sysroot
NDK_SYSROOT_LINK=$NDK/platforms/android-$NDKABI/arch-x86

$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
$NDK/ndk-build.cmd APP_ABI="x86" APP_PLATFORM=android-$NDKABI
cp obj/local/x86/liblua.a ../../android/jni/
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI


cd ../../android
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
$NDK/ndk-build.cmd APP_ABI="x86" APP_PLATFORM=android-$NDKABI

cp libs/x86/libtolua.so ../Plugins/Android/libs/x86
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI