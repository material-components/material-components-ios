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

/**
 A simple protocol that custom views rendered in MDCTabBarView must adopt.

 @note `intrinsicContentSize` must always return the correct content size for the view, even before
       layout has occurred.  If the value changes, it may be necessary to force the tab bar to lay
       out its subviews.

 @seealso MDCTabBarViewIndicatorTemplate
 */
@protocol MDCTabBarViewCustomViewable

/**
 The bounds of the receiver.
 */
@property(readonly) CGRect bounds;

/**
 The frame of the content of the receiver. Used to position the Selection Indicator relative to
 the content.
 */
@property(readonly) CGRect contentFrame;

/**
 Called when the view should change its appearance based on its selection status.

 @param selected The new selection state of the view.
 @param animated Whether the change should be animated.
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
