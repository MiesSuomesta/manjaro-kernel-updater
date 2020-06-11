#!/bin/sh

initgitrepos()
{
  from="$1"
  to="$2"
  MAINLINEKERNELPATH="$PWD"
		
  if [ -d $to ]; then
	(
		
		cd $to;
		cp -v ../misc/* .

		sed -i "s,MAINLINEKERNELPATH,${MAINLINEKERNELPATH},g" PKG*

		updgitsources
		exit $?
	)
        return $?
  else
	git clone $from $to
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
    echo "Updated mainline kernel sources."
    exit $err
)
err=$?

(
    echo "Updating mainline kernel sources...."
    initgitrepos https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git mainline-kernel-org
    err=$?
    echo "Updated mainline kernel sources."
    exit $err
)
err=$(($err + $?))
exit $err

