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

#import "../../src/private/MDCBottomNavigationItemView.h"
#import "MaterialSnapshot.h"

static const CGFloat kFakeWidth = 500;
static const CGFloat kFakeHeight = 75;

@interface MDCBottomNavigationThemingSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCBottomNavigationBar *bottomNavigationBar;
@property(nonatomic, strong) UITabBarItem *tabItem1;
@property(nonatomic, strong) UITabBarItem *tabItem2;
@property(nonatomic, strong) UITabBarItem *tabItem3;
@end

@implementation MDCBottomNavigationThemingSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  CGSize imageSize = CGSizeMake(24, 24);
  self.tabItem1 = [[UITabBarItem alloc]
      initWithTitle:@"Item 1"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleEllipses]
                tag:1];
  self.tabItem2 = [[UITabBarItem alloc]
      initWithTitle:@"Item 2"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleCheckerboard]
                tag:2];
  self.tabItem3 = [[UITabBarItem alloc]
      initWithTitle:@"Item 3"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleFramedX]
                tag:3];
  self.bottomNavigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.bottomNavigationBar.frame = CGRectMake(0, 0, kFakeWidth, kFakeHeight);
  self.bottomNavigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
}

- (void)tearDown {
  self.bottomNavigationBar = nil;
  self.tabItem1 = nil;
  self.tabItem2 = nil;
  self.tabItem3 = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.bottomNavigationBar mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)performInkTouchOnBar:(MDCBottomNavigationBar *)navigationBar item:(UITabBarItem *)item {
  [navigationBar layoutIfNeeded];
  MDCBottomNavigationItemView *itemView =
      (MDCBottomNavigationItemView *)[self.bottomNavigationBar viewForItem:item];
  [itemView.inkView startTouchBeganAtPoint:CGPointMake(CGRectGetMidX(itemView.bounds),
                                                       CGRectGetMidY(itemView.bounds))
                                  animated:NO
                            withCompletion:nil];
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

- (void)testPrimaryThemeWithDefaultContainerScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [bottomNav applyPrimaryThemeWithScheme:containerScheme];
  [self performInkTouchOnBar:bottomNav item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
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
  [self generateAndVerifySnapshot];
}

- (void)testSurfaceThemeWithDefaultScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [bottomNav applySurfaceThemeWithScheme:containerScheme];
  [self performInkTouchOnBar:bottomNav item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
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
  [self generateAndVerifySnapshot];
}

@end
