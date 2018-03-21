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

#import <XCTest/XCTest.h>

#import "MaterialThemes.h"
#import "MaterialChips.h"
#import "MDCChipViewFontThemer.h"

@interface FakeFontScheme : NSObject <MDCFontScheme>
@end

@implementation FakeFontScheme

- (UIFont *)headline1 {
  return nil;
}

- (UIFont *)headline2 {
  return nil;
}

- (UIFont *)headline3 {
  return nil;
}

- (UIFont *)headline4 {
  return nil;
}

- (UIFont *)headline5 {
  return nil;
}

- (UIFont *)headline6 {
  return nil;
}

- (UIFont *)subtitle1 {
  return nil;
}

- (UIFont *)subtitle2 {
  return nil;
}

- (UIFont *)caption {
  return nil;
}

- (UIFont *)overline {
  return nil;
}

- (UIFont *)button {
  return nil;
}

- (UIFont *)body1 {
  return nil;
}

- (UIFont *)body2 {
  return [UIFont systemFontOfSize:99];
}

@end

@interface ChipViewFontThemerTests : XCTestCase

@end

@implementation ChipViewFontThemerTests

- (void)testFontThemer {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  FakeFontScheme *fontScheme = [[FakeFontScheme alloc] init];

  // When
  [MDCChipViewFontThemer applyFontScheme:fontScheme toChipView:chip];

  // Then
  XCTAssertEqualObjects(chip.titleFont, fontScheme.body2);
}

@end
