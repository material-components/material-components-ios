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

#import "MDCSelfSizingStereoCellExample.h"

#import "MDCSelfSizingStereoCell.h"

static CGFloat const kArbitraryCellHeight = 75.f;
static NSString *const kSelfSizingStereoCellIdentifier = @"kSelfSizingStereoCellIdentifier";
static NSString *const kSelfSizingStereoCellExampleComponent = @"List Items";
static NSString *const kSelfSizingStereoCellExampleDescription =
    @"Self Sizing Stereo Cell Typical Use";

@interface MDCSelfSizingStereoCellExample () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property(nonatomic, strong) NSArray *randomStrings;
@property(nonatomic, assign) NSInteger numberOfCells;
@end

@implementation MDCSelfSizingStereoCellExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self createDataSource];
  [self createCollectionView];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self positionCollectionView];
}

- (void)createDataSource {
  self.numberOfCells = 100;
  NSMutableArray *randomStrings = [[NSMutableArray alloc] initWithCapacity:self.numberOfCells];
  for (NSInteger i = 0; i < self.numberOfCells; i++) {
    [randomStrings addObject:[self generateRandomString]];
  }
  self.randomStrings = [randomStrings copy];
}

- (void)createCollectionView {
  self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionViewLayout.estimatedItemSize =
      CGSizeMake(self.collectionView.bounds.size.width, kArbitraryCellHeight);
  self.collectionViewLayout.minimumInteritemSpacing = 1;
  self.collectionViewLayout.minimumLineSpacing = 0;
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.collectionView registerClass:[MDCSelfSizingStereoCell class]
          forCellWithReuseIdentifier:kSelfSizingStereoCellIdentifier];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  [self.view addSubview:self.collectionView];
}

- (void)positionCollectionView {
  CGFloat originX = self.view.bounds.origin.x;
  CGFloat originY = self.view.bounds.origin.y;
  CGFloat width = self.view.bounds.size.width;
  CGFloat height = self.view.bounds.size.height;
  if (@available(iOS 11.0, *)) {
    originX += self.view.safeAreaInsets.left;
    originY += self.view.safeAreaInsets.top;
    width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
    height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  }
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.collectionView.frame = frame;
  self.collectionViewLayout.estimatedItemSize =
      CGSizeMake(self.collectionView.bounds.size.width, kArbitraryCellHeight);
  [self.collectionViewLayout invalidateLayout];
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
  MDCSelfSizingStereoCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kSelfSizingStereoCellIdentifier
                                                forIndexPath:indexPath];
  cell.titleLabel.text = self.randomStrings[indexPath.item];
  cell.detailLabel.text = self.randomStrings[(indexPath.item + 1) % self.randomStrings.count];
  cell.titleLabel.textColor = [UIColor darkGrayColor];
  cell.detailLabel.textColor = [UIColor darkGrayColor];
  cell.leadingImageView.image =
      [[UIImage imageNamed:@"Cake"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  cell.trailingImageView.image =
      [[UIImage imageNamed:@"Favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  cell.leadingImageView.tintColor = [UIColor darkGrayColor];
  cell.trailingImageView.tintColor = [UIColor darkGrayColor];
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  return cell;
}

- (NSString *)generateRandomString {
  NSInteger numberOfWords = 0 + arc4random() % (25 - 0);
  NSMutableArray *wordArray = [[NSMutableArray alloc] initWithCapacity:numberOfWords];
  for (NSInteger i = 0; i < numberOfWords; i++) {
    NSInteger lengthOfWord = 0 + arc4random() % (10 - 0);
    NSMutableArray *letterArray = [[NSMutableArray alloc] initWithCapacity:lengthOfWord];
    for (NSInteger j = 0; j < lengthOfWord; j++) {
      int asciiCode = 97 + arc4random() % (122 - 97);
      NSString *characterString = [NSString stringWithFormat:@"%c", asciiCode];
      [letterArray addObject:characterString];
    }
    NSString *word = [letterArray componentsJoinedByString:@""];
    [wordArray addObject:word];
  }
  return [wordArray componentsJoinedByString:@" "];
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ kSelfSizingStereoCellExampleComponent, kSelfSizingStereoCellExampleDescription ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return kSelfSizingStereoCellExampleDescription;
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

+ (BOOL)catalogIsDebug {
  return NO;
}

@end
