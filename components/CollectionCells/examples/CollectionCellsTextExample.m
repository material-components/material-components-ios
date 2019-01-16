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

#import "supplemental/CollectionCellsTextExample.h"
#import "MaterialTypography.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
static NSString *const kExampleDetailText =
    @"Pellentesque non quam ornare, porta urna sed, malesuada felis. Praesent at gravida felis, "
     "non facilisis enim. Proin dapibus laoreet lorem, in viverra leo dapibus a.";

@implementation CollectionCellsTextExample {
  NSMutableArray *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content with array of text, details text, and number of lines.
  _content = [NSMutableArray array];
  NSDictionary *alignmentValues = @{
    @"Left" : @(NSTextAlignmentLeft),
    @"Right" : @(NSTextAlignmentRight),
    @"Center" : @(NSTextAlignmentCenter),
    @"Just." : @(NSTextAlignmentJustified),
    @"Natural" : @(NSTextAlignmentNatural)
  };

  for (NSString *alignmentKey in alignmentValues) {
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Single line text", alignmentKey],
      alignmentValues[alignmentKey], @"", alignmentValues[alignmentKey],
      @(MDCCellDefaultOneLineHeight)
    ]];
    [_content addObject:@[
      @"", alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) Single line detail text", alignmentKey],
      alignmentValues[alignmentKey], @(MDCCellDefaultOneLineHeight)
    ]];
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Two line text", alignmentKey],
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) Here is the detail text", alignmentKey],
      alignmentValues[alignmentKey], @(MDCCellDefaultTwoLineHeight)
    ]];
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Two line text (truncated)", alignmentKey],
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) %@", alignmentKey, kExampleDetailText],
      alignmentValues[alignmentKey], @(MDCCellDefaultTwoLineHeight)
    ]];
    [_content addObject:@[
      [NSString stringWithFormat:@"(%@) Three line text (wrapped)", alignmentKey],
      alignmentValues[alignmentKey],
      [NSString stringWithFormat:@"(%@) %@", alignmentKey, kExampleDetailText],
      alignmentValues[alignmentKey], @(MDCCellDefaultThreeLineHeight)
    ]];
  }
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_content count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.item][0];
  cell.textLabel.textAlignment = [_content[indexPath.item][1] integerValue];
  cell.detailTextLabel.text = _content[indexPath.item][2];
  cell.detailTextLabel.textAlignment = [_content[indexPath.item][3] integerValue];

  if (indexPath.item % 5 == 4) {
    cell.detailTextLabel.numberOfLines = 2;
  }
  return cell;
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  return [_content[indexPath.item][4] floatValue];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collection Cells", @"Cell Text Example" ],
    @"description" :
        @"Material Collection Cells enables a native collection view cell to have "
        @"Material design layout and styling. It also provides editing and extensive customization "
        @"capabilities.",
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
