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

#import "supplemental/ChipsExamplesSupplemental.h"

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"

@implementation ChipsCustomizedExampleViewController {
  UICollectionView *_collectionView;
  MDCChipView *_sizingChip;
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

+ (void)configureChip:(MDCChipView *)chip {
  UIFont *customTitleFont = [UIFont fontWithName:@"ChalkDuster" size:14];
  chip.titleFont = customTitleFont;

  UIColor *customColor = [UIColor blueColor];
  [chip setTitleColor:customColor forState:UIControlStateNormal];
  [chip setBorderColor:customColor forState:UIControlStateNormal];
  [chip setBorderWidth:2 forState:UIControlStateNormal];
  [chip setInkColor:[customColor colorWithAlphaComponent:(CGFloat)0.2]
           forState:UIControlStateNormal];

  UIColor *customSelectedColor = [UIColor orangeColor];
  [chip setTitleColor:customSelectedColor forState:UIControlStateSelected];
  [chip setBorderColor:customSelectedColor forState:UIControlStateSelected];
  [chip setBorderWidth:4 forState:UIControlStateSelected];
  [chip setInkColor:[customSelectedColor colorWithAlphaComponent:(CGFloat)0.2]
           forState:UIControlStateSelected];
  [chip setInkColor:[customSelectedColor colorWithAlphaComponent:(CGFloat)0.2]
           forState:UIControlStateSelected | UIControlStateHighlighted];
}

- (void)loadView {
  [super loadView];

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
      forCellWithReuseIdentifier:@"MDCChipCollectionViewCell"];

  _sizingChip = [[MDCChipView alloc] init];
  [[self class] configureChip:_sizingChip];

  [self.view addSubview:_collectionView];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [_sizingChip applyThemeWithScheme:self.containerScheming];
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
      [collectionView dequeueReusableCellWithReuseIdentifier:@"MDCChipCollectionViewCell"
                                                forIndexPath:indexPath];

  [[self class] configureChip:cell.chipView];
  cell.chipView.titleLabel.text = self.titles[indexPath.row];
  cell.chipView.selectedImageView.image = [self doneImage];
  cell.alwaysAnimateResize = YES;
  [cell.chipView applyThemeWithScheme:self.containerScheming];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
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
