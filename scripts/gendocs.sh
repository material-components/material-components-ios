#!/bin/bash
#
# Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

JAZZY_VERSION=`jazzy --version`
if [[ $? != 0 ]]; then
	echo "Cannot find jazzy.  To install try:"
	echo "[sudo] gem install jazzy"
	exit 1
fi

REPO_NAME="material-components-ios"

ORIGINAL_WORKING_DIR=`pwd`

if [[ ! $ORIGINAL_WORKING_DIR =~ $REPO_NAME ]]; then
	echo "Cannot find repo $REPO_NAME in $ORIGINAL_WORKING_DIR"
	exit 1
fi

REPO_ROOT_DIR=`echo $ORIGINAL_WORKING_DIR | sed -n s/$REPO_NAME.*$/$REPO_NAME/p`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $REPO_ROOT_DIR >> /dev/null

mkdir -p docs

# Enumerate all documentable folders
for d in components/*/.jazzy.yaml; do
  folder=$(dirname $d)
  component=$(basename $folder)

  echo "Generating docs for $component..."

  pushd $folder >> /dev/null
  jazzy --output $REPO_ROOT_DIR/docs/$component >> /dev/null 2> /dev/null
	# copy assets
	cp -R docs/assets/ $REPO_ROOT_DIR/docs/$component/assets >> /dev/null 2> /dev/null
	# adjust path to assets in generated files
	sed -i '' 's/docs\///g' $REPO_ROOT_DIR/docs/$component/*.html
  popd >> /dev/null
done

popd >> /dev/null
