#!/usr/bin/python
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

"""Manages all pods under a directory.
"""

from __future__ import print_function

import argparse
import re
import os
import shutil
import subprocess
import sys


COMMANDS = ['install', 'clean', 'update', 'list']
BLACKLIST_DIRS = ['external', 'third_party']

def path_matches_blacklist(path, blacklist_dirs):
  """Returns whether a path has any directory that matches a list of directories."""
  blacklist = set(blacklist_dirs)
  path_components = set(path.split(os.sep))
  return blacklist.intersection(path_components)


def find_podfile_dirs(directory, blacklist_dirs):
  """Return a list of directories that contain Podfile files.

  Paths have a directory matching anything in blacklist_dirs are excluded.

  Args:
    directory: Path to the directory to recursively search.
    blacklist_dirs: Directory names that cannot appear in the paths of podfiles.

  Returns:
    A list of file paths.
  """
  paths = []
  for dirpath, unused_dirnames, filenames in os.walk(directory):
    matches = path_matches_blacklist(dirpath, blacklist_dirs)
    if 'Podfile' in filenames and not matches:
      paths.append(dirpath)

  return paths


def update_podfile_dir(directory):
  """Run `pod update` in a directory.

  Args:
    directory: The directory to use.
  """
  cmd = ['pod', 'update', '--project-directory=%s' % directory]
  subprocess.check_call(cmd)


def update_all_podfile_dirs(directory, blacklist_dirs):
  """Run `pod update` in all directories containing a Podfile.

  Args:
    directory: The directory to use.
    blacklist_dirs: Directory names that cannot appear in the paths of podfiles.
  """
  dirs = find_podfile_dirs(directory, blacklist_dirs)
  for d in dirs:
    update_podfile_dir(d)


def install_podfile_dir(directory, fast_install):
  """Run `pod install` in a directory.

  Args:
    directory: The directory to use.
    fast_install: If True, then skip updating the podspec repo.
  """
  cmd = ['pod', 'install', '--project-directory=%s' % directory]
  if fast_install:
    cmd.append("--no-repo-update")
  subprocess.check_call(cmd)


def install_all_podfile_dirs(directory, fast_install, blacklist_dirs):
  """Run `pod install` in all directories containing a Podfile.

  Args:
    directory: The directory to use.
    fast_install: If True, then skip updating the podspec repo.
    blacklist_dirs: Directory names that cannot appear in the paths of podfiles.
  """
  dirs = find_podfile_dirs(directory, blacklist_dirs)
  for d in dirs:
    install_podfile_dir(d, fast_install)


def list_all_podfile_dirs(directory, blacklist_dirs):
  """Print all directories containing a Podfile.

  Args:
    directory: The directory to use.
    blacklist_dirs: Directory names that cannot appear in the paths of podfiles.
  """
  dirs = find_podfile_dirs(directory, blacklist_dirs)
  for d in dirs:
    print(d)


def clean_all_pods_dirs(directory, blacklist_dirs):
  """Remove all Pods directories.

  Args:
    directory: The directory to search.
    blacklist_dirs: Directory names that cannot appear in the paths of podfiles.
  """
  paths = []
  for dirpath, unused_dirnames, filenames in os.walk(directory):
    matches = path_matches_blacklist(dirpath, blacklist_dirs)
    if os.path.split(dirpath)[-1] == 'Pods' and not matches:
      paths.append(dirpath)

  for p in paths:
    shutil.rmtree(p, ignore_errors=True)


def create_argument_parser(commands):
  """Create an ArgumentParser for this script.

  Args:
    commands: The list of possible commands the user can specify.

  Returns:
    An ArgumentParser object.
  """
  epilog="""
possible commands are:
  install: Run `pod install` in every directory with a Podfile.
  update: Run `pod update` in every directory with a Podfile.
  clean: Recursively remove all Pods directories.
  list: Print a list of directories with Podfiles.
  """
  parser = argparse.ArgumentParser(description=('Runs `pod` commands in all '
                                                'directories containing a '
                                                'Podfile file.'),
                                   epilog=epilog,
                                   formatter_class=argparse.RawTextHelpFormatter)

  parser.add_argument('command', help='the command to run.',
                      choices=COMMANDS)

  parser.add_argument('--verbose', '-v', dest='verbose', action='store_true',
                      help='print more information about actions being taken.',
                      default=False)

  parser.add_argument('--dir', dest='directory',
                      help='do all work in this directory.',
                      default='.')

  parser.add_argument('--fast_pod_install', action='store_true',
                      help=('skip updating the pod repos when running `pod '
                            'install`.'),
                      default=False)
  return parser


def print_nothing(unused_message):
  """Prints nothing.

  Args:
    unused_message: A message to not print.
  """
  pass


def main():
  parser = create_argument_parser(COMMANDS)
  args = parser.parse_args()

  # Set up print functions for messages to the user.
  if args.verbose:
    verbose_printer = lambda x: print(x, file=sys.stdout)
  else:
    verbose_printer = print_nothing

  stderr_printer = lambda x: print(x, file=sys.stderr)

  # TODO: Avoid this duplication of the COMMANDS strings.
  if args.command == 'install':
    install_all_podfile_dirs(args.directory, args.fast_pod_install, BLACKLIST_DIRS)
  elif args.command == 'update':
    update_all_podfile_dirs(args.directory, BLACKLIST_DIRS)
  elif args.command == 'list':
    list_all_podfile_dirs(args.directory, BLACKLIST_DIRS)
  elif args.command == 'clean':
    clean_all_pods_dirs(args.directory, BLACKLIST_DIRS)
  else:
    print('Internal mismatch in the list of possible commands, aborting.',
          file=sys.stderr)
    sys.exit(-1)


if __name__ == '__main__':
  main()
