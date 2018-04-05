/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "MaterialTypographyScheme.h"

@interface MDCTypographySchemeTests : XCTestCase
@property(nonatomic, strong) MDCTypographyScheme *scheme;
@end

@implementation MDCTypographySchemeTests

- (void)setUp {
  [super setUp];
  self.scheme = [[MDCTypographyScheme alloc] init];
}

- (void)tearDown {
  self.scheme = nil;
  [super tearDown];
}

- (void)testInitializer {
  // Given
  MDCTypographyScheme *defaultScheme =
      [[MDCTypographyScheme alloc] initWithMaterialDefaults];

  // Then
  XCTAssertEqual(self.scheme.headline1, defaultScheme.headline1);
  XCTAssertEqual(self.scheme.headline2, defaultScheme.headline2);
  XCTAssertEqual(self.scheme.headline3, defaultScheme.headline3);
  XCTAssertEqual(self.scheme.headline4, defaultScheme.headline4);
  XCTAssertEqual(self.scheme.headline5, defaultScheme.headline5);
  XCTAssertEqual(self.scheme.headline6, defaultScheme.headline6);
  XCTAssertEqual(self.scheme.subtitle1, defaultScheme.subtitle1);
  XCTAssertEqual(self.scheme.subtitle2, defaultScheme.subtitle2);
  XCTAssertEqual(self.scheme.body1, defaultScheme.body1);
  XCTAssertEqual(self.scheme.body2, defaultScheme.body2);
  XCTAssertEqual(self.scheme.caption, defaultScheme.caption);
  XCTAssertEqual(self.scheme.button, defaultScheme.button);
  XCTAssertEqual(self.scheme.overline, defaultScheme.overline);
}

@end
