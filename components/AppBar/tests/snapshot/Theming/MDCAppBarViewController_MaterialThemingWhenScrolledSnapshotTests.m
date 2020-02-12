// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import "MaterialAppBar+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

@interface MDCAppBarViewController_MaterialThemingWhenScrolledSnapshotTests : MDCSnapshotTestCase

/** Container scheme used for theming. */
@property(nonatomic, strong) MDCContainerScheme *customizedContainerScheme;

/** The controller being tested. */
@property(nonatomic, strong) MDCAppBarViewController *appBarController;

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MDCAppBarViewController_MaterialThemingWhenScrolledSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.customizedContainerScheme = [[MDCContainerScheme alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = UIColor.cyanColor;
  colorScheme.primaryColorVariant = UIColor.redColor;
  colorScheme.secondaryColor = UIColor.blueColor;
  colorScheme.errorColor = UIColor.yellowColor;
  colorScheme.surfaceColor = UIColor.brownColor;
  colorScheme.backgroundColor = UIColor.orangeColor;
  colorScheme.onPrimaryColor = UIColor.darkGrayColor;
  colorScheme.onSecondaryColor = UIColor.lightGrayColor;
  colorScheme.onSurfaceColor = UIColor.greenColor;
  colorScheme.onBackgroundColor = UIColor.purpleColor;
  self.customizedContainerScheme.colorScheme = colorScheme;

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
  self.customizedContainerScheme.typographyScheme = typographyScheme;

  self.appBarController = [[MDCAppBarViewController alloc] init];
  self.appBarController.navigationBar.title = @"AppBar";
  self.appBarController.navigationBar.leadingItemsSupplementBackButton = YES;
  CGRect headerBounds = CGRectMake(0, 0, 640, 80);
  self.appBarController.view.bounds = headerBounds;
  self.appBarController.headerView.maximumHeight = CGRectGetHeight(headerBounds);
  [self.appBarController.headerView sizeToFit];

  CGSize imageSize = CGSizeMake(24, 24);
  UIBarButtonItem *trailingItem1 = [[UIBarButtonItem alloc]
      initWithImage:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleEllipses]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  UIBarButtonItem *trailingItem2 = [[UIBarButtonItem alloc]
      initWithImage:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleRectangles]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  UIBarButtonItem *leadingItem1 = [[UIBarButtonItem alloc]
      initWithImage:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleFramedX]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  UIBarButtonItem *leadingItem2 = [[UIBarButtonItem alloc]
      initWithImage:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleCheckerboard]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];

  self.appBarController.navigationBar.backItem = [[UIBarButtonItem alloc]
      initWithImage:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  self.appBarController.navigationBar.leadingBarButtonItems = @[ leadingItem1, leadingItem2 ];
  self.appBarController.navigationBar.trailingBarButtonItems = @[ trailingItem1, trailingItem2 ];

  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(headerBounds), 1000);
  self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(headerBounds), 250);
  self.appBarController.headerView.trackingScrollView = self.scrollView;
}

- (void)tearDown {
  self.customizedContainerScheme = nil;
  self.appBarController = nil;
  self.scrollView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)testApplyPrimaryThemeWithSchemeWithBaselineScheme {
  // Given
  [self.appBarController applyPrimaryThemeWithScheme:[[MDCContainerScheme alloc] init]];

  // When
  [self.scrollView setContentOffset:CGPointMake(0, 200) animated:NO];
  [self.appBarController.headerView trackingScrollViewDidScroll];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

- (void)testApplyPrimaryThemeWithSchemeWithCustomScheme {
  // Given
  [self.appBarController applyPrimaryThemeWithScheme:self.customizedContainerScheme];

  // When
  [self.scrollView setContentOffset:CGPointMake(0, 200) animated:NO];
  [self.appBarController.headerView trackingScrollViewDidScroll];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

- (void)testApplySurfaceThemeWithSchemeWithBaselineScheme {
  // Given
  [self.appBarController applySurfaceThemeWithScheme:[[MDCContainerScheme alloc] init]];

  // When
  [self.scrollView setContentOffset:CGPointMake(0, 200) animated:NO];
  [self.appBarController.headerView trackingScrollViewDidScroll];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

- (void)testApplySurfaceThemeWithSchemeWithCustomScheme {
  // Given
  [self.appBarController applySurfaceThemeWithScheme:self.customizedContainerScheme];

  // When
  [self.scrollView setContentOffset:CGPointMake(0, 200) animated:NO];
  [self.appBarController.headerView trackingScrollViewDidScroll];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

@end
