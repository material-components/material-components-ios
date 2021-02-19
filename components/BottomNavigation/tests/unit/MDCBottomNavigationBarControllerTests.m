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

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "MaterialBottomNavigation+BottomNavigationController.h"
#import "MaterialBottomNavigation.h"

static CGFloat const kDefaultExpectationTimeout = 15;

/**
 A coder object used for testing state restoration of the bottom navigation bar controller.
 References to encoded objects are stored in memory and retained by this object.
 @warning Not all @c NSCoder methods are implemented as they are not needed at the time of
 writing. If the implementation of encoding/decoding the bottom navigation bar controller changes,
 this coder's impementation may need to be extended to support other types.
 */
@interface MDCBottomNavigationBarControllerTestRestorationArchive : NSCoder

/** The archive that contains the objects encoded by the coder. */
@property(nonatomic, nonnull, readonly) NSMutableDictionary<NSString *, id> *objectArchive;

@end

@implementation MDCBottomNavigationBarControllerTestRestorationArchive

- (instancetype)init {
  self = [super init];
  if (self) {
    _objectArchive = [NSMutableDictionary dictionary];
  }

  return self;
}

- (BOOL)allowsKeyedCoding {
  return YES;
}

- (BOOL)containsValueForKey:(NSString *)key {
  if (!key) {
    return NO;
  }

  return self.objectArchive[key] != nil;
}

- (void)encodeObject:(id)object {
  if ([object respondsToSelector:@selector(restorationIdentifier)]) {
    [self encodeObject:object forKey:[object restorationIdentifier]];
  }
}

- (void)encodeObject:(id)object forKey:(NSString *)key {
  if (!key) {
    return;
  }

  self.objectArchive[key] = object;
}

- (id)decodeObjectForKey:(NSString *)key {
  return self.objectArchive[key];
}

@end

@interface MDCBottomNavigationBarControllerTests
    : XCTestCase <MDCBottomNavigationBarControllerDelegate>

/** The bottom navigation controller to test. */
@property(nonatomic, strong, nonnull)
    MDCBottomNavigationBarController *bottomNavigationBarController;

/**
 Is fufilled when the a delegate method is called. Set the description of the expectation with the
 string value of the selector of the method you are expecting to be called.
 */
@property(nonatomic, strong, nullable) XCTestExpectation *delegateExpecation;

/**
 An array of the values of the expected arguments the delegate method should be called with. The
 order of the array is the order the arguments appear in the method signature.
 */
@property(nonatomic, strong, nullable) NSArray<id> *expectedArguments;

/** The return value a delegate method should return with. */
@property(nonatomic, strong, nullable) id delegateReturnValue;

@end

@implementation MDCBottomNavigationBarControllerTests

- (void)setUp {
  [super setUp];
  self.bottomNavigationBarController = [[MDCBottomNavigationBarController alloc] init];
}

- (void)tearDown {
  _bottomNavigationBarController = nil;

  [super tearDown];
}

- (void)testSetViewControllers {
  // Given
  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Title1" image:nil tag:0];
  UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Title2" image:nil tag:1];
  NSArray<UITabBarItem *> *tabBarItems = @[ tabBarItem1, tabBarItem2 ];

  UIViewController *viewController1 = [[UIViewController alloc] init];
  UIViewController *viewController2 = [[UIViewController alloc] init];

  viewController1.tabBarItem = tabBarItem1;
  viewController2.tabBarItem = tabBarItem2;

  // When
  self.bottomNavigationBarController.viewControllers = @[ viewController1, viewController2 ];

  // Then
  XCTAssertEqual(
      self.bottomNavigationBarController.navigationBar.items.count, tabBarItems.count,
      @"The number of items in the bottom navigation bar's items property does not match the "
      @"number of items set in the test");

  XCTAssertEqual(viewController1, self.bottomNavigationBarController.selectedViewController);
  // Check each item in the navigation bar.
  int count = (int)[tabBarItems count];
  for (int i = 0; i < count; i++) {
    UITabBarItem *expectedItem = [tabBarItems objectAtIndex:i];
    UITabBarItem *item = [self.bottomNavigationBarController.navigationBar.items objectAtIndex:i];
    XCTAssertEqualObjects(expectedItem.title, item.title, @"Unexpected title value at index: %i",
                          i);
    XCTAssertEqual(expectedItem.tag, item.tag, @"Unexpected tag value at index: %i", i);
  }
}

