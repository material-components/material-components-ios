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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MDCTextField+Testing.h"
#import "MaterialChips.h"

@interface ChipsDelegateTests : XCTestCase <MDCChipFieldDelegate>

@property(nonatomic, nullable) MDCChipField *chip;
@property(nonatomic, copy, nullable) NSString *delegateTextInput;

@end

@implementation ChipsDelegateTests

- (void)setUp {
  [super setUp];
  self.delegateTextInput = nil;
  self.chip = [[MDCChipField alloc] init];
  self.chip.delegate = self;
}

- (void)tearDown {
  self.delegateTextInput = nil;
  self.chip.delegate = nil;
  self.chip = nil;
  [super tearDown];
}

- (void)testSettingTextInvokesDidChangeInputOnDelegate {
  // Given
  self.chip.textField.text = @"Hello World";

  // Then
  XCTAssertEqualObjects(self.delegateTextInput, @"Hello World");
}

- (void)testTouchUpOnClearButtonInvokesDidChangeInputOnDelegate {
  // Given
  self.chip.textField.text = @"Hello World";

  // When
  [self.chip.textField clearButtonDidTouch];

  // Then
  // Check length == 0 instead of looking for nil to handle both nil and @"".
  // Cast to (unsigned long) to handle 32-bit and 64-bit tests.
  XCTAssertEqual((unsigned long)self.delegateTextInput.length, 0UL);
}

#pragma mark - MDCChipFieldDelegate

- (void)chipField:(nonnull MDCChipField *)chipField didChangeInput:(nullable NSString *)input {
  self.delegateTextInput = input;
}

@end
