/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

/**
 A bottom navigation view.

 The bottom navigation view is a bar docked at the bottom of the screen with tappable items. Only
 one item can be selected at once. The selected item's title text is displayed. Title text for
 unselected items is hidden.
 */
@interface MDCBottomNavigationView : UIView

/**
 An array of UITabBarItems that is used to populate bottom navigation view content. The array must
 contain a minimum of three items with a maxiumum of up to five items. The first item is selected by
 default.
 */
@property(nonatomic, copy, nonnull) NSArray<UITabBarItem *> *navBarItems;

/**
 Selects an item contained in the bottom navigation view.

 @param item UITabBarItem to select from the navBarItems array.
 */
- (void)selectItem:(nonnull UITabBarItem *)item;

@end
