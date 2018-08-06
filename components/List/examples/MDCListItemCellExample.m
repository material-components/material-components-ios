/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCListItemCellExample.h"

#import "MDCListItemCell.h"

static CGFloat const kArbitraryCellHeight = 75.f;
static NSString *const kListItemCellIdentifier = @"kListItemCellIdentifier";

@interface MDCListItemCellExample () <UICollectionViewDelegate,
                                      UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;
@property (strong, nonatomic) NSArray *randomStrings;
@property (nonatomic, assign) NSInteger numberOfCells;
@end

@implementation MDCListItemCellExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self createDataSource];
  [self createCollectionView];
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self positionCollectionView];
}

- (void)createDataSource {
  self.numberOfCells = 100;
  NSMutableArray *randomStrings = [[NSMutableArray alloc] initWithCapacity:self.numberOfCells];
  for (NSInteger i = 0; i < self.numberOfCells; i++) {
    [randomStrings addObject:[self generateRandomString]];
  }
  self.randomStrings = [randomStrings mutableCopy];
}

- (void)createCollectionView {
  self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionViewLayout.estimatedItemSize = CGSizeMake(self.collectionView.bounds.size.width, kArbitraryCellHeight);
  self.collectionViewLayout.minimumInteritemSpacing = 1;
  self.collectionViewLayout.minimumLineSpacing = 0;
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.collectionView registerClass:[MDCListItemCell class]
          forCellWithReuseIdentifier:kListItemCellIdentifier];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  [self.view addSubview:self.collectionView];
}

- (void)positionCollectionView {
  CGFloat originX = self.view.bounds.origin.x;
  CGFloat originY = self.view.bounds.origin.y;
  CGFloat width = self.view.bounds.size.width;
  CGFloat height = self.view.bounds.size.height;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    originX += self.view.safeAreaInsets.left;
    originY += self.view.safeAreaInsets.top;
    width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
    height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  }
#endif
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.collectionView.frame = frame;
  self.collectionViewLayout.estimatedItemSize = CGSizeMake(self.collectionView.bounds.size.width, kArbitraryCellHeight);
  [self.collectionViewLayout invalidateLayout];
  [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.numberOfCells;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kListItemCellIdentifier
                                                                       forIndexPath:indexPath];
  cell.cellWidth = CGRectGetWidth(collectionView.bounds);
  cell.titleLabel.text = self.randomStrings[indexPath.item];
  cell.detailLabel.text = self.randomStrings[(indexPath.item + 1) % self.randomStrings.count];
  cell.leadingImageView.image = [UIImage imageNamed:@"Cake"];
  cell.trailingImageView.image = [UIImage imageNamed:@"Favorite"];
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
      NSString *characterString = [NSString stringWithFormat:@"%c", asciiCode]; // A
      [letterArray addObject:characterString];
    }
    NSString *word = [letterArray componentsJoinedByString:@""];
    [wordArray addObject:word];
  }
  return [wordArray componentsJoinedByString:@" "];
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Lists", @"Manual Layout List 3" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"Manual Layout List 3";
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

+ (BOOL)catalogIsDebug {
  return NO;
}

@end
