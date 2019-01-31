// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "supplemental/CollectionCellsTextWithImageController.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
static NSString *const kExampleText =
    @"Pellentesque non quam ornare, porta urna sed, malesuada felis. Praesent at gravida felis, "
     "non facilisis enim. Proin dapibus laoreet lorem, in viverra leo dapibus a.";

static const NSUInteger kRowCount = 22;

@implementation CollectionCellsTextWithImageController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return kRowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = kExampleText;

  if (indexPath.item % 3 == 2) {
    NSBundle *bundle = [NSBundle bundleForClass:[CollectionCellsTextWithImageController class]];
    UIImage *cellImage = [UIImage imageNamed:@"SixtyThreexSixtyThree"
                                    inBundle:bundle
               compatibleWithTraitCollection:nil];
    cell.imageView.image = cellImage;
  } else if (indexPath.item % 3 == 1) {
    NSBundle *bundle = [NSBundle bundleForClass:[CollectionCellsTextWithImageController class]];
    UIImage *cellImage = [UIImage imageNamed:@"FortyxForty"
                                    inBundle:bundle
               compatibleWithTraitCollection:nil];
    cell.imageView.image = cellImage;
  } else {
    cell.imageView.image = nil;
  }

  return cell;
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  return MDCCellDefaultOneLineHeight;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collection Cells", @"Cell Text with Image Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
