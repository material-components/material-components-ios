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

#import "MaterialSnapshot.h"

#import <UIKit/UIKit.h>

#import "MaterialButtons.h"

/** General snapshot tests for @c MDCFloatingButton. */
@interface MDCFloatingButtonSnapshotTests : MDCSnapshotTestCase

@end

@implementation MDCFloatingButtonSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view sizeToFit];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/** Test a @c MDCFloatingButton with a standard icon set on it. */
- (void)testDefaultShapeInNormalModeWithStandardIconShowsStandardIcon {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

/** Test a @c MDCFloatingButton with a large icon set on it. */
- (void)testDefaultShapeInNormalModeWithLargeIconShowsLargeIcon {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

// TODO(b/153576427): The label should be hidden in this test, but it is not.
- (void)testNormalModeWithTitleLabelDoesNotShowLabel {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];
  button.mode = MDCFloatingButtonModeNormal;

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

#pragma mark - Animated mode changes

// This screenshot should identically match testModeToExpandedAnimated
- (void)testModeFromNormalToExpandedImmediate {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];

  // When
  [button setMode:MDCFloatingButtonModeExpanded animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

// This screenshot should identically match testModeToExpandedImmediate
- (void)testModeFromNormalToExpandedAnimated {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];

  // When
  button.layer.speed = 1000;
  [button setMode:MDCFloatingButtonModeExpanded animated:YES];
  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

// This screenshot should identically match testModeFromExpandedToNormalAnimated
- (void)testModeFromExpandedToNormalImmediate {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];
  [button setMode:MDCFloatingButtonModeExpanded animated:NO];

  // When
  [button setMode:MDCFloatingButtonModeNormal animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

// This screenshot should identically match testModeFromExpandedToNormalImmediate
- (void)testModeFromExpandedToNormalAnimated {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [button setImage:buttonImage forState:UIControlStateNormal];
  [button setMode:MDCFloatingButtonModeExpanded animated:NO];

  // When
  button.layer.speed = 1000;
  [button setMode:MDCFloatingButtonModeNormal animated:YES];
  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];

  // Then
  [self generateSnapshotAndVerifyForView:button];
}

@end
