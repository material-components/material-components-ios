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

#import "MaterialBottomAppBar+ColorThemer.h"
#import "MaterialBottomAppBar.h"
#import "MaterialThemes.h"

@interface BottomAppBarColorThemerTests : XCTestCase
@property(nonatomic, strong) MDCBottomAppBarView *bottomAppBar;
@end

@implementation BottomAppBarColorThemerTests

- (void)setUp {
  [super setUp];
  self.bottomAppBar = [[MDCBottomAppBarView alloc] init];
}

- (void)tearDown {
  self.bottomAppBar = nil;
  [super tearDown];
}

- (void)testPrimaryColorAppliedToBarTintColor {
  // Given
  MDCBasicColorScheme *scheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:UIColor.cyanColor];

  // When
  [MDCBottomAppBarColorThemer applyColorScheme:scheme toBottomAppBarView:self.bottomAppBar];

  // Then
  XCTAssertEqualObjects(self.bottomAppBar.barTintColor, scheme.primaryColor);
}

- (void)testSurfaceVariantColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = UIColor.orangeColor;
  colorScheme.onPrimaryColor = UIColor.cyanColor;
  colorScheme.surfaceColor = UIColor.blueColor;
  colorScheme.onSurfaceColor = UIColor.purpleColor;

  // When
  [MDCBottomAppBarColorThemer applySurfaceVariantWithSemanticColorScheme:colorScheme
                                                      toBottomAppBarView:self.bottomAppBar];

  // Then
  UIColor *barItemTintColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6];
  XCTAssertEqualObjects(self.bottomAppBar.barTintColor, colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.bottomAppBar.leadingBarItemsTintColor, barItemTintColor);
  XCTAssertEqualObjects(self.bottomAppBar.trailingBarItemsTintColor, barItemTintColor);
  XCTAssertEqualObjects(
      [self.bottomAppBar.floatingButton backgroundColorForState:UIControlStateNormal],
      colorScheme.primaryColor);
  XCTAssertEqualObjects([self.bottomAppBar.floatingButton titleColorForState:UIControlStateNormal],
                        colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(
      [self.bottomAppBar.floatingButton imageTintColorForState:UIControlStateNormal],
      colorScheme.onPrimaryColor);
}

@end
