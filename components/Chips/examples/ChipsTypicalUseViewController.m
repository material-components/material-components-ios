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

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"

#import "supplemental/ChipsExampleAssets.h"
#import "MaterialContainerScheme.h"

@interface ChipModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) BOOL showProfilePic;
@property(nonatomic, assign) BOOL showDoneImage;
@property(nonatomic, assign) BOOL showDeleteButton;
@end

@interface ChipsTypicalUseViewController
    : UICollectionViewController <UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSArray<ChipModel *> *model;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@property(nonatomic) BOOL popRecognizerDelaysTouches;
@property(nonatomic) CGSize chipSize;
@property(nonatomic) BOOL chipCenterVisibleArea;
@end

static ChipModel *MakeModel(NSString *title,
                            BOOL showProfilePic,
                            BOOL showDoneImage,
                            BOOL showDeleteButton) {
  ChipModel *chip = [[ChipModel alloc] init];
  chip.title = title;
  chip.showProfilePic = showProfilePic;
  chip.showDoneImage = showDoneImage;
  chip.showDeleteButton = showDeleteButton;
  return chip;
};

@implementation ChipModel
@end

@implementation ChipsTypicalUseViewController

- (instancetype)init {
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
    self.model = @[
      MakeModel(@"Chip", NO, YES, NO),
      MakeModel(@"Chip", YES, NO, NO),
      MakeModel(@"Chip", YES, NO, YES),
      MakeModel(@"Chip", NO, NO, YES),
      MakeModel(@"Chip", NO, YES, YES),
      MakeModel(@"Chip", YES, YES, YES),
    ];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

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

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  self.popRecognizerDelaysTouches =
      self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan;
  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan =
      self.popRecognizerDelaysTouches;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.chipView.mdc_adjustsFontForContentSizeCategory = YES;
  cell.alwaysAnimateResize = YES;

  ChipModel *model = self.model[indexPath.row];

  cell.chipView.enableRippleBehavior = YES;
  cell.chipView.titleLabel.text = model.title;
  cell.chipView.imageView.image = model.showProfilePic ? ChipsExampleAssets.faceImage : nil;
  cell.chipView.selectedImageView.image = model.showDoneImage ? ChipsExampleAssets.doneImage : nil;
  cell.chipView.accessoryView = model.showDeleteButton ? ChipsExampleAssets.deleteButton : nil;
  cell.chipView.centerVisibleArea = self.chipCenterVisibleArea;
  cell.chipView.hitAreaInsets = UIEdgeInsetsMake(-16, 0, -16, 0);

  [cell.chipView applyThemeWithScheme:self.containerScheme];
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
  MDCChipView *chipView = (MDCChipView *)[collectionView cellForItemAtIndexPath:indexPath];
  if (!chipView) {
    ChipModel *model = self.model[indexPath.row];
    chipView = [[MDCChipView alloc] init];
    chipView.enableRippleBehavior = YES;
    chipView.titleLabel.text = model.title;
    chipView.imageView.image = model.showProfilePic ? ChipsExampleAssets.faceImage : nil;
    chipView.selectedImageView.image = model.showDoneImage ? ChipsExampleAssets.doneImage : nil;
    chipView.accessoryView = model.showDeleteButton ? ChipsExampleAssets.deleteButton : nil;
    chipView.centerVisibleArea = self.chipCenterVisibleArea;
    [chipView applyThemeWithScheme:self.containerScheme];
  }
  CGSize chipViewSize = [chipView intrinsicContentSize];
  if (!CGSizeEqualToSize(self.chipSize, CGSizeZero)) {
    chipViewSize.height = MAX(self.chipSize.height, chipViewSize.height);
    chipViewSize.width = MAX(self.chipSize.width, chipViewSize.width);
  }
  return chipViewSize;
}

@end

@implementation ChipsTypicalUseViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Chips" ],
    @"description" : @"Chips are compact elements that represent an input, attribute, or action.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation ChipsTypicalUseViewController (SnapshotTestingByConvention)

- (void)testDefaults {
  // When
  [self.collectionView reloadData];
}

- (void)testCustomSizeWhenCenterVisibleArea {
  // Given
  self.chipSize = CGSizeMake(44, 44);
  self.chipCenterVisibleArea = YES;

  // When
  [self.collectionView reloadData];
}

@end
