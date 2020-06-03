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

#import "MaterialTabs.h"

#import "MaterialSnapshot.h"

/** Snapshot tests to verify that @c MDCTabBar correctly handles selected state images .*/
@interface MDCTabBarSelectedImageSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCTabBar *tabBar;
@end

@implementation MDCTabBarSelectedImageSnapshotTests

- (void)setUp {
  [super setUp];

  UIImage *selectedImage = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                              withStyle:MDCSnapshotTestImageStyleCheckerboard];
  UIImage *unselectedImage = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                withStyle:MDCSnapshotTestImageStyleEllipses];
  UITabBarItem *selectedTabItem = [[UITabBarItem alloc] initWithTitle:@"Selected"
                                                                image:unselectedImage
                                                        selectedImage:selectedImage];
  UITabBarItem *unselectedTabItem = [[UITabBarItem alloc] initWithTitle:@"Unselected"
                                                                  image:unselectedImage
                                                          selectedImage:nil];

  self.tabBar = [[MDCTabBar alloc] init];
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.items = @[ selectedTabItem, unselectedTabItem ];
}

- (void)testTabBarItemShowsSelectedImageWhenSelected {
  // Given
  self.tabBar.frame = CGRectMake(0, 0, 250, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.selectedItem = self.tabBar.items.firstObject;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

@end
