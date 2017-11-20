/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MaterialTypography.h"
#import "supplemental/CollectionsAppearanceAnimationExample.h"

static const NSInteger kSectionCount = 10;
static const NSInteger kSectionItemCount = 5;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsAppearanceAnimationExample {
  NSMutableArray *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = [NSMutableArray array];
  for (NSInteger i = 0; i < kSectionCount; i++) {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger j = 0; j < kSectionItemCount; j++) {
      NSString *itemString = [NSString stringWithFormat:@"Section-%zd Item-%zd", i, j];
      [items addObject:itemString];
    }
    [_content addObject:items];
  }

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
  self.styler.shouldAnimateCellsOnAppearance = YES;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return [_content count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_content[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.section][indexPath.item];
  return cell;
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collections", @"Appearance Animation Example" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
