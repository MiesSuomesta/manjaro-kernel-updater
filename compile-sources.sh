#!/bin/sh
TARGET="$1"
CRONRUN=0
if [ "x$TARGET" == "xcron" ]
then
   shift
   TARGET="$1"
   CRONRUN=1
fi

echo compiling $TARGET
shift

sh update-sources.sh 

(
   cd linux57
   cp -v PKGBUILD.$TARGET PKGBUILD

   updpkgsums

   if [ $CRONRUN -eq 1 ]; then
      RE=$(echo -e "\n")
      time yes "$RE" | makepkg $*   
   else
      time makepkg $*   
   fi

)

