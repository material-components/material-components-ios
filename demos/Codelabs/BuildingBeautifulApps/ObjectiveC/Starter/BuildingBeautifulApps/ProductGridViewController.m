/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
 
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

@interface ProductGridViewController ()

@property(nonatomic) IBOutlet HomeHeaderView *headerContentView;
@property(nonatomic) IBOutlet UIImageView *shrineLogo;

@end

@implementation ProductGridViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.bounds.size.height, 0);

  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
  self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
  self.styler.gridPadding = 8;
  [self updateLayout];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateLayout];
}

- (void)updateLayout {
  self.styler.gridColumnCount = 1;

  [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Target / Action

- (void)favoriteButtonDidTouch:(UIButton *)sender {
  Product *product = self.products[sender.tag];
  product.isFavorite = !product.isFavorite;
  [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
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
