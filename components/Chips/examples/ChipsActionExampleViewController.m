// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "ChipsExamplesSupplemental.h"

#import <MaterialComponents/MaterialChips.h>
#import "MaterialChips+ChipThemer.h"

@implementation ChipsActionExampleViewController {
  UICollectionView *_collectionView;
  MDCChipView *_sizingChip;
  BOOL _isOutlined;
}

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
    self.shapeScheme = [[MDCShapeScheme alloc] init];
  }
  return self;
}

- (void)loadView {
  [super loadView];

  // Our preferred CollectionView Layout For chips
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;


  // Action chips should allow single selection, collection view default is based on single
  // selection. Note that MDCChipCollectionViewCell manages the state of the chip accordingly.
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

  // Since there is no scrolling turning off the delaysContentTouches makes the cells respond faster
  _collectionView.delaysContentTouches = NO;

  // Collection view setup
  _collectionView.dataSource = self;
  _collectionView.delegate = self;
  _collectionView.backgroundColor = [UIColor whiteColor];
  _collectionView.contentInset = UIEdgeInsetsMake(4, 8, 4, 8);
  [_collectionView registerClass:[MDCChipCollectionViewCell class]
      forCellWithReuseIdentifier:@"Cell"];

  if (@available(iOS 11.0, *)) {
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }

  // This is used to calculate the size of each chip based on the chip setup
  _sizingChip = [[MDCChipView alloc] init];

  [self.view addSubview:_collectionView];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _isOutlined = NO;
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Outlined Style"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(switchStyle)];
}

- (void)switchStyle {
  _isOutlined = !_isOutlined;
  NSString *buttonTitle = _isOutlined ? @"Filled Style" : @"Outlined Style";
  [self.navigationItem.rightBarButtonItem setTitle:buttonTitle];
  NSArray *indexPaths = [_collectionView indexPathsForSelectedItems];
  [_collectionView reloadData];
  for (NSIndexPath *path in indexPaths) {
    [_collectionView selectItemAtIndexPath:path
                                  animated:NO
                            scrollPosition:UICollectionViewScrollPositionNone];
  }
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
  MDCChipView *chipView = cell.chipView;

  // Customize Chip
  chipView.titleLabel.text = self.titles[indexPath.row];

  MDCChipViewScheme *scheme = [[MDCChipViewScheme alloc] init];
  scheme.colorScheme = self.colorScheme;
  scheme.shapeScheme = self.shapeScheme;

  // Apply Theming
  if (_isOutlined) {
    [MDCChipViewThemer applyOutlinedVariantWithScheme:scheme toChipView:chipView];
  } else {
    [MDCChipViewThemer applyScheme:scheme toChipView:chipView];
  }

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  // For action chips, we never want the chip to stay in selected state.
  // Other possible apporaches would be relying on theming or Customizing collectionViewCell
  // selected state.
  [collectionView deselectItemAtIndexPath:indexPath animated:NO];

  // Do the action related to the chip
  [self setTitle:[NSString stringWithFormat:@"Action %d", (int)indexPath.row]];

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  _sizingChip.titleLabel.text = self.titles[indexPath.row];
  return [_sizingChip sizeThatFits:collectionView.bounds.size];
}

- (NSArray *)titles {
  if (!_titles) {
    _titles = @[
                @"Change Title to Action 0",
                @"Change Title to Action 1",
                @"Change Title to Action 2",
                @"Change Title to Action 3",
                ];
  }
  return _titles;
}

@end

