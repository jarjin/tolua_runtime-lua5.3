#!/bin/bash
# 32 Bit Version
mkdir -p linux/x86
mkdir -p Plugins/x86

cd lua53
mingw32-make clean

make linux BUILDMODE=static CC="gcc -fPIC -m32 -O2"
cp src/liblua.a ../window/x86/liblua.a
mingw32-make clean

cd ../pbc/
make clean
make BUILDMODE=static CC="gcc -fPIC -m32 -O2"
cp build/libpbc.a ../linux/x86/libpbc.a

cd ..

gcc -m32 -O2 -std=gnu99 -shared \
	int64.c \
	uint64.c \
	tolua.c \
	pb.c \
	lpeg/lpcap.c \
	lpeg/lpcode.c \
	lpeg/lpprint.c \
	lpeg/lptree.c \
	lpeg/lpvm.c	\
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
	luasocket/usocket.c \
	luasocket/compat.c \
	sproto/sproto.c \
	sproto/lsproto.c \
	pbc/binding/lua53/pbc-lua53.c \
	-fPIC \
	-o Plugins/x86/tolua.so \
	-I./ \
	-Ilua53/src \
	-Iluasocket \
	-Isproto \
	-Ipbc \
	-Icjson \
	-Ilpeg \
	-Wl,--whole-archive linux/x86/liblua.a linux/x86/libpbc.a \
	-Wl,--no-whole-archive -static-libgcc -static-libstdc++
	
echo "build tolua.so success" 	
