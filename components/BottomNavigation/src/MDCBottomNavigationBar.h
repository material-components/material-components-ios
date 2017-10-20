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

/** States used to configure bottom navigation on when to show item titles. */
typedef NS_ENUM(NSInteger, MDCBottomNavigationBarTitleVisibility) {

  // Default behavior is to show title when item is selected, hide otherwise.
  MDCBottomNavigationBarTitleVisibilitySelected = 0,

  // Item titles are always visible.
  MDCBottomNavigationBarTitleVisibilityAlways = 1,

  // Item titles are never visible.
  MDCBottomNavigationBarTitleVisibilityNever = 2
};

/**
 States used to configure bottom navigation in landscape mode with respect to how items are spaced
 and item title orientation. Titles will be shown or hidden depending on title hide state.
 */
typedef NS_ENUM(NSInteger, MDCBottomNavigationBarLandscapeItemMode) {

  // Items are distributed using the entire landscape mode width of the device. Titles are centered
  // below icons.
  MDCBottomNavigationBarLandscapeItemModeDistributeCenteredTitles = 0,

  // Items are distributed using the entire landscape mode width of the device. Titles are
  // positioned adjacent to icons.
  MDCBottomNavigationBarLandscapeItemModeDistributeAdjacentTitles = 1,

  // Items are tightly clustered together. Titles are positioned below icons.
  MDCBottomNavigationBarLandscapeItemModeCluster = 2
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
 Default is MDCBottomNavigationBarTitleVisibilitySelected.
 */
@property(nonatomic, assign) MDCBottomNavigationBarTitleVisibility titleVisibility;

/**
 Configures item spacing and title orientation in landscape mode.
 Default is MDCBottomNavigationBarLandscapeItemModeDistributeCenteredTitles.
 */
@property(nonatomic, assign) MDCBottomNavigationBarLandscapeItemMode landscapeItemMode;

/**
 An array of UITabBarItems that is used to populate bottom navigation bar content. The array must
 contain a minimum of three items with a maximum of up to five items.
 */
@property(nonatomic, copy, nullable) NSArray<UITabBarItem *> *items;

/**
 Selected item in the bottom navigation bar.
 */
@property(nonatomic, weak, nullable) UITabBarItem *selectedItem;

/**
 Display font used for item titles.
 */
@property(nonatomic, strong, nullable) UIFont *itemTitleFont UI_APPEARANCE_SELECTOR;

/**
 Color of selected item. Applies color to items' icons and text.
 */
@property (nonatomic, strong, readwrite, nullable) UIColor *selectedItemTintColor
    UI_APPEARANCE_SELECTOR;

/**
 Color of unselected items. Applies color to items' icons. Text is not displayed in unselected mode.
 */
@property (nonatomic, strong, readwrite, nullable) UIColor *unselectedItemTintColor
    UI_APPEARANCE_SELECTOR;

@end
