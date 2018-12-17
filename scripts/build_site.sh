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

# Validate arguments options
args=$*

# Checking prerequisites for folders
# Getting the link for github repository
GITHUB_REMOTE="https://github.com/material-components/material-components-site-generator.git"
SITE_SOURCE_BRANCH='master'
SITE_SOURCE_FOLDER='docsite-generator'

# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/.."
ROOT_DIR="$(pwd)"

# # If site-source doesn't exist, clone the repository into site-source folder
if [[ -d ./$SITE_SOURCE_FOLDER ]]; then
  echo "Update site folder..."
  pushd $SITE_SOURCE_FOLDER
  git checkout $SITE_SOURCE_BRANCH >> /dev/null 2> /dev/null
  git pull >> /dev/null 2> /dev/null
  popd
else
  echo "Set up site folder...";
  git clone $GITHUB_REMOTE $SITE_SOURCE_FOLDER || { echo "Failed to clone."; exit 1; }
  echo "Please follow the instructions in $SITE_SOURCE_FOLDER/README.md, then run build_site.sh to complete the build.";
  exit 0
fi

# If it is not for set up, build site
pushd $SITE_SOURCE_FOLDER
$ROOT_DIR/$SITE_SOURCE_FOLDER/scripts/build $args ..
popd
