// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "M3CButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface M3CButtonTests : XCTestCase
@property(nonatomic, strong, nullable) M3CButton *button;
@end

@implementation M3CButtonTests

- (void)setUp {
  [super setUp];

  self.button = [[M3CButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)testAnything {
  // Given
  NSString *originalTitle = @"some Text";

  // When
  [self.button setTitle:originalTitle forState:UIControlStateNormal];

  // Then
  XCTAssertEqualObjects(self.button.currentTitle, originalTitle);
}

@end

NS_ASSUME_NONNULL_END
