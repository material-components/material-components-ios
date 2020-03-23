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

#import <UIKit/UIKit.h>

@class MDCSlider;

@protocol MDCSliderDelegate <NSObject>
@optional

/**
 Called when the user taps on the MDCSlider.

 If not implemented, the MDCSlider will always be allowed to jump to any value.
 */
- (BOOL)slider:(nonnull MDCSlider *)slider shouldJumpToValue:(CGFloat)value;

/**
 For discrete sliders, called when the slider is determining the string label to display for a given
 discrete value.

 If not implemented, or if no slider delegate is specified, the slider defaults to displaying the
 value rounded to the closest relevant digit. For instance, 0.50000 would become "0.5"

 Override this to provide custom behavior, for instance if your slider deals in percentages, the
 above example could become "50%"

 @param slider The MDCSlider sender.
 @param value The value whose label needs to be calculated.
 */
- (nonnull NSString *)slider:(nonnull MDCSlider *)slider displayedStringForValue:(CGFloat)value;

/**
 Used to determine what string value should be used as the accessibility string for a given value.

 If not implemented, or if no slider delegate is specified, the slider defaults to how filled the
 slider is, as a percentage. Override this method to provide custom behavior, and when implementing,
 you may want to also implement @c -slider:displayedStringForValue: to ensure consistency between
 the displayed value and the accessibility label.

 @param slider The MDCSlider sender.
 @param value The value whose accessibility label needs to be calculated.
 */
- (nonnull NSString *)slider:(nonnull MDCSlider *)slider accessibilityLabelForValue:(CGFloat)value;

@end
