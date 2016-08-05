#!/bin/bash
#
# Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

# Install Phabricator's Arcanist tool (`arc`) for managing code reviews.
#
# https://secure.phabricator.com/book/phabricator/article/arcanist/
#
# This is not required for anyone but core team members to conduct reviews.

usage() {
  echo "Usage:"
  echo "$0 [arc_install_path [shell_startup_path]]"
  echo
  echo "If arc is not already installed, install it to arc_install_path/arcanist. In addition, "
  echo "arc_install_path/libphutil, a requirement of arcanist, will be installed."
  echo
  echo "If shell_startup_path is specified, add a shell command at the end of shell_startup_path "
  echo "that adds arc to your PATH variable. Specifying shell_startup_path is optional, in which "
  echo "case you are responsible for adding the arc command to your setup."
  echo
  echo "Example usage: $0 ~/Source/Git ~/.bash_profile"
}

# Figure out if arc is already installed.
ARC_PATH=$(which arc)
if [ $? -eq 0 ]; then
  echo "Upgrading arc..."
  ${ARC_PATH} upgrade
else
  # Arc is not installed and we don't have a path to install it to.
  echo "Arc is not installed."
  if [ "$#" -lt 1 ]; then
    echo "To install arc, please specify arc_install_path and, optionally, shell_startup_path."
    echo 
    usage
    exit -1
  fi

  # Install arc as requested.
  ARC_INSTALL_PATH="$1"
  git -C "${ARC_INSTALL_PATH}" clone https://github.com/phacility/libphutil.git && \
  git -C "${ARC_INSTALL_PATH}" clone https://github.com/phacility/arcanist.git
  if [ $? -ne 0 ]; then
    echo "Failed to install arc, please follow the directions manually at "
    echo "https://secure.phabricator.com/book/phabricator/article/arcanist/"
    exit -1
  fi

  ARC_BINARY_PATH="${ARC_INSTALL_PATH}/arcanist/bin"
  ARC_PATH="${ARC_BINARY_PATH}/arc"

  # Add arc to the user's startup paths if requested.
  if [ "$#" -gt 1 ]; then
    SHELL_STARTUP_PATH="$2"

    # Check if it already exists.
    if grep --quiet "PATH=${ARC_BINARY_PATH}" "${SHELL_STARTUP_PATH}"; then
      echo "Looks like arc is already specified in a path in ${SHELL_STARTUP_PATH}."
    else
      echo "Adding arc to your path in ${SHELL_STARTUP_PATH}."
      PATH_COMMAND="export PATH=\"\$PATH:${ARC_BINARY_PATH}\""
      echo >> "${SHELL_STARTUP_PATH}" 
      echo "# Arcanist" >> "${SHELL_STARTUP_PATH}" 
      echo "export PATH=\"\$PATH:${ARC_BINARY_PATH}\"" >> "${SHELL_STARTUP_PATH}" 
      echo
      echo "NOTE: To get arc in your path for *this* sesssion, re-source ${SHELL_STARTUP_PATH} or "
      echo "      otherwise re-initialize your shell's path."
    fi
  else
    echo "Please add \"${ARC_INSTALL_PATH}/arcanist/bin\" to your shell's path and re-run this "
    echo "script."
    exit -1
  fi
fi

# Finally, initialize Arcanist's extensions stored as submodules.
git submodule init
git submodule update

echo 
echo "Testing arc..."
"${ARC_PATH}" version

if [ $? -ne 0 ]; then
  echo "Failed to execute ${ARC_INSTALL_PATH}/arcanist/bin/arc, aborting."
  exit -1
fi
echo "Done!"

