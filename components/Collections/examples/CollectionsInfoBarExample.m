/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "CollectionsInfoBarExample.h"

static const NSInteger kItemCount = 10;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsInfoBarExample {
  NSArray *_accessoryTypes;
  NSMutableArray *_content;
  BOOL _enableEditing;
  BOOL _allowsSwipeToDismiss;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collections", @"Cell InfoBar Example" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = [NSMutableArray array];
  [_content addObject:@[ @"Enable Editing", @"Enable Swipe-to-Dismiss"]];
  NSMutableArray *items = [NSMutableArray array];
  for (NSInteger i = 0; i < kItemCount; i++) {
    [items addObject:[NSString stringWithFormat:@"Item-%zd", i]];
  }
  [_content addObject:items];

  // Customize collection view settings.
  _enableEditing = NO;
  _allowsSwipeToDismiss = YES;
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

  // Add switched as accessory views.
  if (indexPath.section == 0) {
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchControl.tag = indexPath.item;
    [switchControl addTarget:self
                      action:@selector(didSwitch:)
            forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = switchControl;
    if (indexPath.item == 0) {
      switchControl.on = _enableEditing;
    } else {
      switchControl.on = _allowsSwipeToDismiss;
    }
  }

  return cell;
}

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsEditing:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canEditItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.section != 0);
}

- (BOOL)collectionViewAllowsSwipeToDismissItem:(UICollectionView *)collectionView {
  return self.editor.isEditing && _allowsSwipeToDismiss;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.section != 0);
}

- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
  NSArray *sortedArray = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
  for (NSIndexPath *indexPath in [sortedArray reverseObjectEnumerator]) {
    [_content[indexPath.section] removeObjectAtIndex:indexPath.item];
  }
}

#pragma mark - UIControlEvents

- (void)didSwitch:(id)sender {
  UISwitch *switchControl = sender;
  if (switchControl.tag == 0) {
    _enableEditing = !_enableEditing;
    [self.editor setEditing:_enableEditing animated:YES];
  } else if (switchControl.tag == 1) {
    _allowsSwipeToDismiss = !_allowsSwipeToDismiss;
  }
}

@end
