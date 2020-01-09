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

#import "MaterialBottomNavigation+Theming.h"

#import <XCTest/XCTest.h>

#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialShadowElevations.h"
#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kUnselectedPrimaryAlpha = 0.74f;
static const CGFloat kUnselectedSurfaceAlpha = 0.6f;

static UIImage *fakeImage(void) {
  CGSize imageSize = CGSizeMake(24, 24);
  UIGraphicsBeginImageContext(imageSize);
  [UIColor.whiteColor setFill];
  UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MDCBottomNavigationThemingTests : XCTestCase
@property(nonatomic, strong, nullable) MDCBottomNavigationBar *bottomNavigationBar;
@end

@implementation MDCBottomNavigationThemingTests

- (void)setUp {
  [super setUp];

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Home" image:fakeImage() tag:0];
  UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Messages"
                                                            image:fakeImage()
                                                              tag:0];
  UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Favorites"
                                                            image:fakeImage()
                                                              tag:0];
  self.bottomNavigationBar.items = @[ tabBarItem1, tabBarItem2, tabBarItem3 ];
}

- (void)tearDown {
  self.bottomNavigationBar = nil;

  [super tearDown];
}

- (void)testPrimaryThemeWithDefaultContainerScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [bottomNav applyPrimaryThemeWithScheme:containerScheme];

  // Then
  [self helperTextPrimaryThemeColorForColorScheme:containerScheme.colorScheme];
  [self helperTestItemTitleFontEqualsFont:containerScheme.typographyScheme.caption];
  [self helperTestNonsubsytemValuesForBottomNavigationBar:bottomNav];
}

- (void)testPrimaryThemeWithCustomContainerScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.typographyScheme = [self customTypographyScheme];
  containerScheme.colorScheme = [self customColorScheme];

  // When
  [bottomNav applyPrimaryThemeWithScheme:containerScheme];

  // Then
  [self helperTextPrimaryThemeColorForColorScheme:containerScheme.colorScheme];
  [self helperTestItemTitleFontEqualsFont:containerScheme.typographyScheme.caption];
  [self helperTestNonsubsytemValuesForBottomNavigationBar:bottomNav];
}

- (void)helperTextPrimaryThemeColorForColorScheme:(id<MDCColorScheming>)colorScheme {
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  XCTAssertEqualObjects(bottomNav.barTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTintColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTitleColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(
      bottomNav.unselectedItemTintColor,
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedPrimaryAlpha]);
}

- (void)testSurfaceThemeWithDefaultScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [bottomNav applySurfaceThemeWithScheme:containerScheme];

  // Then
  [self assertSecondaryThemeColorForColorScheme:containerScheme.colorScheme];
  [self helperTestItemTitleFontEqualsFont:containerScheme.typographyScheme.caption];
  [self helperTestNonsubsytemValuesForBottomNavigationBar:bottomNav];
}

- (void)testSurfaceThemeWithCustomContainerScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.typographyScheme = [self customTypographyScheme];
  containerScheme.colorScheme = [self customColorScheme];

  // When
  [bottomNav applySurfaceThemeWithScheme:containerScheme];

  // Then
  [self assertSecondaryThemeColorForColorScheme:containerScheme.colorScheme];
  [self helperTestItemTitleFontEqualsFont:containerScheme.typographyScheme.caption];
  [self helperTestNonsubsytemValuesForBottomNavigationBar:bottomNav];
}

- (void)assertSecondaryThemeColorForColorScheme:(id<MDCColorScheming>)colorScheme {
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  XCTAssertEqualObjects(bottomNav.barTintColor, colorScheme.surfaceColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTitleColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(
      bottomNav.unselectedItemTintColor,
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedSurfaceAlpha]);
}

- (void)helperTestItemTitleFontEqualsFont:(UIFont *)font {
  XCTAssertTrue([self.bottomNavigationBar.itemTitleFont mdc_isSimplyEqual:font],
                @"(%@) is not equal to (%@)", self.bottomNavigationBar.itemTitleFont, font);
}

- (void)helperTestNonsubsytemValuesForBottomNavigationBar:
    (MDCBottomNavigationBar *)bottomNavigationBar {
  XCTAssertEqual(bottomNavigationBar.elevation, MDCShadowElevationBottomNavigationBar);
  XCTAssertEqual(bottomNavigationBar.itemsContentVerticalMargin, 0);
}

- (MDCTypographyScheme *)customTypographyScheme {
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  typographyScheme.headline1 = [UIFont systemFontOfSize:10];
  typographyScheme.headline2 = [UIFont systemFontOfSize:11];
  typographyScheme.headline3 = [UIFont systemFontOfSize:12];
  typographyScheme.headline4 = [UIFont systemFontOfSize:13];
  typographyScheme.headline5 = [UIFont systemFontOfSize:14];
  typographyScheme.headline6 = [UIFont systemFontOfSize:15];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:16];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:17];
  typographyScheme.body1 = [UIFont systemFontOfSize:18];
  typographyScheme.body2 = [UIFont systemFontOfSize:19];
  typographyScheme.caption = [UIFont systemFontOfSize:20];
  typographyScheme.button = [UIFont systemFontOfSize:21];
  typographyScheme.overline = [UIFont systemFontOfSize:22];
  return typographyScheme;
}

- (MDCSemanticColorScheme *)customColorScheme {
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = UIColor.blueColor;
  colorScheme.primaryColorVariant = UIColor.greenColor;
  colorScheme.secondaryColor = UIColor.redColor;
  colorScheme.errorColor = UIColor.brownColor;
  colorScheme.surfaceColor = UIColor.cyanColor;
  colorScheme.backgroundColor = UIColor.grayColor;
  colorScheme.onPrimaryColor = UIColor.magentaColor;
  colorScheme.onSecondaryColor = UIColor.orangeColor;
  colorScheme.onSurfaceColor = UIColor.purpleColor;
  colorScheme.onBackgroundColor = UIColor.yellowColor;
  return colorScheme;
}

@end
