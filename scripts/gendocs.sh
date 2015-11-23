#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $(dirname $DIR) >> /dev/null

mkdir -p docs
echo -n "[" > docs/index.json

first=true

# Enumerate all documentable folders
for d in */.jazzy.yaml; do
  if [ "$first" = false ]; then
    echo -n "," >> docs/index.json
  fi

  folder=$(dirname $d)

  echo "Generating docs for $folder..."

  pushd $folder >> /dev/null
  jazzy --output ../docs/$folder >> /dev/null 2> /dev/null
  popd >> /dev/null

  echo -n "\"$folder\"" >> docs/index.json

  first=false
done

echo -n "]" >> docs/index.json

popd >> /dev/null
