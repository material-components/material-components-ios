// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MaterialAppBar.h"

@interface AppBarLocalizationTests : XCTestCase

@end

@implementation AppBarLocalizationTests

- (void)testBackBarButtonItemAccessibilityLabelIsTranslated {
  // Given
  MDCAppBarNavigationController *navigationController =
      [[MDCAppBarNavigationController alloc] init];
  UIViewController *viewController1 = [[UIViewController alloc] init];
  UIViewController *viewController2 = [[UIViewController alloc] init];
  NSString *languageCode =
      [NSLocale.preferredLanguages.firstObject componentsSeparatedByString:@"-"].firstObject;

  // When
  [navigationController setViewControllers:@[ viewController1, viewController2 ] animated:NO];
  MDCAppBarViewController *appBarViewController = viewController2.childViewControllers.firstObject;
  [appBarViewController viewWillAppear:NO];
  UIBarButtonItem *backBarButtonItem = appBarViewController.navigationBar.backItem;

  // Then
  if ([languageCode isEqualToString:@"ar"]) {
    XCTAssertEqualObjects(backBarButtonItem.accessibilityLabel, @"رجوع");
  } else {
    XCTFail(@"Language %@ isn't supported by this localization test case", languageCode);
  }
}

@end
