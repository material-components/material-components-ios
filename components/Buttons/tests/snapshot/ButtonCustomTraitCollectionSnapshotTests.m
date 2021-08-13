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

#import "MaterialAvailability.h"
#import "MaterialButtons.h"
#import "MDCFontScaler.h"
#import "MaterialTypography.h"
#import "MaterialColor.h"

/** A @c MDCButton test fake to override the @c traitCollection to test for dynamic type. */
@interface ButtonDynamicTypeSnapshotTestFakeButton : MDCButton
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation ButtonDynamicTypeSnapshotTestFakeButton

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/**
 Used to test dynamic type visual differences based on different @c UIContentSizeCategory
 values.
 */
@interface ButtonCustomTraitCollectionSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) ButtonDynamicTypeSnapshotTestFakeButton *button;
@end

@implementation ButtonCustomTraitCollectionSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.button = [[ButtonDynamicTypeSnapshotTestFakeButton alloc] init];
  [self.button setTitle:@"Material" forState:UIControlStateNormal];
  self.button.mdc_adjustsFontForContentSizeCategory = YES;
  MDCFontScaler *fontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleSubtitle1];
  UIFont *buttonFont = [UIFont systemFontOfSize:14];
  buttonFont = [fontScaler scaledFontWithFont:buttonFont];
  buttonFont = [buttonFont mdc_scaledFontAtDefaultSize];
  [self.button setTitleFont:buttonFont forState:UIControlStateNormal];
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

/**
 Used to set the @c UIContentSizeCategory on an @c MDCButton.
 */
- (void)setButtonTraitCollectionSizeToSize:(UIContentSizeCategory)sizeCategory {
  UITraitCollection *traitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:sizeCategory];

  self.button.traitCollectionOverride = traitCollection;
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategorySmall. */
- (void)testContentSizeCategorySmall {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryMedium. */
- (void)testContentSizeCategoryMedium {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryMedium];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryLarge. */
- (void)testContentSizeCategoryLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraLarge. */
- (void)testContentSizeCategoryExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraExtraLarge. */
- (void)testContentSizeCategoryExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraExtraExtraLarge. */
- (void)testContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityMedium. */
- (void)testContentSizeCategoryAccessibilityMedium {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityLarge. */
- (void)testContentSizeCategoryAccessibilityLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testButtonRespondsToDynamicColor {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *shadowColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.magentaColor
                                                            defaultColor:UIColor.blackColor];
    UIColor *backgroundColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.yellowColor
                                                                defaultColor:UIColor.blackColor];
    UIColor *borderColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.greenColor
                                                            defaultColor:UIColor.blackColor];
    [self.button setShadowColor:shadowColor forState:UIControlStateNormal];
    [self.button setBackgroundColor:backgroundColor forState:UIControlStateNormal];
    [self.button setBorderColor:borderColor forState:UIControlStateNormal];
    [self.button setBorderWidth:2 forState:UIControlStateNormal];
    [self.button setElevation:10 forState:UIControlStateNormal];

    // When
    self.button.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [self.button layoutIfNeeded];

    // Then
    [self.button sizeToFit];
    UIView *snapshotView =
        [self.button mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

@end
