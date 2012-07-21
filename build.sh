#!/bin/bash
#    Copyright (c) 2012, Salesforce.com, Inc.
#    All rights reserved.
#    
#    Redistribution and use in source and binary forms, with or without modification,
#    are permitted provided that the following conditions are met:
#    
#    Redistributions of source code must retain the above copyright notice, this list
#    of conditions and the following disclaimer. Redistributions in binary form must
#    reproduce the above copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided with the
#    distribution.
#    
#    Neither the name of the Salesforce.com nor the names of its contributors may be
#    used to endorse or promote products derived from this software without specific
#    prior written permission.
#    
#    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
#    OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

SRC_DIR=`pwd`
TAR_DIR=/tmp
BUILD_DIR=PerlKoans
BUILD_PATH=$TAR_DIR/$BUILD_DIR

VERSION_FILE=$SRC_DIR/road_to_illumination.pl
VERSION=`grep '$VERSION = ' $VERSION_FILE | awk -F ';' '{print $1}' | awk -F ' ' '{print $4}'`

if [ ! -f "$VERSION_FILE" ]; then
	echo "ERROR: unable to find version file [$VERSION_FILE]"
	exit 1
fi

if [ -z "$VERSION" ]; then
	echo -n "version: "
	read VERSION
fi

echo "using version [$VERSION].."
FILE=PerlKoans-$VERSION.tar
FILEGZ=$FILE.gz

echo "creating [$BUILD_PATH].."
mkdir $BUILD_PATH

echo "copying files into [$BUILD_PATH].."
cp -r * $BUILD_PATH

# echo "stripping TODO.."
# cd $BUILD_DIR
#`bash todo_cleanup.sh`

echo "building [$FILEGZ].."
cd $TAR_DIR
tar -cf $FILE --exclude="t" $BUILD_DIR/*
gzip $FILE
mv -v $FILEGZ $SRC_DIR

if [ -d "$BUILD_DIR" ]; then
	echo "removing [$BUILD_PATH].."
	rm -rf $BUILD_PATH
fi;

cd $SRC_DIR
