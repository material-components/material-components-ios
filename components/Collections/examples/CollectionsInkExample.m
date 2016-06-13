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

#import "CollectionsInkExample.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsInkExample {
  NSArray *_content;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collections", @"Cell Ink Example" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = @[
    @"Default ink color", @"Custom blue ink color", @"Custom red ink color",
    @"Ink hidden on this cell"
  ];

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.item];
  return cell;
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView
    hidesInkViewAtIndexPath:(NSIndexPath *)indexPath {
  // In this example we are not showing ink at a single cell.
  if (indexPath.item == 3) {
    return YES;
  }
  return NO;
}

- (UIColor *)collectionView:(UICollectionView *)collectionView
        inkColorAtIndexPath:(NSIndexPath *)indexPath {
  // Update cell ink colors.
  if (indexPath.item == 1) {
    return [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];
  } else if (indexPath.item == 2) {
    return [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
  }
  return nil;
}

@end
