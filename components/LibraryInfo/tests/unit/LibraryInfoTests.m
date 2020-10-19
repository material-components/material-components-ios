// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <XCTest/XCTest.h>

#import "MaterialLibraryInfo.h"

@interface LibraryInfoTests : XCTestCase

@end

@implementation LibraryInfoTests

- (void)testVersionFormat {
  // Given

  // This regex pattern does the following:
  // Accept: "118.1.0", etc.
  // Reject: "0.0.0", "1.2", "1", "-1.2.3", "Hi, I'm a version 1.2.3", "1.2.3 is my version", etc.
  //
  // Note the major version must be >= 1 since "0.0.0" is used as the version when something goes
  // wrong in the underlying code and we're in Release mode.
  NSString *pattern = @"^[1-9][0-9]*\\.[0-9]+\\.[0-9]+$";

  // When
  NSString *version = [MDCLibraryInfo versionString];

  // Then
  XCTAssertNotEqual(NSNotFound,
                    [version rangeOfString:pattern options:NSRegularExpressionSearch].location);
}
@end
