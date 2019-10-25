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

#import "../../src/private/MDCDialogShadowedView.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MaterialColor.h"
#import "MaterialDialogs.h"
#import "MaterialTypography.h"

/**
 A @c MDCAlertController test fake to override the @c traitCollection to test for dynamic type.
 */
@interface AlertControllerCustomTraitCollectionSnapshotTestFake : MDCAlertController
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation AlertControllerCustomTraitCollectionSnapshotTestFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/** An @c MDCDialogShadowedView test fake to override the @c traitCollection to test. */
@interface ShadowViewCustomTraitCollectionSnapshotTestFake : MDCDialogShadowedView
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation ShadowViewCustomTraitCollectionSnapshotTestFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCAlertControllerCustomTraitCollectionTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable)
    AlertControllerCustomTraitCollectionSnapshotTestFake *alertController;
@end

@implementation MDCAlertControllerCustomTraitCollectionTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alertController = [[AlertControllerCustomTraitCollectionSnapshotTestFake alloc] init];
  self.alertController.title = @"Material";
  self.alertController.message =
      @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt "
      @"ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation "
      @"ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in "
      @"reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
      @"sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id "
      @"est laborum.";
  MDCAlertAction *fakeAction = [MDCAlertAction actionWithTitle:@"Foo"
                                                       handler:^(MDCAlertAction *action){
                                                       }];
  [self.alertController addAction:fakeAction];
  MDCFontScaler *titleFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleSubtitle1];
  UIFont *titleFont = [UIFont systemFontOfSize:14];
  titleFont = [titleFontScaler scaledFontWithFont:titleFont];
  titleFont = [titleFont mdc_scaledFontAtDefaultSize];
  self.alertController.titleFont = titleFont;
  MDCFontScaler *messageFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleBody2];
  UIFont *messageFont = [UIFont systemFontOfSize:15];
  messageFont = [messageFontScaler scaledFontWithFont:messageFont];
  messageFont = [messageFont mdc_scaledFontAtDefaultSize];
  self.alertController.messageFont = messageFont;
  MDCFontScaler *buttonFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleButton];
  UIFont *buttonFont = [UIFont systemFontOfSize:15];
  buttonFont = [buttonFontScaler scaledFontWithFont:buttonFont];
  buttonFont = [buttonFont mdc_scaledFontAtDefaultSize];
  for (MDCAlertAction *action in _alertController.actions) {
    MDCButton *button = [_alertController buttonForAction:action];
    if (button.enableTitleFontForState) {
      [button setTitleFont:buttonFont forState:UIControlStateNormal];
    } else {
      button.titleLabel.font = buttonFont;
    }
  }

  self.alertController.view.bounds = CGRectMake(0, 0, 300, 300);
}

- (void)tearDown {
  self.alertController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/**
 Used to set the @c UIContentSizeCategory on an @c MDCAlertController.

 @note On iOS 9 or below this method has no impact.
 */
- (void)setAlertControllerContentSizeCategory:(UIContentSizeCategory)sizeCategory {
  UITraitCollection *traitCollection = [[UITraitCollection alloc] init];
  if (@available(iOS 10.0, *)) {
    traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:sizeCategory];
  }

  self.alertController.traitCollectionOverride = traitCollection;
}

- (void)testScaledFontDynamicTypeForContentSizeCategorySmall {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategorySmall];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryMedium {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryMedium];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraExtraLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryExtraExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityMedium {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryAccessibilityMedium];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryAccessibilityLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryAccessibilityExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setAlertControllerContentSizeCategory:UIContentSizeCategoryAccessibilityExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self
      setAlertControllerContentSizeCategory:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDynamicColorSupport {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *titleColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.greenColor
                                                           defaultColor:UIColor.blackColor];
    UIColor *messageColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.purpleColor
                                                             defaultColor:UIColor.blackColor];
    UIColor *backgroundColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.blueColor
                                                                defaultColor:UIColor.blackColor];
    self.alertController.titleColor = titleColor;
    self.alertController.messageColor = messageColor;
    self.alertController.backgroundColor = backgroundColor;

    // When
    self.alertController.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];

    // Then
    UIView *snapshotView = [self.alertController.view
        mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif
}

- (void)testDynamicColorSupportForTrackingView {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *shadowColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.greenColor
                                                            defaultColor:UIColor.blackColor];
    ShadowViewCustomTraitCollectionSnapshotTestFake *trackingView =
        [[ShadowViewCustomTraitCollectionSnapshotTestFake alloc] init];
    trackingView.frame = CGRectMake(0, 0, 100, 200);
    trackingView.shadowColor = shadowColor;
    trackingView.backgroundColor = UIColor.whiteColor;

    // When
    trackingView.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [trackingView layoutIfNeeded];

    // Then
    UIView *snapshotView =
        [trackingView mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif
}

@end
