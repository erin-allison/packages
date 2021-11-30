#!/bin/bash

set -e

dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

mkdir -p pkg/

podman build . --no-cache --iidfile image-id
podman run -it --rm -v $(pwd)/pkg/:/home/build/ea-private/ $(cat image-id) bash /home/build/packages/in-container.sh

ln -sf ea-private.db.tar.xz pkg/ea-private.db
ln -sf ea-private.files.tar.xz pkg/ea-private.files

./sign.sh