- (void)testSelectionBySettingSelectedIndex {
  // Given
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // When
  NSUInteger index = 1;
  self.bottomNavigationBarController.selectedIndex = index;

  // Then
  [self verifyStateOfSelectedIndex:index];
}

- (void)testDeselectBySettingSelectedIndex {
  // Given
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  self.bottomNavigationBarController.selectedIndex = 0;

  // When
  self.bottomNavigationBarController.selectedIndex = NSNotFound;

  // Then
  [self verifyDeselect];
}

- (void)testSelectionBySettingSelectedViewController {
  // Given
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Then
  NSUInteger index = 1;
  UIViewController *selectedViewController =
      [self.bottomNavigationBarController.viewControllers objectAtIndex:index];
  self.bottomNavigationBarController.selectedViewController = selectedViewController;

  // Then
  [self verifyStateOfSelectedIndex:index];
}

- (void)testDeselectBySettingSelectedViewController {
  // Given
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  UIViewController *firstSelect =
      [self.bottomNavigationBarController.viewControllers objectAtIndex:0];
  self.bottomNavigationBarController.selectedViewController = firstSelect;

  // When
  self.bottomNavigationBarController.selectedViewController = nil;

  // Then
  [self verifyDeselect];
}

- (void)testOutOfBoundsSelectionBySettingSelectedIndex {
  // Given
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  self.bottomNavigationBarController.selectedIndex = 0;

  // When/Then
  XCTAssertThrowsSpecificNamed(
      [self.bottomNavigationBarController setSelectedIndex:100], NSException,
      NSInternalInconsistencyException,
      @"Expected NSAssert to fire exception when setting an index out of bounds");
}

- (void)testOutOfBoundsSelectionBySettingSelectedViewController {
  // Given
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];
  self.bottomNavigationBarController.selectedViewController =
      [self.bottomNavigationBarController.viewControllers objectAtIndex:0];

  // When/Then
  UIViewController *newViewController = [[UIViewController alloc] init];
  XCTAssertThrowsSpecificNamed(
      [self.bottomNavigationBarController setSelectedViewController:newViewController], NSException,
      NSInternalInconsistencyException,
      @"Expected NSAssert to fire an exception when setting the bottom bar's selected view "
      @"controller to one it does not own");
}

- (void)testDidSelectItemDelegateMethod {
  // Given
  self.bottomNavigationBarController.delegate = self;
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Create the expectation
  NSString *signature = NSStringFromSelector(@selector(bottomNavigationBarController:
                                                             didSelectViewController:));
  self.delegateExpecation = [self expectationWithDescription:signature];

  // The index of the view controller we want to select.
  NSUInteger index = 0;
  UIViewController *selectedViewController =
      [self.bottomNavigationBarController.viewControllers objectAtIndex:index];

  // The corresponding tab bar item we want to select.
  UITabBarItem *selectedItem =
      [self.bottomNavigationBarController.navigationBar.items objectAtIndex:index];

  // The arguments we are expecting from the delegate.
  self.expectedArguments = @[ self.bottomNavigationBarController, selectedViewController ];

  // When
  [self.bottomNavigationBarController
      bottomNavigationBar:self.bottomNavigationBarController.navigationBar
            didSelectItem:selectedItem];

  // Then
  XCTAssertEqual(self.bottomNavigationBarController.selectedViewController, selectedViewController,
                 @"Expected the selected view controller of the navigation controller to be equal "
                 @"to the navigation bar's tab bar item's corresponding view controller.");
  XCTAssertEqual(self.bottomNavigationBarController.selectedIndex, index,
                 @"Expected the selected index of the navigation controller to be equal to the "
                 @"selected view controller.");

  // Test to see if the delegate method was called.
  [self waitForExpectationsWithTimeout:kDefaultExpectationTimeout handler:nil];
}

