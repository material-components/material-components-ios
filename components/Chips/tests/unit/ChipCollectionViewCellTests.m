// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialChips.h"

#import <XCTest/XCTest.h>

@interface ChipCollectionViewCellTests : XCTestCase
@property(nonatomic, nullable) MDCChipCollectionViewCell *chipCell;
@end

@implementation ChipCollectionViewCellTests

- (void)setUp {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:layout];
  [collectionView registerClass:[MDCChipCollectionViewCell class]
      forCellWithReuseIdentifier:@"cell"];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  self.chipCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                            forIndexPath:indexPath];
}

- (void)tearDown {
  self.chipCell = nil;
}

- (void)testChipCellsAreSelectableAndHighlightable {
  // Then (Before)
  XCTAssertFalse(self.chipCell.selected);
  XCTAssertFalse(self.chipCell.chipView.selected);

  XCTAssertFalse(self.chipCell.highlighted);
  XCTAssertFalse(self.chipCell.chipView.highlighted);

  // When
  self.chipCell.highlighted = YES;
  self.chipCell.selected = YES;

  // Then (After)
  XCTAssertTrue(self.chipCell.selected);
  XCTAssertTrue(self.chipCell.chipView.selected);

  XCTAssertTrue(self.chipCell.highlighted);
  XCTAssertTrue(self.chipCell.chipView.highlighted);
}

@end
