

mkdir -p Plugins/Android/libs/arm64-v8a
cd lua53/src
# Android/ARM, armeabi-v8a (ARMv7 VFP), Android 4.0+ (ICS)
NDK=D:/android/android-ndk-r16b
NDKABI=21
NDKTRIPLE=aarch64-linux-android
NDKVER=$NDK/toolchains/$NDKTRIPLE-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/$NDKTRIPLE-
NDKF="-isystem $NDK/sysroot/usr/include/$NDKTRIPLE -D__ANDROID_API__=$NDKABI -D_FILE_OFFSET_BITS=64"
NDK_SYSROOT_BUILD=$NDK/sysroot
NDK_SYSROOT_LINK=$NDK/platforms/android-$NDKABI/arch-arm64
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1 -DLUAJIT_ENABLE_GC64=1"

$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
$NDK/ndk-build.cmd APP_ABI="arm64-v8a" APP_PLATFORM=android-$NDKABI
cp obj/local/arm64-v8a/liblua.a ../../android/jni/
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI    


cd ../../android
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
$NDK/ndk-build.cmd APP_ABI="arm64-v8a" APP_PLATFORM=android-$NDKABI
cp libs/arm64-v8a/libtolua.so ../Plugins/Android/libs/arm64-v8a
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI