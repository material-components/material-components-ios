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

#import "MaterialBanner+Theming.h"
#import "MaterialBanner.h"
#import "MaterialContainerScheme.h"

static CGFloat const kBannerViewTextViewOpacityDefault = (CGFloat)0.87;
static CGFloat const kBannerViewDividerOpacityDefault = (CGFloat)0.12;


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
  XCTAssertEqualObjects(self.bannerView.textView.textColor,
                        [self.containerScheme.colorScheme.onSurfaceColor
                         colorWithAlphaComponent:kBannerViewTextViewOpacityDefault]);
  XCTAssertEqualObjects(self.bannerView.dividerColor,
                        [self.containerScheme.colorScheme.onSurfaceColor
                         colorWithAlphaComponent:kBannerViewDividerOpacityDefault]);
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.bannerView.leadingButton titleColorForState:UIControlStateNormal],
                          self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects([self.bannerView.leadingButton imageTintColorForState:UIControlStateNormal],
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
}

- (void)testThemingWithCustomValues {
  // Given
  self.containerScheme.colorScheme.surfaceColor = UIColor.yellowColor;
  self.containerScheme.colorScheme.onSurfaceColor = UIColor.cyanColor;
  self.containerScheme.colorScheme.primaryColor = UIColor.purpleColor;
  self.containerScheme.colorScheme.secondaryColor = UIColor.redColor;
  self.containerScheme.colorScheme.backgroundColor = UIColor.blueColor;
  self.containerScheme.typographyScheme.body2 = [UIFont systemFontOfSize:101.0];

  // When
  [self.bannerView applyThemeWithScheme:self.containerScheme];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
  UIControlStateHighlighted | UIControlStateDisabled;
  // Color
  XCTAssertEqualObjects(self.bannerView.backgroundColor,
                        self.containerScheme.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.bannerView.textView.textColor,
                        [self.containerScheme.colorScheme.onSurfaceColor
                         colorWithAlphaComponent:kBannerViewTextViewOpacityDefault]);
  XCTAssertEqualObjects(self.bannerView.dividerColor,
                        [self.containerScheme.colorScheme.onSurfaceColor
                         colorWithAlphaComponent:kBannerViewDividerOpacityDefault]);
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([self.bannerView.leadingButton titleColorForState:UIControlStateNormal],
                          self.containerScheme.colorScheme.primaryColor);
    XCTAssertEqualObjects([self.bannerView.leadingButton imageTintColorForState:UIControlStateNormal],
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
}

@end
