// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCTabBarViewIndicatorAttributes;

/** View responsible for drawing the indicator behind tab content and animating changes. */
@interface MDCTabBarViewIndicatorView : UIView

/**
 The animation duration for changes to the path of the selection indicator.
 Defaults to 300 milliseconds.
 */
@property(nonatomic, assign) CFTimeInterval indicatorPathAnimationDuration;

/**
 The timing function for animating changes to the path of the selection indicator. Defaults to an
 ease-in ease-out function.
 */
@property(nonatomic, strong, nonnull) CAMediaTimingFunction *indicatorPathTimingFunction;

/**
 Called to indicate that the indicator should update to display new attributes. This method may be
 called from an implicit animation block.
 */
- (void)applySelectionIndicatorAttributes:(MDCTabBarViewIndicatorAttributes *)attributes;

@end
