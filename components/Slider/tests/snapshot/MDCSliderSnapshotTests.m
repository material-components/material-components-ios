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

#import "MDCAvailability.h"
#import "MDCSlider.h"

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCSlider+Private.h"
#import "MDCSnapshotTestCase.h"
#import "UIView+MDCSnapshot.h"
#import "MDCThumbTrack.h"
#import "MDCThumbView.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

/** A @c UITouch subclass where the location can be set. */
@interface MDCSliderSnapshotTestTouchFake : UITouch

/** The location of the touch in the target view. */
@property(nonatomic, assign) CGPoint mdc_touchPoint;
@end

@implementation MDCSliderSnapshotTestTouchFake

- (CGPoint)locationInView:(nullable UIView *)view {
  return self.mdc_touchPoint;
}

@end

/**
 Performs a touch event on the thumb of the provided slider.

 @param slider The Slider to touch.
 @return The touch object used.
 */
static MDCSliderSnapshotTestTouchFake *TouchThumbInSlider(MDCSlider *slider) {
  CGRect thumbViewBounds = slider.thumbTrack.thumbView.bounds;
  CGPoint thumbPosition = [slider.thumbTrack
      convertPoint:CGPointMake(CGRectGetMidX(thumbViewBounds), CGRectGetMidY(thumbViewBounds))
          fromView:slider.thumbTrack.thumbView];
  MDCSliderSnapshotTestTouchFake *thumbTouch = [[MDCSliderSnapshotTestTouchFake alloc] init];
  thumbTouch.mdc_touchPoint = thumbPosition;
  [slider.thumbTrack touchesBegan:[NSSet setWithObject:thumbTouch] withEvent:nil];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
  return thumbTouch;
}

/**
 Moves the Slider Thumb to a position relative to the slider width. A relative value of 0 is the
 minimum and a relative value of 1 is the maximum.

 @param slider The Slider to touch.
 @param touch The initial touch passed to @c touchesBegan:withEvent:.
 @param relativePosition The new position of the touch, relative to the bounds of the Slider's
                         track.
 */
