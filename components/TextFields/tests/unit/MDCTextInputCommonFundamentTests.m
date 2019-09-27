// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "../../src/private/MDCTextInputCommonFundament.h"
#import "MaterialTextFields.h"

/** Unit tests for @c MDCTextInputCommonFundament. */
@interface MDCTextInputCommonFundamentTests : XCTestCase
/** The text input under test. */
@property(nonatomic, strong) MDCTextInputCommonFundament *textInput;
@end

@implementation MDCTextInputCommonFundamentTests

- (void)setUp {
  [super setUp];

  self.textInput =
      [[MDCTextInputCommonFundament alloc] initWithTextInput:[[MDCTextField alloc] init]];
}

- (void)tearDown {
  self.textInput = nil;

  [super tearDown];
}

- (void)testDefaultFontValues {
  // Then
  XCTAssertNotNil(self.textInput.font);
  XCTAssertNotNil(self.textInput.placeholderLabel);
  XCTAssertEqual(self.textInput.font, self.textInput.placeholderLabel.font);
}

- (void)testDidSetFontChangesFontUpdatesPlaceholderFontWhenFontsMatch {
  // Given
  UIFont *originalFont = [UIFont systemFontOfSize:10];
  self.textInput.font = originalFont;
  self.textInput.placeholderLabel.font = self.textInput.font;

  // When
  UIFont *assignedFont = [UIFont systemFontOfSize:99];
  self.textInput.font = assignedFont;
  [self.textInput didSetFont:originalFont];

  // Then
  XCTAssertEqual(self.textInput.font, assignedFont);
  XCTAssertEqual(self.textInput.placeholderLabel.font, self.textInput.font);
}

- (void)testDidSetFontChangesFontDoesNotUpdatePlaceholderFontWhenFontsDoNotMatch {
  // Given
  UIFont *originalFont = [UIFont systemFontOfSize:66];
  self.textInput.font = originalFont;
  self.textInput.placeholderLabel.font = [UIFont systemFontOfSize:55];

  // When
  UIFont *assignedFont = [UIFont systemFontOfSize:99];
  self.textInput.font = assignedFont;
  [self.textInput didSetFont:originalFont];

  // Then
  XCTAssertEqual(self.textInput.font, assignedFont);
  XCTAssertNotEqual(self.textInput.placeholderLabel.font, self.textInput.font);
}

@end
