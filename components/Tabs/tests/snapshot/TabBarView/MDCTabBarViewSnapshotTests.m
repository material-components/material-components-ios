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

#import "MDCTabBarView.h"

<<<<<<< HEAD
/** The typical size of an image in a Tab bar. */
static const CGSize kTypicalImageSize = (CGSize){24, 24};

/** The expected height of titles-only or icons-only Tabs. */
static const CGFloat kExpectedHeightTitlesOrIconsOnly = 48;

/** The expected height of Tabs with titles and icons. */
static const CGFloat kExpectedHeightTitlesAndIcons = 72;

@interface MDCTabBarViewSnapshotTests : MDCSnapshotTestCase

/** The view being snapshotted. */
@property(nonatomic, strong) MDCTabBarView *tabBarView;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon1;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon2;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon3;

@end

@implementation MDCTabBarViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  self.recordMode = YES;

  self.tabBarView = [[MDCTabBarView alloc] init];
  self.tabBarView.backgroundColor = UIColor.whiteColor;
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesOrIconsOnly);

  self.typicalIcon1 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.typicalIcon2 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleDiagonalLines]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.typicalIcon3 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)tearDown {
  self.typicalIcon1 = nil;
  self.typicalIcon2 = nil;
  self.typicalIcon3 = nil;
  self.tabBarView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - UITabBarItem properties

- (void)testItemsWithOnlyTitles {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyImages {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon3 tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithTitlesAndImages {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithMixedTitlesAndImages {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

@end
