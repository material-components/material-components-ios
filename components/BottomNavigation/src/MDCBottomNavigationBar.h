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

@protocol MDCBottomNavigationBarDelegate;

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
typedef NS_ENUM(NSInteger, MDCBottomNavigationBarAlignment) {

  // Items are distributed using the entire width of the device, justified. Titles are centered
  // below icons.
  MDCBottomNavigationBarAlignmentJustified = 0,

  // Items are distributed using the entire width of the device, justified. Titles are positioned
  // adjacent to icons.
  MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles = 1,

  // Items are tightly clustered together and centered on the navigation bar. Titles are positioned
  // below icons.
  MDCBottomNavigationBarAlignmentCentered = 2
};

/**
 A bottom navigation bar.

 The bottom navigation bar is docked at the bottom of the screen with tappable items. Only one item
 can be selected at at time. The selected item's title text is displayed. Title text for unselected
 items are hidden.
 */
@interface MDCBottomNavigationBar : UIView

/** The bottom navigation bar delegate. */
@property(nonatomic, weak, nullable) id<MDCBottomNavigationBarDelegate> delegate;

/**
 Configures when item titles should be displayed.
 Default is MDCBottomNavigationBarTitleVisibilitySelected.
 */
@property(nonatomic, assign) MDCBottomNavigationBarTitleVisibility titleVisibility
    UI_APPEARANCE_SELECTOR;

/**
 Configures item space distribution and title orientation in landscape mode.
 Default is MDCBottomNavigationBarDistributionEqual.
 */
@property(nonatomic, assign) MDCBottomNavigationBarAlignment alignment UI_APPEARANCE_SELECTOR;

/**
 An array of UITabBarItems that is used to populate bottom navigation bar content. It is strongly
 recommended the array contain at least three items and no more than five items -- appearance may
 degrade outside of this range.
 */
@property(nonatomic, copy, nonnull) NSArray<UITabBarItem *> *items;

/**
 Selected item in the bottom navigation bar.
 Default is no item selected.
 */
@property(nonatomic, weak, nullable) UITabBarItem *selectedItem;

/**
 Display font used for item titles.
 Default is system font.
 */
@property(nonatomic, strong, nonnull) UIFont *itemTitleFont UI_APPEARANCE_SELECTOR;

/**
 Color of selected item. Applies color to items' icons and text. If set also sets
 selectedItemTitleColor. Default color is black.
 */
@property (nonatomic, strong, readwrite, nonnull) UIColor *selectedItemTintColor
    UI_APPEARANCE_SELECTOR;

/**
 Color of the selected item's title text. Default color is black.
 */
@property(nonatomic, strong, readwrite, nonnull) UIColor *selectedItemTitleColor;

/**
 Color of unselected items. Applies color to items' icons. Text is not displayed in unselected mode.
 Default color is dark gray.
 */
@property (nonatomic, strong, readwrite, nonnull) UIColor *unselectedItemTintColor
    UI_APPEARANCE_SELECTOR;

/**
 Color of the background of bottom navigation bar and the bar items.
 */
@property(nonatomic, strong, nullable) UIColor *barTintColor UI_APPEARANCE_SELECTOR;

/**
 To color the background of the view use -barTintColor instead.
 */
@property(nullable, nonatomic,copy) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;

/**
 The inset applied to each items bounds to determine the rect in which the items' contents will be
 centered. The contents are centered in this rect, but not compressed, so they may still extend
 beyond these bounds. Defaults to {0, 0, 0, 0}. The inset is flipped for RTL.
 */
@property(nonatomic, assign) UIEdgeInsets itemsContentInsets;

/**
 The margin between the item's icon and title when alignment is either Justified or Centered.
 Defaults to 0.
 */
@property(nonatomic, assign) CGFloat itemsContentVerticalMargin;

/**
 The margin between the item's icon and title when alignment is JustifiedAdjacentTitles. Defaults to
 12.
 */
@property(nonatomic, assign) CGFloat itemsContentHorizontalMargin;

@end

#pragma mark - MDCBottomNavigationBarDelegate

/**
 Delegate protocol for MDCBottomNavigationBar. Clients may implement this protocol to receive
 notifications of selection changes by user action in the bottom navigation bar.
 */
@protocol MDCBottomNavigationBarDelegate <UINavigationBarDelegate>

@optional

/**
 Called before the selected item changes by user action. Return YES to allow the selection. If not
 implemented all items changes are allowed.
 */
- (BOOL)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
           shouldSelectItem:(nonnull UITabBarItem *)item;

/**
 Called when the selected item changes by user action.
 */
- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item;

@end
