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
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

@interface ChipsChoiceExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@property(nonatomic, assign, getter=isOutlined) BOOL outlined;
@end

@implementation ChipsChoiceExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
    _titles = @[
      @"The Bronx",
      @"Brooklyn",
      @"Manhattan",
      @"Queens",
      @"Staten Island",
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

  self.view.backgroundColor = [UIColor whiteColor];

  // Our preferred CollectionView Layout For chips
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;
  MDCChipCollectionViewCell *cell = [[MDCChipCollectionViewCell alloc] init];
  layout.estimatedItemSize = [cell intrinsicContentSize];

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
  self.collectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;

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
  self.outlined = !self.isOutlined;
  NSString *buttonTitle = self.isOutlined ? @"Filled Style" : @"Outlined Style";
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
  chipView.enabled = indexPath.row != 2;
  cell.userInteractionEnabled = indexPath.row != 2;

  if (self.isOutlined) {
    [chipView applyOutlinedThemeWithScheme:self.containerScheme];
  } else {
    [chipView applyThemeWithScheme:self.containerScheme];
  }

  return cell;
}

@end

@implementation ChipsChoiceExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Choice" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
