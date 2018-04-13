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

#import "ChipsExamplesSupplemental.h"

#import "MaterialChips.h"
#import "MDCChipViewColorThemer.h"

@implementation ChipsFilterExampleViewController {
  UICollectionView *_collectionView;
  MDCChipView *_sizingChip;
  MDCSemanticColorScheme *_colorScheme;
}

- (void)loadView {
  [super loadView];

  _colorScheme = [[MDCSemanticColorScheme alloc] init];

  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  _collectionView.dataSource = self;
  _collectionView.delegate = self;
  _collectionView.allowsMultipleSelection = YES;
  _collectionView.backgroundColor = [UIColor whiteColor];
  _collectionView.delaysContentTouches = NO;
  _collectionView.contentInset = UIEdgeInsetsMake(4, 8, 4, 8);
  [_collectionView registerClass:[MDCChipCollectionViewCell class]
      forCellWithReuseIdentifier:@"Cell"];

  _sizingChip = [[MDCChipView alloc] init];

  [self.view addSubview:_collectionView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  _collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.chipView.titleLabel.text = self.titles[indexPath.row];
  cell.chipView.selectedImageView.image = [self doneImage];
  cell.alwaysAnimateResize = YES;
  if (indexPath.row % 2) {
    [cell.chipView setBorderWidth:0 forState:UIControlStateNormal];
    [MDCChipViewColorThemer applySemanticColorScheme:_colorScheme toChoiceChipView:cell.chipView];
  } else {
    [cell.chipView setBorderWidth:1 forState:UIControlStateNormal];
    [MDCChipViewColorThemer applySemanticColorScheme:_colorScheme
                             toStrokedChoiceChipView:cell.chipView];
  }
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *selectedPaths = [collectionView indexPathsForSelectedItems];
  _sizingChip.selected = [selectedPaths containsObject:indexPath];
  _sizingChip.titleLabel.text = self.titles[indexPath.row];
  _sizingChip.selectedImageView.image = [self doneImage];
  return [_sizingChip sizeThatFits:collectionView.bounds.size];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView performBatchUpdates:nil completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView performBatchUpdates:nil completion:nil];
}

- (NSArray *)titles {
  if (!_titles) {
    _titles = @[
      @"Doorman",
      @"Elevator",
      @"Garage Parking",
      @"Gym",
      @"Laundry in Building",
      @"Green Building",
      @"Parking Available",
      @"Pets Allowed",
      @"Pied-a-Terre Allowed",
      @"Swimming Pool",
      @"Smoke-free",
    ];
  }
  return _titles;
}

@end

