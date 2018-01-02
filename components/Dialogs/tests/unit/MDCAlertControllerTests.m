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
#import "MaterialDialogs.h"

#pragma mark - Subclasses for testing

static NSString *const MDCAlertControllerSubclassValueKey = @"MDCAlertControllerSubclassValueKey";

@interface MDCAlertControllerSubclass : MDCAlertController
@property(nonatomic, assign) NSInteger value;
@end

@implementation MDCAlertControllerSubclass

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _value = [aDecoder decodeIntegerForKey:MDCAlertControllerSubclassValueKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:self.value forKey:MDCAlertControllerSubclassValueKey];
}

@end

#pragma mark - Tests

@interface MDCAlertControllerTests : XCTestCase

@end

@implementation MDCAlertControllerTests

- (void)testInit {
  // Given
  MDCAlertController *alert = [[MDCAlertController alloc] init];

  // Then
  XCTAssertNotNil(alert.actions);
  XCTAssertNotNil(alert.mdm_transitionController.transition);
  XCTAssertNil(alert.title);
  XCTAssertNil(alert.message);
}

- (void)testAlertControllerWithTitleMessage {
  // Given
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];

  // Then
  XCTAssertNotNil(alert.actions);
  XCTAssertNotNil(alert.mdm_transitionController.transition);
  XCTAssertEqualObjects(alert.title, @"title");
  XCTAssertEqualObjects(alert.message, @"message");
}

- (void)testSubclassEncodingFails {
  // Given
  MDCAlertControllerSubclass *subclass = [[MDCAlertControllerSubclass alloc] init];
  subclass.value = 7;
  subclass.title = @"title";
  subclass.message = @"message";
  subclass.modalInPopover = YES;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:subclass];
  MDCAlertControllerSubclass *unarchivedSubclass =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertEqual(unarchivedSubclass.value, subclass.value);
  XCTAssertNil(unarchivedSubclass.title);
  XCTAssertNil(unarchivedSubclass.message);
  XCTAssertEqual(unarchivedSubclass.isModalInPopover, NO);
}

@end
