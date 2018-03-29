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
#import "MaterialButtonBar.h"

@interface ButtonBarCodingTests : XCTestCase

@end

@implementation ButtonBarCodingTests

- (void)testBasicCoding {
  // Given
  MDCButtonBar *buttonBar = [[MDCButtonBar alloc] initWithFrame:CGRectZero];
  buttonBar.buttonTitleBaseline = (CGFloat)2.1;
  buttonBar.layoutPosition = 3;
  UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithTitle:@"barButton1"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:nil
                                                                action:nil];
  UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithTitle:@"barButton2"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
  buttonBar.items = @[barButton1, barButton2];
  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:buttonBar];
  MDCButtonBar *unarchivedBarButton = [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertNotNil(unarchivedBarButton);
  XCTAssertEqual(unarchivedBarButton.buttonTitleBaseline, buttonBar.buttonTitleBaseline);
  XCTAssertEqual(unarchivedBarButton.layoutPosition, buttonBar.layoutPosition);
  XCTAssertEqual(unarchivedBarButton.items.count, buttonBar.items.count);
  XCTAssertEqualObjects([unarchivedBarButton.items[0] title], [buttonBar.items[0] title]);
  XCTAssertEqualObjects([unarchivedBarButton.items[1] title], [buttonBar.items[1] title]);
  XCTAssertEqual([unarchivedBarButton.items[0] style], [buttonBar.items[0] style]);
  XCTAssertEqual([unarchivedBarButton.items[1] style], [buttonBar.items[1] style]);
}

@end
