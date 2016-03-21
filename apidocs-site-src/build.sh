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
# Make sure jazzy is installed
JAZZY_VERSION=`jazzy --version`
if [[ $? != 0 ]]; then
	echo "Cannot find jazzy.  To install try:"
	echo "[sudo] gem install jazzy"
	exit 1
fi

# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/../.."
ROOT_DIR="$(pwd)"

# Enumerate all documentable folders
for directory in "$ROOT_DIR"/components/*/README.md; do
  folder=$(dirname $directory)
  #no longer using lowercase directory
  #component="$(echo $(basename $folder) | tr '[A-Z]' '[a-z]')"
  component=$(basename $folder)

  echo "Generating api reference for $component..."

  cd "$folder"

  jazzy_output="$ROOT_DIR/site-source/jekyll-site-src/apidocs/$component"

  jazzy \
    --output "$jazzy_output" \
    --theme "$ROOT_DIR/site-source/apidocs-site-src/theme" \
    --module $component \
    --umbrella-header src/Material$component.h \
    --objc \
    --sdk iphonesimulator \
    >> /dev/null 2> /dev/null

  # copy assets
  cp -R "$ROOT_DIR/docs/assets/" "$jazzy_output/assets" >> /dev/null 2> /dev/null
  # adjust path to assets in generated files
  sed -i '' 's/docs\///g' $jazzy_output/*.html

  cd $ROOT_DIR
done


