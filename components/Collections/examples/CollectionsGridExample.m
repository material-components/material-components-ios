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

#import "supplemental/CollectionsGridExample.h"

static const NSInteger kSectionCount = 10;
static const NSInteger kSectionItemCount = 4;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsGridExample {
  NSMutableArray<NSMutableArray *> *_content;
  UIAlertController *_actionController;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Add button to update styles.
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Update Styles"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(presentActionController:)];

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

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
  self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
  self.styler.gridPadding = 8;
  self.styler.gridColumnCount = 2;
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

#pragma mark - Update Styles

- (void)toggleCellLayoutType {
  // Toggles between list and grid layout.
  BOOL isListLayout = (self.styler.cellLayoutType == MDCCollectionViewCellLayoutTypeList);
  self.styler.cellLayoutType =
      isListLayout ? MDCCollectionViewCellLayoutTypeGrid : MDCCollectionViewCellLayoutTypeList;
  [self.collectionView performBatchUpdates:nil completion:nil];
}

- (void)toggleCellStyle {
  // Toggles between card and grouped styles.
  BOOL isCardStyle = (self.styler.cellStyle == MDCCollectionViewCellStyleCard);
  self.styler.cellStyle =
      isCardStyle ? MDCCollectionViewCellStyleGrouped : MDCCollectionViewCellStyleCard;
  [self.collectionView performBatchUpdates:nil completion:nil];
}

#pragma mark - Action Controller

- (void)presentActionController:(id)sender {
  _actionController =
      [UIAlertController alertControllerWithTitle:@"Update Styles"
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];

  [_actionController addAction:[UIAlertAction actionWithTitle:@"Toggle List/Grid Layout"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                        [self toggleCellLayoutType];
                                                      }]];

  [_actionController addAction:[UIAlertAction actionWithTitle:@"Toggle Card/Grouped Style"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                        [self toggleCellStyle];
                                                      }]];

  [_actionController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                        [self dismissActionController];
                                                      }]];

  [self presentViewController:_actionController animated:YES completion:nil];
}

- (void)dismissActionController {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsSwipeToDismissItem:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(NSIndexPath *)indexPath {
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
    @"breadcrumbs" : @[ @"Collections", @"Grid Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
