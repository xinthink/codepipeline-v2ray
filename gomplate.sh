#!/bin/bash
docker run --rm --volume=${PWD}/templates:/in --volume=${PWD}:/out:rw \
    --env-file ${PWD}/.env hairyhenderson/gomplate --input-dir=/in/ \
    --output-map='/out/{{ .in | strings.ReplaceAll ".tmpl" "" }}' -V