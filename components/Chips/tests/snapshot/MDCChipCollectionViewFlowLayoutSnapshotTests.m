// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import "MaterialChips.h"

@interface DummyCollectionViewDataSource : NSObject <UICollectionViewDataSource>
@end

@implementation DummyCollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.chipView.titleLabel.text = [NSString stringWithFormat:@"Chip %@", @(indexPath.row)];
  return cell;
}

@end

@interface MDCChipCollectionViewFlowLayoutSnapshotTests : MDCSnapshotTestCase
/** The collection view being tested. */
@property(nonatomic, strong) UICollectionView *collectionView;

/** The collection view layout being tested */
@property(nonatomic, strong) MDCChipCollectionViewFlowLayout *collectionViewLayout;

/** A simple data source for the collection view that vends a fixed number of dummy cells */
@property(nonatomic, strong) DummyCollectionViewDataSource *dataSource;
@end

@implementation MDCChipCollectionViewFlowLayoutSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  self.collectionViewLayout = [[MDCChipCollectionViewFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)
                                           collectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  MDCChipCollectionViewCell *cell = [[MDCChipCollectionViewCell alloc] init];
  self.collectionViewLayout.estimatedItemSize = [cell intrinsicContentSize];
  self.dataSource = [[DummyCollectionViewDataSource alloc] init];
  self.collectionView.dataSource = self.dataSource;
}

- (void)tearDown {
  self.collectionView = nil;
  self.collectionViewLayout = nil;
  self.dataSource = nil;

  [super tearDown];
}

- (void)testWithDefaultConfiguration {
  // Then
  [self generateSnapshotAndVerifyForView:self.collectionView];
}

- (void)testRespectsSectionInsets {
  // When
  self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.collectionView];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}
@end
