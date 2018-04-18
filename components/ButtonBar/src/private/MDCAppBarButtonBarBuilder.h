/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCButtonBar.h"

/** MDCBarButtonItemBuilder is an implementation of a Material button item factory. */
@interface MDCAppBarButtonBarBuilder : NSObject <MDCButtonBarDelegate>

/** The title color for the bar button items. */
@property(nonatomic, strong) UIColor *buttonTitleColor;

/** The underlying color for the bar button items. */
@property(nonatomic, strong) UIColor *buttonUnderlyingColor;

/**
 Sets the desired button title font for a given state. Will only affect buttons created after this
 invocation.

 @param font The font that should be displayed on text buttons for the given state.
 @param state The state for which the font should be displayed.
 */
- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state;

/**
 Gets the desired button title font for a given state.

 If no font has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The state for which the font should be returned.
 @return The font associated with the given state.
 */
- (UIFont *)titleFontForState:(UIControlState)state;

@end
