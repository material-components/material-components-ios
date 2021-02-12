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

#import "CardsCollectionExample.h"

#import "MaterialCards.h"
#import "MaterialCards+Theming.h"
#import "UICollectionViewController+MDCCardReordering.h"
#import "MaterialContainerScheme.h"

@interface CardsCollectionExample ()

@end

@implementation CardsCollectionExample

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
@synthesize collectionViewLayout = _collectionViewLayout;

- (instancetype)init {
  UICollectionViewFlowLayout *defaultLayout = [[UICollectionViewFlowLayout alloc] init];
  defaultLayout.minimumInteritemSpacing = 0;
  defaultLayout.minimumLineSpacing = 1;
  defaultLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  self = [super initWithCollectionViewLayout:defaultLayout];
  if (self) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _collectionViewLayout = layout;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];
  self.collectionView.alwaysBounceVertical = YES;
  // Register cell classes
  [self.collectionView registerClass:[MDCCardCollectionCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  [self mdc_setupCardReordering];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCardCollectionCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  [cell applyThemeWithScheme:self.containerScheme];
  [cell setBackgroundColor:[UIColor colorWithRed:107 / (CGFloat)255
                                           green:63 / (CGFloat)255
                                            blue:238 / (CGFloat)255
                                           alpha:1]];
  return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat cardSize = (self.view.bounds.size.width / 3) - 12;
  return CGSizeMake(cardSize, cardSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                                 layout:(UICollectionViewLayout *)collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                                      layout:(UICollectionViewLayout *)collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 8;
}

#pragma mark - Reordering

- (void)collectionView:(UICollectionView *)collectionView
    moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
            toIndexPath:(NSIndexPath *)destinationIndexPath {
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Cards", @"Collection Card Cells" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
    @"skip_snapshots" : @YES,  // Crashing with 'NSInternalInconsistencyException', reason: 'layout
                               // cannot be nil in setCollectionViewLayout:'
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
