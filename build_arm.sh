mkdir -p Plugins/Android/libs/armeabi-v7a

cd lua53/src
# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)


NDK=D:/android/android-ndk-r16b
NDKABI=21
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/arm-linux-androideabi-
NDKF="-isystem $NDK/sysroot/usr/include/arm-linux-androideabi -D__ANDROID_API__=$NDKABI -D_FILE_OFFSET_BITS=32"
NDK_SYSROOT_BUILD=$NDK/sysroot
NDK_SYSROOT_LINK=$NDK/platforms/android-$NDKABI/arch-arm
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"

$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
$NDK/ndk-build.cmd APP_ABI="armeabi-v7a" APP_PLATFORM=android-$NDKABI
cp obj/local/armeabi-v7a/liblua.a ../../android/jni/
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI

cd ../../android
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
$NDK/ndk-build.cmd APP_ABI="armeabi-v7a" APP_PLATFORM=android-$NDKABI
cp libs/armeabi-v7a/libtolua.so ../Plugins/Android/libs/armeabi-v7a
$NDK/ndk-build.cmd clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI