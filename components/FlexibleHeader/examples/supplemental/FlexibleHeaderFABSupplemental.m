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

/** IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components iOS.
 */

#import "FlexibleHeaderFABSupplemental.h"

#import "MaterialFlexibleHeader.h"

static NSString * const kCell = @"cell";

@implementation FlexibleHeaderFABExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Flexible Header", @"Flexible Header with FAB" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The Flexible Header is a container view whose height and vertical offset react to"
  " UIScrollViewDelegate events.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}


@end

@implementation FlexibleHeaderFABExample (Supplemental)

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)loadCollectionView {
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) return 160;
  return 56;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
  cell.textLabel.text = @"";
  switch (indexPath.row) {
    case 0:
      break;
    case 1:
      cell.textLabel.text = @"Scroll down to shrink header.";
      break;
    case 2:
      cell.textLabel.text = @"Scroll up to reveal header.";
      break;
    case 3:
      cell.textLabel.text = @"Left-side swipe to go back.";
      break;
    default:
      break;
  }
  return cell;
}




@end
