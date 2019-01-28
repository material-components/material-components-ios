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

@implementation ChipsTypicalUseViewController {
  MDCChipView *_sizingChip;
}

- (instancetype)init {
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _sizingChip = [[MDCChipView alloc] init];
    _sizingChip.mdc_adjustsFontForContentSizeCategory = YES;
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

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [_sizingChip applyThemeWithScheme:self.containerScheming];

  if (@available(iOS 11.0, *)) {
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }

  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.delaysContentTouches = NO;
  self.collectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(clearSelected)];

  NSDictionary *enabledAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
  NSDictionary *disabledAttributes =
      @{NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:0.75]};
  [self.navigationItem.rightBarButtonItem setTitleTextAttributes:enabledAttributes
                                                        forState:UIControlStateNormal];
  [self.navigationItem.rightBarButtonItem setTitleTextAttributes:disabledAttributes
                                                        forState:UIControlStateDisabled];

  self.navigationItem.rightBarButtonItem.accessibilityHint = @"Unselects all chips";
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];

  [self updateClearButton];
}

- (void)contentSizeCategoryDidChange {
  [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)clearSelected {
  NSArray *selectedPaths = [self.collectionView indexPathsForSelectedItems];
  for (NSIndexPath *indexPath in selectedPaths) {
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
  }
  [self.collectionView performBatchUpdates:nil completion:nil];
  [self updateClearButton];
}

- (void)updateClearButton {
  BOOL hasSelectedItems = [self.collectionView indexPathsForSelectedItems].count > 0;
  self.navigationItem.rightBarButtonItem.enabled = hasSelectedItems ? YES : NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.model.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.chipView.mdc_adjustsFontForContentSizeCategory = YES;
  cell.alwaysAnimateResize = YES;

  ChipModel *model = self.model[indexPath.row];
  [model apply:cell.chipView];
  [cell.chipView applyThemeWithScheme:self.containerScheming];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView performBatchUpdates:nil completion:nil];
  [self updateClearButton];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
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
