// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCAvailability.h"
#import "MDCBottomNavigationBar.h"
#import "MDCBottomNavigationBar+ItemView.h"
#import "MDCBottomNavigationBar+Private.h"
#import "MDCBottomNavigationItemView.h"

@implementation MDCBottomNavigationBar (ItemViewConfiguration)

#pragma mark - Public

- (void)configureItemView:(MDCBottomNavigationItemView *)itemView withItem:(UITabBarItem *)item {
  [self configure:itemView withItem:item];
  [self configureAppearanceForItemView:itemView];
  [self configurePointerInteractionForItemView:itemView];
}

#pragma mark - Private

- (void)configureAppearanceForItemView:(MDCBottomNavigationItemView *)itemView {
  itemView.badgeAppearance = self.itemBadgeAppearance;
  itemView.selectionIndicatorSize = self.selectionIndicatorSize;
  itemView.showsSelectionIndicator = self.showsSelectionIndicator;

  // TODO(b/234850214): Delete once everyone has migrated to itemBadgeAppearance.
  [self configureBadgeForItemViewLegacy:itemView];

  [self configureColorsForItemView:itemView];
  [self configureMarginForItemView:itemView];
  [self configureTitleForItemView:itemView];
}

// TODO(b/234850214): Delete once everyone has migrated to itemBadgeAppearance.
- (void)configureBadgeForItemViewLegacy:(MDCBottomNavigationItemView *)itemView {
  itemView.badgeColor = self.itemBadgeBackgroundColor;
  itemView.badgeFont = self.itemBadgeTextFont;
  itemView.badgeTextColor = self.itemBadgeTextColor;
}

- (void)configureColorsForItemView:(MDCBottomNavigationItemView *)itemView {
  // rippleColor must be set before selectedItemTintColor because selectedItemTintColor's behavior
  // depends on the value of rippleColor.
  itemView.rippleColor = self.rippleColor;
  itemView.selectedItemTintColor = self.selectedItemTintColor;

  itemView.unselectedItemTintColor = self.unselectedItemTintColor;
  itemView.selectedItemTitleColor = self.selectedItemTitleColor;

  itemView.selectionIndicatorColor = self.selectionIndicatorColor;
}

- (void)configureMarginForItemView:(MDCBottomNavigationItemView *)itemView {
  itemView.contentHorizontalMargin = self.itemsContentHorizontalMargin;
  itemView.contentVerticalMargin = self.itemsContentVerticalMargin;
}

- (void)configure:(MDCBottomNavigationItemView *)itemView withItem:(UITabBarItem *)item {
  itemView.tag = item.tag;
  itemView.title = item.title;

  itemView.isAccessibilityElement = item.isAccessibilityElement;
  itemView.accessibilityElementIdentifier = item.accessibilityIdentifier;
  itemView.accessibilityHint = item.accessibilityHint;
  itemView.accessibilityLabel = item.accessibilityLabel;
  itemView.accessibilityValue = item.accessibilityValue;

  itemView.titlePositionAdjustment = item.titlePositionAdjustment;

  itemView.image = item.image;
  itemView.selectedImage = item.selectedImage;
  itemView.badgeText = item.badgeValue;
  itemView.badgeColor = item.badgeColor;

#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13, *)) {
    itemView.largeContentImageInsets = item.largeContentSizeImageInsets;
    itemView.largeContentImage = item.largeContentSizeImage;
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)configureTitleForItemView:(MDCBottomNavigationItemView *)itemView {
  itemView.itemTitleFont = self.itemTitleFont;
  itemView.titleBelowIcon = self.isTitleBelowIcon;
  itemView.titleNumberOfLines = self.titlesNumberOfLines;
  itemView.titleVisibility = self.titleVisibility;
  itemView.truncatesTitle = self.truncatesLongTitles;
}

- (void)configurePointerInteractionForItemView:(MDCBottomNavigationItemView *)itemView {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Because some iOS 13 betas did not have the UIPointerInteraction class, we need to verify
    // that it exists before attempting to use it.
    if (NSClassFromString(@"UIPointerInteraction")) {
      UIPointerInteraction *pointerInteraction =
          [[UIPointerInteraction alloc] initWithDelegate:self];
      [itemView addInteraction:pointerInteraction];
    }
  }
#endif
}

@end
