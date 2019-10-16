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

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"

#import "supplemental/ChipsExampleAssets.h"

@interface ChipsCustomizedExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

@implementation ChipsCustomizedExampleViewController

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
  }
  return self;
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
  MDCChipCollectionViewCell *cell = [[MDCChipCollectionViewCell alloc] init];
  layout.estimatedItemSize = [cell intrinsicContentSize];

  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:layout];
  self.collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.allowsMultipleSelection = YES;
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.delaysContentTouches = NO;
  self.collectionView.contentInset = UIEdgeInsetsMake(4, 8, 4, 8);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"MDCChipCollectionViewCell"];

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

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"MDCChipCollectionViewCell"
                                                forIndexPath:indexPath];

  [[self class] configureChip:cell.chipView];
  cell.chipView.titleLabel.text = self.titles[indexPath.row];
  cell.chipView.selectedImageView.image = ChipsExampleAssets.doneImage;
  cell.chipView.mdc_adjustsFontForContentSizeCategory = YES;
  cell.alwaysAnimateResize = YES;
  [cell.chipView applyThemeWithScheme:self.containerScheme];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView performBatchUpdates:nil completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView performBatchUpdates:nil completion:nil];
}

@end

@implementation ChipsCustomizedExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Customized" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
