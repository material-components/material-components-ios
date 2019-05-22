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

#import "MDCShapeExamplesDummyCollectionViewController.h"

@interface MDCShapeExamplesDummyCollectionViewController () <UICollectionViewDataSource>
@end

@interface MDCShapeExamplesDummyCollectionViewCell : UICollectionViewCell
@end

static NSString *kReuseIdentifier = @"dummyCell";

@implementation MDCShapeExamplesDummyCollectionViewController {
  NSInteger _numItems;
  UICollectionViewFlowLayout *_layout;
}

- (instancetype)initWithNumItems:(NSInteger)numItems {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing = 0;
  if (self = [super initWithCollectionViewLayout:layout]) {
    _layout = layout;

    _numItems = numItems;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.collectionView.backgroundColor = [UIColor whiteColor];

  [self.collectionView registerClass:[MDCShapeExamplesDummyCollectionViewCell class]
          forCellWithReuseIdentifier:kReuseIdentifier];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGFloat s = self.view.frame.size.width / 3;
  _layout.itemSize = CGSizeMake(s, s);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _numItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCShapeExamplesDummyCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier
                                                forIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithWhite:(indexPath.row % 2) * (CGFloat)0.2 + (CGFloat)0.8
                                           alpha:1];
  return cell;
}

@end

@implementation MDCShapeExamplesDummyCollectionViewCell
@end
