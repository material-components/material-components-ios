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

#import "supplemental/CollectionsSwipeToDismissRowExample.h"
#import "MaterialCollections.h"

static const NSInteger kSectionCount = 10;
static const NSInteger kSectionItemCount = 5;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsSwipeToDismissRowExample {
  NSMutableArray<NSMutableArray *> *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

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

  // Insert cell that cannot be removed.
  [_content insertObject:[@[ @"This cell cannot be deleted." ] mutableCopy] atIndex:0];

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

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsSwipeToDismissItem:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(NSIndexPath *)indexPath {
  // In this example we are allowing all items to be dismissed
  // except this first section.
  if (indexPath.section == 0) {
    return NO;
  }
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
  // Remove these swiped index paths from our data.
  for (NSIndexPath *indexPath in indexPaths) {
    [_content[indexPath.section] removeObjectAtIndex:indexPath.item];
  }
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Swipe-To-Dismiss-Row Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
