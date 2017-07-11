/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
#import "CollectionsSectionInsetsExample.h"

static const NSInteger kSectionCount = 5;
static const NSInteger kSectionItemCount = 3;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsSectionInsetsExample {
  NSMutableArray *_content;
  NSMutableDictionary *_sectionUsesCustomInsets;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collections", @"Custom Section Insets" ];
}

+ (NSString *)catalogDescription {
  return @"Demonstration of customizing section insets in Material Collections views.";
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Custom Section Insets";
  self.collectionView.accessibilityIdentifier = @"collectionsCustomSectionInsetsCollectionView";

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = [NSMutableArray array];
  _sectionUsesCustomInsets = [NSMutableDictionary dictionaryWithCapacity:kSectionCount];
  for (NSInteger i = 0; i < kSectionCount; i++) {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger j = 0; j < kSectionItemCount; j++) {
      NSString *itemString = [NSString stringWithFormat:@"Section-%zd Item-%zd", i, j];
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
  cell.accessibilityIdentifier = [NSString stringWithFormat:@"%ld.%ld", indexPath.section, indexPath.row];
  if (indexPath.row == 0) {
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchControl setOn:[_sectionUsesCustomInsets[@(indexPath.section)] boolValue]];
    [switchControl addTarget:self action:@selector(didSet:) forControlEvents:UIControlEventValueChanged];
    switchControl.tag = indexPath.section;

    cell.accessoryView = switchControl;
  }

  return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  UIEdgeInsets insets = [super collectionView:collectionView
                                       layout:collectionViewLayout
                       insetForSectionAtIndex:section];
  if ([_sectionUsesCustomInsets[@(section)] boolValue]) {
    insets.left = MIN(40, 8 * section);
    insets.right = insets.left;
  }
  return insets;
}

#pragma mark - UIControlEventHandlers

- (void)didSet:(id)sender {
  UISwitch *switchControl = (UISwitch *)sender;
  NSUInteger section = switchControl.tag;
  _sectionUsesCustomInsets[@(section)] = @(switchControl.isOn);
  [self.collectionView.collectionViewLayout invalidateLayout];
}

@end
