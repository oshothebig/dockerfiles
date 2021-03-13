#!/usr/bin/env bash
set -euo pipefail

for image in $(ls -d */ | sed -e 's|/||')
do
    if [[ ! -f ${image}/Dockerfile ]]; then
        continue
    fi

    docker build -f ${image}/Dockerfile -t ${image} ${image}
done
