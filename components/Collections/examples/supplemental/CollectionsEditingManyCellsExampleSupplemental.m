// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "CollectionsEditingManyCellsExampleSupplemental.h"

#import "MaterialCollections.h"

@implementation CollectionsEditingManyCellsExample (Supplemental)

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Cell Editing Example (1000+)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return [self.content count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [self.content[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:kCollectionsEditingManyCellsCellIdentifierItem
                                forIndexPath:indexPath];
  cell.textLabel.text = self.content[indexPath.section][indexPath.item];
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  // If you have defined your own supplementary views, deque them here
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    MDCCollectionViewTextCell *sectionHeader = [collectionView
        dequeueReusableSupplementaryViewOfKind:kind
                           withReuseIdentifier:kCollectionsEditingManyCellsHeaderReuseIdentifier
                                  forIndexPath:indexPath];

    NSAssert(sectionHeader != nil, @"Unable to dequeue SupplementaryView");

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      sectionHeader.textLabel.text =
          [NSString stringWithFormat:@"Section %lu Header", (long)indexPath.section];
    }

    return sectionHeader;
  }

  // Otherwise, pass the kind to super to let MDCCollectionViewController handle the request
  return [super collectionView:collectionView
      viewForSupplementaryElementOfKind:kind
                            atIndexPath:indexPath];
}

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsEditing:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionViewAllowsReordering:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionViewAllowsSwipeToDismissItem:(UICollectionView *)collectionView {
  return self.editor.isEditing;
}

- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
  // First sort reverse order then remove. This is done because when we delete an index path the
  // higher rows shift down, altering the index paths of those that we would like to delete in the
  // next iteration of this loop.
  NSArray *sortedArray = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
  for (NSIndexPath *indexPath in [sortedArray reverseObjectEnumerator]) {
    [self.content[indexPath.section] removeObjectAtIndex:indexPath.item];
  }
}

- (void)collectionView:(UICollectionView *)collectionView
    willMoveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath {
  if (indexPath.section == newIndexPath.section) {
    // Exchange data within same section.
    [self.content[indexPath.section] exchangeObjectAtIndex:indexPath.item
                                         withObjectAtIndex:newIndexPath.item];
  } else {
    // Since moving to different section, first remove data from index path and insert
    // at new index path.
    id movedObject = [self.content[indexPath.section] objectAtIndex:indexPath.item];
    [self.content[indexPath.section] removeObjectAtIndex:indexPath.item];
    [self.content[newIndexPath.section] insertObject:movedObject atIndex:newIndexPath.item];
  }
}

#pragma mark UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(collectionView.bounds.size.width, MDCCellDefaultOneLineHeight);
}

@end
