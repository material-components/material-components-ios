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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MDCTextControl.h"

// TODO: When the MDCBaseTextField subclass that makes use of this style (and the path drawing logic
// inside it) lands there should be snapshot tests for it.
/**
 This style object is used by MDCTextControls adopting the Material Outlined style.
 */
@interface MDCTextControlStyleOutlined : NSObject <MDCTextControlStyle>

/**
Sets the outline color for a given state.
@param outlineColor The UIColor for the given state.
@param state The MDCTextControlState.
*/
- (void)setOutlineColor:(nonnull UIColor *)outlineColor forState:(MDCTextControlState)state;

/**
Returns the outline color for a given state.
@param state The MDCTextControlState.
*/
- (nonnull UIColor *)outlineColorForState:(MDCTextControlState)state;

@end
