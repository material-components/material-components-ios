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
#import "supplemental/MDCAbstractTextFieldSnapshotTests.h"

@interface MDCAbstractTextFieldSnapshotTests (Testing)
- (BOOL)shouldTestExecute;
- (void)testTextFieldEmpty;
- (void)testTextFieldEmptyIsEditing;
- (void)testTextFieldEmptyDisabled;
- (void)testTextFieldWithShortPlaceholderText;
- (void)testTextFieldWithShortPlaceholderTextIsEditing;
- (void)testTextFieldWithShortPlaceholderTextDisabled;
- (void)testTextFieldWithLongPlaceholderText;
- (void)testTextFieldWithLongPlaceholderTextIsEditing;
- (void)testTextFieldWithLongPlaceholderTextDisabled;
- (void)testTextFieldWithShortHelperText;
- (void)testTextFieldWithShortHelperTextIsEditing;
- (void)testTextFieldWithShortHelperTextDisabled;
- (void)testTextFieldWithLongHelperText;
- (void)testTextFieldWithLongHelperTextIsEditing;
- (void)testTextFieldWithLongHelperTextDisabled;
- (void)testTextFieldWithShortErrorText;
- (void)testTextFieldWithShortErrorTextIsEditing;
- (void)testTextFieldWithShortErrorTextDisabled;
- (void)testTextFieldWithLongErrorText;
- (void)testTextFieldWithLongErrorTextIsEditing;
- (void)testTextFieldWithLongErrorTextDisabled;
- (void)testTextFieldWithShortInputText;
- (void)testTextFieldWithShortInputTextIsEditing;
- (void)testTextFieldWithShortInputTextDisabled;
- (void)testTextFieldWithLongInputText;
- (void)testTextFieldWithLongInputTextIsEditing;
- (void)testTextFieldWithLongInputTextDisabled;
- (void)testTextFieldWithShortInputPlaceholderHelperTexts;
- (void)testTextFieldWithShortInputPlaceholderHelperTextsIsEditing;
- (void)testTextFieldWithShortInputPlaceholderHelperTextsDisabled;
- (void)testTextFieldWithLongInputPlaceholderHelperTexts;
- (void)testTextFieldWithLongInputPlaceholderHelperTextsIsEditing;
- (void)testTextFieldWithLongInputPlaceholderHelperTextsDisabled;
- (void)testTextFieldWithShortInputPlaceholderErrorTexts;
- (void)testTextFieldWithShortInputPlaceholderErrorTextsIsEditing;
- (void)testTextFieldWithShortInputPlaceholderErrorTextsDisabled;
- (void)testTextFieldWithLongInputPlaceholderErrorTexts;
- (void)testTextFieldWithLongInputPlaceholderErrorTextsIsEditing;
- (void)testTextFieldWithLongInputPlaceholderErrorTextsDisabled;
@end

/**
 A test fake implementation of MDCAbstractTextFieldSnapshotTests that does not conform to the
 @c MDCTextFieldSnapshotTestCaseHooking protocol.
 */
@interface MDCAbstractTextFieldSnapshotTestsFake : MDCAbstractTextFieldSnapshotTests
@property(nonatomic, assign) BOOL generateSnapshotAndVerifyCalled;
@end

@implementation MDCAbstractTextFieldSnapshotTestsFake

- (BOOL)shouldTestExecute {
  return YES;
}

- (void)willGenerateSnapshotAndVerify {
  XCTAssertTrue(NO, @"This method should not be called.");
}

- (void)generateSnapshotAndVerify {
  self.generateSnapshotAndVerifyCalled = YES;
}

@end

/**
 A test fake implementation of MDCAbstractTextFieldSnapshotTests that conforms to the
 @c MDCTextFieldSnapshotTestCaseHooking protocol.
 */
@interface MDCAbstractTextFieldSnapshotTestsHookingFake
    : MDCAbstractTextFieldSnapshotTestsFake <MDCTextFieldSnapshotTestCaseHooking>
@property(nonatomic, assign) BOOL willGenerateSnapshotAndVerifyCalled;
@end

@implementation MDCAbstractTextFieldSnapshotTestsHookingFake

- (void)willGenerateSnapshotAndVerify {
  self.willGenerateSnapshotAndVerifyCalled = YES;
}

@end

@interface MDCAbstractTextFieldSnapshotTestsTests : XCTestCase
@property(nonatomic, strong) MDCAbstractTextFieldSnapshotTestsFake *fakeTest;
@property(nonatomic, strong) MDCAbstractTextFieldSnapshotTestsHookingFake *hookingFakeTest;
@end

/**
 A set of tests to ensure that @c MDCAbstractTextFieldSnapshotTests invoke the expected set of hooks
 when they are implemented by a subclass.
 */
