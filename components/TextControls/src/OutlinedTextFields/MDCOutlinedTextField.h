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

#import "MaterialTextControls+BaseTextFields.h"

/**
 An implementation of a Material outlined text field.
 */
@interface MDCOutlinedTextField : MDCBaseTextField

/**
 MDCOutlinedTextField does not support UITextBorderStyle borders.
 */
@property(nonatomic, assign) UITextBorderStyle borderStyle NS_UNAVAILABLE;

/**
 Sets the outline color for a given state.
 @param outlineColor The UIColor for the given state.
 @param state The MDCTextControlState.
 */
- (void)setOutlineColor:(nonnull UIColor *)outlineColor forState:(MDCTextControlState)state;

/**
 Returns the outline color for a given state.
 @param state The MDCTextControlState.

 The default values are sensible black values.
 */
- (nonnull UIColor *)outlineColorForState:(MDCTextControlState)state;

@end
