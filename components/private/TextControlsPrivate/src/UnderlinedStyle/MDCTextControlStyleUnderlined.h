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

#import "MDCTextControl.h"

/**
This style object is used by MDCTextControls adopting the Material Underlined style.
*/
@interface MDCTextControlStyleUnderlined : NSObject <MDCTextControlStyle>

/**
Sets the underline color color for a given state.
@param underlineColor The UIColor for the given state.
@param state The MDCTextControlState.
*/
- (void)setUnderlineColor:(nonnull UIColor *)underlineColor forState:(MDCTextControlState)state;

/**
Returns the underline color color for a given state.
@param state The MDCTextControlState.
*/
- (nonnull UIColor *)underlineColorForState:(MDCTextControlState)state;

@end
