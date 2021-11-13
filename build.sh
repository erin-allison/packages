#!/bin/bash

set -e

key="4236391669901CBB4E8687C3635F855566C675DB"

dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
export PKGDEST="${dir}/./pkg"

rm -fr "$PKGDEST"
mkdir "$PKGDEST"

for dir in `find . -mindepth 1 -maxdepth 1 -type d | grep -v "./.git" | grep -v "./pkg"`
do
	pushd "$dir"
	makepkg -cC --sign --key "$key"
	popd
done

pushd "$PKGDEST"

for pkg in `find -name '*.zst'`
do
	repo-add "ea-github.db.tar.gz" "$pkg" --sign --key "$key" --verify
done



