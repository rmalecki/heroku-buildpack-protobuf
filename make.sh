#!/bin/sh

# This is a bash script that just builds the protocol buffer binary. You can use
# it by executing something like:
# anvil build https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz \
#   -b https://raw.githubusercontent.com/hfwang/heroku-buildpack-protobuf/master/make.sh

# fail fast
set -e

# capture root dir
root=$(pwd)

# change into subdir of archive
cd $root/protobuf-*

# configure and compile
./configure --prefix /app/protobuf
make
make install

# remove source files
rm -rf $root/*

# copy build artifacts back into the root
cp -R /app/protobuf $root/
