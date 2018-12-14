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

#import "MDCBottomNavigationBarController.h"

CGFloat const kDefaultExpectationTimeout = 15.f;

@interface MDCBottomNavigationControllerTests
    : XCTestCase <MDCBottomNavigationBarControllerDelegate>

/** The bottom navigation controller to test **/
@property(nonatomic, strong, nonnull)
    MDCBottomNavigationBarController *bottomNavigationBarController;

/**
 * Is fufilled when the a delegate method is called. Set the description of the expectation with the
 * string value of the selector of the method you are expecting to be called.
 **/
@property(nonatomic, strong, nullable) XCTestExpectation *delegateExpecation;

/**
 * An array of the values of the expected arguments the delegate method should be called with.
 * The order of the array is the order the arguments appear in the method signature.
 */
@property(nonatomic, strong, nullable) NSArray<id> *expectedArguments;

/**
 * The return value a delegate method should return with.
 */
@property(nonatomic, strong, nullable) id returnValue;

@end

@implementation MDCBottomNavigationControllerTests

- (void)setUp {
  [super setUp];
  _bottomNavigationBarController = [[MDCBottomNavigationBarController alloc] init];
}

- (void)testSetViewControllers {
  // Setup items.
  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Title1" image:nil tag:0];
  UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Title2" image:nil tag:1];
  NSArray<UITabBarItem *> *tabBarItems = @[ tabBarItem1, tabBarItem2 ];

  // Setup view controllers
  UIViewController *viewController1 = [[UIViewController alloc] init];
  UIViewController *viewController2 = [[UIViewController alloc] init];

  // Assign the tab bar items to the view controllers
  viewController1.tabBarItem = tabBarItem1;
  viewController2.tabBarItem = tabBarItem2;

  _bottomNavigationBarController.viewControllers = @[ viewController1, viewController2 ];

  XCTAssert([tabBarItems count] == [_bottomNavigationBarController.navigationBar.items count],
            @"The number of items in the bottom navigation bar's items property does not match the "
            @"number of items set in the test");
  int count = (int)[tabBarItems count];

  // Check each item in the navigation bar.
  for (int i = 0; i < count; i++) {
    UITabBarItem *expectedItem = [tabBarItems objectAtIndex:i];
    UITabBarItem *item = [_bottomNavigationBarController.navigationBar.items objectAtIndex:i];
    XCTAssert([expectedItem.title isEqualToString:item.title] && expectedItem.tag == item.tag,
              @"The item at index %i of the bottom navigation bar's items property is not the "
              @"expected item",
              i);
  }
}

- (void)testFreshSelectionBySettingSelectedIndex {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  NSUInteger index = 0;
  _bottomNavigationBarController.selectedIndex = index;
  [self verifyStateOfSelectedIndex:index];
}

- (void)testItemToItemSelectionBySettingSelectedIndex {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Set selection to initial view controller.
  NSUInteger index = 0;
  _bottomNavigationBarController.selectedIndex = index;

  // Increment index and set selection to new index
  index++;
  _bottomNavigationBarController.selectedIndex = index;

  [self verifyStateOfSelectedIndex:index];
}

- (void)testDeselectBySettingSelectedIndex {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  _bottomNavigationBarController.selectedIndex = 0;
  _bottomNavigationBarController.selectedIndex = NSNotFound;

  [self verifyDeselect];
}

- (void)testFreshSelectionBySettingSelectedViewController {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  NSUInteger index = 0;
  UIViewController *selectedViewController =
      [_bottomNavigationBarController.viewControllers objectAtIndex:index];
  _bottomNavigationBarController.selectedViewController = selectedViewController;

  [self verifyStateOfSelectedIndex:index];
}

- (void)testItemToItemSelectionBySettingSelectedViewController {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Select the initial view controller
  NSUInteger index = 0;
  UIViewController *selectedVC =
      [_bottomNavigationBarController.viewControllers objectAtIndex:index];
  _bottomNavigationBarController.selectedViewController = selectedVC;

  // Set the view controller to the next item.
  index++;
  selectedVC = [_bottomNavigationBarController.viewControllers objectAtIndex:index];
  _bottomNavigationBarController.selectedViewController = selectedVC;

  [self verifyStateOfSelectedIndex:index];
}

