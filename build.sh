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
# Switching to the root folder of mdc
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Process options
target="all"
preview=true
while [ $# -gt 0 ]; do
  case $1 in
    "-b" | "--build")
      target=$2
      shift 2
    ;;
    "--no-preview")
      preview=false
      shift
    ;;
    "-d" | "--deploy")
      destination=$2
      shift 2
    ;;
    *)
      shift 1
    ;;
  esac
done
# If deploy option is on, no preview and build all
if [[ $destination != "" ]]; then
  target="all"
  preview=false
fi

# Build api reference
case $target in
  all)
    $DIR/apidocs-site-src/build.sh
  ;;
  site)
  ;;
  components:*)
    components=$(echo $target | sed 's/^components://' | tr "," "\n")
    for component in $components
    do
      $DIR/apidocs-site-src/build.sh $component
    done
  ;;
  *)
    echo "Invalid build options. Only all,site,components:c1,c2 available. Default to all."
    exit 1
  ;;
esac

# Build site & Preview
if $preview ; then
  $DIR/jekyll-site-src/build.sh
else
  $DIR/jekyll-site-src/build.sh --no-preview  --for-env $destination
  # TODO: Deploy
  if [[ $destination != "" ]]; then
    case $destination in
      site-dev)
        echo "Deploy to internal staging site"
      ;;
      develop)
        echo "Deploy to dev staging site"
      ;;
      production)
        GSUTIL_VERSION=`gsutil --version`
        if [[ $? != 0 ]]; then
          echo "Cannot find gsutil. To install gsutil, please visit: "
          echo "https://cloud.google.com/storage/docs/gsutil_install"
          python -m webbrowser "https://cloud.google.com/storage/docs/gsutil_install"
          exit 1
        fi
        read -p "Are you sure you want to deploy to production environment?" -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          gsutil -m cp -r $DIR/site-build/* gs://mdc-ios-preview
          if [[ $? = 0 ]]; then
            echo -e "\033[32m*********************************************************************"
            echo -e "\033[32m*****                                                           *****"
            echo -e "\033[32m*****  ¸¸♬·¯·♩¸¸Successfully deploy to cloud storage♪·¯·♫¸¸     *****"
            echo -e "\033[32m*****  Visit https://material-ext.appspot.com/mdc-ios-preview   *****"
            echo -e "\033[32m*****                                                           *****"
            echo -e "\033[32m*********************************************************************"
            echo -e "\033[0m"
            python -m webbrowser "https://material-ext.appspot.com/mdc-ios-preview"
          else
            echo ""
            echo "Deploy failed. Please check your config or file an issue on github."
          fi
        fi
      ;;
      *)
        echo "Invalid build options. Only site-dev, develop, production available."
        exit 1
      ;;
    esac
  fi
fi