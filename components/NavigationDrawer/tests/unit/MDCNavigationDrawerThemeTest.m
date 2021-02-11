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

#import "MaterialNavigationDrawer+ColorThemer.h"
#import "MaterialNavigationDrawer.h"
#import "MDCNavigationDrawerFakes.h"
#import "MaterialColorScheme.h"

static const CGFloat kScimAlpha = (CGFloat)0.32;

@interface MDCNavigationDrawerThemeTest : XCTestCase
@property(nonatomic, strong) MDCBottomDrawerViewController *bottomDrawer;
@property(nonatomic, strong) MDCNavigationDrawerFakeHeaderViewController *headerViewController;
@property(nonatomic, strong) UIViewController *contentViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation MDCNavigationDrawerThemeTest

- (void)setUp {
  [super setUp];

  self.headerViewController = [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.contentViewController = [[UIViewController alloc] init];
  self.bottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  self.bottomDrawer.headerViewController = self.headerViewController;
  self.bottomDrawer.contentViewController = self.contentViewController;

  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.colorScheme.surfaceColor = UIColor.blueColor;
  self.colorScheme.onSurfaceColor = UIColor.greenColor;
}

- (void)tearDown {
  self.colorScheme = nil;
  self.bottomDrawer = nil;

  [super tearDown];
}

- (void)testApplyColorTheme {
  // When
  [MDCBottomDrawerColorThemer applySemanticColorScheme:self.colorScheme
                                        toBottomDrawer:self.bottomDrawer];

  // Then
  XCTAssertEqualObjects(self.headerViewController.view.backgroundColor,
                        self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.contentViewController.view.backgroundColor,
                        self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.bottomDrawer.scrimColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kScimAlpha]);
}

@end
