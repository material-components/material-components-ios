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

#import <XCTest/XCTest.h>

#include "MDCAvailability.h"
#import "MaterialBanner.h"
#import "MaterialBanner+Theming.h"
#import "UIColor+MaterialDynamic.h"
#import "MaterialMath.h"
#import "MaterialContainerScheme.h"

// The opacity value applied to text view.
static CGFloat const kTextViewOpacity = (CGFloat)0.87;
// The opacity value applied to divider.
static CGFloat const kDividerOpacity = (CGFloat)0.12;

/**
This class is used for creating a @UIWindow with customized size category.
*/
@interface MDCBannerViewThemingTestsDynamicTypeContentSizeCategoryOverrideWindow : UIWindow

/** Used to override the value of @c preferredContentSizeCategory. */
@property(nonatomic, copy) UIContentSizeCategory contentSizeCategoryOverride;

@end

@implementation MDCBannerViewThemingTestsDynamicTypeContentSizeCategoryOverrideWindow

- (instancetype)init {
  self = [super init];
  if (self) {
    self.contentSizeCategoryOverride = UIContentSizeCategoryLarge;
  }
  return self;
}

- (instancetype)initWithContentSizeCategoryOverride:
    (UIContentSizeCategory)contentSizeCategoryOverride {
  self = [super init];
  if (self) {
    self.contentSizeCategoryOverride = contentSizeCategoryOverride;
  }
  return self;
}

- (UITraitCollection *)traitCollection {
  if (@available(iOS 10.0, *)) {
    UITraitCollection *traitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:self.contentSizeCategoryOverride];
    return traitCollection;
  }
  return [super traitCollection];
}

@end

/**
 This class confirms behavior of @c MDCBannerView.
 */
@interface MDCBannerViewThemingTests : XCTestCase

@property(nonatomic, strong, nullable) MDCBannerView *bannerView;
@property(nonatomic, strong, nullable) MDCContainerScheme *containerScheme;

@end

@implementation MDCBannerViewThemingTests

- (void)setUp {
  [super setUp];

  self.bannerView = [[MDCBannerView alloc] init];
  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.bannerView = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testThemingWithDefaultValues {
  // When
  [self.bannerView applyThemeWithScheme:self.containerScheme];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  // Color
  XCTAssertEqualObjects(self.bannerView.backgroundColor,
                        self.containerScheme.colorScheme.surfaceColor);
  XCTAssertEqualObjects(
      self.bannerView.textView.textColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kTextViewOpacity]);
  XCTAssertEqualObjects(
      self.bannerView.dividerColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kDividerOpacity]);
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.bannerView.leadingButton titleColorForState:UIControlStateNormal],
                          self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects(
        [self.bannerView.leadingButton imageTintColorForState:UIControlStateNormal],
        self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects([self.bannerView.trailingButton titleColorForState:UIControlStateNormal],
                          self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects(
        [self.bannerView.trailingButton imageTintColorForState:UIControlStateNormal],
        self.containerScheme.colorScheme.primaryColor);
  }

  // Typography
  XCTAssertEqualObjects(self.bannerView.textView.font, self.containerScheme.typographyScheme.body2);
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.bannerView.leadingButton titleFontForState:state],
                          self.containerScheme.typographyScheme.button);
    XCTAssertEqualObjects([self.bannerView.trailingButton titleFontForState:state],
                          self.containerScheme.typographyScheme.button);
  }

  [self assertTraitCollectionAndElevationBlockForBannerView:self.bannerView
                                                colorScheme:self.containerScheme.colorScheme];
}

