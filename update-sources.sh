#!/bin/sh

manjarorepo() {
  from="$1"
  to="$2"
  MAINLINEKERNELPATH="$PWD"
	(
		cd $to;
		cp ../patches/$to/* .
		cp -v ../misc/* .
		sed -i "s,MAINLINEKERNELPATH,${MAINLINEKERNELPATH},g" PKG*
		
		updgitsources
		exit $?
	)
        return $?
}

initgitrepos()
{
  from="$1"
  to="$2"
  MAINLINEKERNELPATH="$PWD"
		
  if [ -d $to ]; then
     manjarorepo "$1" "$2"
     return $?
  else
     git clone $from $to
     manjarorepo "$1" "$2"
     return $?
  fi
}

updgitsources() {
    git pull --autostash --rebase
    return $?
}

(
    echo "Updating manjaro linux57 kernel sources...."
    initgitrepos https://gitlab.manjaro.org/packages/core/linux57.git linux57
    err=$?
    echo "Updated linux57 kernel sources."
    exit $err
)
err=$?

(
    echo "Updating manjaro linux56 kernel sources...."
    initgitrepos https://gitlab.manjaro.org/packages/core/linux56.git linux56
    err=$?
    echo "Updated linux56 kernel sources."
    exit $err
)
err=$(($err + $?))

(
    echo "Updating mainline kernel sources...."
    initgitrepos https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git mainline
    err=$?
    echo "Updated mainline kernel sources."
    exit $err
)
err=$(($err + $?))
exit $err

