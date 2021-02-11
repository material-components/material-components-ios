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

#import "supplemental/CollectionsInkExample.h"
#import "MaterialCollections.h"
#import "MaterialPalettes.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsInkExample {
  NSArray *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = @[
    @"Default ink color", @"Custom blue ink color", @"Custom red ink color",
    @"Ink hidden on this cell"
  ];

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.item];
  return cell;
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView
    hidesInkViewAtIndexPath:(NSIndexPath *)indexPath {
  // In this example we are not showing ink at a single cell.
  if (indexPath.item == 3) {
    return YES;
  }
  return NO;
}

- (UIColor *)collectionView:(UICollectionView *)collectionView
        inkColorAtIndexPath:(NSIndexPath *)indexPath {
  // Update cell ink colors.
  if (indexPath.item == 1) {
    return [MDCPalette.lightBluePalette.tint500 colorWithAlphaComponent:(CGFloat)0.2];
  } else if (indexPath.item == 2) {
    return [UIColor colorWithRed:1 green:0 blue:0 alpha:(CGFloat)0.2];
  }
  return nil;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Cell Ink Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
