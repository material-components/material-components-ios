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

@implementation ChipsFilterExampleViewController {
  UICollectionView *_collectionView;
  MDCChipView *_sizingChip;
  NSMutableArray *_selectedIndecies;
  BOOL _isOutlined;
}

- (id)init {
  self = [super init];
  if (self) {
    self.containerScheming = [self defaultContainerScheme];
  }
  return self;
}

- (MDCContainerScheme *)defaultContainerScheme {
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  containerScheme.shapeScheme = [[MDCShapeScheme alloc] init];
  containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
  return containerScheme;
}

- (void)loadView {
  [super loadView];

  _selectedIndecies = [NSMutableArray new];

  // Our preferred CollectionView Layout For chips
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  // Filter chips should allow multiSelection, MDCChipCollectionViewCell manages the state of the
  // chip accordingly.
  _collectionView.allowsMultipleSelection = YES;

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
  [_collectionView reloadData];
  for (NSIndexPath *path in _selectedIndecies) {
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
  chipView.selectedImageView.image =
      [[self doneImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  if (self.containerScheming.colorScheme) {
    chipView.selectedImageView.tintColor =
        [self.containerScheming.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54];
  } else {
    chipView.selectedImageView.tintColor = [self.defaultContainerScheme.colorScheme.onSurfaceColor
        colorWithAlphaComponent:(CGFloat)0.54];
  }
  chipView.selected = [_selectedIndecies containsObject:indexPath];
  cell.alwaysAnimateResize = [self shouldAnimateResize];

  if (_isOutlined) {
    if (self.containerScheming.colorScheme) {
      [chipView applyOutlinedThemeWithScheme:self.containerScheming];
    } else {
      [chipView applyOutlinedThemeWithScheme:self.defaultContainerScheme];
    }
  } else {
    if (self.containerScheming.colorScheme) {
      [chipView applyThemeWithScheme:self.containerScheming];
    } else {
      [chipView applyThemeWithScheme:self.defaultContainerScheme];
    }
  }

  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  // The size of the chip depends on title, image and selection state.
  _sizingChip.selected = [_selectedIndecies containsObject:indexPath];
  _sizingChip.titleLabel.text = self.titles[indexPath.row];
  _sizingChip.selectedImageView.image = [self doneImage];
  return [_sizingChip sizeThatFits:collectionView.bounds.size];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [_selectedIndecies addObject:indexPath];
  // Animating Chip Selection
  [collectionView performBatchUpdates:nil completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  [_selectedIndecies removeObject:indexPath];
  // Animating Chip Deselection
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

- (BOOL)shouldAnimateResize {
  return NO;
}

@end
