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

@interface MDCSnackbarColorThemerSingletonTests : XCTestCase

@property(nonatomic, strong) UIColor *messageTextColor;
@property(nonatomic, strong) UIColor *snackbarMessageViewShadowColor;
@property(nonatomic, strong) UIColor *snackbarMessageViewBackgroundColor;
@property(nonatomic, strong) NSMutableDictionary *titleColorForState;

@end

@implementation MDCSnackbarColorThemerSingletonTests

- (void)setUp {
  [super setUp];

  self.messageTextColor = MDCSnackbarManager.messageTextColor;
  self.snackbarMessageViewShadowColor = MDCSnackbarManager.snackbarMessageViewShadowColor;
  self.snackbarMessageViewBackgroundColor = MDCSnackbarManager.snackbarMessageViewBackgroundColor;
  self.titleColorForState = [@{} mutableCopy];
  NSUInteger maxState = UIControlStateNormal | UIControlStateDisabled | UIControlStateSelected |
                        UIControlStateHighlighted;
  for (NSUInteger state = 0; state < maxState; ++state) {
    self.titleColorForState[@(state)] = [MDCSnackbarManager buttonTitleColorForState:state];
  }
}

- (void)tearDown {
  // Restore the Snackbar Manager's state
  MDCSnackbarManager.messageTextColor = self.messageTextColor;
  MDCSnackbarManager.snackbarMessageViewShadowColor = self.snackbarMessageViewShadowColor;
  MDCSnackbarManager.snackbarMessageViewBackgroundColor = self.snackbarMessageViewBackgroundColor;
  for (NSNumber *state in self.titleColorForState.allKeys) {
    if (self.titleColorForState[state] != nil) {
      [MDCSnackbarManager setButtonTitleColor:self.titleColorForState[state]
                                     forState:state.unsignedIntegerValue];
    }
  }

  // Clean-up the test case
  [self.titleColorForState removeAllObjects];
  self.titleColorForState = nil;
  self.messageTextColor = nil;
  self.snackbarMessageViewShadowColor = nil;
  self.snackbarMessageViewBackgroundColor = nil;

  [super tearDown];
}

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
      [MDCSemanticColorScheme blendColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.8]
                     withBackgroundColor:colorScheme.surfaceColor];

  // When
  [MDCSnackbarColorThemer applySemanticColorScheme:colorScheme];

  // Then
  XCTAssertEqualObjects(MDCSnackbarManager.snackbarMessageViewBackgroundColor,
                        blendedBackgroundColor);
  XCTAssertEqualObjects(MDCSnackbarManager.messageTextColor,
                        [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqualObjects([MDCSnackbarManager buttonTitleColorForState:UIControlStateNormal],
                        [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects([MDCSnackbarManager buttonTitleColorForState:UIControlStateHighlighted],
                        [colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
}

@end
