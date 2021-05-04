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

#import "MaterialChips.h"
#import "MaterialChips+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

#import "supplemental/ChipsExampleAssets.h"
#import "MaterialTypographyScheme.h"

@interface ChipsFilterExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *selectedIndicies;
@property(nonatomic, strong) UIBarButtonItem *styleButtonItem;
@property(nonatomic, strong) UIBarButtonItem *animatedButtonItem;
@property(nonatomic, assign) BOOL outlined;
@property(nonatomic, assign) BOOL animated;
@end

@implementation ChipsFilterExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
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

    _selectedIndicies = [NSMutableArray new];

    _outlined = NO;
    _styleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Outlined Style"
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(switchStyle)];
    _animatedButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Not animated"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(switchAnimation)];
    self.navigationItem.rightBarButtonItems = @[ _animatedButtonItem, _styleButtonItem ];
  }
  return self;
}

- (void)loadView {
  [super loadView];

  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  typographyScheme.useCurrentContentSizeCategoryWhenApplied = YES;
  self.containerScheme.typographyScheme = typographyScheme;

  // Our preferred CollectionView Layout For chips
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;
  MDCChipCollectionViewCell *cell = [[MDCChipCollectionViewCell alloc] init];
  layout.estimatedItemSize = [cell intrinsicContentSize];

  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:layout];
  self.collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  // Filter chips should allow multiSelection, MDCChipCollectionViewCell manages the state of the
  // chip accordingly.
  self.collectionView.allowsMultipleSelection = YES;

  // Since there is no scrolling turning off the delaysContentTouches makes the cells respond faster
  self.collectionView.delaysContentTouches = NO;

  // Collection view setup
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.contentInset = UIEdgeInsetsMake(4, 8, 4, 8);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  if (@available(iOS 11.0, *)) {
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }

  [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // When Dynamic Type changes we need to invalidate the collection view layout in order to let the
  // cells change their dimensions because our chips use manual layout.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)switchStyle {
  self.outlined = !self.outlined;
  NSString *buttonTitle = self.outlined ? @"Filled Style" : @"Outlined Style";
  self.styleButtonItem.title = buttonTitle;
  [self.collectionView reloadData];
  for (NSIndexPath *path in self.selectedIndicies) {
    [self.collectionView selectItemAtIndexPath:path
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
  }
}

- (void)switchAnimation {
  self.animated = !self.animated;
  NSString *buttonTitle = self.animated ? @"Animated" : @"Not animated";
  self.animatedButtonItem.title = buttonTitle;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  MDCChipView *chipView = cell.chipView;

  // Customize Chip
  chipView.titleLabel.text = self.titles[indexPath.row];
  chipView.selectedImageView.image =
      [ChipsExampleAssets.doneImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  if (self.containerScheme.colorScheme) {
    chipView.selectedImageView.tintColor =
        [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54];
  } else {
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    chipView.selectedImageView.tintColor =
        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54];
  }
  chipView.selected = [self.selectedIndicies containsObject:indexPath];
  cell.alwaysAnimateResize = self.animated;

  if (self.outlined) {
    [chipView applyOutlinedThemeWithScheme:self.containerScheme];
  } else {
    [chipView applyThemeWithScheme:self.containerScheme];
  }

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self.selectedIndicies addObject:indexPath];
  // Animating Chip Selection
  [collectionView performBatchUpdates:nil completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self.selectedIndicies removeObject:indexPath];
  // Animating Chip Deselection
  [collectionView performBatchUpdates:nil completion:nil];
}

@end

@implementation ChipsFilterExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Filter" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
