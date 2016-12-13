set -x

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
deploy=false
update=true
while test $# -gt 0; do
  case $1 in
    "-b" | "--build")
      shift 2
    ;;
    "-d" | "--deploy")
      deploy=true
      shift 2
    ;;
    "--no-preview")
      shift 1
    ;;
    "--ignore-update")
      update=false
      shift 1
    ;;
    "--setup")
      build=false
      shift 1
    ;;
    "-h" | "--help")
      echo "Usage: build_site.sh <command>"
      echo ""
      echo "options:"
      echo "-b, --build=TARGET        Specify target to build."
      echo "                          Target values in all, site, components:c1,c2."
      echo "                          Default to all."
      echo "--ignore-update           (Optional) Build without pull site-source branch."
      echo "                          Forced to pull before deploy."
      echo "--no-preview              (Optional) Build without host when specified."
      echo "-d, --deploy=DESTINATION  (Optional) Specify destination to deploy."
      echo "                          Destination values in site-dev, develop, production."
      echo "                          Deploy will set build all and no-preview automatically."
      exit 0
    ;;
    *)
      echo "For available options: build_site.sh -h[--help]."
      exit 0
    ;;
  esac
done

# Force pull latest code before deploy
if $deploy ; then
  update=true
fi 

# Checking prerequisites for folders
# Getting the link for github repository
GITHUB_REMOTE=$(git config --get remote.origin.url)
SITE_SOURCE_BRANCH="site-source"
SITE_SOURCE_FOLDER=$SITE_SOURCE_BRANCH

# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/.."
ROOT_DIR="$(pwd)"

# # If site-source doesn't exist, clone the repository into site-source folder
if [[ -d ./$SITE_SOURCE_FOLDER ]]; then
  if $update ; then
    echo "Update site folder..."
    cd $SITE_SOURCE_FOLDER
    git checkout $SITE_SOURCE_BRANCH >> /dev/null 2> /dev/null
    git pull >> /dev/null 2> /dev/null
    cd ..
  else
    echo -e "\033[31m*********************************************************************"
    echo -e "\033[31m*****                                                           *****"
    echo -e "\033[31m*****    Caution: Build Site without pull the latest change!    *****"
    echo -e "\033[31m*****  You are at risk for deverging from the correct preview.  *****"
    echo -e "\033[31m*****                                                           *****"
    echo -e "\033[31m*********************************************************************"
    echo -e "\033[0m"
  fi
else
  echo "Set up site folder..."
  git clone $GITHUB_REMOTE $SITE_SOURCE_FOLDER || { echo "Failed to clone."; exit 1; }
  cd $SITE_SOURCE_FOLDER
  git checkout -b $SITE_SOURCE_BRANCH origin/$SITE_SOURCE_BRANCH >> /dev/null 2> /dev/null
  cd ..
fi

# If it is not for set up, build site
if $build ; then
  $ROOT_DIR/$SITE_SOURCE_FOLDER/build.sh $args
fi
