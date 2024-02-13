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

#import "MaterialAvailability.h"
#import "MaterialBanner.h"
#import "MaterialBanner+Theming.h"
#import "MaterialButtons.h"
#import "UIColor+MaterialDynamic.h"
#import "MaterialMath.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

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
  UITraitCollection *traitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:self.contentSizeCategoryOverride];
  return traitCollection;
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
  XCTAssertEqualObjects(self.bannerView.imageView.tintColor,
                        self.containerScheme.colorScheme.primaryColor);
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
