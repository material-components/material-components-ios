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

@implementation ChipsCollectionExampleViewController

- (instancetype)init {
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10.0f;
  layout.estimatedItemSize = CGSizeMake(60, 33);

  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.editing = YES;
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
  return cell;
}

- (NSArray *)titles {
  if (!_titles) {
    _titles = @[
      @"Truffaut",
      @"Farm-to-table",
      @"XOXO",
      @"Chillwave",
      @"Fanny",
      @"Pack",
      @"Master",
      @"Cleanse",
      @"Small",
      @"Batch",
      @"Church-key",
      @"Biodiesel",
      @"Subway",
      @"Tile",
      @"Gentrify",
      @"Humblebrag",
      @"Drinking",
      @"Vinegar",
      @"Godard",
      @"Pug",
      @"Marfa",
      @"Poutine",
      @"Jianbing",
      @"Fashion",
      @"Axe",
      @"Banjo",
      @"Vegan",
      @"Taxidermy",
      @"Portland",
      @"Irony",
      @"Gastropub",
      @"Truffaut"
    ];
  }
  return _titles;
}

@end
