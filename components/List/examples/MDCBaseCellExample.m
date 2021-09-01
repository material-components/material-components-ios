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

#import "MDCBaseCellExample.h"

#import "MaterialList.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

@implementation MDCBaseCellExample

- (void)viewDidLoad {
  [super viewDidLoad];
  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }
  self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self createCollectionView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self positionCollectionView];
}

- (void)createCollectionView {
  self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionViewLayout.estimatedItemSize =
      CGSizeMake(self.collectionView.bounds.size.width - 20, kArbitraryCellHeight);
  self.collectionViewLayout.minimumInteritemSpacing = 5;
  self.collectionViewLayout.minimumLineSpacing = 5;
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.collectionView registerClass:[MDCBaseCell class]
          forCellWithReuseIdentifier:kBaseCellIdentifier];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  self.numberOfCells = 100;
  [self.view addSubview:self.collectionView];
}

- (void)positionCollectionView {
  CGFloat originX = self.view.bounds.origin.x;
  CGFloat originY = self.view.bounds.origin.y;
  CGFloat width = self.view.bounds.size.width;
  CGFloat height = self.view.bounds.size.height;
  originX += self.view.safeAreaInsets.left;
  originY += self.view.safeAreaInsets.top;
  width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
  height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.collectionView.frame = frame;
  self.collectionViewLayout.estimatedItemSize =
      CGSizeMake(self.collectionView.bounds.size.width - 20, kArbitraryCellHeight);
  [self.collectionViewLayout invalidateLayout];
  [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.numberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  static NSDictionary<NSString *, UIColor *> *colorNameToColorMap;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    colorNameToColorMap = @{
      @"Red" : UIColor.redColor,
      @"Green" : UIColor.greenColor,
      @"Blue" : UIColor.blueColor,
      @"Orange" : UIColor.orangeColor,
      @"Yellow" : UIColor.yellowColor,
      @"Brown" : UIColor.brownColor,
      @"Cyan" : UIColor.cyanColor,
      @"Purple" : UIColor.purpleColor,
    };
  });
  MDCBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBaseCellIdentifier
                                                                forIndexPath:indexPath];
  cell.layer.borderColor = self.containerScheme.colorScheme.onBackgroundColor.CGColor;
  NSInteger styleIndex = (NSInteger)(indexPath.row % colorNameToColorMap.count);
  NSString *colorName = colorNameToColorMap.allKeys[styleIndex];
  cell.backgroundColor = colorNameToColorMap[colorName];
  cell.accessibilityLabel = colorName;
  cell.layer.borderWidth = 1;
  cell.enableRippleBehavior = YES;
  cell.rippleColor = [UIColor colorWithRed:0 green:(CGFloat)0 blue:(CGFloat)0 alpha:(CGFloat)0.1];
  cell.isAccessibilityElement = YES;
  cell.accessibilityLabel = [NSString stringWithFormat:@"Cell number %@", @(indexPath.item)];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCBaseCell *cell = (MDCBaseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
  cell.elevation = 10;
  cell.accessibilityTraits |= UIAccessibilityTraitSelected;
}

- (void)collectionView:(UICollectionView *)collectionView
    didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCBaseCell *cell = (MDCBaseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
  cell.elevation = 0;
  cell.accessibilityTraits &= ~UIAccessibilityTraitSelected;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"List Items", @"MDCBaseCell Example" ],
    @"description" : @"MDCBaseCell Example",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
