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

#import <UIKit/UIKit.h>

#import "MDCBaseTextField.h"

/**
 An implementation of a Material filled text field.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCFilledTextField : MDCBaseTextField

/**
 Sets the filled background color for a given state.
 @param filledBackgroundColor The UIColor for the given state.
 @param state The UIControlState. The accepted values are UIControlStateNormal,
 UIControlStateDisabled, and UIControlStateEditing, which is a custom MDC
 UIControlState value.
 */
- (void)setFilledBackgroundColor:(nonnull UIColor *)filledBackgroundColor
                        forState:(UIControlState)state;
/**
 Returns the filled background color for a given state.
 @param state The UIControlState.
 */
- (nonnull UIColor *)filledBackgroundColorForState:(UIControlState)state;

/**
 Sets the underline color for a given state.
 @param underlineColor The UIColor for the given state.
 @param state The UIControlState. The accepted values are UIControlStateNormal,
 UIControlStateDisabled, and UIControlStateEditing, which is a custom MDC
 UIControlState value.
 */
- (void)setUnderlineColor:(nonnull UIColor *)underlineColor forState:(UIControlState)state;

/**
 Returns the underline color for a given state.
 @param state The UIControlState.
 */
- (nonnull UIColor *)underlineColorForState:(UIControlState)state;

@end
