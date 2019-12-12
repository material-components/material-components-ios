#!/bin/bash
#
# Copyright 2018-present The Material Components for iOS Authors. All Rights Reserved.
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

version_as_number() {
  padded_version="${1%.}" # Strip any trailing dots
  # Pad with .0 until we get a M.m.p version string.
  while [ $(grep -o "\." <<< "$padded_version" | wc -l) -lt "2" ]; do
    padded_version=${padded_version}.0
  done
  echo "${padded_version//.}"
}

# xcode-select's the provided xcode version.
# Usage example:
#     select_xcode 9.2.0
select_xcode() {
  desired_version="$1"
  if [ -z "$desired_version" ]; then
    return # No Xcode version to select.
  fi

  xcodes=$(ls /Applications/ | grep "Xcode")
  for xcode_path in $xcodes; do
    xcode_version=$(cat /Applications/$xcode_path/Contents/version.plist \
      | grep "CFBundleShortVersionString" -A1 \
      | grep string \
      | cut -d'>' -f2 \
      | cut -d'<' -f1)
    xcode_version_as_number="$(version_as_number $xcode_version)"

    if [ "$xcode_version_as_number" -ne "$(version_as_number $desired_version)" ]; then
      continue
    fi

    sudo xcode-select --switch /Applications/$xcode_path/Contents/Developer
    xcodebuild -version

    # Resolves the following crash when switching Xcode versions:
    # "Failed to locate a valid instance of CoreSimulatorService in the bootstrap"
    launchctl remove com.apple.CoreSimulator.CoreSimulatorService || true

    break
  done
}

