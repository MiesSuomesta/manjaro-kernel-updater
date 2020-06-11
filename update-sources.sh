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
	)
  else
	git clone $from $to
  fi

}

updgitsources() {
    git stash && git pull --rebase && git stash pop
}

(
    echo "Updating manjaro linux57 kernel sources...."
    initgitrepos https://gitlab.manjaro.org/packages/core/linux57.git linux57
    echo "Updated mainline kernel sources."
)

(
    echo "Updating mainline kernel sources...."
    initgitrepos https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git mainline-kernel-org
    echo "Updated mainline kernel sources."
)

# mangiturl="https://gitlab.manjaro.org/packages/core/linux${BRANCHVER}.git"