- (void)testDeselectBySettingSelectedViewController {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  UIViewController *firstSelect = [_bottomNavigationBarController.viewControllers objectAtIndex:0];
  _bottomNavigationBarController.selectedViewController = firstSelect;
  _bottomNavigationBarController.selectedViewController = nil;

  [self verifyDeselect];
}

- (void)testOutOfBoundsSelectionBySettingSelectedIndex {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  // Initial selection
  _bottomNavigationBarController.selectedIndex = 0;

  XCTAssertThrowsSpecificNamed(
      [_bottomNavigationBarController setSelectedIndex:100], NSException,
      NSInternalInconsistencyException,
      @"Expected NSAssert to fire exception when setting an index out of bounds");
}

- (void)testOutOfBoundsSelectionBySettingSelectedViewController {
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  // Initial selection
  _bottomNavigationBarController.selectedViewController =
      [_bottomNavigationBarController.viewControllers objectAtIndex:0];

  UIViewController *newViewController = [[UIViewController alloc] init];

  XCTAssertThrowsSpecificNamed(
      [_bottomNavigationBarController setSelectedViewController:newViewController], NSException,
      NSInternalInconsistencyException,
      @"Expected NSAssert to fire an exception when setting the bottom bar's selected view "
      @"controller to one it does not own");
}

- (void)testDidSelectItemDelegateMethod {
  // Setup the navigation controller
  _bottomNavigationBarController.delegate = self;
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Create the expectation
  NSString *signature = NSStringFromSelector(@selector(bottomNavigationBarController:
                                                             didSelectViewController:));
  _delegateExpecation = [self expectationWithDescription:signature];

  // The index of the view controller we want to select.
  NSUInteger index = 0;
  UIViewController *selectedViewController =
      [_bottomNavigationBarController.viewControllers objectAtIndex:index];

  // The corresponding tab bar item we want to select.
  UITabBarItem *selectedItem =
      [_bottomNavigationBarController.navigationBar.items objectAtIndex:index];

  // The arguments we are expecting from the delegate.
  _expectedArguments = @[ _bottomNavigationBarController, selectedViewController ];

  // Fake a navigation bar selection call.
  [_bottomNavigationBarController bottomNavigationBar:_bottomNavigationBarController.navigationBar
                                        didSelectItem:selectedItem];

  XCTAssertEqual(selectedViewController, _bottomNavigationBarController.selectedViewController,
                 @"Expected the selected view controller of the navigation controller to be equal "
                 @"to the navigation bar's tab bar item's corresponding view controller.");
  XCTAssertEqual(index, _bottomNavigationBarController.selectedIndex,
                 @"Expected the selected index of the navigation controller to be equal to the "
                 @"selected view controller.");

  // Test to see if the delegate method was called.
  [self waitForExpectationsWithTimeout:kDefaultExpectationTimeout handler:nil];
}

- (void)testShouldNotSelectItemDelegateMethod {
  // Setup the navigation controller.
  _bottomNavigationBarController.delegate = self;
  _bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Get the selected view controller and items for an index.
  NSUInteger index = 0;
  UIViewController *shouldSelectViewController =
      [_bottomNavigationBarController.viewControllers objectAtIndex:index];
  UITabBarItem *selectedItem =
      [_bottomNavigationBarController.navigationBar.items objectAtIndex:index];
  _expectedArguments = @[ _bottomNavigationBarController, shouldSelectViewController ];
  _returnValue = [NSNumber numberWithBool:NO];

  // Create the expectation.
  NSString *signature = NSStringFromSelector(@selector(bottomNavigationBarController:
                                                          shouldSelectViewController:));
  _delegateExpecation = [self expectationWithDescription:signature];

  // Call the navigation bar's delegate method.
  BOOL returnValue = [_bottomNavigationBarController
      bottomNavigationBar:_bottomNavigationBarController.navigationBar
         shouldSelectItem:selectedItem];

  // Test the return value.
  XCTAssertEqual([_returnValue boolValue], returnValue,
                 @"Expected %@ to return with %@.  Received: %@", signature,
                 [self boolToString:[_returnValue boolValue]], [self boolToString:returnValue]);

  // Test that the delegate method was called.
  [self waitForExpectationsWithTimeout:kDefaultExpectationTimeout handler:nil];
}

