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

#import "MaterialActivityIndicator+ColorThemer.h"
#import "MaterialActivityIndicator.h"
#import "MaterialColorScheme.h"

@interface ActivityIndicatorColorThemerTests : XCTestCase

@end

@implementation ActivityIndicatorColorThemerTests

- (void)testColorThemerChangesTheBackgroundColor {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
  colorScheme.primaryColor = UIColor.redColor;
  activityIndicator.cycleColors = @[ UIColor.whiteColor ];

  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [MDCActivityIndicatorColorThemer applySemanticColorScheme:colorScheme
                                        toActivityIndicator:activityIndicator];
#pragma clang diagnostic pop

  // Then
  XCTAssertEqualObjects(activityIndicator.cycleColors, @[ colorScheme.primaryColor ]);
}
@end
