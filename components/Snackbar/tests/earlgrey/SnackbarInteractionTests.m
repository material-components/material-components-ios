/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
#import <EarlGrey/EarlGrey.h>

@interface SnackbarEarlGreyTests : XCTestCase

@end

@implementation SnackbarEarlGreyTests

/**
 Scrolls the element matched by @c scrollableMatcher in the specified direction until @c matcher
 evaluates as true.

 @param matcher a matcher for target element
 @param scrollableMatcher a matcher for the scrollable view
 @param direction the scroll direction
 @param step the amount to scroll in each repeated step until the target element is found. If @c
             step is non-positive, a default value is used.
 @param action a GREYAction to perform after scrolling
 */
+ (void)scrollToElementWithMatcher:(nonnull id<GREYMatcher>)matcher
              inElementWithMatcher:(nonnull id<GREYMatcher>)scrollableMatcher
                         direction:(GREYDirection)direction
                          withStep:(NSInteger)step
                            action:(nullable id<GREYAction>)action {
  if (step <= 0) {
    step = [UIApplication sharedApplication].delegate.window.bounds.size.height / 2;
  }

  GREYElementInteraction *interaction = [EarlGrey selectElementWithMatcher:matcher];
  id<GREYAction> scrollAction = grey_scrollInDirection(direction, step);
  interaction = [interaction usingSearchAction:scrollAction onElementWithMatcher:scrollableMatcher];
  if (action) {
    [interaction performAction:action];
  }
}

/**
 Scrolls the element with accessibilityIdentifier @c scrollableIdentifier until the element with
 @c identifier is sufficiently visible and interactable.

 @param identifier the accessibilityIdentifier of the element to make visible
 @param scrollableIdentifier the accessibilityIdentifier of the element to scroll
 @param direction the scroll direction
 @param step the amount to scroll in each repeated step until the target element is found. If @c
             step is non-positive, a default value is used.
 @param tap YES if a tap should be performed on the element once it is visible
 */
+ (void)scrollToElementWithIdentifier:(nonnull NSString *)identifier
              inElementWithIdentifier:(nonnull NSString *)scrollableIdentifier
                            direction:(GREYDirection)direction
                             withStep:(NSInteger)step
                                  tap:(BOOL)tap {
  id<GREYMatcher> targetMatcher = grey_allOfMatchers(
      @[ grey_accessibilityID(identifier), grey_sufficientlyVisible(), grey_interactable() ]);
  id<GREYMatcher> scrollableMatcher = grey_accessibilityID(scrollableIdentifier);
  [SnackbarEarlGreyTests scrollToElementWithMatcher:targetMatcher
                               inElementWithMatcher:scrollableMatcher
                                          direction:direction
                                           withStep:step
                                             action:tap ? grey_tap() : nil];
}

/**
 Navigates to a specific Example screen given an array of "breadcrumb" identifiers.

 @param breadcrumbs an array of identifiers for the example to open.

 @note Only the first two elements are currently handled.
 */
+ (void)jumpToExampleWithBreadcrumbs:(NSArray<NSString *> *)breadcrumbs {
  NSAssert(breadcrumbs.count >= 1, @"Breadcrumb paths must be at least 1 element.");
  [SnackbarEarlGreyTests scrollToElementWithIdentifier:breadcrumbs[0]
                               inElementWithIdentifier:@"collectionView"
                                             direction:kGREYDirectionDown
                                              withStep:-1
                                                   tap:YES];
  NSString *demoName =
      breadcrumbs.count >= 2 ? [NSString stringWithFormat:@"Cell%@", breadcrumbs[1]]
                             : @"start.demo";
  [SnackbarEarlGreyTests
      scrollToElementWithIdentifier:demoName
            inElementWithIdentifier:[NSString stringWithFormat:@"Table%@", breadcrumbs[0]]
                          direction:kGREYDirectionDown
                           withStep:-1
                                tap:YES];
}

+ (void)returnToMainScreen {
  // Leave the Demo view
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"back_bar_button")]
      performAction:grey_tap()];
  // Leave the Snackbar view
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"back_bar_button")]
      performAction:grey_tap()];
  // Scroll to the top of the main screen
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"collectionView")]
   performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
}

- (void)testSliding {
  [SnackbarEarlGreyTests jumpToExampleWithBreadcrumbs:@[ @"Snackbar"]];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"Simple Snackbar")]
      performAction:grey_tap()];
  [SnackbarEarlGreyTests returnToMainScreen];
}

@end
