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

# Make sure jekyll is installed
JEKYLL_VERSION=`jekyll --version`
if [[ $? != 0 ]]; then
	echo "Cannot find jekyll.  To install try:"
	echo "[sudo] gem install github-pages"
	exit 1
fi

GH_PAGES_BRANCH="gh-pages-prelaunch"

# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/.."
ROOT_DIR="$(pwd)"

# If gh-pages doesn't exist, clone the repository into gh-pages folder
if [ ! -d $ROOT_DIR/gh-pages ]; then
	# Getting the link for github repository
	GITHUB_REMOTE=`git remote -v | grep "origin" | grep "fetch" \
    | sed -e 's/origin.//' | sed -e 's/.(fetch)//'`
	git clone -b $GH_PAGES_BRANCH --single-branch $GITHUB_REMOTE gh-pages
fi

# Switch to gh-pages folder and pull latest update
cd $ROOT_DIR/gh-pages
git checkout $GH_PAGES_BRANCH
git pull origin $GH_PAGES_BRANCH
cd $ROOT_DIR

# Ensure that the _posts directory exists.
mkdir -p "$ROOT_DIR/gh-pages/_posts"

# Sweep the components folder, grab each README.md file and copy them into
# ./gh-pages/_posts as folder name
for component in $(ls ./components); do
	cd $ROOT_DIR/components/$component
	if [ -f ./README.md ]; then
		cp README.md $ROOT_DIR/gh-pages/_posts/2016-03-01-$component.md
	fi
	cd $ROOT_DIR
done

# Enumerate all documentable folders
for directory in "$ROOT_DIR"/components/*/README.md; do
  folder=$(dirname $directory)
  component=$(basename $folder)

  echo "Generating docs for $component..."

  cd "$folder"

  jazzy_output="$ROOT_DIR/gh-pages/apidocs/$component"

  jazzy \
    --output "$jazzy_output" \
    --theme "$ROOT_DIR/gh-pages/_jazzy/theme" \
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

# run ```jekyll serve``` inside that folder and prompt user to view the local
# version at localhost:4000
cd $ROOT_DIR/gh-pages && jekyll serve