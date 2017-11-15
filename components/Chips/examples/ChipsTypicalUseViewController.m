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

@implementation ChipsTypicalUseViewController {
  MDCChipView *_sizingChip;
}

- (instancetype)init {
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _sizingChip = [[MDCChipView alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.delaysContentTouches = NO;
  self.collectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(clearSelected)];
}

- (void)clearSelected {
  NSArray *selectedPaths = [self.collectionView indexPathsForSelectedItems];
  for (NSIndexPath *indexPath in selectedPaths) {
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
  }
  [self.collectionView performBatchUpdates:nil completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.model.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.alwaysAnimateResize = YES;

  ChipModel *model = self.model[indexPath.row];
  [model apply:cell.chipView];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView performBatchUpdates:nil completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *selectedPaths = [collectionView indexPathsForSelectedItems];
  _sizingChip.selected = [selectedPaths containsObject:indexPath];

  ChipModel *model = self.model[indexPath.row];
  [model apply:_sizingChip];
  return [_sizingChip sizeThatFits:collectionView.bounds.size];
}

- (NSArray *)model {
  if (!_model) {
    _model = @[
      MakeModel(@"Chip", NO, YES, NO),
      MakeModel(@"Chip", YES, NO, NO),
      MakeModel(@"Chip", YES, NO, YES),
      MakeModel(@"Chip", NO, NO, YES),
      MakeModel(@"Chip", NO, YES, YES),
      MakeModel(@"Chip", YES, YES, YES),
    ];
  }
  return _model;
}

@end
