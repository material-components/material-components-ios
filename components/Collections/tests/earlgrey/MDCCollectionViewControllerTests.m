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

@interface MDCCollectionViewControllerTests : XCTestCase
@end

@implementation MDCCollectionViewControllerTests

#pragma mark - Navigation helpers
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
    step = [UIApplication sharedApplication].delegate.window.bounds.size.height / 2.0f;
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
  [MDCCollectionViewControllerTests scrollToElementWithMatcher:targetMatcher
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
  NSAssert(breadcrumbs.count >= 2, @"Breadcrumb paths must be at least 2 elements.");
  [MDCCollectionViewControllerTests scrollToElementWithIdentifier:breadcrumbs[0]
                                          inElementWithIdentifier:@"collectionView"
                                                        direction:kGREYDirectionDown
                                                         withStep:-1
                                                              tap:YES];
  [MDCCollectionViewControllerTests
      scrollToElementWithIdentifier:[NSString stringWithFormat:@"Cell%@", breadcrumbs[1]]
            inElementWithIdentifier:[NSString stringWithFormat:@"Table%@", breadcrumbs[0]]
                          direction:kGREYDirectionDown
                           withStep:-1
                                tap:YES];
}

/**
 Navigates back to the main screen from the Custom Section Insets example screen.
 */
+ (void)returnToMainScreen {
  // Leave the Custom Section Insets view
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"back_bar_button")]
      performAction:grey_tap()];
  // Leave the Collections view
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"back_bar_button")]
      performAction:grey_tap()];
  // Scroll to the top of the main screen
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"collectionView")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
}

#pragma mark - Property accessors

/**
 Returns a GREYActionBlock that retrieves the @c numberOfSections property value from a
 UICollectionView.

 @param numberOfSections inout parameter for storing the number of sections value.
 */
+ (GREYActionBlock *)getNumberOfSections:(NSInteger *)numberOfSections {
  return [GREYActionBlock
      actionWithName:@"getNumberOfSectionsFromUICollectionView"
         constraints:grey_respondsToSelector(@selector(numberOfSections))
        performBlock:^BOOL(UICollectionView *collectionView, NSError *__strong *errorOrNil) {
          *numberOfSections = collectionView.numberOfSections;
          return YES;
        }];
}

/**
 Returns a GREYActionBlock that retrieves the @c bounds property value from a UIView.

 @param bounds inout parameter for storing the bounds value.
 */
+ (GREYActionBlock *)getBounds:(CGRect *)bounds {
  return [GREYActionBlock actionWithName:@"getBoundsFromUIView"
                             constraints:grey_respondsToSelector(@selector(bounds))
                            performBlock:^BOOL(UIView *view, NSError *__strong *errorOrNil) {
                              *bounds = view.bounds;
                              return YES;
                            }];
}

#pragma mark - EarlGrey assertions

/**
 Returns a GREYAssertionBlock that will XCTAssert that the selected element's bounds width is less
 than or equal to the passed width.

 @param width the width value for comparison.
 */
- (GREYAssertionBlock *)assertBoundsWidthLessThan:(CGFloat)width {
  return
      [GREYAssertionBlock assertionWithName:@"boundsAreGreaterOrEqualThanOtherBounds"
                    assertionBlockWithError:^BOOL(UIView *element, NSError *__strong *errorOrNil) {
                      XCTAssertLessThan(element.bounds.size.width, width,
                                        @"View's width is not less than or equal to the expected "
                                         "width.");
                      return YES;
                    }];
}

#pragma mark - Tests

/**
 Tests that the width of the bounds of each section is less than the width of the bounds of the one
 above (before) it.
 */
- (void)testEachSectionWidthLessThanSectionAbove {
  [MDCCollectionViewControllerTests
      jumpToExampleWithBreadcrumbs:@[ @"Collections", @"Custom Section Insets" ]];

  // Get the number of sections in the example collection view
  NSInteger totalSections;
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(
                                          @"collectionsCustomSectionInsetsCollectionView")]
      performAction:[MDCCollectionViewControllerTests getNumberOfSections:&totalSections]];

  // Step through each section and confirm that the bounds are no greater than the one above it
  CGRect bounds = CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX);
  for (int section = 0; section < totalSections; ++section) {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%d.0", section];
    [MDCCollectionViewControllerTests
        scrollToElementWithIdentifier:cellIdentifier
              inElementWithIdentifier:@"collectionsCustomSectionInsetsCollectionView"
                            direction:kGREYDirectionDown
                             withStep:-1
                                  tap:NO];
    [MDCCollectionViewControllerTests
        scrollToElementWithMatcher:grey_allOfMatchers(@[
          grey_kindOfClass([UISwitch class]), grey_ancestor(grey_accessibilityID(cellIdentifier)),
          grey_sufficientlyVisible(), grey_interactable()
        ])
              inElementWithMatcher:grey_accessibilityID(
                                       @"collectionsCustomSectionInsetsCollectionView")
                         direction:kGREYDirectionDown
                          withStep:-1
                            action:grey_turnSwitchOn(YES)];
    [[[EarlGrey selectElementWithMatcher:grey_accessibilityID(cellIdentifier)]
        assert:[self assertBoundsWidthLessThan:bounds.size.width]]
        performAction:[MDCCollectionViewControllerTests getBounds:&bounds]];
  }

  [MDCCollectionViewControllerTests returnToMainScreen];
}

@end
