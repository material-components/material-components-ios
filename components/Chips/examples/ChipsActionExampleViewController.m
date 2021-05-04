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

#import "MaterialChips.h"
#import "MaterialChips+Theming.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

@interface ChipsActionExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@property(nonatomic, assign, getter=isOutlined) BOOL outlined;
@end

@implementation ChipsActionExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
    _titles = @[
      @"Change Title to Action 0",
      @"Change Title to Action 1",
      @"Change Title to Action 2",
      @"Change Title to Action 3",
    ];
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

  // Action chips should allow single selection, collection view default is based on single
  // selection. Note that MDCChipCollectionViewCell manages the state of the chip accordingly.
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:layout];
  self.collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

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

  self.outlined = NO;
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Outlined Style"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(switchStyle)];

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
  [self.navigationItem.rightBarButtonItem setTitle:buttonTitle];
  NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
  [self.collectionView reloadData];
  for (NSIndexPath *path in indexPaths) {
    [self.collectionView selectItemAtIndexPath:path
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
  }
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

  // Apply Theming
  if (self.outlined) {
    [chipView applyOutlinedThemeWithScheme:self.containerScheme];
  } else {
    [chipView applyThemeWithScheme:self.containerScheme];
  }

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  // For action chips, we never want the chip to stay in selected state.
  // Other possible apporaches would be relying on theming or Customizing collectionViewCell
  // selected state.
  [collectionView deselectItemAtIndexPath:indexPath animated:NO];

  // Do the action related to the chip
  [self setTitle:[NSString stringWithFormat:@"Action %d", (int)indexPath.row]];
}

@end

@implementation ChipsActionExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Action" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
