#!/bin/sh
TARGET="$1"
echo compiling $TARGET
shift

sh update-sources.sh 

(
   cd linux57
   cp -v PKGBUILD.$TARGET PKGBUILD

   updpkgsums

   time makepkg $*   

)

