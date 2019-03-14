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

#import "MaterialSnapshot.h"

#import <MaterialComponents/MaterialColorScheme.h>
#import <MaterialComponents/MaterialTypographyScheme.h>
#import "MaterialAppBar+MaterialTheming.h"
#import "MaterialContainerScheme.h"

@interface MDCAppBarViewController_MaterialThemingSnapshotTests : MDCSnapshotTestCase

/** Container scheme used for theming. */
@property(nonatomic, strong) MDCContainerScheme *customizedContainerScheme;

/** The controller being tested. */
@property(nonatomic, strong) MDCAppBarViewController *appBarController;

@end

@implementation MDCAppBarViewController_MaterialThemingSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.customizedContainerScheme = [[MDCContainerScheme alloc] init];
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
  CGSize imageSize = CGSizeMake(24, 24);
  UIBarButtonItem *trailingItem1 = [[UIBarButtonItem alloc]
      initWithImage:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleEllipses]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  UIBarButtonItem *trailingItem2 = [[UIBarButtonItem alloc]
      initWithImage:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleRectangles]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  UIBarButtonItem *leadingItem1 = [[UIBarButtonItem alloc]
      initWithImage:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleFramedX]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  UIBarButtonItem *leadingItem2 = [[UIBarButtonItem alloc]
      initWithImage:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleCheckerboard]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];

  self.appBarController.navigationBar.backItem = [[UIBarButtonItem alloc]
      initWithImage:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              style:UIBarButtonItemStylePlain
             target:nil
             action:NULL];
  self.appBarController.navigationBar.leadingBarButtonItems = @[ leadingItem1, leadingItem2 ];
  self.appBarController.navigationBar.trailingBarButtonItems = @[ trailingItem1, trailingItem2 ];
}

- (void)tearDown {
  self.customizedContainerScheme = nil;
  self.appBarController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)testApplyPrimaryThemeWithSchemeWithBaselineScheme {
  // When
  [self.appBarController applyPrimaryThemeWithScheme:[[MDCContainerScheme alloc] init]];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

- (void)testApplyPrimaryThemeWithSchemeWithCustomScheme {
  // When
  [self.appBarController applyPrimaryThemeWithScheme:self.customizedContainerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

- (void)testApplySurfaceThemeWithSchemeWithBaselineScheme {
  // When
  [self.appBarController applySurfaceThemeWithScheme:[[MDCContainerScheme alloc] init]];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

- (void)testApplySurfaceThemeWithSchemeWithCustomScheme {
  // When
  [self.appBarController applySurfaceThemeWithScheme:self.customizedContainerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBarController.view];
}

@end
