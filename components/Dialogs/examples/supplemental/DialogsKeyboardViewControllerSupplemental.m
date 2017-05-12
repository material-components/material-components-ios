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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "DialogsKeyboardViewControllerSupplemental.h"

#pragma mark - DialogsKeyboardViewController

static NSString * const kReusableIdentifierItem = @"cell";


@implementation DialogsKeyboardViewController (Supplemental)

- (void)loadCollectionView {
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = @"Show Dialog";
  return cell;
}

@end


@implementation DialogsKeyboardViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Dialogs", @"Text Field Dialog" ];
}

+ (NSString *)catalogDescription {
  return @"Demonstrate Material dialog controller with an input field.";
}

@end
