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

#import "SnackbarExampleSupplemental.h"

NSString *const kSnackbarExamplesCellIdentifier = @"Cell";

@implementation SnackbarExample

- (void)setupExampleViews:(NSArray *)choices {
  self.choices = choices;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kSnackbarExamplesCellIdentifier];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.choices.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kSnackbarExamplesCellIdentifier
                                                forIndexPath:indexPath];
  cell.textLabel.text = self.choices[indexPath.row];
  cell.accessibilityTraits = cell.accessibilityTraits | UIAccessibilityTraitButton;
  cell.isAccessibilityElement = YES;
  cell.accessibilityIdentifier = cell.textLabel.text;
  cell.accessibilityLabel = cell.textLabel.text;
  return cell;
}

@end

