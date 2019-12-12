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

#import "MaterialFeatureHighlight.h"

@interface MDCFeatureHighlightView (TestInterface)

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *bodyLabel;

@end

@interface FeatureHighlightCustomFontTest : XCTestCase

@end

@implementation FeatureHighlightCustomFontTest

- (void)testCustomTitleFontUpdateLabel {
  // Given
  MDCFeatureHighlightView *view = [[MDCFeatureHighlightView alloc] init];

  // When
  NSString *customFontName = @"Zapfino";
  UIFont *customFont = [UIFont fontWithName:customFontName size:14.0];
  XCTAssert(customFont != nil, @"Unable to instantiate font named %@", customFontName);

  view.titleFont = customFont;

  // Then
  NSString *labelFontName = view.titleLabel.font.fontName;
  XCTAssert([customFontName isEqualToString:labelFontName],
            @"Label font name should be custom font name");
}

- (void)testCustomBodyFontUpdateLabel {
  // Given
  MDCFeatureHighlightView *view = [[MDCFeatureHighlightView alloc] init];

  // When
  NSString *customFontName = @"Chalkduster";
  UIFont *customFont = [UIFont fontWithName:customFontName size:14.0];
  XCTAssert(customFont != nil, @"Unable to instantiate font named %@", customFontName);

  view.bodyFont = customFont;

  // Then
  NSString *labelFontName = view.bodyLabel.font.fontName;
  XCTAssert([customFontName isEqualToString:labelFontName],
            @"Label font name should be custom font name");
}

@end
