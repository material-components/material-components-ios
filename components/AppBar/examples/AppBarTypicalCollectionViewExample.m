// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

@interface AppBarTypicalCollectionViewExample : UICollectionViewController

// Step 1: Create an App Bar.
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;

@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end
@implementation AppBarTypicalCollectionViewExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  self = [super initWithCollectionViewLayout:layout];

  if (self) {
    self.title = @"App Bar";

    // Step 2: Initialize the App Bar and add the headerViewController as a child.
    _appBarViewController = [[MDCAppBarViewController alloc] init];

    // Behavioral flags.
    _appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
    _appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

    [self addChildViewController:_appBarViewController];
    _appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Collection view setup
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.contentInset = UIEdgeInsetsMake(4, 8, 4, 8);
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  // Recommended step: Set the tracking scroll view.
  MDCFlexibleHeaderView *headerView = self.appBarViewController.headerView;
  headerView.trackingScrollView = self.collectionView;
  headerView.minimumHeight = 64;
  headerView.maximumHeight = 200;

  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:_appBarViewController];
  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                         forIndexPath:indexPath];
  switch (indexPath.row % 3) {
    case 0:
      cell.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.2 alpha:1];
      break;
    case 1:
      cell.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:1];
      break;
    case 2:
      cell.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.7 alpha:1];
      break;
    default:
      break;
  }

  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGRect collectionViewFrame = collectionView.frame;
  return CGSizeMake(collectionViewFrame.size.width / 2 - 14, 40);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

@end

@implementation AppBarTypicalCollectionViewExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"Collection View with App bar" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
