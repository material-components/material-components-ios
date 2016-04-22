/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "CollectionsInlayExample.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsInlayExample {
  NSArray *_colors;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collections", @"Cell Inlay Example" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _colors = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Customize collection view settings.
  self.styleManager.cellStyle = MDCCollectionViewCellStyleCard;
  self.styleManager.allowsItemInlay = YES;
  self.styleManager.allowsMultipleItemInlays = YES;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _colors[indexPath.item];
  return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  BOOL isInlaid = [self.styleManager isItemInlaidAtIndexPath:indexPath];
  if (isInlaid) {
    [self.styleManager removeInlayFromItemAtIndexPath:indexPath animated:YES];
  } else {
    [self.styleManager applyInlayToItemAtIndexPath:indexPath animated:YES];
  }
}

@end
