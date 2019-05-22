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

- (void)testSelfSizingStereoCellDynamicTypeBehavior {
  // Given
  MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow *largeContainer =
      [[MDCSelfSizingStereoCellTestsDynamicTypeContentSizeCategoryOverrideWindow alloc]
          initWithContentSizeCategoryOverride:UIContentSizeCategoryLarge];
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] init];
  [largeContainer addSubview:cell];
  UIFont *titleFont = cell.titleLabel.font;
  UIFont *detailFont = cell.detailLabel.font;
  MDCFontScaler *headlineFontScaler =
      [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleSubtitle1];
  // TODO: Investigate what can be done about the line below failing when using .caption instead of
  // .button. See
  // https://github.com/material-components/material-components-ios/pull/7413/files#r285289332 for
  // context.
  MDCFontScaler *detailFontScalar =
      [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleButton];
  titleFont = [headlineFontScaler scaledFontWithFont:titleFont];
  titleFont = [titleFont mdc_scaledFontAtDefaultSize];
  detailFont = [detailFontScalar scaledFontWithFont:detailFont];
  detailFont = [detailFont mdc_scaledFontAtDefaultSize];
  cell.titleLabel.font = titleFont;
  cell.detailLabel.font = detailFont;
  cell.mdc_legacyFontScaling = NO;
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
  CGFloat fontTitleSizeForExtraExtraLargeSizeCategory = cell.titleLabel.font.pointSize;
  CGFloat fontDetailSizeForExtraExtraLargeSizeCategory = cell.detailLabel.font.pointSize;

  // Then
  if (@available(iOS 10.0, *)) {
    XCTAssertGreaterThan(fontTitleSizeForExtraExtraLargeSizeCategory, defaultTitleSize);
    XCTAssertGreaterThan(fontDetailSizeForExtraExtraLargeSizeCategory, defaultDetailSize);
  } else {
    XCTAssertEqual(fontTitleSizeForExtraExtraLargeSizeCategory, defaultTitleSize);
    XCTAssertEqual(fontDetailSizeForExtraExtraLargeSizeCategory, defaultDetailSize);
  }
}

@end
