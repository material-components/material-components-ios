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


# COPY ALL SOURCE MARKDOWN
# 1. Home page
cp "$ROOT_DIR"/site-index.md "$ROOT_DIR"/site-source/jekyll-site-src/index.md
# 2. Copy and rename components README.md files
[ -d "$ROOT_DIR"/site-source/jekyll-site-src/components ] ||
	mkdir "$ROOT_DIR"/site-source/jekyll-site-src/components
cp "$ROOT_DIR"/components/README.md "$ROOT_DIR"/site-source/jekyll-site-src/components/index.md
for directory in "$ROOT_DIR"/components/*/README.md; do
	folder=$(dirname $directory)
  component=$(basename $folder)
  # echo "Copy docs for $component..."
  cd "$folder"
  [ -d "$ROOT_DIR"/site-source/jekyll-site-src/components/"$component" ] ||
    mkdir "$ROOT_DIR"/site-source/jekyll-site-src/components/"$component"
  cp README.md "$ROOT_DIR"/site-source/jekyll-site-src/components/$component/index.md >> /dev/null 2> /dev/null
  [ -d docs ] && cp -r docs "$ROOT_DIR"/site-source/jekyll-site-src/components/$component
  cd $ROOT_DIR
done
# 3. Copy all community markdown files
[ -d "$ROOT_DIR"/site-source/jekyll-site-src/community ] ||
	mkdir "$ROOT_DIR"/site-source/jekyll-site-src/community
cp "$ROOT_DIR"/community/* "$ROOT_DIR"/site-source/jekyll-site-src/community >> /dev/null 2> /dev/null
mv "$ROOT_DIR"/site-source/jekyll-site-src/community/README.md "$ROOT_DIR"/site-source/jekyll-site-src/community/index.md
# 4. Copy all howto files
[ -d "$ROOT_DIR"/site-source/jekyll-site-src/howto ] ||
	mkdir "$ROOT_DIR"/site-source/jekyll-site-src/howto
cp "$ROOT_DIR"/howto/* "$ROOT_DIR"/site-source/jekyll-site-src/howto >> /dev/null 2> /dev/null
mv "$ROOT_DIR"/site-source/jekyll-site-src/howto/README.md "$ROOT_DIR"/site-source/jekyll-site-src/howto/index.md


# UNCOMMENT LIQUID TAGS FROM MARKDOWN
#grep -rl '<!--{.*}-->' ./ | xargs sed -i '' 's/<!--{\(.*\)}-->/{\1}/g'
GREP_LIQUID_TAGS="grep -rl --include='*\.md' '<!--[{<].*[>}]-->'"
#SED_LIQUID_TAGS="sed -i '' 's/<!--\([{<]\)\([^>]*\)\([>}]\)-->/\1\2\3/g'"
PERLSUB_LIQUID_TAGS="perl -pi -e 's/<!--([{<])(.*?)([>}])-->/\1\2\3/g'"
eval "$PERLSUB_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/index.md"
eval "$GREP_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/howto | xargs $PERLSUB_LIQUID_TAGS"
eval "$GREP_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/community | xargs $PERLSUB_LIQUID_TAGS"
eval "$GREP_LIQUID_TAGS $ROOT_DIR/site-source/jekyll-site-src/components | xargs $PERLSUB_LIQUID_TAGS"


# Build/Preview
jekyll_output="$ROOT_DIR/site-source/site-build"
# Clear the exsiting folder
if [ -d $jekyll_output ]; then
  rm -r $jekyll_output/*
fi

# Determine build mode: preview/build
if [[ $1 == '--no-preview' ]]; then
	preview=false
else
	preview=true
fi
# Build site
cd "$ROOT_DIR"/site-source/jekyll-site-src
if $preview ; then
	jekyll serve --destination $jekyll_output
else
	jekyll build --destination $jekyll_output
fi