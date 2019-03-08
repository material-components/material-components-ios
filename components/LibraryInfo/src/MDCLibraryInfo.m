// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCLibraryInfo.h"

// The current version of the MDC-iOS library. DO NOT EDIT MANUALLY.
//
// This string is updated automatically as a part of the release process and should not be edited
// manually. Do not rename this constant or change the formatting without updating the release
// scripts.
static NSString const *MDCLibraryInfoVersionString = @"79.0.1";

@implementation MDCLibraryInfo

+ (NSString *)versionString {
  return [MDCLibraryInfoVersionString copy];  // Copy because caller isn't expecting `const`.
}

@end
