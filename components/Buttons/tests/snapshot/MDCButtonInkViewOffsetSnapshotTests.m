// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialInk.h"
#import "MaterialRipple.h"
#import "MaterialSnapshot.h"

static const CGFloat kOffsetViewAlpha = 0.3f;

@interface MDCButton (Testing)
@property(nonatomic, strong) MDCInkView *inkView;
@property(nonatomic, strong, readonly, nonnull) MDCStatefulRippleView *rippleView;
@end

/** Snapshot tests for @c MDCButton when inkViewOffset has been altered. */
@interface MDCButtonInkViewOffsetSnapshotTests : MDCSnapshotTestCase
/** The button being tested */
@property(nonatomic, strong) MDCButton *button;
@end

@implementation MDCButtonInkViewOffsetSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.button = [[MDCButton alloc] init];
  UIImage *testImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.button setImage:testImage forState:UIControlStateNormal];
  self.button.backgroundColor = UIColor.lightGrayColor;
  [self.button sizeToFit];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/** Verifies that the button's inkView is centered when given a zero-sized inkViewOffset. */
- (void)testInkViewIsCenteredWithZeroSizeInkViewOffset {
  // When
  self.button.inkViewOffset = CGSizeZero;
  self.button.inkView.backgroundColor =
      [UIColor.greenColor colorWithAlphaComponent:kOffsetViewAlpha];
  [self.button layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Verifies that the button's inkView is offset from the button's center by the provided
 inkViewOffset.
 */
- (void)testInkViewIsMovedWithNonZeroInkViewOffset {
  // When
  self.button.inkViewOffset = CGSizeMake(3, 3);
  self.button.inkView.backgroundColor =
      [UIColor.greenColor colorWithAlphaComponent:kOffsetViewAlpha];
  [self.button layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Verifies that the button's rippleView is centered when given a zero-sized inkViewOffset. */
- (void)testRippleViewIsCenteredWithZeroSizeInkViewOffset {
  // When
  self.button.enableRippleBehavior = YES;
  self.button.inkViewOffset = CGSizeZero;
  self.button.rippleView.backgroundColor =
      [UIColor.redColor colorWithAlphaComponent:kOffsetViewAlpha];
  [self.button layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Verifies that the button's rippleView is offset from the button's center by the provided
 inkViewOffset.
*/
- (void)testRippleViewIsMovedWithNonZeroInkViewOffset {
  // When
  self.button.enableRippleBehavior = YES;
  self.button.inkViewOffset = CGSizeMake(3, 3);
  self.button.rippleView.backgroundColor =
      [UIColor.redColor colorWithAlphaComponent:kOffsetViewAlpha];
  [self.button layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

@end
