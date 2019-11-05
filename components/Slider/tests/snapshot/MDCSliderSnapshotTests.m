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

#import "MaterialSnapshot.h"

#import <UIKit/UIKit.h>

#import "../../src/private/MDCSlider_Subclassable.h"
#import "MaterialSlider.h"
#import "MaterialThumbTrack.h"

/**
 An MDCSlider subclass that allows the user to override the @c traitCollection property.
 */
@interface MDCSliderWithCustomTraitCollection : MDCSlider
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@property(nonatomic, strong) MDCThumbTrack *thumbTrack;

@end

@implementation MDCSliderWithCustomTraitCollection

- (MDCThumbTrack *)thumbTrack {
  return _thumbTrack;
}

- (void)setThumbTrack:(MDCThumbTrack *)thumbTrack {
  _thumbTrack = thumbTrack;
}

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

@interface MDCSliderSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCSliderWithCustomTraitCollection *slider;
@end

@implementation MDCSliderSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

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
  slider.continuous = NO;
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

- (void)testContinuousSliderAtMinimum {
  // When
  self.slider.value = self.slider.minimumValue;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testContinuousSliderAtMidpoint {
  // When
  self.slider.value =
      self.slider.minimumValue + (self.slider.maximumValue - self.slider.minimumValue) / 2;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testContinuousSliderAtMaximum {
  // When
  self.slider.value = self.slider.maximumValue;

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
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
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
#endif
}

- (void)testPreferredFontForAXXXLContentSizeCategory {
  if (@available(iOS 11.0, *)) {
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
}

- (void)testPreferredFontForXSContentSizeCategory {
  if (@available(iOS 11.0, *)) {
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
}

- (void)testLargerTrackHeight {
  // When
  self.slider.trackHeight = 6;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testSmallerTrackHeight {
  // When
  self.slider.trackHeight = 1;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

@end
