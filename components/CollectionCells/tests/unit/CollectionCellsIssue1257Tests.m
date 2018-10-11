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

#import <XCTest/XCTest.h>

#import "MaterialCollectionCells.h"
#import "MaterialCollectionLayoutAttributes.h"

// Expose internal helper method.
@interface MDCCollectionViewCell (Private)
+ (NSString *)localizedStringWithKey:(NSString *)key;
@end

// Tests confirming that the accessibility hint for (de)selectable cells is correctly set up.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/1257
@interface CollectionCellsIssue1257Tests : XCTestCase
@property(nonatomic, strong) MDCCollectionViewCell *cell;
@property(nonatomic, strong) MDCCollectionViewLayoutAttributes *layoutAttributes;
@end

@implementation CollectionCellsIssue1257Tests

- (void)setUp {
  [super setUp];
  self.cell = [[MDCCollectionViewCell alloc] init];
  self.layoutAttributes = [[MDCCollectionViewLayoutAttributes alloc] init];
}

- (void)tearDown {
  self.cell = nil;
  self.layoutAttributes = nil;
  [super tearDown];
}

- (void)testSelectableSelected {
  self.layoutAttributes.shouldShowSelectorStateMask = YES;
  [self.cell applyLayoutAttributes:self.layoutAttributes];
  self.cell.selected = YES;

  XCTAssertEqual(self.cell.accessibilityHint,
                 [MDCCollectionViewCell localizedStringWithKey:kSelectedCellAccessibilityHintKey]);
}

- (void)testSelectableDeselected {
  self.layoutAttributes.shouldShowSelectorStateMask = YES;
  [self.cell applyLayoutAttributes:self.layoutAttributes];
  self.cell.selected = NO;

  XCTAssertEqual(
      self.cell.accessibilityHint,
      [MDCCollectionViewCell localizedStringWithKey:kDeselectedCellAccessibilityHintKey]);
}

- (void)testUnselectable {
  self.layoutAttributes.shouldShowSelectorStateMask = NO;
  [self.cell applyLayoutAttributes:self.layoutAttributes];

  XCTAssertEqual(self.cell.accessibilityHint, nil);
}

@end
