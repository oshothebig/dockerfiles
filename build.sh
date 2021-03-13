#!/usr/bin/env bash
set -euo pipefail

for image in $(ls -d */ | sed -e 's|/||')
do
    docker build -f ${image}/Dockerfile -t ${image} ${image}
done
