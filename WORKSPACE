# Copyright 2017-present The Material Components for iOS Authors. All Rights Reserved.
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

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

git_repository(
    name = "build_bazel_rules_apple",
    remote = "https://github.com/bazelbuild/rules_apple.git",
    tag = "0.9.0",
)

load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

git_repository(
    name = "build_bazel_rules_swift",
    remote = "https://github.com/bazelbuild/rules_swift.git",
    tag = "0.4.0",
)

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.6.0",
)

git_repository(
    name = "bazel_ios_warnings",
    remote = "https://github.com/material-foundation/bazel_ios_warnings.git",
    tag = "v3.0.0",
)

http_file(
    name = "xctestrunner",
    executable = 1,
    urls = ["https://github.com/google/xctestrunner/releases/download/0.2.10/ios_test_runner.par"],
)

git_repository(
    name = "material_internationalization_ios",
    remote = "https://github.com/material-foundation/material-internationalization-ios.git",
    tag = "v2.0.1",
)

git_repository(
    name = "material_testing_ios",
    remote = "https://github.com/material-foundation/material-testing-ios.git",
    tag = "v1.0.1",
)

git_repository(
    name = "material_text_accessibility_ios",
    remote = "https://github.com/material-foundation/material-text-accessibility-ios.git",
    tag = "v2.0.0",
)

git_repository(
    name = "motion_interchange_objc",
    remote = "https://github.com/material-motion/motion-interchange-objc.git",
    tag = "v2.0.0",
)

git_repository(
    name = "motion_animator_objc",
    remote = "https://github.com/material-motion/motion-animator-objc.git",
    tag = "v3.0.0",
)

git_repository(
    name = "ios_snapshot_test_case",
    remote = "https://github.com/material-foundation/ios-snapshot-test-case",
    commit = "cd9db9129956037297ef023857e3d82c424b6880",
)

git_repository(
    name = "catalog_by_convention",
    remote = "https://github.com/material-foundation/cocoapods-catalog-by-convention.git",
    tag = "v2.5.1",
)