static void MoveSliderThumbToRelativePosition(MDCSlider *slider,
                                              MDCSliderSnapshotTestTouchFake *touch,
                                              CGFloat relativePosition) {
  // This calculation is generated from the code in MDCThumbTrack valueForThumbPosition.
  // relativeX = (thumbPosition.x - thumbRadius) / thumbPanRange
  CGPoint touchPoint = CGPointMake(
      (CGRectGetWidth(slider.thumbTrack.bounds) - (slider.thumbRadius * 2)) * relativePosition +
          slider.thumbTrack.thumbRadius,
      CGRectGetMidY(slider.thumbTrack.bounds));
  touch.mdc_touchPoint = touchPoint;
  [slider.thumbTrack touchesMoved:[NSSet setWithObject:touch] withEvent:nil];
  [NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

/**
 An MDCSlider subclass that allows the user to override the @c traitCollection property.
 */
@interface MDCSliderWithCustomTraitCollection : MDCSlider
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;

@end

@implementation MDCSliderWithCustomTraitCollection

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

@interface MDCSliderSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCSliderWithCustomTraitCollection *slider;
@end

@implementation MDCSliderSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.slider =
      [[MDCSliderWithCustomTraitCollection alloc] initWithFrame:CGRectMake(0, 0, 120, 48)];
  self.slider.statefulAPIEnabled = YES;
  self.slider.minimumValue = -10;
  self.slider.maximumValue = 10;
  self.slider.value = 0;
  self.slider.thumbHollowAtStart = YES;
  self.slider.backgroundColor = UIColor.whiteColor;
}

- (void)tearDown {
  self.slider = nil;

  [super tearDown];
}

- (void)makeSliderDiscrete:(MDCSlider *)slider {
  slider.discrete = YES;
  slider.numberOfDiscreteValues = (NSUInteger)(slider.maximumValue - slider.minimumValue + 1);
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testDiscreteSliderAtMinimum {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.value = self.slider.minimumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderAtMidpoint {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderAtMaximum {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.value = self.slider.maximumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderInactiveThumbTrackTickMarksNever {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderActiveThumbTrackTickMarksNever {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderInactiveThumbTrackTickMarksWhenDragging {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderActiveThumbTrackTickMarksWhenDragging {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderInactiveThumbTrackTickMarksAlways {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderActiveThumbTrackTickMarksAlways {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderShrinksFilledSectionWithoutCrossingAnchor {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  self.slider.filledTrackAnchorValue = 0;
  self.slider.value = self.slider.maximumValue - 3;

  // When
  self.slider.value = self.slider.filledTrackAnchorValue + 3;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderGrowsFilledSectionWithoutCrossingAnchor {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  self.slider.filledTrackAnchorValue = 0;
  self.slider.value = self.slider.filledTrackAnchorValue + 3;

  // When
  self.slider.value = self.slider.maximumValue - 3;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderCrossesAnchorAndShrinksFilledSection {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  self.slider.filledTrackAnchorValue = 0;
  self.slider.value = self.slider.maximumValue - 3;

  // When
  self.slider.value = self.slider.filledTrackAnchorValue - 3;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderCrossesAnchorAndGrowsFilledSection {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  self.slider.filledTrackAnchorValue = 0;
  self.slider.value = self.slider.filledTrackAnchorValue - 3;

  // When
  self.slider.value = self.slider.maximumValue - 3;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderAtMinimum {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;

  // When
  self.slider.value = self.slider.minimumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderAtMinimum {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;

  // When
  self.slider.value = self.slider.minimumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderAtMidpoint {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;

  // When
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderAtMidpoint {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;

  // When
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderAtMaximum {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;

  // When
  self.slider.value = self.slider.maximumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderAtMaximum {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;

  // When
  self.slider.value = self.slider.maximumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderInactiveThumbTrackTickMarksNever {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderInactiveThumbTrackTickMarksNever {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderActiveThumbTrackTickMarksNever {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderActiveThumbTrackTickMarksNever {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityNever;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderInactiveThumbTrackTickMarksWhenDragging {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderInactiveThumbTrackTickMarksWhenDragging {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderActiveThumbTrackTickMarksWhenDragging {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderActiveThumbTrackTickMarksWhenDragging {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityWhenDragging;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderInactiveThumbTrackTickMarksAlways {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderInactiveThumbTrackTickMarksAlways {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderActiveThumbTrackTickMarksAlways {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderActiveThumbTrackTickMarksAlways {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.discrete = NO;
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // When
  self.slider.trackTickVisibility = MDCSliderTrackTickVisibilityAlways;
  TouchThumbInSlider(self.slider);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderAlignsToSnappedValue {
  // Given
  self.slider.numberOfDiscreteValues = 5;
  self.slider.discrete = YES;

  // When
  MDCSliderSnapshotTestTouchFake *touch = TouchThumbInSlider(self.slider);
  MoveSliderThumbToRelativePosition(self.slider, touch, (CGFloat)0.15);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testImplicitlyNonDiscreteSliderAlignsToThumbPosiition {
  // Given
  self.slider.discrete = YES;
  self.slider.numberOfDiscreteValues = 0;

  // When
  MDCSliderSnapshotTestTouchFake *touch = TouchThumbInSlider(self.slider);
  MoveSliderThumbToRelativePosition(self.slider, touch, (CGFloat)0.15);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testExplicitlyNonDiscreteSliderAlignsToThumbPosition {
  // Given
  self.slider.numberOfDiscreteValues = 5;
  self.slider.discrete = NO;

  // When
  MDCSliderSnapshotTestTouchFake *touch = TouchThumbInSlider(self.slider);
  MoveSliderThumbToRelativePosition(self.slider, touch, (CGFloat)0.15);

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testNotHollowThumbAtStart {
  // When
  self.slider.thumbHollowAtStart = NO;
  self.slider.value = self.slider.minimumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDynamicColorSupport {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *sliderDynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blackColor;
          } else {
            return UIColor.purpleColor;
          }
        }];
    UIColor *sliderBackgroundDynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blackColor;
          } else {
            return UIColor.yellowColor;
          }
        }];

    UIColor *sliderThumbShadowDynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blackColor;
          } else {
            return UIColor.blueColor;
          }
        }];

    [self.slider setTrackFillColor:sliderDynamicColor forState:UIControlStateNormal];
    [self.slider setThumbColor:sliderDynamicColor forState:UIControlStateNormal];
    [self.slider setTrackBackgroundColor:sliderBackgroundDynamicColor
                                forState:UIControlStateNormal];
    self.slider.thumbElevation = 5;
    self.slider.thumbShadowColor = sliderThumbShadowDynamicColor;

    // When
    self.slider.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;

    // Then
    UIView *snapshotView = [self.slider mdc_addToBackgroundView];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testPreferredFontForAXXXLContentSizeCategory {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;
  self.slider.shouldDisplayDiscreteValueLabel = YES;
  UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
  UIFont *originalFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:12]];
  self.slider.discreteValueLabelFont = originalFont;
  self.slider.adjustsFontForContentSizeCategory = YES;
  UITraitCollection *xsTraitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
  self.slider.traitCollectionOverride = xsTraitCollection;
  // Cannot set font, nor adjustsFontForContentSizeCategory for the thumbtrack label.

  // When
  UITraitCollection *aXXXLTraitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.slider.traitCollectionOverride = aXXXLTraitCollection;
  // In Thumbtrack's code, there is a check for verifying that the thumbtrack's width is larger
  // than 1 point, otherwise it won't go into the main frame adjusting logic. This is to make sure
  // that the scale transform of the slider's view isn't at its default of 0.001. Therefore this
  // transform adjustment was made so it can let the logic know we are actually interacting with
  // the thumb in the test.
  UIView *valueLabel = [self.slider.thumbTrack valueForKey:@"_valueLabel"];
  valueLabel.transform = CGAffineTransformIdentity;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  UIView *snapshotView =
      [self.slider mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
  [self generateSnapshotAndVerifyForView:snapshotView];
}

- (void)testPreferredFontForXSContentSizeCategory {
  // Given
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;
  self.slider.shouldDisplayDiscreteValueLabel = YES;
  UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
  UIFont *originalFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:12]];
  self.slider.discreteValueLabelFont = originalFont;
  self.slider.adjustsFontForContentSizeCategory = YES;
  UITraitCollection *aXXXLTraitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.slider.traitCollectionOverride = aXXXLTraitCollection;
  // Cannot set font, nor adjustsFontForContentSizeCategory for the thumbtrack label.

  // When
  UITraitCollection *xsTraitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
  self.slider.traitCollectionOverride = xsTraitCollection;
  // In Thumbtrack's code, there is a check for verifying that the thumbtrack's width is larger
  // than 1 point, otherwise it won't go into the main frame adjusting logic. This is to make sure
  // that the scale transform of the slider's view isn't at its default of 0.001. Therefore this
  // transform adjustment was made so it can let the logic know we are actually interacting with
  // the thumb in the test.
  UIView *valueLabel = [self.slider.thumbTrack valueForKey:@"_valueLabel"];
  valueLabel.transform = CGAffineTransformIdentity;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  UIView *snapshotView =
      [self.slider mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
  [self generateSnapshotAndVerifyForView:snapshotView];
}

- (void)testNonDiscreteSliderLargerTrackHeight {
  // Given
  self.slider.discrete = NO;

  // When
  self.slider.trackHeight = 6;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testNonDiscreteSliderSmallerTrackHeight {
  // Given
  self.slider.discrete = NO;

  // When
  self.slider.trackHeight = 1;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithTrackHeight1Points {
  // Given
  [self makeSliderDiscrete:self.slider];

  // When
  self.slider.trackHeight = 1;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithTrackHeight2Points {
  // Given
  [self makeSliderDiscrete:self.slider];

  // When
  self.slider.trackHeight = 2;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithTrackHeight3Points {
  // Given
  [self makeSliderDiscrete:self.slider];

  // When
  self.slider.trackHeight = 3;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithTrackHeight4Points {
  // Given
  [self makeSliderDiscrete:self.slider];

  // When
  self.slider.trackHeight = 4;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithTrackHeight6Points {
  // Given
  [self makeSliderDiscrete:self.slider];

  // When
  self.slider.trackHeight = 6;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithTrackHeight10Points {
  // Given
  [self makeSliderDiscrete:self.slider];

  // When
  self.slider.trackHeight = 10;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDiscreteSliderWithThumbAndValueLabel {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;
  self.slider.shouldDisplayDiscreteValueLabel = YES;
  self.slider.shouldDisplayThumbWithDiscreteValueLabel = YES;
  [self.slider.thumbTrack setValue:@"YES" forKey:@"_isDraggingThumb"];

  // Then
  UIView *snapshotView =
      [self.slider mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
  [self generateSnapshotAndVerifyForView:snapshotView];
}

// Test slider layout is RTL when ForceRTL semanticContentAttribute is set
- (void)testRightToLeftLayout {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.value = self.slider.minimumValue;
  self.slider.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;

  // Then
  UIView *snapshotView =
      [self.slider mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
  [self generateSnapshotAndVerifyForView:snapshotView];
}

// Test slider layout is LTR when ForceLTR semanticContentAttribute is set
- (void)testLeftToRightLayout {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.value = self.slider.minimumValue;
  self.slider.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;

  // Then
  UIView *snapshotView =
      [self.slider mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
  [self generateSnapshotAndVerifyForView:snapshotView];
}

@end

NS_ASSUME_NONNULL_END
