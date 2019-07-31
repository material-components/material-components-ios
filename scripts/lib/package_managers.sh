#!/bin/bash
#
# Copyright 2019-present The Material Components for iOS Authors. All Rights Reserved.
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

gem_update() {
  gem update --system --no-document --quiet
}

gem_install() {
  gem_update
  gem install "$@" --no-document --quiet
}

brew_update() {
  brew_current=$(brew config | grep -E 'Core tap HEAD: [0-9a-f]+' | grep -oE '[0-9a-f]+$')
  echo "Current Homebrew HEAD is ($brew_current)"
  echo "Last Brew update HEAD is ($BREW_VERSION)"
  if [ -z "$BREW_VERSION" -o "$brew_current" != $"BREW_VERSION" ]; then 
    brew --version
    echo "Updating Homebrew"
    brew update
    BREW_VERSION=$(brew config | grep -E 'Core tap HEAD: [0-9a-f]+' | grep -oE '[0-9a-f]+$')
    echo "Homebrew HEAD is now ($BREW_VERSION)"
    brew --version
  fi
}

brew_install() {
  echo "Installing \"$@\" using Homebrew"
  brew_update
  brew install "$@"
}

