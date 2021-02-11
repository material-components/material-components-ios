// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "supplemental/CollectionsHeaderFooterExample.h"
#import "MaterialCollections.h"

static const NSInteger kSectionCount = 3;
static const NSInteger kSectionItemCount = 2;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsHeaderFooterExample {
  NSMutableArray<NSMutableArray *> *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Register header.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:UICollectionElementKindSectionHeader];

  // Register footer.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:UICollectionElementKindSectionFooter];

  // Populate content.
  _content = [NSMutableArray array];
  for (NSInteger i = 0; i < kSectionCount; i++) {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger j = 0; j < kSectionItemCount; j++) {
      NSString *itemString = [NSString stringWithFormat:@"Section-%ld Item-%ld", (long)i, (long)j];
      [items addObject:itemString];
    }
    [_content addObject:items];
  }

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return [_content count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_content[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.section][indexPath.item];
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *supplementaryView =
      [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                         withReuseIdentifier:kind
                                                forIndexPath:indexPath];

  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    if (indexPath.section == 0) {
      supplementaryView.textLabel.text = @"Section with only header";
    } else {
      supplementaryView.textLabel.text = @"Section header";
    }
  } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    if (indexPath.section == 1) {
      supplementaryView.textLabel.text = @"Section with only footer";
    } else {
      supplementaryView.textLabel.text = @"Section footer";
    }
  }

  return supplementaryView;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
  if (section == 0 || section == 2) {
    return CGSizeMake(collectionView.bounds.size.width, MDCCellDefaultOneLineHeight);
  }
  return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForFooterInSection:(NSInteger)section {
  if (section > 0) {
    return CGSizeMake(collectionView.bounds.size.width, MDCCellDefaultOneLineHeight);
  }
  return CGSizeZero;
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView
    shouldHideFooterBackgroundForSection:(NSInteger)section {
  return (section == 2);
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Header / Footer Demo" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
