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

#import "MaterialActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDCActionSheetControllerCustomTraitCollectionTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheetController;

/// Parent of the action sheet controller, used to override trait collection.
@property(nonatomic, strong, nullable) UIViewController *parent;
@end

@implementation MDCActionSheetControllerCustomTraitCollectionTests

- (void)setUp {
  [super setUp];

  self.actionSheetController = [[MDCActionSheetController alloc] init];
  self.actionSheetController.adjustsFontForContentSizeCategory = YES;
  MDCActionSheetAction *firstAction = [MDCActionSheetAction actionWithTitle:@"First"
                                                                      image:nil
                                                                    handler:nil];
  MDCActionSheetAction *secondAction = [MDCActionSheetAction actionWithTitle:@"Second"
                                                                       image:nil
                                                                     handler:nil];

  [self.actionSheetController addAction:firstAction];
  [self.actionSheetController addAction:secondAction];
  self.actionSheetController.message = @"Message";
  self.actionSheetController.title = @"Title";

  self.actionSheetController.view.bounds = CGRectMake(0, 0, 700, 700);

  // Set up the parent view controller.
  self.parent = [[UIViewController alloc] init];
  [self.parent addChildViewController:self.actionSheetController];
  [self.parent.view addSubview:self.actionSheetController.view];
  [self.actionSheetController didMoveToParentViewController:self.parent];
}

- (void)tearDown {
  self.actionSheetController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

/**
 Test that @c adjustsFontForContentSizeCategory will scale an appropriate font to a larger
 size when the preferred content size category increases.
 */
- (void)testAdjustsFontForContentSizeUpscalesUIFontMetricsFontsForSizeCategoryXS {
  // Given
  UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
  UITraitCollection *aXXXLTraits =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];

  UIFont *titleFont = [UIFont fontWithName:@"Zapfino" size:15];
  XCTAssertNotNil(titleFont);
  titleFont = [bodyMetrics scaledFontForFont:titleFont compatibleWithTraitCollection:aXXXLTraits];
  self.actionSheetController.titleFont = titleFont;

  UIFont *messageFont = [UIFont fontWithName:@"Zapfino" size:10];
  messageFont = [bodyMetrics scaledFontForFont:messageFont
                 compatibleWithTraitCollection:aXXXLTraits];
  self.actionSheetController.messageFont = messageFont;

  UIFont *actionFont = [UIFont fontWithName:@"Zapfino" size:15];
  actionFont = [bodyMetrics scaledFontForFont:actionFont compatibleWithTraitCollection:aXXXLTraits];
  self.actionSheetController.actionFont = actionFont;

  self.actionSheetController.adjustsFontForContentSizeCategory = YES;
  [self.actionSheetController loadViewIfNeeded];

  // When
  UITraitCollection *xsTraits = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
  [self.parent setOverrideTraitCollection:xsTraits
                   forChildViewController:self.actionSheetController];

  [self.actionSheetController.view layoutIfNeeded];
  [self.actionSheetController.view sizeToFit];
  CGSize size = self.actionSheetController.view.bounds.size;
  self.parent.view.bounds = CGRectMake(0, 0, size.width, size.height);
  self.actionSheetController.view.frame = self.parent.view.bounds;
  [self.parent.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.parent.view];
}

/**
 Test that @c adjustsFontForContentSizeCategory will scale an appropriate font to a
 smaller size when the preferred content size category decreases.
 */
- (void)testAdjustsFontForContentSizeUpscalesUIFontMetricsFontsForSizeCategoryAXXXL {
  // Given
  UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
  UITraitCollection *extraSmallTraits = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
  UIFont *titleFont = [UIFont fontWithName:@"Zapfino" size:15];
  XCTAssertNotNil(titleFont);
  titleFont = [bodyMetrics scaledFontForFont:titleFont
               compatibleWithTraitCollection:extraSmallTraits];
  self.actionSheetController.titleFont = titleFont;

  UIFont *messageFont = [UIFont fontWithName:@"Zapfino" size:10];
  messageFont = [bodyMetrics scaledFontForFont:messageFont
                 compatibleWithTraitCollection:extraSmallTraits];
  self.actionSheetController.messageFont = messageFont;

  UIFont *actionFont = [UIFont fontWithName:@"Zapfino" size:15];
  actionFont = [bodyMetrics scaledFontForFont:actionFont
                compatibleWithTraitCollection:extraSmallTraits];
  self.actionSheetController.actionFont = actionFont;

  self.actionSheetController.adjustsFontForContentSizeCategory = YES;
  [self.actionSheetController loadViewIfNeeded];

  // When
  UITraitCollection *xxxlTraits =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  [self.parent setOverrideTraitCollection:xxxlTraits
                   forChildViewController:self.actionSheetController];

  [self.actionSheetController.view layoutIfNeeded];
  [self.actionSheetController.view sizeToFit];
  CGSize size = self.actionSheetController.view.bounds.size;
  self.parent.view.bounds = CGRectMake(0, 0, size.width, size.height);
  self.actionSheetController.view.frame = self.parent.view.bounds;
  [self.parent.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.parent.view];
}

@end

NS_ASSUME_NONNULL_END