- (void)testThemingWithCustomValues {
  // Given
  self.containerScheme.colorScheme.surfaceColor = UIColor.yellowColor;
  self.containerScheme.colorScheme.onSurfaceColor = UIColor.cyanColor;
  self.containerScheme.colorScheme.primaryColor = UIColor.purpleColor;
  self.containerScheme.colorScheme.secondaryColor = UIColor.redColor;
  self.containerScheme.colorScheme.backgroundColor = UIColor.blueColor;
  self.containerScheme.colorScheme.elevationOverlayEnabledForDarkMode = YES;
  self.containerScheme.typographyScheme.body2 = [UIFont systemFontOfSize:101.0];

  // When
  [self.bannerView applyThemeWithScheme:self.containerScheme];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  // Color
  XCTAssertEqualObjects(self.bannerView.backgroundColor,
                        self.containerScheme.colorScheme.surfaceColor);
  XCTAssertEqualObjects(
      self.bannerView.textView.textColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kTextViewOpacity]);
  XCTAssertEqualObjects(
      self.bannerView.dividerColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kDividerOpacity]);
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.bannerView.leadingButton titleColorForState:UIControlStateNormal],
                          self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects(
        [self.bannerView.leadingButton imageTintColorForState:UIControlStateNormal],
        self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects([self.bannerView.trailingButton titleColorForState:UIControlStateNormal],
                          self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects(
        [self.bannerView.trailingButton imageTintColorForState:UIControlStateNormal],
        self.containerScheme.colorScheme.primaryColor);
  }
  // Typography
  XCTAssertEqualObjects(self.bannerView.textView.font, self.containerScheme.typographyScheme.body2);

  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.bannerView.leadingButton titleFontForState:state],
                          self.containerScheme.typographyScheme.button);
    XCTAssertEqualObjects([self.bannerView.trailingButton titleFontForState:state],
                          self.containerScheme.typographyScheme.button);
  }

  [self assertTraitCollectionAndElevationBlockForBannerView:self.bannerView
                                                colorScheme:self.containerScheme.colorScheme];
}

- (void)testFontsAreScaledWhenTypographySchemeRequestsPrescaling {
  if (@available(iOS 10.0, *)) {
    // Given
    self.containerScheme.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
    self.containerScheme.typographyScheme.useCurrentContentSizeCategoryWhenApplied = YES;

    // When
    MDCBannerViewThemingTestsDynamicTypeContentSizeCategoryOverrideWindow
        *extraExtraLargeContainer =
            [[MDCBannerViewThemingTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
                initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraExtraLarge];
    [extraExtraLargeContainer addSubview:self.bannerView];
    [NSNotificationCenter.defaultCenter
        postNotificationName:UIContentSizeCategoryDidChangeNotification
                      object:nil];
    [self.bannerView applyThemeWithScheme:self.containerScheme];

    // Then
    XCTAssertGreaterThan(self.bannerView.textView.font.pointSize,
                         self.containerScheme.typographyScheme.body2.pointSize);
  }
}

- (void)testBannerViewBackgroundColorChangeWhenUIUserInterfaceStyleChangesOnIOS13 {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *darkSurfaceColor = UIColor.blackColor;
    UIColor *lightSurfaceColor = UIColor.whiteColor;

    UIColor *dynamicSurfaceColor = [UIColor colorWithUserInterfaceStyleDarkColor:darkSurfaceColor
                                                                    defaultColor:lightSurfaceColor];
    self.containerScheme.colorScheme.surfaceColor = dynamicSurfaceColor;
    self.containerScheme.colorScheme.elevationOverlayEnabledForDarkMode = YES;

    // When
    [self.bannerView applyThemeWithScheme:self.containerScheme];
    UITraitCollection *previousTraitCollection = [self.bannerView.traitCollection copy];
    self.bannerView.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    [self.bannerView traitCollectionDidChange:previousTraitCollection];

    // Then
    XCTAssertTrue([self compareColorsWithFloatPrecisionFirstColor:self.bannerView.backgroundColor
                                                      secondColor:darkSurfaceColor]);
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)assertTraitCollectionAndElevationBlockForBannerView:(MDCBannerView *)bannerView
                                                colorScheme:(id<MDCColorScheming>)colorScheme {
  if (colorScheme.elevationOverlayEnabledForDarkMode) {
    XCTAssertNotNil(bannerView.mdc_elevationDidChangeBlock);
    XCTAssertNotNil(bannerView.traitCollectionDidChangeBlock);
  } else {
    XCTAssertNil(bannerView.mdc_elevationDidChangeBlock);
    XCTAssertNil(bannerView.traitCollectionDidChangeBlock);
  }
}

// TODO(https://github.com/material-components/material-components-ios/issues/8532): Replace the
// usage of this method with generic macro when available.
- (BOOL)compareColorsWithFloatPrecisionFirstColor:(UIColor *)firstColor
                                      secondColor:(UIColor *)secondColor {
  CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
  [firstColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
  CGFloat sRed = 0.0, sGreen = 0.0, sBlue = 0.0, sAlpha = 0.0;
  [secondColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];

  return (MDCCGFloatEqual(fRed, sRed) && MDCCGFloatEqual(fGreen, sGreen) &&
          MDCCGFloatEqual(fBlue, sBlue) && MDCCGFloatEqual(fAlpha, sAlpha));
}

@end
