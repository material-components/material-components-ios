/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ProductGridViewController.h"
#import "ProductCollectionViewCell.h"
#import "Product.h"
#import "HomeHeaderView.h"

#import "MaterialButtons.h"
#import "MaterialAppBar.h"
#import "MaterialSnackbar.h"

@interface ProductGridViewController ()

@property(nonatomic) MDCAppBar *appBar;
@property(nonatomic) IBOutlet HomeHeaderView *headerContentView;
@property(nonatomic) IBOutlet UIImageView *shrineLogo;

@end

@implementation ProductGridViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.bounds.size.height, 0);

  self.appBar = [[MDCAppBar alloc] init];
  [self addChildViewController:self.appBar.headerViewController];
  [self.appBar addSubviewsToParent];
  self.appBar.headerViewController.headerView.trackingScrollView = self.collectionView;
  self.appBar.headerViewController.headerView.backgroundColor = [UIColor whiteColor];
  self.appBar.headerViewController.headerView.maximumHeight = 440;
  self.appBar.headerViewController.headerView.minimumHeight = 72;

  if (self.isHome) {
    [self setupHeaderContentView];
    [self setupHeaderLogo];
  }

  self.title = self.tabBarItem.title;

  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
  self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
  self.styler.gridPadding = 8;
  [self updateLayout];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateLayout];
}

#pragma mark - Rotation and Screen size

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [self updateLayout];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self updateLayout];
}

- (void)updateLayout {
  [self sizeHeaderView];

  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    self.styler.gridColumnCount = 5;
  } else {
    switch (self.traitCollection.horizontalSizeClass) {
      case UIUserInterfaceSizeClassCompact:
        self.styler.gridColumnCount = 2;
        break;
      case UIUserInterfaceSizeClassUnspecified:
      case UIUserInterfaceSizeClassRegular:
        self.styler.gridColumnCount = 3;
        break;
    }
  }

  [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Header

- (void)setupHeaderContentView {
  [self.appBar.headerViewController.headerView addSubview:self.headerContentView];
  self.headerContentView.frame = self.appBar.headerViewController.headerView.frame;
  self.headerContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)sizeHeaderView {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  CGRect bounds = [UIScreen mainScreen].bounds;
  if (self.isHome && bounds.size.width < bounds.size.height) {
    headerView.maximumHeight = 440;
  } else {
    headerView.maximumHeight = 72;
  }
  headerView.minimumHeight = 72;
}

- (void)setupHeaderLogo {
  [self.appBar.headerViewController.headerView addSubview:self.shrineLogo];
  [self.shrineLogo.topAnchor constraintEqualToAnchor:self.shrineLogo.superview.topAnchor constant:24].active = YES;
  [self.shrineLogo.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  self.shrineLogo.translatesAutoresizingMaskIntoConstraints = NO;

  self.shrineLogo.alpha = 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.appBar.headerViewController scrollViewDidScroll:scrollView];
  CGFloat scrollOffsetY = scrollView.contentOffset.y;
  CGFloat opacity = 1.0;

  if (scrollOffsetY > -240) {
    opacity = 0;
  }

  CGFloat logoOpacity = 0.0;

  if (scrollOffsetY > -200) {
    logoOpacity = 1.0;
  }

  [UIView animateWithDuration:0.5 animations:^{
    self.headerContentView.backgroundImage.alpha = opacity;
    self.headerContentView.descLabel.alpha = opacity;
    self.headerContentView.titleLabel.alpha = opacity;

    self.shrineLogo.alpha = logoOpacity;
  }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

#pragma mark - Target / Action

- (void)favoriteButtonDidTouch:(UIButton *)sender {
  Product *product = self.products[sender.tag];
  product.isFavorite = !product.isFavorite;
  [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];

  if (product.isFavorite) {
    [MDCSnackbarManager showMessage:[MDCSnackbarMessage messageWithText:@"Added to favorites!"]];
  }
}

#pragma mark - CollectionView DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  cell.product = self.products[indexPath.item];

  cell.favoriteButton.tag = indexPath.item;
  if (![cell.favoriteButton.allTargets containsObject:self]) {
    [cell.favoriteButton addTarget:self action:@selector(favoriteButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
  }

  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.products.count;
}

#pragma mark - MDCCollectionViewStylingDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  return (collectionView.bounds.size.width - (self.styler.gridColumnCount + 1) * self.styler.gridColumnCount) * 5/4.f / self.styler.gridColumnCount;
}

@end
