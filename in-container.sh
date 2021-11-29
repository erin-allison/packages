#!/bin/bash

packages=`find ./packages -mindepth 1 -maxdepth 1 -type d -not -name '.git' -and -not -name 'pkg' | cut -f3 -d'/'`

crema="crema add -r ea-private -n"

for package in $packages
do
    crema+=" -l ./packages/$package"
done

echo ":: Building local packages..."
$crema

echo -e "\n[ea-private]\nSigLevel = Optional TrustAll\nServer = file:///home/build/ea-private/\n" |\
	sudo tee --append /etc/pacman.conf > /dev/null

echo ":: Recursively building dependencies..."
while true
do
    sudo pacman -Sy
    echo ":: Calculating missing dependencies..."
    missing=$(pacman -Dkk 2>&1 |\
        egrep `echo $packages | sed 's/ /\\|/g'` |\
        cut -f2 -d"'")
        
    if [ -z "${missing}" ]
    then
        echo "No missing packages found"
        break
    fi

    count=$(echo $missing | tr " " "\n" | wc -l)
    echo " ${count} missing packages found"

    crema="crema add -r ea-private -n"

    for package in $missing
    do
        crema+=" -a $package"
    done

    echo ":: Importing ${count} packages from AUR..."
    $crema
done
