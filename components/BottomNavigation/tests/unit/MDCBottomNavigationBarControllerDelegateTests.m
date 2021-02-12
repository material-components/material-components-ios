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

#import "MaterialBottomNavigation+BottomNavigationController.h"
#import "MaterialBottomNavigation.h"

/** Delegate that implements no optional APIs. */
@interface MDCBottomNavigationBarControllerDelegateWithNoOptionals
    : NSObject <MDCBottomNavigationBarControllerDelegate>
@end

@implementation MDCBottomNavigationBarControllerDelegateWithNoOptionals
@end

/** Delegate that only implements @c bottomNavigationBarController:shouldSelectViewController:. */
@interface MDCBottomNavigationBarControllerDelegateWithOnlyShouldSelect
    : NSObject <MDCBottomNavigationBarControllerDelegate>

/** @c YES if @c bottomNavigationBarController:shouldSelectViewController: was called. */
@property(nonatomic, assign, readonly) BOOL shouldSelectViewControllerWasCalled;

@end

@implementation MDCBottomNavigationBarControllerDelegateWithOnlyShouldSelect

- (BOOL)bottomNavigationBarController:
            (MDCBottomNavigationBarController *)bottomNavigationBarController
           shouldSelectViewController:(UIViewController *)viewController {
  _shouldSelectViewControllerWasCalled = YES;
  return YES;
}

@end

/** Delegate that only implements @c bottomNavigationBarController:didSelectViewController:. */
@interface MDCBottomNavigationBarControllerDelegateWithOnlyDidSelect
    : NSObject <MDCBottomNavigationBarControllerDelegate>

/** @c YES if @c bottomNavigationBarController:didSelectViewController: was called. */
@property(nonatomic, assign, readonly) BOOL didSelectViewControllerWasCalled;

@end

@implementation MDCBottomNavigationBarControllerDelegateWithOnlyDidSelect

- (void)bottomNavigationBarController:
            (MDCBottomNavigationBarController *)bottomNavigationBarController
              didSelectViewController:(UIViewController *)viewController {
  _didSelectViewControllerWasCalled = YES;
}

@end

/** Delegate that implements all optional APIs. */
@interface MDCBottomNavigationBarControllerDelegateWithAllOptionals
    : NSObject <MDCBottomNavigationBarControllerDelegate>

/** @c YES if @c bottomNavigationBarController:shouldSelectViewController: was called. */
@property(nonatomic, assign, readonly) BOOL shouldSelectViewControllerWasCalled;

/** @c YES if @c bottomNavigationBarController:didSelectViewController: was called. */
@property(nonatomic, assign, readonly) BOOL didSelectViewControllerWasCalled;

@end

@implementation MDCBottomNavigationBarControllerDelegateWithAllOptionals

- (BOOL)bottomNavigationBarController:
            (MDCBottomNavigationBarController *)bottomNavigationBarController
           shouldSelectViewController:(UIViewController *)viewController {
  _shouldSelectViewControllerWasCalled = YES;
  return YES;
}

- (void)bottomNavigationBarController:
            (MDCBottomNavigationBarController *)bottomNavigationBarController
              didSelectViewController:(UIViewController *)viewController {
  _didSelectViewControllerWasCalled = YES;
}

@end

/** Unit tests to ensure the different implementations of delegates function correctly. */
@interface MDCBottomNavigationBarControllerDelegateTests : XCTestCase

/** Controller for testing. */
@property(nonatomic, strong) MDCBottomNavigationBarController *controller;

@end

@implementation MDCBottomNavigationBarControllerDelegateTests

- (void)setUp {
  [super setUp];

  self.controller = [[MDCBottomNavigationBarController alloc] init];
  NSMutableArray<UIViewController *> *viewControllers = [NSMutableArray array];
  [viewControllers addObject:[[UIViewController alloc] init]];
  [viewControllers addObject:[[UIViewController alloc] init]];
  [viewControllers addObject:[[UIViewController alloc] init]];
  [viewControllers addObject:[[UIViewController alloc] init]];
  self.controller.viewControllers = [viewControllers copy];

  self.controller.view.bounds = CGRectMake(0, 0, 320, 72);
  [self.controller.view layoutIfNeeded];
}

- (void)tearDown {
  self.controller = nil;

  [super tearDown];
}

- (void)testNoOptionalsDelegate {
  // Given
  MDCBottomNavigationBarControllerDelegateWithNoOptionals *delegate =
      [[MDCBottomNavigationBarControllerDelegateWithNoOptionals alloc] init];
  self.controller.selectedIndex = 0;

  // When
  self.controller.delegate = delegate;
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
         shouldSelectItem:self.controller.navigationBar.items.lastObject]);
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
            didSelectItem:self.controller.navigationBar.items.lastObject]);
}

- (void)testOnlyDidSelectDelegate {
  // Given
  MDCBottomNavigationBarControllerDelegateWithOnlyDidSelect *delegate =
      [[MDCBottomNavigationBarControllerDelegateWithOnlyDidSelect alloc] init];
  self.controller.selectedIndex = 0;

  // When
  self.controller.delegate = delegate;
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
         shouldSelectItem:self.controller.navigationBar.items.lastObject]);
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
            didSelectItem:self.controller.navigationBar.items.lastObject]);

  // Then
  XCTAssertTrue(delegate.didSelectViewControllerWasCalled);
}

- (void)testOnlyShouldSelectDelegate {
  // Given
  MDCBottomNavigationBarControllerDelegateWithOnlyShouldSelect *delegate =
      [[MDCBottomNavigationBarControllerDelegateWithOnlyShouldSelect alloc] init];
  self.controller.selectedIndex = 0;

  // When
  self.controller.delegate = delegate;
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
         shouldSelectItem:self.controller.navigationBar.items.lastObject]);
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
            didSelectItem:self.controller.navigationBar.items.lastObject]);

  // Then
  XCTAssertTrue(delegate.shouldSelectViewControllerWasCalled);
}

- (void)testAllOptionalsDelegate {
  // Given
  MDCBottomNavigationBarControllerDelegateWithAllOptionals *delegate =
      [[MDCBottomNavigationBarControllerDelegateWithAllOptionals alloc] init];
  self.controller.selectedIndex = 0;

  // When
  self.controller.delegate = delegate;
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
         shouldSelectItem:self.controller.navigationBar.items.lastObject]);
  XCTAssertNoThrow([self.controller.navigationBar.delegate
      bottomNavigationBar:self.controller.navigationBar
            didSelectItem:self.controller.navigationBar.items.lastObject]);

  // Then
  XCTAssertTrue(delegate.shouldSelectViewControllerWasCalled);
  XCTAssertTrue(delegate.didSelectViewControllerWasCalled);
}

@end
