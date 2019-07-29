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

@end

@implementation BannerViewTests

- (void)testBannerViewDynamicTypeBehavior {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCBannerView *bannerView = [[MDCBannerView alloc] init];
    bannerView.trailingButton.hidden = YES;
    bannerView.mdc_adjustsFontForContentSizeCategory = YES;
    UIFont *font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    MDCFontScaler *fontScaler = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleBody2];
    UIFont *scalableFont = [fontScaler scaledFontWithFont:font];
    scalableFont = [scalableFont mdc_scaledFontAtDefaultSize];
    bannerView.textView.font = scalableFont;
    bannerView.textView.text = @"Banner Text";
    CGFloat originalTextFontSize = bannerView.textView.font.pointSize;
    MDCButton *leadingButton = bannerView.leadingButton;
    [leadingButton setTitleFont:scalableFont forState:UIControlStateNormal];
    CGFloat originalButtonFontSize =
        [bannerView.leadingButton titleFontForState:UIControlStateNormal].pointSize;

    // When
    MDCBannerViewTestsDynamicTypeContentSizeCategoryOverrideWindow *extraExtraLargeContainer =
        [[MDCBannerViewTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
            initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraExtraLarge];
    [extraExtraLargeContainer addSubview:bannerView];
    [NSNotificationCenter.defaultCenter
        postNotificationName:UIContentSizeCategoryDidChangeNotification
                      object:nil];

    // Then
    CGFloat actualTextFontSize = bannerView.textView.font.pointSize;
    XCTAssertGreaterThan(actualTextFontSize, originalTextFontSize);
    CGFloat actualButtonFontSize =
        [bannerView.leadingButton titleFontForState:UIControlStateNormal].pointSize;
    XCTAssertGreaterThan(actualButtonFontSize, originalButtonFontSize);
  }
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCBannerView *banner = [[MDCBannerView alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCBannerView *passedBannerView;
  banner.traitCollectionDidChangeBlock =
      ^(MDCBannerView *_Nonnull bannerView, UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedBannerView = bannerView;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [banner traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedBannerView, banner);
}

@end
