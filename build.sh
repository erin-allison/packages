#!/bin/bash

set -e

dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

mkdir -p pkg/

cmd="cd '$dir'; "
cmd+='id=`podman build -q . --no-cache`; '
cmd+='podman run -it --rm -v $(pwd)/pkg/:/home/build/ea-private/ $id bash /home/build/packages/in-container.sh; '

echo $cmd | pkexec /bin/bash

ln -sf ea-private.db.tar.xz pkg/ea-private.db
ln -sf ea-private.files.tar.xz pkg/ea-private.files

./sign.sh
