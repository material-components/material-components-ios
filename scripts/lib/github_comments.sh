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

# Posts a comment to the current pull request.
# Args:
#   $1: A unique identifier for this comment.
#   $2: A path to a file containing the body of the comment to post.
post_comment() {
  identifier="$1"
  comment_body_file="$2"

  if [ -z "$identifier" ]; then
    echo "Please pass an identifier as the first argument."
    exit 1
  fi

  if [ -z "$comment_body_file" ]; then
    echo "Please pass the path to a comment_body file as the second argument."
    exit 1
  fi

  if [ -z "$GITHUB_API_TOKEN" ]; then
    echo "No GITHUB_API_TOKEN provided; can't post a comment."
    exit 1
  fi

  if [ -n "$KOKORO_BUILD_NUMBER" ]; then
    # Move into our cloned repo
    pushd github/repo
  fi

  if [ ! -f scripts/external/github-comment/.git ]; then
    git submodule update --init --recursive scripts/external/github-comment
  fi

  pushd scripts/external/github-comment >> /dev/null

  swift run github-comment \
    --repo=material-components/material-components-ios \
    --github_token="$GITHUB_API_TOKEN" \
    --pull_request_number="$KOKORO_GITHUB_PULL_REQUEST_NUMBER" \
    --identifier="$identifier" \
    --comment_body="$comment_body_file"

  popd >> /dev/null

  if [ -n "$KOKORO_BUILD_NUMBER" ]; then
    popd >> /dev/null
  fi
}

# Posts a comment from the current pull request.
# Args:
#   $1: A unique identifier for this comment.
delete_comment() {
  identifier="$1"

  if [ -z "$identifier" ]; then
    echo "Please pass an identifier as the first argument."
    exit 1
  fi

  if [ -z "$GITHUB_API_TOKEN" ]; then
    echo "No GITHUB_API_TOKEN provided; can't post a comment."
    exit 1
  fi

  if [ -n "$KOKORO_BUILD_NUMBER" ]; then
    # Move into our cloned repo
    pushd github/repo
  fi

  if [ ! -f scripts/external/github-comment/.git ]; then
    git submodule update --init --recursive scripts/external/github-comment
  fi

  pushd scripts/external/github-comment >> /dev/null

  swift run github-comment \
    --repo=material-components/material-components-ios \
    --github_token="$GITHUB_API_TOKEN" \
    --pull_request_number="$KOKORO_GITHUB_PULL_REQUEST_NUMBER" \
    --identifier="$identifier" \
    --delete

  popd >> /dev/null

  if [ -n "$KOKORO_BUILD_NUMBER" ]; then
    popd >> /dev/null
  fi
}

