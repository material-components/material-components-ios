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

/**
 An implementation of Material Tabs (https://material.io/design/components/tabs.html).
 */
__attribute__((objc_subclassing_restricted)) @interface MDCTabBarView : UIScrollView

/** The set of items displayed in the Tab bar. */
@property(nonnull, nonatomic, copy) NSArray<UITabBarItem *> *items;

/** The currently-selected item in the Tab bar. */
@property(nullable, nonatomic, strong) UITabBarItem *selectedItem;

/** The color of the Tab bar's background. */
@property(nullable, nonatomic, copy) UIColor *barTintColor;

/**
 Sets the color of the bar items' image @c tintColor for the given control state.  Supports
 @c UIControlStateNormal and @c UIControlStateSelected.

 If no value for a control state is set, the value for @c UIControlStateNormal is used. If no value
 for @c UIControlStateNormal is set, then a default value is used.
 */
- (void)setImageTintColor:(nullable UIColor *)imageTintColor forState:(UIControlState)state;

/**
 Returns the color of the bar items' image @c tintColor for the given control state.

 If no value for a control state is set, the value for @c UIControlStateNormal is returned.
 */
- (nullable UIColor *)imageTintColorForState:(UIControlState)state;

/**
 Sets the color of the bar items' title for the given control state.  Supports
 @c UIControlStateNormal and @c UIControlStateSelected.

 If no value for a control state is set, the value for @c UIControlStateNormal is used. If no value
 for @c UIControlStateNormal is set, then a default value is used.
 */
- (void)setTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state;

/**
 Returns the color of the bar items' title for the given control state.

 If no value for a control state is set, the value for @c UIControlStateNormal is returned.
 */
- (nullable UIColor *)titleColorForState:(UIControlState)state;

@end
