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

#import "MaterialSnapshot.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialContainerScheme.h"

/** Snapshot tests for @c MDCButton when a theming extension has been applied. */
@interface ButtonsThemingSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCButton *button;
@property(nonatomic, strong, nullable) MDCContainerScheme *containerScheme;
@end

@implementation ButtonsThemingSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.button = [[MDCButton alloc] init];
  [self.button setTitle:@"Material" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.button setImage:buttonImage forState:UIControlStateNormal];
  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view sizeToFit];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

/** Test a @c MDCButton being themed with @c applyTextThemeWithScheme:. */
- (void)testTextThemedButton {
  // When
  [self.button applyTextThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test a @c MDCButton being themed with @c applyContainedThemeWithScheme:. */
- (void)testContainedThemedButton {
  // When
  [self.button applyContainedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test a @c MDCButton being themed with @c applyOutlinedThemeWithScheme:. */
- (void)testOutlineThemedButton {
  // When
  [self.button applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test a @c MDCFloatingButton being themed with @c applySecondaryThemeWithScheme:. */
- (void)testFloatingButtonWithDefaultContainerScheme {
  // Given
  MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [floatingButton setImage:buttonImage forState:UIControlStateNormal];
  self.containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [floatingButton applySecondaryThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:floatingButton];
}

/** Test a themed @c MDCFloatingButton with a large icon set on it. */
- (void)testFloatingButtonWithDefaultContainerSchemeAndLargeIcon {
  // Given
  MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [floatingButton setImage:buttonImage forState:UIControlStateNormal];
  self.containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [floatingButton applySecondaryThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:floatingButton];
}

@end
