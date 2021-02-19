// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MaterialFlexibleHeader.h"

@interface AppBarNavigationControllerTests : XCTestCase

@property(nonatomic, strong) MDCAppBarNavigationController *navigationController;

@end

@implementation AppBarNavigationControllerTests

- (void)setUp {
  [super setUp];

  self.navigationController = [[MDCAppBarNavigationController alloc] init];
}

- (void)tearDown {
  self.navigationController = nil;

  [super tearDown];
}

- (void)testInitHidesTheNavigationBar {
  // Then
  XCTAssertTrue(self.navigationController.navigationBarHidden);
}

- (void)testInitWithNibNameHidesTheNavigationBar {
  // Given
  MDCAppBarNavigationController *navigationController =
      [[MDCAppBarNavigationController alloc] initWithNibName:nil bundle:nil];

  // Then
  XCTAssertTrue(navigationController.navigationBarHidden);
}

- (void)testInitWithRootViewControllerHidesTheNavigationBar {
  // Given
  UIViewController *viewController = [[UIViewController alloc] init];
  MDCAppBarNavigationController *navigationController =
      [[MDCAppBarNavigationController alloc] initWithRootViewController:viewController];

  // Then
  XCTAssertTrue(navigationController.navigationBarHidden);
}

- (void)testSettingAViewControllerInjectsAnAppBar {
  // Given
  UIViewController *viewController = [[UIViewController alloc] init];

  // When
  self.navigationController.viewControllers = @[ viewController ];

  // Then
  XCTAssertEqual(
      viewController.childViewControllers.count, 1,
      @"Expected there to be exactly one child view controller added to the view controller.");
  XCTAssertEqual(self.navigationController.topViewController, viewController,
                 @"The navigation controller's top view controller is supposed to be the pushed "
                 @"view controller, but it is %@.",
                 viewController);
  XCTAssertTrue(
      [viewController.childViewControllers.firstObject
          isKindOfClass:[MDCFlexibleHeaderViewController class]],
      "The injected view controller is not a flexible header view controller, it is %@ instead.",
      NSStringFromClass([viewController.childViewControllers.firstObject class]));

  if ([viewController.childViewControllers.firstObject
          isKindOfClass:[MDCFlexibleHeaderViewController class]]) {
    MDCFlexibleHeaderViewController *headerViewController =
        viewController.childViewControllers.firstObject;
    XCTAssertEqual(headerViewController.headerView.frame.size.height,
                   headerViewController.headerView.maximumHeight);
  }
}

- (void)testSettingAViewControllerAnimatedInjectsAnAppBar {
  // Given
  UIViewController *viewController = [[UIViewController alloc] init];

  // When
  [self.navigationController setViewControllers:@[ viewController ] animated:NO];

  // Then
  XCTAssertEqual(
      viewController.childViewControllers.count, 1,
      @"Expected there to be exactly one child view controller added to the view controller.");
  XCTAssertEqual(self.navigationController.topViewController, viewController,
                 @"The navigation controller's top view controller is supposed to be the pushed "
                 @"view controller, but it is %@.",
                 viewController);
  XCTAssertTrue(
      [viewController.childViewControllers.firstObject
          isKindOfClass:[MDCFlexibleHeaderViewController class]],
      "The injected view controller is not a flexible header view controller, it is %@ instead.",
      NSStringFromClass([viewController.childViewControllers.firstObject class]));

  if ([viewController.childViewControllers.firstObject
          isKindOfClass:[MDCFlexibleHeaderViewController class]]) {
    MDCFlexibleHeaderViewController *headerViewController =
        viewController.childViewControllers.firstObject;
    XCTAssertEqual(headerViewController.headerView.frame.size.height,
                   headerViewController.headerView.maximumHeight);
  }
}

- (void)testSettingAViewControllerAssignsTraitCollectionDidChangeBlock {
  // Given
  UIViewController *viewController = [[UIViewController alloc] init];
  self.navigationController.traitCollectionDidChangeBlockForAppBarController =
      ^(MDCFlexibleHeaderViewController *_Nonnull flexibleHeaderViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
      };

  // When
  self.navigationController.viewControllers = @[ viewController ];

  // Then
  MDCAppBarViewController *injectedAppBarViewController =
      viewController.childViewControllers.firstObject;
  XCTAssertNotNil(injectedAppBarViewController);
  XCTAssertNotNil(injectedAppBarViewController.traitCollectionDidChangeBlock);
}

- (void)testSettingAViewControllerAnimatedAssignsTraitCollectionDidChangeBlock {
  // Given
  UIViewController *viewController = [[UIViewController alloc] init];
  self.navigationController.traitCollectionDidChangeBlockForAppBarController =
      ^(MDCFlexibleHeaderViewController *_Nonnull flexibleHeaderViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
      };

  // When
  [self.navigationController setViewControllers:@[ viewController ] animated:NO];

  // Then
  MDCAppBarViewController *injectedAppBarViewController =
      viewController.childViewControllers.firstObject;
  XCTAssertNotNil(injectedAppBarViewController);
  XCTAssertNotNil(injectedAppBarViewController.traitCollectionDidChangeBlock);
}

@end
