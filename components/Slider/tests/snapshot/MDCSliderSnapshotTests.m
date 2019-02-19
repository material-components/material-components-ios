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

#import "MaterialSlider.h"

@interface MDCSliderSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCSlider *slider;
@end

@implementation MDCSliderSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 120, 48)];
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

@end
