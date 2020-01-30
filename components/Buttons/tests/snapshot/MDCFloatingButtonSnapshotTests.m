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

@end
