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
#import "MDCCollectionInfoBarView.h"

@interface MDCCollectionInfoBarViewTests : XCTestCase

@end

@implementation MDCCollectionInfoBarViewTests

- (void)testAppliesZIndexForKindHeader {
  // Given
  UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes
      layoutAttributesForSupplementaryViewOfKind:MDCCollectionInfoBarKindHeader
                                   withIndexPath:[NSIndexPath indexPathWithIndex:0]];
  MDCCollectionInfoBarView *infoBarView =
      [[MDCCollectionInfoBarView alloc] initWithFrame:CGRectZero];
  layoutAttributes.zIndex = 5;

  // When
  [infoBarView applyLayoutAttributes:layoutAttributes];

  // Then
  XCTAssertEqual(infoBarView.layer.zPosition, layoutAttributes.zIndex);
}

- (void)testAppliesZIndexForKindFooter {
  // Given
  UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes
      layoutAttributesForSupplementaryViewOfKind:MDCCollectionInfoBarKindFooter
                                   withIndexPath:[NSIndexPath indexPathWithIndex:0]];
  MDCCollectionInfoBarView *infoBarView =
      [[MDCCollectionInfoBarView alloc] initWithFrame:CGRectZero];
  layoutAttributes.zIndex = 5;

  // When
  [infoBarView applyLayoutAttributes:layoutAttributes];

  // Then
  XCTAssertEqual(infoBarView.layer.zPosition, layoutAttributes.zIndex);
}

@end
