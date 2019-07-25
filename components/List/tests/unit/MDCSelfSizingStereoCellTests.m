// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialList.h"

#import <XCTest/XCTest.h>

#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

@interface MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow : UIWindow

/** Used to override the value of @c preferredContentSizeCategory. */
@property(nonatomic, copy) UIContentSizeCategory contentSizeCategoryOverride;

@end

@implementation MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow

- (instancetype)init {
  self = [super init];
  if (self) {
    self.contentSizeCategoryOverride = UIContentSizeCategoryLarge;
  }
  return self;
}

- (instancetype)initWithContentSizeCategoryOverride:
    (UIContentSizeCategory)contentSizeCategoryOverride {
  self = [super init];
  if (self) {
    self.contentSizeCategoryOverride = contentSizeCategoryOverride;
  }
  return self;
}

- (UITraitCollection *)traitCollection {
  if (@available(iOS 10.0, *)) {
    UITraitCollection *traitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:self.contentSizeCategoryOverride];
    return traitCollection;
  }
  return [super traitCollection];
}

@end

@interface MDCSelfSizingStereoCellTests : XCTestCase

@end

@implementation MDCSelfSizingStereoCellTests

- (void)testContentSizeCategoryNotificationCausesFontsToAdjustOniOS10AndUp {
  // Given
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  UIFont *titleFont = typographyScheme.subtitle1;
  // TODO: Investigate what can be done about the line below failing when using .caption instead of
  // .button. See
  // https://github.com/material-components/material-components-ios/issues/7424 for
  // context.
  UIFont *detailFont = typographyScheme.button;
  cell.titleLabel.font = titleFont;
  cell.detailLabel.font = detailFont;
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  cell.titleLabel.text = @"Title";
  cell.detailLabel.text = @"Detail";
  CGFloat defaultTitleSize = cell.titleLabel.font.pointSize;
  CGFloat defaultDetailSize = cell.detailLabel.font.pointSize;

  // When
  MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow
      *extraExtraLargeContainer =
          [[MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
              initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraLarge];
  [extraExtraLargeContainer addSubview:cell];
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  // We only test the behavior for iOS10.0+ because we are not able to
  // simulate UIApplication in this test for iOS9.0 path.
  if (@available(iOS 10.0, *)) {
    XCTAssertGreaterThan(cell.titleLabel.font.pointSize, defaultTitleSize);
    XCTAssertGreaterThan(cell.detailLabel.font.pointSize, defaultDetailSize);
  }
}

- (void)testAdjustsFontForContentSizeCategoryWhenScaledFontIsUnavailableIsYES {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  UIFont *originalTitleFont = [UIFont systemFontOfSize:99];
  UIFont *originalDetailFont = [UIFont systemFontOfSize:99];
  cell.titleLabel.font = originalTitleFont;
  cell.detailLabel.font = originalDetailFont;
  cell.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  cell.titleLabel.text = @"Title";
  cell.detailLabel.text = @"Detail";

  // When
  MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow
      *extraExtraLargeContainer =
          [[MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
              initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraLarge];
  [extraExtraLargeContainer addSubview:cell];
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  XCTAssertFalse([cell.titleLabel.font mdc_isSimplyEqual:originalTitleFont]);
  XCTAssertFalse([cell.detailLabel.font mdc_isSimplyEqual:originalDetailFont]);
}

- (void)testDoesNotAdjustFontForContentSizeCategoryWhenScaledFontIsUnavailableIsNO {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  UIFont *originalTitleFont = [UIFont systemFontOfSize:99];
  UIFont *originalDetailFont = [UIFont systemFontOfSize:99];
  cell.titleLabel.font = originalTitleFont;
  cell.detailLabel.font = originalDetailFont;
  cell.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
  cell.mdc_adjustsFontForContentSizeCategory = YES;
  cell.titleLabel.text = @"Title";
  cell.detailLabel.text = @"Detail";

  // When
  MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow
      *extraExtraLargeContainer =
          [[MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
              initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraLarge];
  [extraExtraLargeContainer addSubview:cell];
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  XCTAssertTrue([cell.titleLabel.font mdc_isSimplyEqual:originalTitleFont]);
  XCTAssertTrue([cell.detailLabel.font mdc_isSimplyEqual:originalDetailFont]);
}

- (void)testSizingWithPreferredLayoutAttributesFittingAttributes {
  // Given
  NSString *oneLineString = @"Text spanning one line";
  NSString *twoLineString = @"Text spanning\ntwo lines";
  CGSize estimatedCellSize = CGSizeMake(100, 40);
  CGRect initialCellFrame = CGRectMake(0, 0, estimatedCellSize.width, estimatedCellSize.height);
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] initWithFrame:initialCellFrame];
  cell.titleLabel.text = oneLineString;
  cell.detailLabel.text = oneLineString;
  UICollectionViewLayoutAttributes *attributes = [[UICollectionViewLayoutAttributes alloc] init];
  attributes.size = estimatedCellSize;
  attributes = [cell preferredLayoutAttributesFittingAttributes:attributes];
  CGSize initialAttributeSize = attributes.size;

  // When
  cell.titleLabel.text = twoLineString;
  cell.detailLabel.text = twoLineString;
  [cell setNeedsLayout];
  attributes = [cell preferredLayoutAttributesFittingAttributes:attributes];

  // Then
  XCTAssert(attributes.size.height > initialAttributeSize.height);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCSelfSizingStereoCell *stereoCell = [[MDCSelfSizingStereoCell alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCBaseCell *passedCell = nil;
  stereoCell.traitCollectionDidChangeBlock =
      ^(MDCBaseCell *_Nonnull cell, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedCell = cell;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [stereoCell traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedCell, stereoCell);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

#pragma mark - MaterialElevation

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];

  // Then
  XCTAssertLessThan(cell.mdc_overrideBaseElevation, 0);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];

  // When
  cell.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(cell.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  const CGFloat finalElevation = 6;
  cell.elevation = finalElevation - 1;
  __block CGFloat newElevation = -1;
  cell.mdc_elevationDidChangeBlock = ^(MDCBaseCell *blockCell, CGFloat elevation) {
    newElevation = elevation;
  };

  // When
  cell.elevation = cell.elevation + 1;

  // Then
  XCTAssertEqualWithAccuracy(newElevation, finalElevation, 0.001);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  cell.elevation = 5;
  __block BOOL blockCalled = NO;
  cell.mdc_elevationDidChangeBlock = ^(MDCBaseCell *blockCell, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  cell.elevation = cell.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

@end
