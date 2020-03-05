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

#import "MaterialAppBar+Theming.h"

#import <XCTest/XCTest.h>

#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

/** Unit tests for MDCAppBarViewController's MaterialTheming category methods. */
@interface MDCAppBarViewController_MaterialThemingTests : XCTestCase

/** Container scheme used for theming. */
@property(nonatomic, strong) MDCContainerScheme *containerScheme;

/** The controller being tested. */
@property(nonatomic, strong) MDCAppBarViewController *appBarController;

@end

@implementation MDCAppBarViewController_MaterialThemingTests

- (void)setUp {
  [super setUp];

  self.containerScheme = [[MDCContainerScheme alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:0];
  colorScheme.primaryColorVariant = [UIColor colorWithWhite:(CGFloat)0.8 alpha:(CGFloat)0.1];
  colorScheme.secondaryColor = [UIColor colorWithWhite:(CGFloat)0.7 alpha:(CGFloat)0.2];
  colorScheme.errorColor = [UIColor colorWithWhite:(CGFloat)0.6 alpha:(CGFloat)0.3];
  colorScheme.surfaceColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:(CGFloat)0.4];
  colorScheme.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.4 alpha:(CGFloat)0.5];
  colorScheme.onPrimaryColor = [UIColor colorWithWhite:(CGFloat)0.3 alpha:(CGFloat)0.6];
  colorScheme.onSecondaryColor = [UIColor colorWithWhite:(CGFloat)0.2 alpha:(CGFloat)0.7];
  colorScheme.onSurfaceColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:(CGFloat)0.8];
  colorScheme.onBackgroundColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.9];
  self.containerScheme.colorScheme = colorScheme;

  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  typographyScheme.headline1 = [UIFont systemFontOfSize:1];
  typographyScheme.headline2 = [UIFont systemFontOfSize:2];
  typographyScheme.headline3 = [UIFont systemFontOfSize:3];
  typographyScheme.headline4 = [UIFont systemFontOfSize:4];
  typographyScheme.headline5 = [UIFont systemFontOfSize:5];
  typographyScheme.headline6 = [UIFont systemFontOfSize:6];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:7];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:8];
  typographyScheme.body1 = [UIFont systemFontOfSize:9];
  typographyScheme.body2 = [UIFont systemFontOfSize:10];
  typographyScheme.caption = [UIFont systemFontOfSize:11];
  typographyScheme.button = [UIFont systemFontOfSize:12];
  typographyScheme.overline = [UIFont systemFontOfSize:13];
  self.containerScheme.typographyScheme = typographyScheme;

  self.appBarController = [[MDCAppBarViewController alloc] init];
}

- (void)tearDown {
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testApplyPrimaryThemeWithScheme {
  // When
  [self.appBarController applyPrimaryThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.appBarController.navigationBar.titleFont,
                        self.containerScheme.typographyScheme.headline6);
  XCTAssertEqualObjects(self.appBarController.navigationBar.titleTextColor,
                        self.containerScheme.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(self.appBarController.headerView.backgroundColor,
                        self.containerScheme.colorScheme.primaryColor);
  XCTAssertEqualObjects(self.appBarController.navigationBar.leadingBarItemsTintColor,
                        self.containerScheme.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(self.appBarController.navigationBar.trailingBarItemsTintColor,
                        self.containerScheme.colorScheme.onPrimaryColor);
  if ([self.appBarController.headerView.shadowLayer isKindOfClass:[MDCShadowLayer class]]) {
    MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.appBarController.headerView.shadowLayer;
    XCTAssertEqualWithAccuracy(shadowLayer.elevation, 0, 0.001);
  } else {
    XCTAssert(NO, @"AppBar's header view should hae a shadow layer.");
  }
}

- (void)testApplySurfaceThemeWithScheme {
  // When
  [self.appBarController applySurfaceThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.appBarController.navigationBar.titleFont,
                        self.containerScheme.typographyScheme.headline6);
  XCTAssertEqualObjects(
      self.appBarController.navigationBar.titleTextColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqualObjects(self.appBarController.headerView.backgroundColor,
                        self.containerScheme.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.appBarController.navigationBar.leadingBarItemsTintColor,
                        self.containerScheme.colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(
      self.appBarController.navigationBar.trailingBarItemsTintColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54]);
  if ([self.appBarController.headerView.shadowLayer isKindOfClass:[MDCShadowLayer class]]) {
    MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.appBarController.headerView.shadowLayer;
    XCTAssertEqualWithAccuracy(shadowLayer.elevation, 0, 0.001);
  } else {
    XCTAssert(NO, @"AppBar's header view should hae a shadow layer.");
  }
}

@end
