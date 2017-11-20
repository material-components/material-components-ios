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

#import "supplemental/CollectionsCellColorExample.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsCellColorExample {
  NSMutableArray *_content;
  NSArray *_cellBackgroundColors;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Array of cell background colors.
  _cellBackgroundColors = @[
    [UIColor colorWithWhite:0 alpha:0.2],
    [UIColor colorWithRed:(CGFloat)0x39 / (CGFloat)255
                    green:(CGFloat)0xA4 / (CGFloat)255
                     blue:(CGFloat)0xDD / (CGFloat)255
                    alpha:1],
    [UIColor whiteColor]
  ];

  // Populate content.
  _content = [NSMutableArray array];
  [_content addObject:@[
    @"[UIColor colorWithWhite:0 alpha:0.2]", @"Custom Blue Color", @"Default White Color"
  ]];

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
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

#pragma mark - <MDCCollectionViewStylingDelegate>

- (UIColor *)collectionView:(UICollectionView *)collectionView
    cellBackgroundColorAtIndexPath:(NSIndexPath *)indexPath {
  return _cellBackgroundColors[indexPath.item];
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collections", @"Cell Color Example" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
