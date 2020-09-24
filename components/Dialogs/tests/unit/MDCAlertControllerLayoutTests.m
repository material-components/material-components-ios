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

#import "MaterialDialogs.h"

#import "MaterialButtons.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MDCAlertControllerView+Private.h"

#import <XCTest/XCTest.h>

static const CGFloat kFourInchPortraitWidth = 320.0;
static const CGFloat kFourInchLandscapeWidth = 568.0;

@interface MDCAlertControllerLayoutTests : XCTestCase

@end

@implementation MDCAlertControllerLayoutTests {
  MDCAlertController *_alertController;
}

- (void)setUp {
  [super setUp];
}

// The large point size Urdu text in this dialog should lay out the two buttons vertically on
// a 4" portrait size screen and horizontally in landscape
- (void)setupLargePointSizeUrduNetworkRetryDialog {
  NSString *networkFailureInUrdu = @"براہ کرم اپنا نیٹ ورک کنکشن چیک کریں اور دوبارہ کوشش کریں۔";
  _alertController = [MDCAlertController alertControllerWithTitle:nil message:networkFailureInUrdu];
  NSString *urduFontName = @"NotoNastaliqUrdu";
  UIFont *dialogBodyFont;
  UIFont *dialogButtonFont;
  if (@available(iOS 11, *)) {
    // Noto Nastaliq Urdu was added in iOS 11, and is an extremely tall
    // font for any given nominal point size.
    dialogBodyFont = [UIFont fontWithName:urduFontName size:20.0];
    dialogButtonFont = [UIFont fontWithName:urduFontName size:26.0];
  } else {
    dialogBodyFont = [UIFont systemFontOfSize:20.0];
    dialogButtonFont = [UIFont systemFontOfSize:26.0];
  }
  _alertController.messageFont = dialogBodyFont;

  MDCAlertAction *retryAction = [MDCAlertAction actionWithTitle:@"دوبارہ کوشش کریں" handler:nil];
  MDCAlertAction *cancelAction = [MDCAlertAction actionWithTitle:@"منسوخ کریں" handler:nil];
  [_alertController addAction:retryAction];
  [_alertController addAction:cancelAction];

  for (MDCAlertAction *action in _alertController.actions) {
    [[_alertController buttonForAction:action] setTitleFont:dialogButtonFont
                                                   forState:UIControlStateNormal];
  }
}

- (void)tearDown {
  _alertController = nil;
  [super tearDown];
}

- (void)testButtonLayout {
  [self setupLargePointSizeUrduNetworkRetryDialog];
  MDCAlertControllerView *view = (MDCAlertControllerView *)_alertController.view;

  CGSize sizeOnFourInchPortrait = [view calculateActionsSizeThatFitsWidth:kFourInchPortraitWidth];
  CGSize sizeOnFourInchLandscape = [view calculateActionsSizeThatFitsWidth:kFourInchLandscapeWidth];

  // The vertical layout should be approximately twice as high as the horizontal layout, +/-
  // padding between buttons.
  XCTAssertEqualWithAccuracy(sizeOnFourInchLandscape.height * 2, sizeOnFourInchPortrait.height, 20);
  XCTAssertGreaterThan(sizeOnFourInchLandscape.width, sizeOnFourInchPortrait.width);
}

@end
