#!/bin/bash

set -e

key="4236391669901CBB4E8687C3635F855566C675DB"
dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

pushd pkg

ln -sf ea-private.db.tar.xz.sig ea-private.db.sig
ln -sf ea-private.files.tar.xz.sig ea-private.files.sig

find . -name '*.zst' -exec repo-add --sign --key $key ea-private.db.tar.xz {} +

rm *.old

popd
