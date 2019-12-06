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

#import <UIKit/UIKit.h>

#import "MDCBottomNavigationBar+MaterialTheming.h"
#import "MaterialBottomNavigation.h"
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

@interface BottomNavigationBlurExample : UIViewController <UICollectionViewDataSource>

@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavBar;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIImage *blurOnIcon;
@property(nonatomic, strong) UIImage *blurOffIcon;
@end

@implementation BottomNavigationBlurExample

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)configureNavigationBar {
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.bottomNavBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;

  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Home"
                                                            image:[UIImage imageNamed:@"Home"]
                                                              tag:0];
  UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Messages"
                                                            image:[UIImage imageNamed:@"Email"]
                                                              tag:0];
  tabBarItem2.badgeValue = @"8";
  UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Favorites"
                                                            image:[UIImage imageNamed:@"Favorite"]
                                                              tag:0];
  tabBarItem3.badgeValue = @"";
  UITabBarItem *tabBarItem4 = [[UITabBarItem alloc]
      initWithTitle:@"Reader"
              image:[UIImage imageNamed:@"baseline_chrome_reader_mode_black_24pt"
                                             inBundle:[NSBundle
                                                          bundleForClass:
                                                              [BottomNavigationBlurExample class]]
                        compatibleWithTraitCollection:nil]
                tag:0];
  tabBarItem4.badgeValue = @"88";
  UITabBarItem *tabBarItem5 = [[UITabBarItem alloc] initWithTitle:@"Birthday"
                                                            image:[UIImage imageNamed:@"Cake"]
                                                              tag:0];
  tabBarItem5.badgeValue = @"888+";
  self.bottomNavBar.items = @[ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ];
  self.bottomNavBar.selectedItem = tabBarItem2;
}

- (void)configureBlurToggleButton {
  NSBundle *selfBundle = [NSBundle bundleForClass:[BottomNavigationBlurExample class]];
  self.blurOffIcon = [[UIImage imageNamed:@"baseline_blur_off_black_24pt"
                                 inBundle:selfBundle
            compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.blurOnIcon = [[UIImage imageNamed:@"baseline_blur_on_black_24pt"
                                inBundle:selfBundle
           compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithImage:nil
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(toggleBlurEffect)];
  // Updates icon and accessibility values for blur button
  [self updateBlurToggleButton];
}

- (void)applyTheming {
  [self.bottomNavBar applyPrimaryThemeWithScheme:self.containerScheme];
  self.bottomNavBar.barTintColor =
      [self.bottomNavBar.barTintColor colorWithAlphaComponent:(CGFloat)0.85];
  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  self.collectionView.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self configureBlurToggleButton];

  self.collectionView =
      [[UICollectionView alloc] initWithFrame:self.view.bounds
                         collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
  self.collectionView.dataSource = self;
  self.collectionView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:@"cell"];
  [self.view addSubview:self.collectionView];

  self.bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectZero];
  [self.view addSubview:self.bottomNavBar];
  [self configureNavigationBar];

  [self applyTheming];
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  self.collectionView.frame = CGRectStandardize(self.view.bounds);
}

- (void)layoutBottomNavBar {
  CGRect viewBounds = CGRectStandardize(self.view.bounds);
  CGSize size = [self.bottomNavBar sizeThatFits:viewBounds.size];
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
  // Extend the Bottom Navigation to the bottom of the screen.
  if (@available(iOS 11.0, *)) {
    safeAreaInsets = self.view.safeAreaInsets;
  }
  CGRect bottomNavBarFrame =
      CGRectMake(0, viewBounds.size.height - size.height - safeAreaInsets.bottom, size.width,
                 size.height + safeAreaInsets.bottom);
  self.bottomNavBar.frame = bottomNavBarFrame;
  self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, size.height, 0);
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self layoutBottomNavBar];
}

- (void)viewSafeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super viewSafeAreaInsetsDidChange];
  }
  [self layoutBottomNavBar];
}

#pragma mark - Blur effect

- (void)toggleBlurEffect {
  self.bottomNavBar.backgroundBlurEnabled = !self.bottomNavBar.isBackgroundBlurEnabled;
  [self updateBlurToggleButton];
}

- (void)updateBlurToggleButton {
  if (self.bottomNavBar.isBackgroundBlurEnabled) {
    self.navigationItem.rightBarButtonItem.image = self.blurOnIcon;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Disable blur";
    self.navigationItem.rightBarButtonItem.accessibilityHint =
        @"Disables the Bottom Navigation bar blur visual effect";

  } else {
    self.navigationItem.rightBarButtonItem.image = self.blurOffIcon;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Enable blur";
    self.navigationItem.rightBarButtonItem.accessibilityHint =
        @"Enables the Bottom Navigation bar blur visual effect";
  }
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 1000;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  static NSArray<UIColor *> *colors;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    colors = @[
      UIColor.redColor, UIColor.blueColor, UIColor.greenColor, UIColor.cyanColor, UIColor.blackColor
    ];
  });
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                         forIndexPath:indexPath];
  int colorIndex = indexPath.row % (int)colors.count;
  cell.backgroundColor = colors[colorIndex];
  return cell;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Navigation", @"Blur Effect" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
