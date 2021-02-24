#!/bin/bash
# 64 Bit Version
mkdir -p window/x86_64
mkdir -p Plugins/x86_64

cd lua53
mingw32-make clean
mingw32-make mingw BUILDMODE=static CC="gcc -m64 -std=gnu99"
cp src/liblua.a ../window/x86_64/liblua.a
mingw32-make clean

cd ../pbc/
make clean
make BUILDMODE=static CC="gcc -m64"
cp build/libpbc.a ../window/x86_64/libpbc.a

cd ..

gcc -m64 -O2 -std=gnu99 -shared \
	tolua.c \
	int64.c \
	uint64.c \
	pb.c \
    lpeg/lpcap.c \
    lpeg/lpcode.c \
    lpeg/lpprint.c \
    lpeg/lptree.c \
    lpeg/lpvm.c \
	struct.c \
	cjson/strbuf.c \
	cjson/lua_cjson.c \
	cjson/fpconv.c \
	luasocket/auxiliar.c \
	luasocket/buffer.c \
	luasocket/except.c \
	luasocket/inet.c \
	luasocket/io.c \
	luasocket/luasocket.c \
	luasocket/mime.c \
	luasocket/options.c \
	luasocket/select.c \
	luasocket/tcp.c \
	luasocket/timeout.c \
	luasocket/udp.c \
	luasocket/wsocket.c \
	luasocket/compat.c \
	sproto/sproto.c \
	sproto/lsproto.c \
	pbc/binding/lua53/pbc-lua53.c \
	-o Plugins/x86_64/tolua.dll \
	-I./ \
	-Ilua53/src \
	-Iluasocket \
	-Isproto \
	-Ipbc \
	-Icjson \
	-Ilpeg \
	-lws2_32 \
	-Wl,--whole-archive window/x86_64/liblua.a window/x86_64/libpbc.a \
	-Wl,--no-whole-archive -static-libgcc -static-libstdc++
echo "build tolua.dll success"