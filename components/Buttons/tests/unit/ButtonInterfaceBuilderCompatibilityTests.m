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
#import <Foundation/Foundation.h>

#import "supplemental/ButtonTestView.h"

@interface ButtonInterfaceBuilderCompatibilityTests : XCTestCase

@end

@implementation ButtonInterfaceBuilderCompatibilityTests

- (void)testFontRestoredFromNib {
  // Given
  ButtonTestView *buttonView = [[ButtonTestView alloc] initFromNib];
  UIFont *buttonFont = buttonView.button.titleLabel.font;
  UIColor *buttonColor = buttonView.button.titleLabel.textColor;

  // When
  buttonView.button.selected = YES;
  buttonView.button.selected = NO;

  // Then
  XCTAssertEqualObjects(buttonFont, [UIFont systemFontOfSize:40]);
  XCTAssertEqualObjects(buttonColor, [UIColor blackColor]);

}

@end
