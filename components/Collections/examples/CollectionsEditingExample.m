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

#import "supplemental/CollectionsEditingExample.h"
#import "MaterialCollections.h"

static const NSInteger kSectionCount = 10;
static const NSInteger kSectionItemCount = 5;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
static NSString *const HEADER_REUSE_IDENTIFIER = @"EditingExampleHeader";

@implementation CollectionsEditingExample {
  NSMutableArray<NSMutableArray *> *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Add button to toggle edit mode.
  [self updatedRightBarButtonItem:NO];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
  // Optional
  // Register section header class
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:HEADER_REUSE_IDENTIFIER];

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

- (void)updatedRightBarButtonItem:(BOOL)isEditing {
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:isEditing ? @"Cancel" : @"Edit"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(toggleEditMode:)];
}

- (void)toggleEditMode:(id)sender {
  BOOL isEditing = self.editor.isEditing;
  [self updatedRightBarButtonItem:!isEditing];
  [self.editor setEditing:!isEditing animated:YES];
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
  // If you have defined your own supplementary views, deque them here
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    MDCCollectionViewTextCell *sectionHeader =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:HEADER_REUSE_IDENTIFIER
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
    [_content[indexPath.section] removeObjectAtIndex:indexPath.item];
  }
}

- (void)collectionView:(UICollectionView *)collectionView
    willMoveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath {
  if (indexPath.section == newIndexPath.section) {
    // Exchange data within same section.
    [_content[indexPath.section] exchangeObjectAtIndex:indexPath.item
                                     withObjectAtIndex:newIndexPath.item];
  } else {
    // Since moving to different section, first remove data from index path and insert
    // at new index path.
    id movedObject = [_content[indexPath.section] objectAtIndex:indexPath.item];
    [_content[indexPath.section] removeObjectAtIndex:indexPath.item];
    [_content[newIndexPath.section] insertObject:movedObject atIndex:newIndexPath.item];
  }
}

#pragma mark UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(collectionView.bounds.size.width, MDCCellDefaultOneLineHeight);
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Cell Editing Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
