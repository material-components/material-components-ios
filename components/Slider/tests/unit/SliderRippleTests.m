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

#import "MDCInkTouchController.h"
#import "MDCInkView.h"
#import "MDCPalettes.h"
#import "MDCRippleView.h"
#import "MDCSlider.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCSlider+Private.h"
#import "MDCThumbTrack.h"
#import "MDCThumbView.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

@interface MDCThumbTrack (Testing)
@property(nonatomic, strong, nullable) MDCRippleView *rippleView;
@property(nonatomic, strong, nullable) MDCInkTouchController *touchController;
@end

/**
 This class confirms behavior of @c MDCSlider when used with @c MDCRippleView.
 */
@interface SliderRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCSlider *slider;

@end

@implementation SliderRippleTests

- (void)setUp {
  [super setUp];

  self.slider = [[MDCSlider alloc] init];
}

- (void)tearDown {
  self.slider = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCSlider without any customization.
 */
- (void)testRippleIsDisabledAndThatItsPropertiesAreSetUpCorrectly {
  // Then
  XCTAssertNotNil(self.slider.thumbTrack.rippleView);
  XCTAssertEqualObjects(self.slider.thumbTrack.rippleView.rippleColor,
                        [MDCPalette.bluePalette.tint500 colorWithAlphaComponent:(CGFloat)0.5]);
  XCTAssertEqual(self.slider.thumbTrack.rippleView.rippleStyle, MDCRippleStyleUnbounded);
  XCTAssertFalse(self.slider.enableRippleBehavior);
  XCTAssertFalse(self.slider.thumbTrack.enableRippleBehavior);
  XCTAssertTrue(self.slider.thumbTrack.shouldDisplayRipple);
  XCTAssertNil(self.slider.thumbTrack.rippleView.superview);
}

/**
 Test to confirm that setting @c enableRippleBehavior adds the @c rippleView as a subview.
 */
- (void)testRippleIsEnabledAndThatItsPropertiesAreSetUpCorrectlyWhenRippleBehaviorIsEnabled {
  // When
  self.slider.enableRippleBehavior = YES;

  // Then
  XCTAssertNil(self.slider.thumbTrack.touchController.defaultInkView.superview);
  XCTAssertEqual(self.slider.thumbTrack.rippleView.superview, self.slider.thumbTrack.thumbView);
  CGFloat thumbViewRadius = self.slider.thumbTrack.thumbRadius;
  CGSize visibleThumbViewSize = CGSizeMake(2 * thumbViewRadius, 2 * thumbViewRadius);
  CGRect rippleBounds = CGRectStandardize(self.slider.thumbTrack.rippleView.bounds);
  XCTAssertTrue(CGSizeEqualToSize(visibleThumbViewSize, rippleBounds.size),
                @"%@ is not equal to %@", NSStringFromCGSize(visibleThumbViewSize),
                NSStringFromCGSize(rippleBounds.size));
}

/**
 Test to confirm toggling @c enableRippleBehavior removes the @c rippleView as a subview.
 */
- (void)testSetEnableRippleBehaviorToYesThenNoRemovesRippleViewAsSubviewOfThumbView {
  // When
  self.slider.enableRippleBehavior = YES;
  self.slider.enableRippleBehavior = NO;

  // Then
  XCTAssertEqual(self.slider.thumbTrack.touchController.defaultInkView.superview,
                 self.slider.thumbTrack.thumbView);
  XCTAssertNil(self.slider.thumbTrack.rippleView.superview);
}

/**
 Test setting @c rippleColor correctly sets the @c rippleColor on @c rippleView of the slider.
 */
- (void)testSetCustomRippleColorUpdatesRippleView {
  // Given
  UIColor *color = UIColor.redColor;

  // When
  self.slider.rippleColor = color;

  // Then
  XCTAssertEqualObjects(self.slider.thumbTrack.rippleView.rippleColor, color);
}

@end

NS_ASSUME_NONNULL_END