- (void)testShouldNotSelectItemDelegateMethod {
  // Given
  self.bottomNavigationBarController.delegate = self;
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // Get the selected view controller and items for an index.
  NSUInteger index = 0;
  UIViewController *shouldSelectViewController =
      [self.bottomNavigationBarController.viewControllers objectAtIndex:index];
  UITabBarItem *selectedItem =
      [self.bottomNavigationBarController.navigationBar.items objectAtIndex:index];
  self.expectedArguments = @[ self.bottomNavigationBarController, shouldSelectViewController ];
  self.delegateReturnValue = [NSNumber numberWithBool:NO];

  // Create the expectation.
  NSString *signature = NSStringFromSelector(@selector(bottomNavigationBarController:
                                                          shouldSelectViewController:));
  self.delegateExpecation = [self expectationWithDescription:signature];

  // When
  BOOL returnValue = [self.bottomNavigationBarController
      bottomNavigationBar:self.bottomNavigationBarController.navigationBar
         shouldSelectItem:selectedItem];

  // Then
  XCTAssertEqual([self.delegateReturnValue boolValue], returnValue,
                 @"Expected %@ to return with %@.  Received: %@", signature,
                 [self boolToString:[self.delegateReturnValue boolValue]],
                 [self boolToString:returnValue]);

  // Test that the delegate method was called.
  [self waitForExpectationsWithTimeout:kDefaultExpectationTimeout handler:nil];
}

