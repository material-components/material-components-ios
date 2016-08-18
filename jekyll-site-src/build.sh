#!/bin/bash
#
# Copyright 2015-present Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Check the pre-requisits
# Make sure jekyll is installed
JEKYLL_VERSION=`jekyll --version`
if [[ $? != 0 ]]; then
  echo "Cannot find jekyll.  To install try:"
  echo "[sudo] gem install github-pages"
  exit 1
fi


# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/../.."
ROOT_DIR="$(pwd)"


## COPY ALL SOURCE MARKDOWN

## The home page is special.
cp "$ROOT_DIR"/site-index.md "$ROOT_DIR"/site-source/jekyll-site-src/index.md

## Copy each folder containing documentation.
FOLDERS=("components" "contributing" "howto")
TARGET="${ROOT_DIR}/site-source/jekyll-site-src"
for i in ${FOLDERS[@]}; do
  ## Include all folders (for recursion), Markdown files, and README.yaml files but nothing else.
  rsync -r --include='*/' --include='*.md' --include='README.yaml' --exclude='*' --prune-empty-dirs "${ROOT_DIR}/${i}" "${TARGET}"

  ## Rename the README.md files to index.md in preparation to become index.html.
  for j in $(find "${TARGET}/${i}" -name README.md); do

    ## Prepend all README.md files with associated README.yaml files if available then remove
    ## README.yaml files
    DIR=$(dirname "$j")
    YAML_FILE=$(find "$DIR" -maxdepth 1 -name README.yaml)
    if [ -e "$YAML_FILE" ]; then
      cat "$YAML_FILE" "$j" > "${DIR}/README.tmp"
      mv "${DIR}/README.tmp" "$j"
      rm $YAML_FILE
    fi
    NEW_NAME=$(echo ${j} | sed -e s/README/index/)
    mv "${j}" "${NEW_NAME}"
  done
done

## For the components only, copy extra docs in.
for i in $(find components/* -type d -maxdepth 0); do
  if [ -d "${i}/docs" ]; then
    rsync -r "${i}/docs" "${TARGET}/${i}"
  fi
done

# UNCOMMENT LIQUID TAGS FROM MARKDOWN
#grep -rl '<!--{.*}-->' ./ | xargs sed -i '' 's/<!--{\(.*\)}-->/{\1}/g'
GREP_LIQUID_TAGS="grep -rl --include='*\.md' '<!--[{<].*[>}]-->'"
#SED_LIQUID_TAGS="sed -i '' 's/<!--\([{<]\)\([^>]*\)\([>}]\)-->/\1\2\3/g'"
PERLSUB_LIQUID_TAGS="perl -pi -e 's/<!--([{<])(.*?)([>}])-->/\1\2\3/g'"
eval "$PERLSUB_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/index.md"
eval "$GREP_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/howto | xargs $PERLSUB_LIQUID_TAGS"
eval "$GREP_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/contributing | xargs $PERLSUB_LIQUID_TAGS"
eval "$GREP_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/components | xargs $PERLSUB_LIQUID_TAGS"


# Build/Preview
jekyll_output="$ROOT_DIR/site-source/site-build"
# Clear the exsiting folder
if [ -d $jekyll_output ]; then
  rm -r $jekyll_output/*
fi

# Determine build mode: preview/build, deploy env
preview=true
config="_config.yml"
while [ $# -gt 0 ]; do
  case $1 in
    "--no-preview")
      preview=false
      shift
    ;;
    "-e" | "--for-env")
      if [[ $2 == 'production' ]]; then
        config="_config.yml,_mdc_ios_preview_config.yml"
      fi
      shift 2
    ;;
    *)
      shift 1
    ;;
  esac
done

# Build site
cd "$ROOT_DIR"/site-source/jekyll-site-src
if $preview ; then
  jekyll serve --destination $jekyll_output --config $config
else
  jekyll build --destination $jekyll_output --config $config
fi
