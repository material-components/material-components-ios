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

@interface MDCSliderStatesSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCSlider *slider;
@end

@implementation MDCSliderStatesSnapshotTests

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

  [self setSlider:self.slider colorsForState:UIControlStateNormal withRed:1 green:0 blue:0];
  [self setSlider:self.slider colorsForState:UIControlStateSelected withRed:0 green:1 blue:0];
  [self setSlider:self.slider colorsForState:UIControlStateHighlighted withRed:0 green:0 blue:1];
  [self setSlider:self.slider colorsForState:UIControlStateDisabled withRed:1 green:1 blue:0];
  [self setSlider:self.slider
      colorsForState:(UIControlStateSelected | UIControlStateHighlighted)
             withRed:1
               green:0
                blue:1];
}

- (void)tearDown {
  self.slider = nil;

  [super tearDown];
}

- (void)setSlider:(MDCSlider *)slider
    colorsForState:(UIControlState)state
           withRed:(CGFloat)red
             green:(CGFloat)green
              blue:(CGFloat)blue {
  [slider setTrackBackgroundColor:[UIColor colorWithRed:(CGFloat)(0.1 * red)
                                                  green:(CGFloat)(0.1 * green)
                                                   blue:(CGFloat)(0.1 * blue)
                                                  alpha:1]
                         forState:state];
  [slider setTrackFillColor:[UIColor colorWithRed:(CGFloat)(0.9 * red)
                                            green:(CGFloat)(0.9 * green)
                                             blue:(CGFloat)(0.9 * blue)
                                            alpha:1]
                   forState:state];
  [slider setFilledTrackTickColor:[UIColor colorWithRed:(CGFloat)(0.7 * red)
                                                  green:(CGFloat)(0.7 * green)
                                                   blue:(CGFloat)(0.7 * blue)
                                                  alpha:1]
                         forState:state];
  [slider setBackgroundTrackTickColor:[UIColor colorWithRed:(CGFloat)(0.3 * red)
                                                      green:(CGFloat)(0.3 * green)
                                                       blue:(CGFloat)(0.3 * blue)
                                                      alpha:1]
                             forState:state];
  [slider setThumbColor:[UIColor colorWithRed:red green:green blue:blue alpha:1] forState:state];
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

- (void)testNormalStateContinuous {
  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testNormalStateDiscrete {
  // When
  [self makeSliderDiscrete:self.slider];

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testSelectedStateContinuous {
  // When
  self.slider.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testSelectedStateDiscrete {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testHighlightedStateContinuous {
  // When
  self.slider.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testHighlightedStateDiscrete {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDisabledStateContinuous {
  // When
  self.slider.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testDisabledStateDiscrete {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testSelectedHighlightedStateContinuous {
  // When
  self.slider.highlighted = YES;
  self.slider.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

- (void)testSelectedHighlightedStateDiscrete {
  // When
  [self makeSliderDiscrete:self.slider];
  self.slider.highlighted = YES;
  self.slider.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.slider];
}

@end
