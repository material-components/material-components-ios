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

#import "MaterialBanner.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"

@interface MDCBannerViewTestsDynamicTypeContentSizeCategoryOverrideWindow : UIWindow

/** Used to override the value of @c preferredContentSizeCategory. */
@property(nonatomic, copy) UIContentSizeCategory contentSizeCategoryOverride;

@end

@implementation MDCBannerViewTestsDynamicTypeContentSizeCategoryOverrideWindow

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

@interface BannerViewTests : XCTestCase
@property(nonatomic, strong, nullable) MDCBannerView *banner;
@end

@implementation BannerViewTests

- (void)setUp {
  [super setUp];

  self.banner = [[MDCBannerView alloc] init];
}

- (void)tearDown {
  self.banner = nil;

  [super tearDown];
}

- (void)testBannerViewDynamicTypeBehavior {
  if (@available(iOS 10.0, *)) {
    // Given
    self.banner.trailingButton.hidden = YES;
    self.banner.mdc_adjustsFontForContentSizeCategory = YES;
    UIFont *font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    MDCFontScaler *fontScaler = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleBody2];
    UIFont *scalableFont = [fontScaler scaledFontWithFont:font];
    scalableFont = [scalableFont mdc_scaledFontAtDefaultSize];
    self.banner.textView.font = scalableFont;
    self.banner.textView.text = @"Banner Text";
    CGFloat originalTextFontSize = self.banner.textView.font.pointSize;
    MDCButton *leadingButton = self.banner.leadingButton;
    [leadingButton setTitleFont:scalableFont forState:UIControlStateNormal];
    CGFloat originalButtonFontSize =
        [self.banner.leadingButton titleFontForState:UIControlStateNormal].pointSize;

    // When
    MDCBannerViewTestsDynamicTypeContentSizeCategoryOverrideWindow *extraExtraLargeContainer =
        [[MDCBannerViewTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
            initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraExtraLarge];
    [extraExtraLargeContainer addSubview:self.banner];
    [NSNotificationCenter.defaultCenter
        postNotificationName:UIContentSizeCategoryDidChangeNotification
                      object:nil];

    // Then
    CGFloat actualTextFontSize = self.banner.textView.font.pointSize;
    XCTAssertGreaterThan(actualTextFontSize, originalTextFontSize);
    CGFloat actualButtonFontSize =
        [self.banner.leadingButton titleFontForState:UIControlStateNormal].pointSize;
    XCTAssertGreaterThan(actualButtonFontSize, originalButtonFontSize);
  }
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCBannerView *passedBannerView;
  self.banner.traitCollectionDidChangeBlock =
      ^(MDCBannerView *_Nonnull bannerView, UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedBannerView = bannerView;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.banner traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedBannerView, self.banner);
}

#pragma mark - MaterialElevation

- (void)testDefaultBaseElevationOverrideIsNegative {
  // Then
  XCTAssertLessThan(self.banner.mdc_overrideBaseElevation, 0);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.banner.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.banner.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

@end
