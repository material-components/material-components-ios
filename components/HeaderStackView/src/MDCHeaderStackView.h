// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 The MDCHeaderStackView class lays out a vertical stack of two views.

 Both bars provided to this view must implement sizeThatFits and return their best-fit
 dimensions.

 # Layout Behavior

 The layout behavior of the two bars is as follows:

 topBar: top aligned, expands to fill all available vertical space not taken up by the bottomBar.
 bottomBar: bottom aligned.

 If no bottomBar is provided, top bar consumes the entire bounds of the stack view.

 When resized, the top bar will shrink until it reaches its sizeThatFits dimensions.
 If there is a bottom bar, then at this point the top bar will begin sliding off the top.
 If there is no bottom bar, then at this point the top bar will stay put.

 At no point in time will either the top or bottom bar shrink below their sizeThatFits height.

 # sizeThatFits Behavior

 sizeThatFits returns the fitted height for bottom bar if available, otherwise it returns the
 fitted height for topBar. The width will be whatever width was provided.
 */
IB_DESIGNABLE
@interface MDCHeaderStackView : UIView

/** The top bar. Top aligned and vertically expands. */
@property(nonatomic, strong, nullable) UIView *topBar;

/** The bottom bar. Bottom aligned. */
@property(nonatomic, strong, nullable) UIView *bottomBar;

/**
 A block that is invoked when the @c MDCHeaderStackView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCHeaderStackView *_Nonnull headerStackView,
     UITraitCollection *_Nullable previousTraitCollection);

@end
