// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialCollectionLayoutAttributes.h"

@interface CollectionLayoutAttributesTests : XCTestCase {
  MDCCollectionViewLayoutAttributes *_attributes;
}
@end

@implementation CollectionLayoutAttributesTests

- (void)setUp {
  [super setUp];

  NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:0];
  _attributes = [MDCCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  _attributes.editing = YES;
  _attributes.shouldShowReorderStateMask = YES;
  _attributes.shouldShowSelectorStateMask = YES;
  _attributes.shouldShowGridBackground = YES;
  _attributes.backgroundImage = [[UIImage alloc] init];
  _attributes.isGridLayout = YES;
  _attributes.sectionOrdinalPosition = (MDCCollectionViewOrdinalPosition)NSUIntegerMax;
  _attributes.separatorColor = [UIColor purpleColor];
  _attributes.separatorInset = UIEdgeInsetsMake(3, 1, 4, 5);
  _attributes.separatorLineHeight = 42;
  _attributes.shouldHideSeparators = YES;
  _attributes.willAnimateCellsOnAppearance = YES;
  _attributes.animateCellsOnAppearanceDuration = 3.145926;
  _attributes.animateCellsOnAppearanceDelay = 42;
}

- (void)tearDown {
  _attributes = nil;

  [super tearDown];
}

- (void)testCopying {
  // When
  MDCCollectionViewLayoutAttributes *copy = [_attributes copy];

  // Then
  XCTAssertEqual(_attributes.editing, copy.editing);
  XCTAssertEqual(_attributes.shouldShowReorderStateMask, copy.shouldShowReorderStateMask);
  XCTAssertEqual(_attributes.shouldShowSelectorStateMask, copy.shouldShowSelectorStateMask);
  XCTAssertEqual(_attributes.shouldShowGridBackground, copy.shouldShowGridBackground);
  XCTAssertEqualObjects(_attributes.backgroundImage, copy.backgroundImage);
  XCTAssertEqual(_attributes.isGridLayout, copy.isGridLayout);
  XCTAssertEqual(_attributes.sectionOrdinalPosition, copy.sectionOrdinalPosition);
  XCTAssertEqualObjects(_attributes.separatorColor, copy.separatorColor);
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(_attributes.separatorInset, copy.separatorInset));
  XCTAssertEqual(_attributes.separatorLineHeight, copy.separatorLineHeight);
  XCTAssertEqual(_attributes.shouldHideSeparators, copy.shouldHideSeparators);
  XCTAssertEqual(_attributes.willAnimateCellsOnAppearance, copy.willAnimateCellsOnAppearance);
  XCTAssertEqual(_attributes.animateCellsOnAppearanceDuration,
                 copy.animateCellsOnAppearanceDuration);
  XCTAssertEqual(_attributes.animateCellsOnAppearanceDelay, copy.animateCellsOnAppearanceDelay);
}

- (void)testEqualAfterCopying {
  // When
  MDCCollectionViewLayoutAttributes *copy = [_attributes copy];

  // Then
  XCTAssertEqualObjects(_attributes, copy);
}

- (void)testEqualHashesAfterCopying {
  // When
  MDCCollectionViewLayoutAttributes *copy = [_attributes copy];

  // Then
  XCTAssertEqual(_attributes.hash, copy.hash);
}

- (void)testEqualNilObject {
  // When
  _attributes.backgroundImage = nil;
  _attributes.separatorColor = nil;
  MDCCollectionViewLayoutAttributes *copy = [_attributes copy];

  // Then
  XCTAssertEqualObjects(_attributes, copy);
}

@end
