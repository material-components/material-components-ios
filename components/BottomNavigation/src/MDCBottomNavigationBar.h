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

/** States used to configure bottom navigation on when to hide item titles.  */
typedef NS_ENUM(NSInteger, MDCBottomNavigationBarTitleHideState) {

  // Default behavior is to hide item titles when item is unselected.
  MDCBottomNavigationBarTitleHideStateDefault = 0,

  // Item titles are never hidden.
  MDCBottomNavigationBarTitleHideStateNever = 1,

  // Item titles are always hidden.
  MDCBottomNavigationBarTitleHideStateAlways = 2
};

/**
 A bottom navigation bar.

 The bottom navigation bar is docked at the bottom of the screen with tappable items. Only one item
 can be selected at at time. The selected item's title text is displayed. Title text for unselected
 items are hidden.
 */
@interface MDCBottomNavigationBar : UIView

/**
 Configures when item titles should be displayed.
 Default is MDCBottomNavigationBarTitleHideStateDefault.
 */
@property(nonatomic, assign) MDCBottomNavigationBarTitleHideState titleHideState;

/**
 An array of UITabBarItems that is used to populate bottom navigation bar content. The array must
 contain a minimum of three items with a maxiumum of up to five items.
 */
@property(nonatomic, copy, nullable) NSArray<UITabBarItem *> *items;

/**
 Selected item in the bottom navigation bar.
 */
@property(nonatomic, weak, nullable) UITabBarItem *selectedItem;

/**
 Color of selected item. Applies color to items' icons and text.
 */
@property (nonatomic, readwrite, copy, nullable) UIColor *selectedItemTintColor
    NS_AVAILABLE_IOS(10_0) UI_APPEARANCE_SELECTOR;

/**
 Color of unselected items. Applies color to items' icons. Text is not displayed in unselected mode.
 */
@property (nonatomic, readwrite, copy, nullable) UIColor *unselectedItemTintColor
    NS_AVAILABLE_IOS(10_0) UI_APPEARANCE_SELECTOR;

@end
