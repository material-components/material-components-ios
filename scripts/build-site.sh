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

# Checking pre-requsits for folders
# Getting the link for github repository
GITHUB_REMOTE=`git remote -v | grep "fetch" | sed -e 's/origin.//' | sed -e 's/.(fetch)//' | grep -v "\t"`
SITE_SOURCE_BRANCH="site-source"
SITE_SOURCE_FOLDER=$SITE_SOURCE_BRANCH
SITE_BUILD="gh-pages"

# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/.."
ROOT_DIR="$(pwd)"

# # If site-source doesn't exist, clone the repository into site-source folder
if [[ -d ./$SITE_SOURCE_FOLDER ]]; then
	cd $SITE_SOURCE_FOLDER
	git checkout $SITE_SOURCE_BRANCH
	git pull
	cd ..
else
	git clone $GITHUB_REMOTE $SITE_SOURCE_FOLDER || { echo "Failed to clone."; exit 1; }
	cd $SITE_SOURCE_FOLDER
	git checkout -b $SITE_SOURCE_BRANCH origin/$SITE_SOURCE_BRANCH
	cd ..
fi

# Build site
$ROOT_DIR/$SITE_SOURCE_FOLDER/build.sh

