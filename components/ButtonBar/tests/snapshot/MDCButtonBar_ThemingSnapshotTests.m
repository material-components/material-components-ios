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

#import <UIKit/UIKit.h>

#import "MaterialButtonBar+Theming.h"
#import "MaterialButtonBar.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

@interface MDCButtonBar_ThemingSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) UIBarButtonItem *leadingTitleItem;
@property(nonatomic, strong) UIBarButtonItem *middleTitleItem;
@property(nonatomic, strong) UIBarButtonItem *trailingTitleItem;
@property(nonatomic, strong) UIBarButtonItem *image16PointSquareItem;
@property(nonatomic, strong) UIBarButtonItem *image24PointSquareItem;
@property(nonatomic, strong) UIBarButtonItem *image32PointSquareItem;
@property(nonatomic, strong) MDCButtonBar *buttonBar;
@property(nonatomic, strong) MDCContainerScheme *defaultScheme;
@property(nonatomic, readonly, strong) MDCContainerScheme *customScheme;
@end

@implementation MDCButtonBar_ThemingSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.buttonBar = [[MDCButtonBar alloc] init];
  self.buttonBar.backgroundColor = UIColor.blackColor;
  self.leadingTitleItem = [[UIBarButtonItem alloc] initWithTitle:@"Lead"
                                                           style:UIBarButtonItemStylePlain
                                                          target:nil
                                                          action:NULL];
  self.middleTitleItem = [[UIBarButtonItem alloc] initWithTitle:@"Mid"
                                                          style:UIBarButtonItemStylePlain
                                                         target:nil
                                                         action:NULL];
  self.trailingTitleItem = [[UIBarButtonItem alloc] initWithTitle:@"Trail"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:NULL];
  self.buttonBar.items = @[ self.leadingTitleItem, self.middleTitleItem, self.trailingTitleItem ];

  UIImage *icon16 = [[UIImage mdc_testImageOfSize:CGSizeMake(16, 16)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image16PointSquareItem = [[UIBarButtonItem alloc] initWithImage:icon16
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:NULL];
  UIImage *icon24 = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image24PointSquareItem = [[UIBarButtonItem alloc] initWithImage:icon24
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:NULL];
  UIImage *icon32 = [[UIImage mdc_testImageOfSize:CGSizeMake(32, 32)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.image32PointSquareItem = [[UIBarButtonItem alloc] initWithImage:icon32
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:NULL];

  self.defaultScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.leadingTitleItem = nil;
  self.middleTitleItem = nil;
  self.trailingTitleItem = nil;
  self.image16PointSquareItem = nil;
  self.image24PointSquareItem = nil;
  self.image32PointSquareItem = nil;
  self.buttonBar = nil;
  self.defaultScheme = nil;

  [super tearDown];
}

- (MDCContainerScheme *)customScheme {
  MDCContainerScheme *container = [[MDCContainerScheme alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
  colorScheme.primaryColorVariant = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
  colorScheme.secondaryColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
  colorScheme.errorColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
  colorScheme.surfaceColor = [UIColor colorWithWhite:(CGFloat)0.25 alpha:1];
  colorScheme.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];
  colorScheme.onPrimaryColor = [UIColor colorWithRed:1
                                               green:(CGFloat)0.5
                                                blue:(CGFloat)0.25
                                               alpha:1];
  colorScheme.onSecondaryColor = [UIColor colorWithRed:(CGFloat)0.5
                                                 green:1
                                                  blue:(CGFloat)0.25
                                                 alpha:1];
  colorScheme.onSurfaceColor = [UIColor colorWithRed:(CGFloat)0.25
                                               green:(CGFloat)0.5
                                                blue:1
                                               alpha:1];
  colorScheme.onBackgroundColor = [UIColor colorWithRed:(CGFloat)0.25
                                                  green:0
                                                   blue:(CGFloat)0.75
                                                  alpha:1];
  container.colorScheme = colorScheme;

  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  typographyScheme.headline1 = [UIFont systemFontOfSize:30];
  typographyScheme.headline2 = [UIFont systemFontOfSize:28];
  typographyScheme.headline3 = [UIFont systemFontOfSize:26];
  typographyScheme.headline4 = [UIFont systemFontOfSize:24];
  typographyScheme.headline5 = [UIFont systemFontOfSize:22];
  typographyScheme.headline6 = [UIFont systemFontOfSize:20];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:18];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:16];
  typographyScheme.body1 = [UIFont systemFontOfSize:14];
  typographyScheme.body2 = [UIFont systemFontOfSize:12];
  typographyScheme.caption = [UIFont systemFontOfSize:10];
  typographyScheme.button = [UIFont systemFontOfSize:8];
  typographyScheme.overline = [UIFont systemFontOfSize:6];
  container.typographyScheme = typographyScheme;

  MDCShapeScheme *shapeScheme =
      [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  shapeScheme.smallComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:8];
  shapeScheme.mediumComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded andSize:16];
  shapeScheme.largeComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:24];
  container.shapeScheme = shapeScheme;

  return container;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeItemsToImages {
  self.buttonBar.items =
      @[ self.image16PointSquareItem, self.image24PointSquareItem, self.image32PointSquareItem ];
}

#pragma mark - Tests

- (void)testDefaultSchemeWithTitles {
  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [self.buttonBar applyPrimaryThemeWithScheme:self.defaultScheme];
#pragma clang diagnostic pop
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testDefaultSchemeWithImages {
  // Given
  [self changeItemsToImages];

  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [self.buttonBar applyPrimaryThemeWithScheme:self.defaultScheme];
#pragma clang diagnostic pop
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testCustomSchemeWithTitles {
  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [self.buttonBar applyPrimaryThemeWithScheme:self.customScheme];
#pragma clang diagnostic pop
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

- (void)testCustomSchemeWithImages {
  // Given
  [self changeItemsToImages];

  // When
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [self.buttonBar applyPrimaryThemeWithScheme:self.customScheme];
#pragma clang diagnostic pop
  [self.buttonBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.buttonBar];
}

@end