- (void)testShouldNotSetNavigationBarItemsWithNoExistingViewControllers {
  // Given
  NSArray<UITabBarItem *> *tabBarItems = @[
    [[UITabBarItem alloc] initWithTitle:@"Tab 1" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Tab 2" image:nil tag:1]
  ];

  // When/Then
  XCTAssertThrowsSpecificNamed(self.bottomNavigationBarController.navigationBar.items = tabBarItems,
                               NSException, NSInternalInconsistencyException);
}

- (void)testShouldNotSetNavigationBarItemsWithExistingViewControllers {
  // Given
  NSArray<UITabBarItem *> *tabBarItems = @[
    [[UITabBarItem alloc] initWithTitle:@"Tab 1" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Tab 2" image:nil tag:1]
  ];
  self.bottomNavigationBarController.viewControllers = [self createArrayOfTwoFakeViewControllers];

  // When/Then
  XCTAssertThrowsSpecificNamed(self.bottomNavigationBarController.navigationBar.items = tabBarItems,
                               NSException, NSInternalInconsistencyException);
}

- (void)testSettingViewControllersUpdatesChildViewControllers {
  // Given
  UIViewController *childViewController1 = [[UIViewController alloc] init];
  UIViewController *childViewController2 = [[UIViewController alloc] init];

  // When
  self.bottomNavigationBarController.viewControllers =
      @[ childViewController1, childViewController2 ];

  // Then
  XCTAssertEqual(self.bottomNavigationBarController.viewControllers.count, 2U);
  XCTAssertEqual(self.bottomNavigationBarController.childViewControllers.count, 2U);
  XCTAssertEqual(self.bottomNavigationBarController.viewControllers.firstObject,
                 childViewController1);
  XCTAssertEqual(self.bottomNavigationBarController.selectedViewController, childViewController1);
}

- (void)testSettingViewControllersEmptyUpdatesChildViewControllers {
  // Given
  UIViewController *childViewController = [[UIViewController alloc] init];
  self.bottomNavigationBarController.viewControllers = @[ childViewController ];

  // When
  self.bottomNavigationBarController.viewControllers = @[];

  // Then
  XCTAssertEqual(self.bottomNavigationBarController.viewControllers.count, 0U);
  XCTAssertEqual(self.bottomNavigationBarController.childViewControllers.count, 0U);
  XCTAssertNil(self.bottomNavigationBarController.selectedViewController);
}

- (void)testNonSelectedViewControllersHaveViewsLazilyLoaded {
  // Given
  UIViewController *childViewController1 = [[UIViewController alloc] init];
  UIViewController *childViewController2 = [[UIViewController alloc] init];

  // When
  self.bottomNavigationBarController.viewControllers =
      @[ childViewController1, childViewController2 ];

  // Then
  XCTAssertTrue(childViewController1.viewLoaded);
  XCTAssertFalse(childViewController2.viewLoaded);
}

- (void)testEncodesChildViewControllersWhenPreservingRestorationState {
  // Given
  UIViewController *childViewController1 = [[UIViewController alloc] init];
  childViewController1.restorationIdentifier = @"vc1";

  UIViewController *childViewController2 = [[UIViewController alloc] init];
  childViewController2.restorationIdentifier = @"vc2";

  self.bottomNavigationBarController.viewControllers =
      @[ childViewController1, childViewController2 ];
  MDCBottomNavigationBarControllerTestRestorationArchive *coder =
      [[MDCBottomNavigationBarControllerTestRestorationArchive alloc] init];

  // When
  [self.bottomNavigationBarController encodeRestorableStateWithCoder:coder];

  // Then
  XCTAssertEqualObjects(coder.objectArchive[childViewController1.restorationIdentifier],
                        childViewController1);
  XCTAssertEqualObjects(coder.objectArchive[childViewController2.restorationIdentifier],
                        childViewController2);
}

- (void)testDecodingControllerAndChildViewControllersState {
  // Given
  NSString *title1 = @"vc1";
  UIViewController *childViewController1 = [[UIViewController alloc] init];
  childViewController1.restorationIdentifier = @"vc1";
  childViewController1.title = title1;

  NSString *title2 = @"title2";
  UIViewController *childViewController2 = [[UIViewController alloc] init];
  childViewController2.restorationIdentifier = @"vc2";
  childViewController2.title = title2;

  self.bottomNavigationBarController.viewControllers =
      @[ childViewController1, childViewController2 ];
  self.bottomNavigationBarController.selectedViewController = childViewController2;
  MDCBottomNavigationBarControllerTestRestorationArchive *coder =
      [[MDCBottomNavigationBarControllerTestRestorationArchive alloc] init];

  // When
  [self.bottomNavigationBarController encodeRestorableStateWithCoder:coder];
  self.bottomNavigationBarController.selectedViewController = childViewController1;
  [self.bottomNavigationBarController decodeRestorableStateWithCoder:coder];

  // Then
  XCTAssertEqualObjects(self.bottomNavigationBarController.selectedViewController,
                        childViewController2);
  XCTAssertEqualObjects(self.bottomNavigationBarController.viewControllers[0].title, title1);
  XCTAssertEqualObjects(self.bottomNavigationBarController.viewControllers[1].title, title2);
}

- (void)testOverwritesAdditionalSafeAreaInsetsOfSelectedViewController {
  // Given
  UIViewController *childViewController1 = [[UIViewController alloc] init];
  UIViewController *childViewController2 = [[UIViewController alloc] init];
  const UIEdgeInsets originalAdditionalSafeAreaInsets = UIEdgeInsetsMake(1, 2, 3, 4);
  if (@available(iOS 11.0, *)) {
    childViewController1.additionalSafeAreaInsets = originalAdditionalSafeAreaInsets;
    childViewController2.additionalSafeAreaInsets = originalAdditionalSafeAreaInsets;
  }

  // When
  self.bottomNavigationBarController.viewControllers =
      @[ childViewController1, childViewController2 ];
  [self.bottomNavigationBarController.view layoutIfNeeded];

  // Then
  const UIEdgeInsets expectedAdditionalSafeaAreaInsets = UIEdgeInsetsMake(
      0, 0, CGRectGetHeight(self.bottomNavigationBarController.navigationBar.bounds), 0);
  XCTAssertEqual(self.bottomNavigationBarController.selectedViewController, childViewController1);
  if (@available(iOS 11.0, *)) {
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(childViewController1.additionalSafeAreaInsets,
                                                expectedAdditionalSafeaAreaInsets),
                  @"(%@) is not equal to (%@)",
                  NSStringFromUIEdgeInsets(childViewController1.additionalSafeAreaInsets),
                  NSStringFromUIEdgeInsets(expectedAdditionalSafeaAreaInsets));
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(childViewController2.additionalSafeAreaInsets,
                                                originalAdditionalSafeAreaInsets),
                  @"(%@) is not equal to (%@)",
                  NSStringFromUIEdgeInsets(childViewController2.additionalSafeAreaInsets),
                  NSStringFromUIEdgeInsets(originalAdditionalSafeAreaInsets));
  }
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
  [self.delegateExpecation fulfill];

  return [self.delegateReturnValue boolValue];
}

