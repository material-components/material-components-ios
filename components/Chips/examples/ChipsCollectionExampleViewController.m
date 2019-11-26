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

@interface ChipsCollectionExampleViewController : UICollectionViewController
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@property(nonatomic) BOOL popRecognizerDelaysTouches;
@end

@implementation ChipsCollectionExampleViewController

- (instancetype)init {
  MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;
  layout.estimatedItemSize = CGSizeMake(60, 33);

  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.editing = YES;
    self.containerScheme = [[MDCContainerScheme alloc] init];
    self.titles = @[
      @"Truffaut",  @"Farm-to-table", @"XOXO",     @"Chillwave",  @"Fanny",      @"Pack",
      @"Master",    @"Cleanse",       @"Small",    @"Batch",      @"Church-key", @"Biodiesel",
      @"Subway",    @"Tile",          @"Gentrify", @"Humblebrag", @"Drinking",   @"Vinegar",
      @"Godard",    @"Pug",           @"Marfa",    @"Poutine",    @"Jianbing",   @"Fashion",
      @"Axe",       @"Banjo",         @"Vegan",    @"Taxidermy",  @"Portland",   @"Irony",
      @"Gastropub", @"Truffaut"
    ];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.delaysContentTouches = NO;
  self.collectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.chipView.titleLabel.text = self.titles[indexPath.row];
  [cell.chipView applyThemeWithScheme:self.containerScheme];
  return cell;
}

@end

@implementation ChipsCollectionExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Collections" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
