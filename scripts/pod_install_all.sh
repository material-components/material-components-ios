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

REPO_NAME="material-components-ios"

ORIGINAL_WORKING_DIR=`pwd`

#if [[ ! REPO_NAME =~ ORIGINAL_WORKING_DIR ]]; then
if [[ ! $ORIGINAL_WORKING_DIR =~ $REPO_NAME ]]; then
	echo "Cannot find repo $REPO_NAME in $ORIGINAL_WORKING_DIR"
	exit 1
fi

REPO_ROOT_DIR=`echo $ORIGINAL_WORKING_DIR | sed -n s/$REPO_NAME.*$/$REPO_NAME/p`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pod_install () {
  pushd $1
  echo "===================="
  echo "running pod install for $1"
  pod install
  echo ""
  popd
}

pushd $REPO_ROOT_DIR >> /dev/null

find . -name Podfile -print0 | xargs -0 -n1 dirname | sort --unique | while read directory; do
  echo $directory
  pod_install $directory
done

popd >> /dev/null
