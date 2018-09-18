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

#import "MaterialActionSheet.h"

#import <XCTest/XCTest.h>

#import "../../src/private/MDCActionSheetHeaderView.h"

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetController (Testing)
@property(nonatomic, strong) MDCActionSheetHeaderView *header;
@end

@interface MDCActionSheetTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@implementation MDCActionSheetTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)testHeaderColor {
  // When
  self.actionSheet.title = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
  
  XCTAssertEqual(self.actionSheet.header.titleLabel.textColor, expectedColor);
}

- (void)testMessageColor {
  // When

  // Then
}

@end
