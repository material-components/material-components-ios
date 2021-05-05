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

/** A test fake window that allows overriding its @c traitCollection. */
@interface MDCActionSheetControllerCustomTraitCollectionTestsWindowFake : UIWindow

/** Set to override the value of @c traitCollection. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;

@end

@implementation MDCActionSheetControllerCustomTraitCollectionTestsWindowFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCActionSheetControllerCustomTraitCollectionTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheetController;
@end

@implementation MDCActionSheetControllerCustomTraitCollectionTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

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

  // Create a window so the Sheet's view can inherit the trait environment.
  MDCActionSheetControllerCustomTraitCollectionTestsWindowFake *window =
      [[MDCActionSheetControllerCustomTraitCollectionTestsWindowFake alloc] init];
  [window makeKeyWindow];
  window.hidden = NO;
  [window addSubview:self.actionSheetController.view];

  // When
  window.traitCollectionOverride = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
  [window traitCollectionDidChange:nil];
  [self.actionSheetController.view layoutIfNeeded];
  [self.actionSheetController.view sizeToFit];
  CGSize size = self.actionSheetController.view.bounds.size;
  window.bounds = CGRectMake(0, 0, size.width, size.height);
  self.actionSheetController.view.frame = window.bounds;

  // Then
  // Can't add a UIWindow to a UIView, so just screenshot the window directly.
  window.bounds = self.actionSheetController.view.frame;
  [window layoutIfNeeded];
  [self snapshotVerifyView:window];
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

  // Create a window so the Action Sheets's view can inherit the trait environment.
  MDCActionSheetControllerCustomTraitCollectionTestsWindowFake *window =
      [[MDCActionSheetControllerCustomTraitCollectionTestsWindowFake alloc] init];
  [window makeKeyWindow];
  window.hidden = NO;
  [window addSubview:self.actionSheetController.view];

  // When
  window.traitCollectionOverride =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  [window traitCollectionDidChange:nil];
  [self.actionSheetController.view layoutIfNeeded];
  [self.actionSheetController.view sizeToFit];
  CGSize size = self.actionSheetController.view.bounds.size;
  window.bounds = CGRectMake(0, 0, size.width, size.height);
  self.actionSheetController.view.frame = window.bounds;

  // Then
  // Can't add a UIWindow to a UIView, so just screenshot the window directly.
  window.bounds = self.actionSheetController.view.frame;
  [window layoutIfNeeded];
  [self snapshotVerifyView:window];
}

@end
