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

#import "FeatureHighlightColorExample.h"

#import "MaterialFeatureHighlight.h"
#import "MaterialPalettes.h"

@interface FeatureHighlightColorExample ()
@end

@implementation FeatureHighlightColorExample {
  NSArray *_colors;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:reuseIdentifier];

  _colors = @[
    [MDCPalette redPalette].tint500,
    [MDCPalette pinkPalette].tint500,
    [MDCPalette purplePalette].tint500,
    [MDCPalette deepPurplePalette].tint500,
    [MDCPalette indigoPalette].tint500,
    [MDCPalette bluePalette].tint500,
    [MDCPalette lightBluePalette].tint500,
    [MDCPalette cyanPalette].tint500,
    [MDCPalette tealPalette].tint500,
    [MDCPalette greenPalette].tint500,
    [MDCPalette lightGreenPalette].tint500,
    [MDCPalette limePalette].tint500,
    [MDCPalette yellowPalette].tint500,
    [MDCPalette amberPalette].tint500,
    [MDCPalette orangePalette].tint500,
    [MDCPalette deepOrangePalette].tint500,
    [MDCPalette brownPalette].tint500,
    [MDCPalette greyPalette].tint500,
    [MDCPalette blueGreyPalette].tint500,
  ];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Feature Highlight", @"Colors" ];
}

+ (NSString *)catalogDescription {
  return @"Boop ba doop dee doo.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                forIndexPath:indexPath];

  UIView *accessory = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  accessory.backgroundColor = _colors[indexPath.row];
  cell.accessoryView = accessory;

  return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell = (MDCCollectionViewTextCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
  MDCFeatureHighlightViewController *highlightController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:cell.accessoryView
                                                              completion:nil];
  highlightController.outerHighlightColor = cell.accessoryView.backgroundColor;
  [self presentViewController:highlightController animated:YES completion:nil];
}

@end