#pragma mark - MDCBottomNavigationBarControllerDelegate Methods

- (void)bottomNavigationBarController:
            (MDCBottomNavigationBarController *)bottomNavigationBarController
              didSelectViewController:(UIViewController *)viewController {
  NSString *signature = NSStringFromSelector(@selector(bottomNavigationBarController:
                                                             didSelectViewController:));
  NSArray *arguments = @[ bottomNavigationBarController, viewController ];

  [self verifyDelegateMethodCall:signature arguments:arguments];
  [self.delegateExpecation fulfill];
}

- (BOOL)bottomNavigationBarController:
            (MDCBottomNavigationBarController *)bottomNavigationBarController
           shouldSelectViewController:(UIViewController *)viewController {
  NSString *signature = NSStringFromSelector(@selector(bottomNavigationBarController:
                                                          shouldSelectViewController:));
  NSArray *arguments = @[ bottomNavigationBarController, viewController ];
  [self verifyDelegateMethodCall:signature arguments:arguments];
  [_delegateExpecation fulfill];

  return [_returnValue boolValue];
}

#pragma mark - Helper Methods

- (NSArray *)createArrayOfTwoFakeViewControllers {
  UIViewController *viewController1 = [[UIViewController alloc] init];
  UIViewController *viewController2 = [[UIViewController alloc] init];

  viewController1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore
                                                                          tag:0];
  viewController2.tabBarItem =
      [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];

  return @[ viewController1, viewController2 ];
}

/**
 * Verifies the state of the bottom navigation bar controller for the given expected selected index.
 */
- (void)verifyStateOfSelectedIndex:(NSUInteger)index {
  XCTAssert(_bottomNavigationBarController.selectedIndex == index,
            @"Expected bottom navigation bar controller's selected index to be %lu. Received: %li",
            index, _bottomNavigationBarController.selectedIndex);

  UIViewController *expectedVC =
      [_bottomNavigationBarController.viewControllers objectAtIndex:index];
  XCTAssertEqualObjects(expectedVC, _bottomNavigationBarController.selectedViewController,
                        @"Expected bottom navigation bar's selected view controller to be equal to "
                        @"the view controller at index: %li",
                        index);

  UITabBarItem *expectedItem =
      [_bottomNavigationBarController.navigationBar.items objectAtIndex:index];
  XCTAssertEqualObjects(
      expectedItem, _bottomNavigationBarController.navigationBar.selectedItem,
      @"Expected bottom navigation bar's selected item to be equal to the item at index: %li",
      index);
}

/**
 * Verifies that the bottom navigation controller has no view controller selected.
 */
- (void)verifyDeselect {
  XCTAssertNil(_bottomNavigationBarController.selectedViewController,
               @"Expected bottom navigation bar's selected view controller to be nil on deselect.");
  XCTAssertNil(_bottomNavigationBarController.navigationBar.selectedItem,
               @"Expected bottom navigation bar's selected item to be nil on deselect");
  XCTAssertEqual(_bottomNavigationBarController.selectedIndex, NSNotFound,
                 @"Expected bottom navigation bar's selected index to be NSNotFound");
}

/**
 * Verifies that the given method signature and arguments match the expected signature and
 * arguments.
 */
- (void)verifyDelegateMethodCall:(NSString *)signature arguments:(NSArray<id> *)arguments {
  XCTAssertEqual(arguments.count, _expectedArguments.count,
                 @"The expected arguments and given arguments lengths of the method, %@, are "
                 @"different lengths.",
                 _delegateExpecation.description);
  XCTAssert([signature isEqualToString:_delegateExpecation.description],
            @"Expected %@ method signature, received %@", _delegateExpecation.description,
            signature);

  for (NSUInteger i = 0; i < arguments.count; i++) {
    XCTAssertEqualObjects(arguments[i], _expectedArguments[i],
                          @"The method argument at index %lu did not equal the expected value. "
                          @"Expected: %@ Received: %@",
                          (unsigned long)i, _expectedArguments[i], arguments[i]);
  }
}

/**
 * Returns the string equivalent for the given boolean.
 */
- (NSString *)boolToString:(BOOL)val {
  return (val) ? @"YES" : @"NO";
}

@end
