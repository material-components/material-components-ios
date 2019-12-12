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

#import "supplemental/CollectionsCellAccessoryExample.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsCellAccessoryExample {
  NSArray *_accessoryTypes;
  NSMutableArray<NSArray *> *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Array of available accessory types.
  _accessoryTypes = @[
    @(MDCCollectionViewCellAccessoryDisclosureIndicator),
    @(MDCCollectionViewCellAccessoryCheckmark), @(MDCCollectionViewCellAccessoryDetailButton),
    @(MDCCollectionViewCellAccessoryNone), @(MDCCollectionViewCellAccessoryNone)
  ];

  // Populate content.
  _content = [NSMutableArray array];
  [_content addObject:@[ @"Enable Editing" ]];
  [_content addObject:@[
    @"Disclosure Indicator", @"Checkmark", @"Detail Button", @"Custom Accessory View",
    @"No Accessory View"
  ]];

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

  // Add accessory views.
  if (indexPath.section == 0) {
    // Add switch as accessory view.
    UISwitch *editingSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [editingSwitch addTarget:self
                      action:@selector(didSwitch:)
            forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = editingSwitch;
  } else {
    cell.accessoryType = [_accessoryTypes[indexPath.item] unsignedIntegerValue];
  }

  return cell;
}

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsEditing:(UICollectionView *)collectionView {
  return NO;
}

- (BOOL)collectionViewAllowsReordering:(UICollectionView *)collectionView {
  return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canEditItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.section != 0);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.section != 0);
}

#pragma mark - UIControlEvents

- (void)didSwitch:(id)sender {
  UISwitch *switchControl = sender;
  [self.editor setEditing:switchControl.isOn animated:YES];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Cell Accessory Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
