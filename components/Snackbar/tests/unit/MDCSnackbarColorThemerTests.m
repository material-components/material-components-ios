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

#import "MaterialSnackbar.h"
#import "MaterialSnackbar+ColorThemer.h"

@interface MDCSnackbarColorThemerTests : XCTestCase
@end

@implementation MDCSnackbarColorThemerTests

- (void)testSnackbarColorThemerChangesCorrectParameters {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.surfaceColor = [UIColor redColor];
  colorScheme.onSurfaceColor = [UIColor blueColor];
  MDCSnackbarManager.snackbarMessageViewBackgroundColor = [UIColor whiteColor];
  MDCSnackbarManager.messageTextColor = [UIColor whiteColor];
  [MDCSnackbarManager setButtonTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [MDCSnackbarManager setButtonTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
  UIColor *blendedBackgroundColor =
      [MDCSemanticColorScheme blendColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:0.8f]
                     withBackgroundColor:colorScheme.surfaceColor];

  // When
  [MDCSnackbarColorThemer applySemanticColorScheme:colorScheme];

  // Then
  XCTAssertEqualObjects(MDCSnackbarManager.snackbarMessageViewBackgroundColor,
                        blendedBackgroundColor);
  XCTAssertEqualObjects(MDCSnackbarManager.messageTextColor,
                        [colorScheme.surfaceColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects([MDCSnackbarManager buttonTitleColorForState:UIControlStateNormal],
                        [colorScheme.surfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects([MDCSnackbarManager buttonTitleColorForState:UIControlStateHighlighted],
                        [colorScheme.surfaceColor colorWithAlphaComponent:0.6f]);

}

@end
