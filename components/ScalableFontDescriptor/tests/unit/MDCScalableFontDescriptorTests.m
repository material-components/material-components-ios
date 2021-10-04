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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MaterialScalableFontDescriptor.h"

@interface MDCScalableFontDescriptorTests : XCTestCase

/** Reusable font metrics for the @c body text style. */
@property(nonatomic, strong) UIFontMetrics *bodyFontMetrics NS_AVAILABLE_IOS(11.0);

/** Reusable trait collection that has the default (@c .large) content size category. */
@property(nonatomic, strong) UITraitCollection *largeContentSizeTraitCollection;

@end

@implementation MDCScalableFontDescriptorTests

- (void)setUp {
  [super setUp];

  self.bodyFontMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
  self.largeContentSizeTraitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryLarge];
}

- (void)tearDown {
  self.largeContentSizeTraitCollection = nil;
  self.bodyFontMetrics = nil;

  [super tearDown];
}

- (void)testBaseFontReturnsSomethingForUnavailableCustomFont {
  // Given
  MDCScalableFontDescriptor *style = [[MDCScalableFontDescriptor alloc]
      initWithFontDescriptor:[UIFontDescriptor fontDescriptorWithName:@"NotAFont" size:14]
                 fontMetrics:[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody]];

  // When
  UIFont *fallbackFont = style.baseFont;

  // Then
  XCTAssertNotNil(fallbackFont);
}

- (void)testPreferredFontReturnsSomethingForUnavailableCustomFont {
  // Given
  MDCScalableFontDescriptor *style = [[MDCScalableFontDescriptor alloc]
      initWithFontDescriptor:[UIFontDescriptor fontDescriptorWithName:@"NotAFont" size:14]
                 fontMetrics:[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody]];

  // When
  UIFont *fallbackFont = [style preferredFontCompatibleWithTraitCollection:nil];

  // Then
  XCTAssertNotNil(fallbackFont);
}

- (void)testBaseFontForSystemFont {
  // Given
  MDCScalableFontDescriptor *style = [[MDCScalableFontDescriptor alloc]
      initWithFontDescriptor:[UIFont systemFontOfSize:14].fontDescriptor
                 fontMetrics:[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody]];

  // When
  UIFont *systemFont = style.baseFont;

  // Then
  XCTAssertNotNil(systemFont);
  XCTAssertEqualWithAccuracy(systemFont.pointSize, style.fontDescriptor.pointSize, 0.001);
}

- (void)testPreferredFontForSystemFont {
  // Given
  MDCScalableFontDescriptor *style = [[MDCScalableFontDescriptor alloc]
      initWithFontDescriptor:[UIFont systemFontOfSize:14].fontDescriptor
                 fontMetrics:[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody]];

  // When
  UIFont *systemFont =
      [style preferredFontCompatibleWithTraitCollection:self.largeContentSizeTraitCollection];

  // Then
  XCTAssertNotNil(systemFont);
  XCTAssertEqualWithAccuracy(systemFont.pointSize, style.fontDescriptor.pointSize, 0.001);
}

- (void)testPreferredFontScalesWithContentSize {
  // Given
  MDCScalableFontDescriptor *style = [[MDCScalableFontDescriptor alloc]
      initWithFontDescriptor:[UIFont systemFontOfSize:14].fontDescriptor
                 fontMetrics:[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody]];
  UIFont *baseFont =
      [style preferredFontCompatibleWithTraitCollection:self.largeContentSizeTraitCollection];

  // When
  UIFont *aXXXLFont =
      [style preferredFontCompatibleWithTraitCollection:
                 [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                                        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge]];

  // Then
  XCTAssertGreaterThan(aXXXLFont.pointSize, baseFont.pointSize);
}

/**
 Verifies that the @c description method will include the font name, point size, and text style used
 sufficient to recreate the type scale style.
 */
- (void)testDescriptionPrintsSufficientInformationForGeneralDebugging {
  // Given
  static NSArray<UIFontTextStyle> *testTextStyles;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    testTextStyles = @[
      UIFontTextStyleLargeTitle,
      UIFontTextStyleTitle1,
      UIFontTextStyleTitle2,
      // TODO(b/142536380): Re-enable testing of .title3 once Forge on Mac fixes a scaling bug.
      // UIFontTextStyleTitle3,
      UIFontTextStyleHeadline,
      UIFontTextStyleSubheadline,
      UIFontTextStyleBody,
      UIFontTextStyleCallout,
      UIFontTextStyleCaption1,
      UIFontTextStyleCaption2,
      UIFontTextStyleFootnote,
    ];
  });
  UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:@"NotAFont" size:10];
  for (UIFontTextStyle textStyle in testTextStyles) {
    // Given
    UIFontMetrics *metrics = [UIFontMetrics metricsForTextStyle:textStyle];
    MDCScalableFontDescriptor *style =
        [[MDCScalableFontDescriptor alloc] initWithFontDescriptor:fontDescriptor
                                                      fontMetrics:metrics];

    // When
    NSString *description = [style description];
    NSLog(@"%@", description);

    // Then
    NSRange textStyleRange = [description rangeOfString:[textStyle description]];
    XCTAssertNotEqual(textStyleRange.location, NSNotFound);
    XCTAssertEqual(textStyleRange.length, textStyle.length);

    NSRange fontPointSizeRange =
        [description rangeOfString:[NSString stringWithFormat:@"%.0f", fontDescriptor.pointSize]];
    XCTAssertNotEqual(fontPointSizeRange.location, NSNotFound);
    XCTAssertGreaterThan(fontPointSizeRange.length, 0);

    NSString *descriptorFontName = fontDescriptor.fontAttributes[UIFontDescriptorNameAttribute];
    NSRange fontNameRange = [description rangeOfString:descriptorFontName];
    XCTAssertNotEqual(fontNameRange.location, NSNotFound);
    XCTAssertEqual(fontNameRange.length, descriptorFontName.length);
  }
}

@end
