/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "BottomSheetDummyCollectionViewController.h"

@interface BottomSheetDummyCollectionViewController () <UICollectionViewDataSource>
@end

@interface DummyCollectionViewCell : UICollectionViewCell
@end

@implementation BottomSheetDummyCollectionViewController {
  NSInteger _numItems;
  UICollectionViewFlowLayout *_layout;
}

- (instancetype)initWithNumItems:(NSInteger)numItems {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _numItems = numItems;
  }
  return self;
}

- (void)loadView {
  _layout = [[UICollectionViewFlowLayout alloc] init];
  _layout.minimumInteritemSpacing = 0;
  _layout.minimumLineSpacing = 0;

  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:_layout];
  collectionView.backgroundColor = [UIColor whiteColor];
  [collectionView registerClass:[DummyCollectionViewCell class]
     forCellWithReuseIdentifier:NSStringFromClass([DummyCollectionViewCell class])];
  collectionView.dataSource = self;
  self.view = collectionView;
}

- (void)viewWillLayoutSubviews {
  CGFloat s = self.view.frame.size.width / 3;
  _layout.itemSize = CGSizeMake(s, s);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _numItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSString *reuseIdent = NSStringFromClass([DummyCollectionViewCell class]);
  DummyCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdent forIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithWhite:(indexPath.row % 2) * 0.2 + 0.8 alpha:1.0];
  return cell;
}

@end

@implementation DummyCollectionViewCell
@end
