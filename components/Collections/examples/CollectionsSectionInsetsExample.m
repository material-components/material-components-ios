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

#import "supplemental/CollectionsSectionInsetsExampleSupplemental.h"
#import "MaterialCollections.h"

@implementation CollectionsSectionInsetsExample

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self collectionsSectionInsetsExampleCommonInit];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    [self collectionsSectionInsetsExampleCommonInit];
  }
  return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  if (self = [super initWithCollectionViewLayout:layout]) {
    [self collectionsSectionInsetsExampleCommonInit];
  }
  return self;
}

- (void)collectionsSectionInsetsExampleCommonInit {
  _content = [NSMutableArray array];
  _sectionUsesCustomInsets = [NSMutableDictionary dictionaryWithCapacity:kSectionCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = self.content[indexPath.section][indexPath.item];
  cell.accessibilityIdentifier =
      [NSString stringWithFormat:@"%ld.%ld", (long)indexPath.section, (long)indexPath.row];
  if (indexPath.row == 0) {
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchControl setOn:[self.sectionUsesCustomInsets[@(indexPath.section)] boolValue]];
    [switchControl addTarget:self
                      action:@selector(didSet:)
            forControlEvents:UIControlEventValueChanged];
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
  if ([self.sectionUsesCustomInsets[@(section)] boolValue]) {
    insets.left = MIN(40, 8 * section);
    insets.right = insets.left;
  }
  return insets;
}

#pragma mark - UIControlEventHandlers

- (void)didSet:(UISwitch *)sender {
  NSUInteger section = sender.tag;
  self.sectionUsesCustomInsets[@(section)] = @(sender.isOn);
  [self.collectionView.collectionViewLayout invalidateLayout];
}

@end
