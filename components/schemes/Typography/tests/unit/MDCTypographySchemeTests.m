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

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "MaterialTypographyScheme.h"

@interface MDCTypographySchemeTests : XCTestCase
@end

@implementation MDCTypographySchemeTests

- (void)testInitializer {
  // Given
  MDCTypographyScheme *latestScheme = [[MDCTypographyScheme alloc] init];
  MDCTypographyScheme *scheme201804 =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // Then
  XCTAssertEqual(latestScheme.headline1, scheme201804.headline1);
  XCTAssertEqual(latestScheme.headline2, scheme201804.headline2);
  XCTAssertEqual(latestScheme.headline3, scheme201804.headline3);
  XCTAssertEqual(latestScheme.headline4, scheme201804.headline4);
  XCTAssertEqual(latestScheme.headline5, scheme201804.headline5);
  XCTAssertEqual(latestScheme.headline6, scheme201804.headline6);
  XCTAssertEqual(latestScheme.subtitle1, scheme201804.subtitle1);
  XCTAssertEqual(latestScheme.subtitle2, scheme201804.subtitle2);
  XCTAssertEqual(latestScheme.body1, scheme201804.body1);
  XCTAssertEqual(latestScheme.body2, scheme201804.body2);
  XCTAssertEqual(latestScheme.caption, scheme201804.caption);
  XCTAssertEqual(latestScheme.button, scheme201804.button);
  XCTAssertEqual(latestScheme.overline, scheme201804.overline);
}

- (void)testTypographySchemeCopyTest {
  // Given
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
  MDCTypographyScheme *typographySchemeCopy = [typographyScheme copy];

  // Then
  XCTAssertFalse(typographyScheme == typographySchemeCopy);
  XCTAssertEqual(typographyScheme.headline1, typographySchemeCopy.headline1);
  XCTAssertEqual(typographyScheme.headline2, typographySchemeCopy.headline2);
  XCTAssertEqual(typographyScheme.headline3, typographySchemeCopy.headline3);
  XCTAssertEqual(typographyScheme.headline4, typographySchemeCopy.headline4);
  XCTAssertEqual(typographyScheme.headline5, typographySchemeCopy.headline5);
  XCTAssertEqual(typographyScheme.headline6, typographySchemeCopy.headline6);
  XCTAssertEqual(typographyScheme.subtitle1, typographySchemeCopy.subtitle1);
  XCTAssertEqual(typographyScheme.subtitle2, typographySchemeCopy.subtitle2);
  XCTAssertEqual(typographyScheme.body1, typographySchemeCopy.body1);
  XCTAssertEqual(typographyScheme.body2, typographySchemeCopy.body2);
  XCTAssertEqual(typographyScheme.caption, typographySchemeCopy.caption);
  XCTAssertEqual(typographyScheme.button, typographySchemeCopy.button);
  XCTAssertEqual(typographyScheme.overline, typographySchemeCopy.overline);
}

@end
