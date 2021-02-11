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

#import "MDCFlexibleHeaderView+ShiftBehavior.h"
#import "MDCFlexibleHeaderShifter.h"

#import "MaterialFlexibleHeader+ShiftBehaviorEnabledWithStatusBar.h"

#import <XCTest/XCTest.h>

@interface FlexibleHeaderShifterTests : XCTestCase
@end

@implementation FlexibleHeaderShifterTests

- (void)testDefaults {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];

  // Then
  XCTAssertNil(shifter.trackingScrollView);
  XCTAssertEqual(shifter.behavior, MDCFlexibleHeaderShiftBehaviorDisabled);
  XCTAssertFalse(shifter.hidesStatusBarWhenShiftedOffscreen);
}

#pragma mark - behavior

- (void)testBehaviorSetterPersistsTheSetValue {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];

  // When
  shifter.behavior = MDCFlexibleHeaderShiftBehaviorEnabled;

  // Then
  XCTAssertEqual(shifter.behavior, MDCFlexibleHeaderShiftBehaviorEnabled);
}

#pragma mark - trackingScrollView

- (void)testTrackingScrollViewIsWeaklyHeld {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];

  // When
  @autoreleasepool {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    shifter.trackingScrollView = scrollView;
  }

  // Then
  XCTAssertNil(shifter.trackingScrollView);
}

#pragma mark - -hidesStatusBarWhenShiftedOffscreen

- (void)testDoesNotHideStatusBarWhenShiftBehaviorEnabled {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];

  // When
  shifter.behavior = MDCFlexibleHeaderShiftBehaviorEnabled;

  // Then
  XCTAssertFalse(shifter.hidesStatusBarWhenShiftedOffscreen);
}

- (void)testHidesStatusBarWhenShiftBehaviorEnabledWithStatusBar {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];

  // When
  shifter.behavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;

  // Then
  XCTAssertTrue(shifter.hidesStatusBarWhenShiftedOffscreen);
}

- (void)testHidesStatusBarWhenHideable {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];

  // When
  shifter.behavior = MDCFlexibleHeaderShiftBehaviorHideable;

  // Then
  XCTAssertTrue(shifter.hidesStatusBarWhenShiftedOffscreen);
}

- (void)
    testDoesNotHideStatusBarWhenShiftBehaviorEnabledWithStatusBarAndTrackingScrollViewPagingEnabled {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  shifter.trackingScrollView = scrollView;

  // When
  shifter.behavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
  scrollView.pagingEnabled = YES;

  // Then
  XCTAssertFalse(shifter.hidesStatusBarWhenShiftedOffscreen);
  XCTAssertNotNil(scrollView);  // Keep a strong reference to the tracking scroll view.
}

- (void)testDoesNotHideStatusBarWhenHideableAndTrackingScrollViewPagingEnabled {
  // Given
  MDCFlexibleHeaderShifter *shifter = [[MDCFlexibleHeaderShifter alloc] init];
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  shifter.trackingScrollView = scrollView;

  // When
  shifter.behavior = MDCFlexibleHeaderShiftBehaviorHideable;
  scrollView.pagingEnabled = YES;

  // Then
  XCTAssertFalse(shifter.hidesStatusBarWhenShiftedOffscreen);
  XCTAssertNotNil(scrollView);  // Keep a strong reference to the tracking scroll view.
}

#pragma mark - +behaviorForCurrentContextFromBehavior:

- (void)testBehaviorForGivenContextReturnsSameContext {
  // TODO(b/156978412): Test this in an app extension target as well.
  XCTAssertEqual([MDCFlexibleHeaderShifter
                     behaviorForCurrentContextFromBehavior:MDCFlexibleHeaderShiftBehaviorDisabled],
                 MDCFlexibleHeaderShiftBehaviorDisabled);
  XCTAssertEqual([MDCFlexibleHeaderShifter
                     behaviorForCurrentContextFromBehavior:MDCFlexibleHeaderShiftBehaviorEnabled],
                 MDCFlexibleHeaderShiftBehaviorEnabled);
  XCTAssertEqual(
      [MDCFlexibleHeaderShifter
          behaviorForCurrentContextFromBehavior:MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar],
      MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar);
  XCTAssertEqual([MDCFlexibleHeaderShifter
                     behaviorForCurrentContextFromBehavior:MDCFlexibleHeaderShiftBehaviorHideable],
                 MDCFlexibleHeaderShiftBehaviorHideable);
}

@end