@implementation MDCAbstractTextFieldSnapshotTestsTests

- (void)setUp {
  [super setUp];

  self.fakeTest = [[MDCAbstractTextFieldSnapshotTestsFake alloc] init];
  self.fakeTest.shouldExecuteEmptyTests = YES;
  self.hookingFakeTest = [[MDCAbstractTextFieldSnapshotTestsHookingFake alloc] init];
  self.hookingFakeTest.shouldExecuteEmptyTests = YES;
}

- (void)tearDown {
  self.hookingFakeTest = nil;
  self.fakeTest = nil;

  [super tearDown];
}

#pragma mark - Tests

- (void)testTestTextFieldEmpty {
  // When
  [self.fakeTest testTextFieldEmpty];
  [self.hookingFakeTest testTextFieldEmpty];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldEmptyShouldNotExecute {
  // Given
  self.fakeTest.shouldExecuteEmptyTests = NO;
  self.hookingFakeTest.shouldExecuteEmptyTests = NO;

  // When
  [self.fakeTest testTextFieldEmpty];
  [self.hookingFakeTest testTextFieldEmpty];

  // Then
  XCTAssertFalse(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertFalse(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertFalse(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldEmptyIsEditing {
  // When
  [self.fakeTest testTextFieldEmptyIsEditing];
  [self.hookingFakeTest testTextFieldEmptyIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldEmptyShouldNotExecuteIsEditing {
  // Given
  self.fakeTest.shouldExecuteEmptyTests = NO;
  self.hookingFakeTest.shouldExecuteEmptyTests = NO;

  // When
  [self.fakeTest testTextFieldEmptyIsEditing];
  [self.hookingFakeTest testTextFieldEmptyIsEditing];

  // Then
  XCTAssertFalse(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertFalse(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertFalse(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldEmptyDisabled {
  // When
  [self.fakeTest testTextFieldEmptyDisabled];
  [self.hookingFakeTest testTextFieldEmptyDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldEmptyShouldNotExecuteDisabled {
  // Given
  self.fakeTest.shouldExecuteEmptyTests = NO;
  self.hookingFakeTest.shouldExecuteEmptyTests = NO;

  // When
  [self.fakeTest testTextFieldEmptyDisabled];
  [self.hookingFakeTest testTextFieldEmptyDisabled];

  // Then
  XCTAssertFalse(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertFalse(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertFalse(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortPlaceholderText {
  // When
  [self.fakeTest testTextFieldWithShortPlaceholderText];
  [self.hookingFakeTest testTextFieldWithShortPlaceholderText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortPlaceholderTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithShortPlaceholderTextIsEditing];
  [self.hookingFakeTest testTextFieldWithShortPlaceholderTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortPlaceholderTextDisabled {
  // When
  [self.fakeTest testTextFieldWithShortPlaceholderTextDisabled];
  [self.hookingFakeTest testTextFieldWithShortPlaceholderTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongPlaceholderText {
  // When
  [self.fakeTest testTextFieldWithLongPlaceholderText];
  [self.hookingFakeTest testTextFieldWithLongPlaceholderText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongPlaceholderTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithLongPlaceholderTextIsEditing];
  [self.hookingFakeTest testTextFieldWithLongPlaceholderTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongPlaceholderTextDisabled {
  // When
  [self.fakeTest testTextFieldWithLongPlaceholderTextDisabled];
  [self.hookingFakeTest testTextFieldWithLongPlaceholderTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortHelperText {
  // When
  [self.fakeTest testTextFieldWithShortHelperText];
  [self.hookingFakeTest testTextFieldWithShortHelperText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortHelperTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithShortHelperTextIsEditing];
  [self.hookingFakeTest testTextFieldWithShortHelperTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortHelperTextDisabled {
  // When
  [self.fakeTest testTextFieldWithShortHelperTextDisabled];
  [self.hookingFakeTest testTextFieldWithShortHelperTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongHelperText {
  // When
  [self.fakeTest testTextFieldWithLongHelperText];
  [self.hookingFakeTest testTextFieldWithLongHelperText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongHelperTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithLongHelperTextIsEditing];
  [self.hookingFakeTest testTextFieldWithLongHelperTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongHelperTextDisabled {
  // When
  [self.fakeTest testTextFieldWithLongHelperTextDisabled];
  [self.hookingFakeTest testTextFieldWithLongHelperTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortErrorText {
  // When
  [self.fakeTest testTextFieldWithShortErrorText];
  [self.hookingFakeTest testTextFieldWithShortErrorText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortErrorTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithShortErrorTextIsEditing];
  [self.hookingFakeTest testTextFieldWithShortErrorTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortErrorTextDisabled {
  // When
  [self.fakeTest testTextFieldWithShortErrorTextDisabled];
  [self.hookingFakeTest testTextFieldWithShortErrorTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongErrorText {
  // When
  [self.fakeTest testTextFieldWithLongErrorText];
  [self.hookingFakeTest testTextFieldWithLongErrorText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongErrorTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithLongErrorTextIsEditing];
  [self.hookingFakeTest testTextFieldWithLongErrorTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongErrorTextDisabled {
  // When
  [self.fakeTest testTextFieldWithLongErrorTextDisabled];
  [self.hookingFakeTest testTextFieldWithLongErrorTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputText {
  // When
  [self.fakeTest testTextFieldWithShortInputText];
  [self.hookingFakeTest testTextFieldWithShortInputText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithShortInputTextIsEditing];
  [self.hookingFakeTest testTextFieldWithShortInputTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputTextDisabled {
  // When
  [self.fakeTest testTextFieldWithShortInputTextDisabled];
  [self.hookingFakeTest testTextFieldWithShortInputTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputText {
  // When
  [self.fakeTest testTextFieldWithLongInputText];
  [self.hookingFakeTest testTextFieldWithLongInputText];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputTextIsEditing {
  // When
  [self.fakeTest testTextFieldWithLongInputTextIsEditing];
  [self.hookingFakeTest testTextFieldWithLongInputTextIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputTextDisabled {
  // When
  [self.fakeTest testTextFieldWithLongInputTextDisabled];
  [self.hookingFakeTest testTextFieldWithLongInputTextDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputPlaceholderHelperTexts {
  // When
  [self.fakeTest testTextFieldWithShortInputPlaceholderHelperTexts];
  [self.hookingFakeTest testTextFieldWithShortInputPlaceholderHelperTexts];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputPlaceholderHelperTextsIsEditing {
  // When
  [self.fakeTest testTextFieldWithShortInputPlaceholderHelperTextsIsEditing];
  [self.hookingFakeTest testTextFieldWithShortInputPlaceholderHelperTextsIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputPlaceholderHelperTextsDisabled {
  // When
  [self.fakeTest testTextFieldWithShortInputPlaceholderHelperTextsDisabled];
  [self.hookingFakeTest testTextFieldWithShortInputPlaceholderHelperTextsDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputPlaceholderHelperTexts {
  // When
  [self.fakeTest testTextFieldWithLongInputPlaceholderHelperTexts];
  [self.hookingFakeTest testTextFieldWithLongInputPlaceholderHelperTexts];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputPlaceholderHelperTextsIsEditing {
  // When
  [self.fakeTest testTextFieldWithLongInputPlaceholderHelperTextsIsEditing];
  [self.hookingFakeTest testTextFieldWithLongInputPlaceholderHelperTextsIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputPlaceholderHelperTextsDisabled {
  // When
  [self.fakeTest testTextFieldWithLongInputPlaceholderHelperTextsDisabled];
  [self.hookingFakeTest testTextFieldWithLongInputPlaceholderHelperTextsDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputPlaceholderErrorTexts {
  // When
  [self.fakeTest testTextFieldWithShortInputPlaceholderErrorTexts];
  [self.hookingFakeTest testTextFieldWithShortInputPlaceholderErrorTexts];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputPlaceholderErrorTextsIsEditing {
  // When
  [self.fakeTest testTextFieldWithShortInputPlaceholderErrorTextsIsEditing];
  [self.hookingFakeTest testTextFieldWithShortInputPlaceholderErrorTextsIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithShortInputPlaceholderErrorTextsDisabled {
  // When
  [self.fakeTest testTextFieldWithShortInputPlaceholderErrorTextsDisabled];
  [self.hookingFakeTest testTextFieldWithShortInputPlaceholderErrorTextsDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputPlaceholderErrorTexts {
  // When
  [self.fakeTest testTextFieldWithLongInputPlaceholderErrorTexts];
  [self.hookingFakeTest testTextFieldWithLongInputPlaceholderErrorTexts];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputPlaceholderErrorTextsIsEditing {
  // When
  [self.fakeTest testTextFieldWithLongInputPlaceholderErrorTextsIsEditing];
  [self.hookingFakeTest testTextFieldWithLongInputPlaceholderErrorTextsIsEditing];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

- (void)testTestTextFieldWithLongInputPlaceholderErrorTextsDisabled {
  // When
  [self.fakeTest testTextFieldWithLongInputPlaceholderErrorTextsDisabled];
  [self.hookingFakeTest testTextFieldWithLongInputPlaceholderErrorTextsDisabled];

  // Then
  XCTAssertTrue(self.fakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.generateSnapshotAndVerifyCalled);
  XCTAssertTrue(self.hookingFakeTest.willGenerateSnapshotAndVerifyCalled);
}

@end
