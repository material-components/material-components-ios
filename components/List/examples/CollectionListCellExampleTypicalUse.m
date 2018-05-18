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

#import "MaterialIcons+ic_info.h"
#import "MaterialTypographyScheme.h"
#import "supplemental/CollectionListCellExampleTypicalUse.h"
#import "supplemental/CollectionViewListCell.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
static NSString *const kExampleDetailText =
    @"Pellentesque non quam ornare, porta urna sed, malesuada felis. Praesent at gravida felis, "
     "non facilisis enim. Proin dapibus laoreet lorem, in viverra leo dapibus a.";
static const CGFloat kSmallestCellHeight = 40.f;
static const CGFloat kSmallArbitraryCellWidth = 100.f;

@implementation CollectionListCellExampleTypicalUse {
  NSMutableArray *_content;
}

@synthesize collectionViewLayout = _collectionViewLayout;

- (instancetype)init {
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.minimumInteritemSpacing = 0;
  flowLayout.minimumLineSpacing = 1;
  flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  flowLayout.estimatedItemSize = CGSizeMake(kSmallArbitraryCellWidth, kSmallestCellHeight);
  return [self initWithCollectionViewLayout:flowLayout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _collectionViewLayout = layout;
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = UIColor.whiteColor;
  self.collectionView.alwaysBounceVertical = YES;
  self.automaticallyAdjustsScrollViewInsets = NO;
  self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }
#endif
  // Register cell class.
  [self.collectionView registerClass:[CollectionViewListCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content with array of text, details text, and number of lines.
  _content = [NSMutableArray array];
  NSDictionary *alignmentValues = @{
    @"Left" : @(NSTextAlignmentLeft),
    @"Right" : @(NSTextAlignmentRight),
    @"Center" : @(NSTextAlignmentCenter),
    @"Just." : @(NSTextAlignmentJustified),
    @"Natural" : @(NSTextAlignmentNatural)
  };

  for (NSString *alignmentKey in alignmentValues) {
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Single line text", alignmentKey],
      alignmentValues[alignmentKey],
      @"",
      alignmentValues[alignmentKey]
    ]];
    [_content addObject:@[
      @"",
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) Single line detail text", alignmentKey],
      alignmentValues[alignmentKey]
    ]];
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Two line text", alignmentKey],
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) Here is the detail text", alignmentKey],
      alignmentValues[alignmentKey]
    ]];
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Two line text (truncated)", alignmentKey],
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) %@", alignmentKey, kExampleDetailText],
      alignmentValues[alignmentKey]
    ]];
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Three line text (wrapped)", alignmentKey],
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) %@", alignmentKey, kExampleDetailText],
      alignmentValues[alignmentKey]
    ]];
  }

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_content count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CollectionViewListCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  [cell applyTypographyScheme:_typographyScheme];
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  CGFloat cellWidth = CGRectGetWidth(collectionView.bounds);
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    cellWidth -=
        (collectionView.adjustedContentInset.left + collectionView.adjustedContentInset.right);
  }
#endif
  [cell setCellWidth:cellWidth];
  cell.titleLabel.text = _content[indexPath.item][0];
  cell.titleLabel.textAlignment = [_content[indexPath.item][1] integerValue];
  cell.detailsTextLabel.text = _content[indexPath.item][2];
  cell.detailsTextLabel.textAlignment = [_content[indexPath.item][3] integerValue];
  if (indexPath.item % 3 == 0) {
    [cell setImage:[MDCIcons imageFor_ic_info]];
  }
  return cell;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self.collectionView reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [self.collectionView.collectionViewLayout invalidateLayout];

  [coordinator animateAlongsideTransition:nil completion:^(__unused id context) {
    [self.collectionView.collectionViewLayout invalidateLayout];
  }];
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Lists", @"List Cell Example" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"Material Collection Lists are continuous, vertical indexes of text or images.";
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

+ (BOOL)catalogIsDebug {
  return NO;
}

@end