#pragma mark - Helper Methods

- (NSArray<UIViewController *> *)createArrayOfTwoFakeViewControllers {
  UIViewController *viewController1 = [[UIViewController alloc] init];
  UIViewController *viewController2 = [[UIViewController alloc] init];

  viewController1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore
                                                                          tag:0];
  viewController2.tabBarItem =
      [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];

  return @[ viewController1, viewController2 ];
}

/**
 Verifies the state of the bottom navigation bar controller for the given expected selected index.
 */
- (void)verifyStateOfSelectedIndex:(NSUInteger)index {
  XCTAssertEqual(
      self.bottomNavigationBarController.selectedIndex, index,
      @"Expected bottom navigation bar controller's selected index to be %lu. Received: %lu",
      (unsigned long)index, (unsigned long)self.bottomNavigationBarController.selectedIndex);

  UIViewController *expectedVC =
      [self.bottomNavigationBarController.viewControllers objectAtIndex:index];
  XCTAssertEqualObjects(self.bottomNavigationBarController.selectedViewController, expectedVC,
                        @"Expected bottom navigation bar's selected view controller to be equal to "
                        @"the view controller at index: %lu",
                        (unsigned long)index);

  UITabBarItem *expectedItem =
      [self.bottomNavigationBarController.navigationBar.items objectAtIndex:index];
  XCTAssertEqualObjects(
      self.bottomNavigationBarController.navigationBar.selectedItem, expectedItem,
      @"Expected bottom navigation bar's selected item to be equal to the item at index: %lu",
      (unsigned long)index);
}

/** Verifies that the bottom navigation controller has no view controller selected. */
- (void)verifyDeselect {
  XCTAssertNil(self.bottomNavigationBarController.selectedViewController,
               @"Expected bottom navigation bar's selected view controller to be nil on deselect.");
  XCTAssertNil(self.bottomNavigationBarController.navigationBar.selectedItem,
               @"Expected bottom navigation bar's selected item to be nil on deselect");
  XCTAssertEqual(self.bottomNavigationBarController.selectedIndex, NSNotFound,
                 @"Expected bottom navigation bar's selected index to be NSNotFound");
}

/**
 Verifies that the given method signature and arguments match the expected signature and arguments.
 */
- (void)verifyDelegateMethodCall:(NSString *)signature arguments:(NSArray<id> *)arguments {
  XCTAssertEqual(self.expectedArguments.count, arguments.count,
                 @"The expected arguments and given arguments lengths of the method, %@, are "
                 @"different lengths.",
                 self.delegateExpecation.description);
  XCTAssertEqualObjects(self.delegateExpecation.description, signature,
                        @"Expected %@ method signature, received %@",
                        self.delegateExpecation.description, signature);

  for (NSUInteger i = 0; i < arguments.count; i++) {
    XCTAssertEqualObjects(self.expectedArguments[i], arguments[i],
                          @"The method argument at index %lu did not equal the expected value. "
                          @"Expected: %@ Received: %@",
                          (unsigned long)i, self.expectedArguments[i], arguments[i]);
  }
}

/** Returns the string equivalent for the given boolean. */
- (NSString *)boolToString:(BOOL)val {
  return (val) ? @"YES" : @"NO";
}

@end
