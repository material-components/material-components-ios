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

#import "MaterialAvailability.h"
#import "UIColor+MaterialDynamic.h"
#import "MaterialMath.h"

@interface MaterialColorTests : XCTestCase
@end

@implementation MaterialColorTests

- (void)testDynamicColorWhenUserInterfaceStyleIsDarkForiOS13 {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;

    // When
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];

    // Then
    XCTAssertEqualObjects([dynamicColor resolvedColorWithTraitCollection:traitCollection],
                          darkColor);
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testDynamicColorWhenUserInterfaceStyleIsLightForiOS13 {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;

    // When
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];

    // Then
    XCTAssertEqualObjects([dynamicColor resolvedColorWithTraitCollection:traitCollection],
                          lightColor);
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testDynamicColorWhenUserInterfaceStyleIsLightForPreiOS13 {
  if (@available(iOS 13.0, *)) {
  } else {
    // Given
    UIColor *darkColor = UIColor.blackColor;
    UIColor *lightColor = UIColor.whiteColor;

    // When
    UIColor *dynamicColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkColor
                                                             defaultColor:lightColor];

    // Then
    XCTAssertEqualObjects(dynamicColor, lightColor);
  }
}

- (void)testDynamicColorWhenAccessibilityContrastIsHighForiOS13 {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *highContrastColor = UIColor.blackColor;
    UIColor *normalContrastColor = UIColor.whiteColor;

    // When
    UIColor *dynamicColor = [UIColor colorWithAccessibilityContrastHigh:highContrastColor
                                                                 normal:normalContrastColor];
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithAccessibilityContrast:UIAccessibilityContrastHigh];

    // Then
    XCTAssertEqualObjects([dynamicColor resolvedColorWithTraitCollection:traitCollection],
                          highContrastColor);
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testDynamicColorWhenAccessibilityContrastIsNormalForiOS13 {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *highContrastColor = UIColor.blackColor;
    UIColor *normalContrastColor = UIColor.whiteColor;

    // When
    UIColor *dynamicColor = [UIColor colorWithAccessibilityContrastHigh:highContrastColor
                                                                 normal:normalContrastColor];
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithAccessibilityContrast:UIAccessibilityContrastNormal];

    // Then
    XCTAssertEqualObjects([dynamicColor resolvedColorWithTraitCollection:traitCollection],
                          normalContrastColor);
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testDynamicColorWhenAccessibilityContrastIsNormalForPreiOS13 {
  if (@available(iOS 13.0, *)) {
  } else {
    // Given
    UIColor *highContrastColor = UIColor.blackColor;
    UIColor *normalContrastColor = UIColor.whiteColor;

    // When
    UIColor *dynamicColor = [UIColor colorWithAccessibilityContrastHigh:highContrastColor
                                                                 normal:normalContrastColor];

    // Then
    XCTAssertEqualObjects(dynamicColor, normalContrastColor);
  }
}

- (void)testResolvedColorForPreiOS13ResultsInSameColor {
  // Given
  UIColor *expectedColor = UIColor.orangeColor;

  // When
  UIColor *returnedColor =
      [expectedColor mdc_resolvedColorWithTraitCollection:[[UITraitCollection alloc] init]];

  // Then
  XCTAssertEqualObjects(expectedColor, returnedColor);
}

- (void)testResolvedColorForiOS13OrLaterReturnsCorrectColor {
  // Given
  UIColor *dynamicColor = UIColor.clearColor;
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    dynamicColor = [UIColor
        colorWithDynamicProvider:^UIColor *_Nonnull(UITraitCollection *_Nonnull traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIColor.orangeColor;
          }
          return UIColor.blueColor;
        }];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

  // When
  UIColor *platformColor = dynamicColor;
  UIColor *mdcColor = dynamicColor;
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    UITraitCollection *fakeTraitCollection =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    platformColor = [dynamicColor resolvedColorWithTraitCollection:fakeTraitCollection];
    mdcColor = [dynamicColor mdc_resolvedColorWithTraitCollection:fakeTraitCollection];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

  // Then
  XCTAssertEqualObjects(platformColor, mdcColor);
}

@end
