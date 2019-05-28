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

#import "MaterialList+TypographyThemer.h"
#import "MaterialList.h"
#import "MaterialTypography.h"

#import <XCTest/XCTest.h>

@interface MDCListTypographyThemerContentSizeCategoryOverrideWindow : UIWindow

/** Used to override the value of @c preferredContentSizeCategory. */
@property(nonatomic, copy) UIContentSizeCategory contentSizeCategoryOverride;

@end

@implementation MDCListTypographyThemerContentSizeCategoryOverrideWindow

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

@interface MDCListTypographyThemerTests : XCTestCase

@end

@implementation MDCListTypographyThemerTests

- (void)testApplyingTypographyScheme {
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] initWithFrame:CGRectZero];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  [MDCListTypographyThemer applyTypographyScheme:typographyScheme toSelfSizingStereoCell:cell];
  XCTAssertEqualObjects(cell.titleLabel.font, typographyScheme.subtitle1);
  XCTAssertEqualObjects(cell.detailLabel.font, typographyScheme.body2);
}

- (void)testFontThemerWhenCurrentContentSizeCategoryIsUsed {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] initWithFrame:CGRectZero];
    MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
    typographyScheme.useCurrentContentSizeCategoryWhenApplied = YES;

    // When
    MDCListTypographyThemerContentSizeCategoryOverrideWindow *extraLargeContainer =
        [[MDCListTypographyThemerContentSizeCategoryOverrideWindow alloc]
            initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraLarge];
    [extraLargeContainer addSubview:cell];
    [MDCListTypographyThemer applyTypographyScheme:typographyScheme toSelfSizingStereoCell:cell];

    // Then
    XCTAssertNotNil(cell.titleLabel.font.mdc_scalingCurve);
    XCTAssertGreaterThan(cell.titleLabel.font.pointSize, typographyScheme.subtitle1.pointSize);
    XCTAssertGreaterThan(cell.detailLabel.font.pointSize, typographyScheme.body2.pointSize);
  }
}

- (void)testFontThemerWhenCurrentContentSizeCategoryIsNotUsed {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] initWithFrame:CGRectZero];
    MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
    typographyScheme.useCurrentContentSizeCategoryWhenApplied = NO;

    // When
    MDCListTypographyThemerContentSizeCategoryOverrideWindow *extraLargeContainer =
        [[MDCListTypographyThemerContentSizeCategoryOverrideWindow alloc]
            initWithContentSizeCategoryOverride:UIContentSizeCategoryExtraLarge];
    [extraLargeContainer addSubview:cell];
    [MDCListTypographyThemer applyTypographyScheme:typographyScheme toSelfSizingStereoCell:cell];

    // Then
    XCTAssertNotNil(cell.titleLabel.font.mdc_scalingCurve);
    XCTAssertTrue([cell.titleLabel.font mdc_isSimplyEqual:typographyScheme.subtitle1]);
    XCTAssertTrue([cell.detailLabel.font mdc_isSimplyEqual:typographyScheme.body2]);
  }
}

@end
