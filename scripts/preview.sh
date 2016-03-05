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

# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

# # If gh-pages doesn't exist, clone the repository into gh-pages folder
# if [ !-d ./gp-pages ]; then
# 	# Getting the link for github repository
# 	GITHUB_REMOTE=`git remote -v | grep "fetch" | sed -e 's/origin.//' | sed -e 's/.(fetch)//'`
# 	git clone $GITHUB_REMOTE gp-pages
# fi

# # Switch to gh-pages folder and pull latest update
# cd gp-pages
# git checkout gh-pages
# git pull
# cd - > /dev/null

# Sweap over components folder, grab each README.md file and copy them into ./gh-pages/_posts as folder name
for component in $(ls ./components); do
	cd components/$component
	if [ -f ./README.md ]; then
		cp README.md ../../gh-pages/_posts/2016-03-01-$component.md
	fi
	cd - > /dev/null
done ;

# # run ```jekyll serve``` inside that folder and prompt user to view the local version at localhost:4000
cd gh-pages && jekyll serve