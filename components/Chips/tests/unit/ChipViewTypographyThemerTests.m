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

#import <XCTest/XCTest.h>

#import "MaterialChips+TypographyThemer.h"
#import "MaterialChips.h"
#import "MaterialTypography.h"

/** Fake MDCChipView for unit testing. */
@interface MDCChipsTypographyThemerTestsFakeChipView : MDCChipView

/** Used to set the value of @c traitCollection. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;

@end

@implementation MDCChipsTypographyThemerTestsFakeChipView

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface ChipViewTypographyThemerTests : XCTestCase

@end

@implementation ChipViewTypographyThemerTests

- (void)testFontThemerWithNoDynamicTypeSupport {
  MDCChipView *chip = [[MDCChipView alloc] init];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  typographyScheme.mdc_adjustsFontForContentSizeCategory = NO;

  [MDCChipViewTypographyThemer applyTypographyScheme:typographyScheme toChipView:chip];

  XCTAssertEqualObjects(chip.titleLabel.font, typographyScheme.body2);
}

- (void)testFontThemerWithDynamicTypeSupport {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCChipsTypographyThemerTestsFakeChipView *chip =
        [[MDCChipsTypographyThemerTestsFakeChipView alloc] init];
    MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
    typographyScheme.mdc_adjustsFontForContentSizeCategory = YES;
    UIContentSizeCategory size = UIContentSizeCategoryExtraExtraLarge;
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:size];
    chip.traitCollectionOverride = traitCollection;

    // When
    [MDCChipViewTypographyThemer applyTypographyScheme:typographyScheme toChipView:chip];

    // Then
    XCTAssertNotNil(chip.titleFont.mdc_scalingCurve);
    XCTAssertGreaterThan(chip.titleFont.pointSize, typographyScheme.body2.pointSize);
  }
}

@end
