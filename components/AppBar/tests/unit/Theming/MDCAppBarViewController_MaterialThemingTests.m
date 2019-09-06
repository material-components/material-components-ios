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
  colorScheme.primaryColor = [UIColor colorWithWhite:0.9f alpha:0];
  colorScheme.primaryColorVariant = [UIColor colorWithWhite:0.8f alpha:0.1f];
  colorScheme.secondaryColor = [UIColor colorWithWhite:0.7f alpha:0.2f];
  colorScheme.errorColor = [UIColor colorWithWhite:0.6f alpha:0.3f];
  colorScheme.surfaceColor = [UIColor colorWithWhite:0.5f alpha:0.4f];
  colorScheme.backgroundColor = [UIColor colorWithWhite:0.4f alpha:0.5f];
  colorScheme.onPrimaryColor = [UIColor colorWithWhite:0.3f alpha:0.6f];
  colorScheme.onSecondaryColor = [UIColor colorWithWhite:0.2f alpha:0.7f];
  colorScheme.onSurfaceColor = [UIColor colorWithWhite:0.1f alpha:0.8f];
  colorScheme.onBackgroundColor = [UIColor colorWithWhite:0 alpha:0.9f];
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
    XCTAssertEqualWithAccuracy(shadowLayer.elevation, MDCShadowElevationAppBar, 0.001);
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
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(self.appBarController.headerView.backgroundColor,
                        self.containerScheme.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.appBarController.navigationBar.leadingBarItemsTintColor,
                        self.containerScheme.colorScheme.onSurfaceColor);
  XCTAssertEqualObjects(
      self.appBarController.navigationBar.trailingBarItemsTintColor,
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:0.54f]);
  XCTAssertNil(self.appBarController.headerView.shadowLayer);
}

@end
