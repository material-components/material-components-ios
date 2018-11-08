// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnackbar+ColorThemer.h"
#import "MaterialSnackbar.h"

@interface MDCSnackbarColorThemerTests : XCTestCase

@end

@implementation MDCSnackbarColorThemerTests

- (void)testSnackbarColorThemerChangesCorrectParameters {
  // Given
  MDCSnackbarManager *snackbarManager = [[MDCSnackbarManager alloc] init];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.surfaceColor = [UIColor redColor];
  colorScheme.onSurfaceColor = [UIColor blueColor];
  UIColor *blendedBackgroundColor =
      [MDCSemanticColorScheme blendColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.8]
                     withBackgroundColor:colorScheme.surfaceColor];

  // When
  [MDCSnackbarColorThemer applySemanticColorScheme:colorScheme toSnackbarManager:snackbarManager];

  // Then
  XCTAssertEqualObjects(snackbarManager.snackbarMessageViewBackgroundColor, blendedBackgroundColor);
  XCTAssertEqualObjects(snackbarManager.messageTextColor,
                        [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqualObjects([snackbarManager buttonTitleColorForState:UIControlStateNormal],
                        [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects([snackbarManager buttonTitleColorForState:UIControlStateHighlighted],
                        [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
}

@end
