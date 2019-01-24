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

#import "supplemental/ChipsExamplesSupplemental.h"

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"
#import "MaterialContainerScheme.h"

@interface ChipsChoiceExampleViewController ()
@property(nonatomic, strong) MDCChipView *sizingChip;
@property(nonatomic, assign, getter=isOutlined) BOOL outlined;
@end

@implementation ChipsChoiceExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
    _containerScheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _containerScheme.shapeScheme = [[MDCShapeScheme alloc] init];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  self.view.backgroundColor = [UIColor whiteColor];

  // This is used to calculate the size of each chip based on the chip setup
  _sizingChip = [[MDCChipView alloc] init];

  // Our preferred CollectionView Layout For chips
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

  // Since there is no scrolling turning off the delaysContentTouches makes the cells respond faster
  _collectionView.delaysContentTouches = NO;

  // Collection view setup
  _collectionView.dataSource = self;
  _collectionView.delegate = self;
  _collectionView.backgroundColor = [UIColor whiteColor];
  _collectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
  [_collectionView registerClass:[MDCChipCollectionViewCell class]
      forCellWithReuseIdentifier:@"Cell"];

  if (@available(iOS 11.0, *)) {
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }

  [self.view addSubview:_collectionView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.sizingChip applyThemeWithScheme:self.containerScheme];

  self.outlined = NO;
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Outlined Style"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(switchStyle)];
}

- (void)switchStyle {
  self.outlined = !self.isOutlined;
  NSString *buttonTitle = self.isOutlined ? @"Filled Style" : @"Outlined Style";
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
  chipView.enabled = indexPath.row != 2;
  cell.userInteractionEnabled = indexPath.row != 2;

  if (self.isOutlined) {
    [chipView applyOutlinedThemeWithScheme:[self containerScheme]];
  } else {
    [chipView applyThemeWithScheme:[self containerScheme]];
  }

  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  // The size of the chip depends on title here.
  self.sizingChip.titleLabel.text = self.titles[indexPath.row];
  return [self.sizingChip sizeThatFits:collectionView.bounds.size];
}

- (NSArray *)titles {
  if (!_titles) {
    _titles = @[
      @"The Bronx",
      @"Brooklyn",
      @"Manhattan",
      @"Queens",
      @"Staten Island",
    ];
  }
  return _titles;
}

@end
