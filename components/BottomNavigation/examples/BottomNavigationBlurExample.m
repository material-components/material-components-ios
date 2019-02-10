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

#import "MaterialBottomNavigation+ColorThemer.h"
#import "MaterialBottomNavigation+TypographyThemer.h"
#import "MaterialBottomNavigation.h"
#import "MaterialColorScheme.h"
#import "MaterialPalettes.h"
#import "MaterialTypographyScheme.h"

@interface BottomNavigationBlurExample : UIViewController <MDCBottomNavigationBarDelegate,
                                                           UICollectionViewDelegate,
                                                           UICollectionViewDataSource>

@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, assign) int badgeCount;
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavBar;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation BottomNavigationBlurExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom Navigation";
    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  return self;
}

- (void)commonBottomNavigationTypicalUseExampleViewDidLoad {
  _bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectZero];
  _bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  _bottomNavBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  _bottomNavBar.delegate = self;
  [self.view addSubview:_bottomNavBar];

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
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  if ([tabBarItem5 respondsToSelector:@selector(badgeColor)]) {
    tabBarItem5.badgeColor = [MDCPalette cyanPalette].accent700;
  }
#pragma clang diagnostic pop
#endif
  _bottomNavBar.items = @[ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ];
  _bottomNavBar.selectedItem = tabBarItem2;

  NSBundle *selfBundle = [NSBundle bundleForClass:[BottomNavigationBlurExample class]];
  UIImage *blurEnableImage = [[UIImage imageNamed:@"baseline_blur_off_black_24pt"
                                         inBundle:selfBundle
                    compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithImage:blurEnableImage
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(toggleBlurEffect)];
  self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Enable blur";
  self.navigationItem.rightBarButtonItem.accessibilityHint =
      @"Enables the Bottom Navigation bar blur visual effect";
  self.navigationItem.rightBarButtonItem.accessibilityIdentifier = @"messages-increment-badge";
}

- (void)layoutBottomNavBar {
  CGSize size = [_bottomNavBar sizeThatFits:self.view.bounds.size];
  CGRect bottomNavBarFrame =
      CGRectMake(0, CGRectGetHeight(self.view.bounds) - size.height, size.width, size.height);
  _bottomNavBar.frame = bottomNavBarFrame;
  self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, size.height, 0);
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self commonBottomNavigationTypicalUseExampleViewDidLoad];

  [MDCBottomNavigationBarTypographyThemer applyTypographyScheme:self.typographyScheme
                                          toBottomNavigationBar:_bottomNavBar];
  [MDCBottomNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
                                           toBottomNavigation:_bottomNavBar];
  self.bottomNavBar.barTintColor = [self.bottomNavBar.barTintColor colorWithAlphaComponent:0.85];
  self.view.backgroundColor = self.colorScheme.backgroundColor;

  self.collectionView =
      [[UICollectionView alloc] initWithFrame:self.view.bounds
                         collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
  self.collectionView.backgroundColor = self.self.colorScheme.backgroundColor;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:@"cell"];
  [self.view addSubview:self.collectionView];

  [self.view bringSubviewToFront:self.bottomNavBar];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  self.collectionView.frame = CGRectStandardize(self.view.bounds);
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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)toggleBlurEffect {
  self.bottomNavBar.backgroundBlurEnabled = !self.bottomNavBar.backgroundBlurEnabled;
  NSBundle *selfBundle = [NSBundle bundleForClass:[BottomNavigationBlurExample class]];
  if (self.bottomNavBar.backgroundBlurEnabled) {
    UIImage *blurEnableImage = [[UIImage imageNamed:@"baseline_blur_on_black_24pt"
                                           inBundle:selfBundle
                      compatibleWithTraitCollection:nil]
        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.navigationItem.rightBarButtonItem.image = blurEnableImage;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Disable blur";
    self.navigationItem.rightBarButtonItem.accessibilityHint =
        @"Disables the Bottom Navigation bar blur visual effect";

  } else {
    UIImage *blurEnableImage = [[UIImage imageNamed:@"baseline_blur_off_black_24pt"
                                           inBundle:selfBundle
                      compatibleWithTraitCollection:nil]
        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.navigationItem.rightBarButtonItem.image = blurEnableImage;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Enable blur";
    self.navigationItem.rightBarButtonItem.accessibilityHint =
        @"Enables the Bottom Navigation bar blur visual effect";
  }
}

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item {
  NSLog(@"Selected Item: %@", item.title);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 100;
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

@end

@interface BottomNavigationBlurExample (CatalogByConvention)
@end

@implementation BottomNavigationBlurExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Navigation", @"Blur Effect" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
