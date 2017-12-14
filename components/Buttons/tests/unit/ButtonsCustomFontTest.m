/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

#import "MaterialButtons.h"

@interface ButtonsCustomFontTests : XCTestCase
@end

@implementation ButtonsCustomFontTests

- (void)testCustomFontTitle {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];

  // When
  NSString *customFontName = @"Zapfino";
  UIFont *customFont = [UIFont fontWithName:customFontName size:14.0];
  XCTAssert(customFont != nil, @"Unable to instantiate font named %@", customFontName);

  [button setTitleFont:customFont forState:UIControlStateNormal];

  // Then
  NSString *titleFontName = button.titleLabel.font.fontName;
  XCTAssert([customFontName isEqualToString:titleFontName],
            @"titleLabel font name should be custom font name");
}

- (void)testUnsetCustomFontTitle {
  // Given
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];

  // When
  NSString *customFontName = @"Zapfino";
  UIFont *customFont = [UIFont fontWithName:customFontName size:14.0];
  XCTAssert(customFont != nil, @"Unable to instantiate font named %@", customFontName);

  [button setTitleFont:customFont forState:UIControlStateNormal];

  // Set font to nil
  [button setTitleFont:nil forState:UIControlStateNormal];

  UIFont *finalTitleFont = [button titleFontForState:UIControlStateNormal];

  // Then
  XCTAssert(finalTitleFont == nil,
            @"titleLabel font should be nil");
}

@end
