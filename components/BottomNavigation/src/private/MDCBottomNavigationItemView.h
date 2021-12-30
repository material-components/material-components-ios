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

#import "MDCBottomNavigationBar.h"
#import "MaterialInk.h"
#import "MaterialRipple.h"

__attribute__((objc_subclassing_restricted))
@interface MDCBottomNavigationItemView : UIView

@property(nonatomic, assign) BOOL titleBelowIcon;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) MDCBottomNavigationBarTitleVisibility titleVisibility;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property(nonatomic, strong, nonnull) MDCInkView *inkView;
#pragma clang diagnostic pop
@property(nonatomic, strong, nonnull) MDCRippleTouchController *rippleTouchController;
@property(nonatomic, assign) UIOffset titlePositionAdjustment;

@property(nonatomic, copy, nullable) NSString *title;
@property(nonatomic, strong, nullable) UIFont *itemTitleFont;

/**
 The number of lines available for rendering the title of this item.  Defaults to 1.

 @note This property is only used when @c titleBelowIcon is @c true.
 */
@property(nonatomic, assign) NSInteger titleNumberOfLines;
// Default = YES
@property(nonatomic, assign) BOOL truncatesTitle;

@property(nonatomic, strong, nonnull) UIButton *button;
@property(nonatomic, strong, nullable) UIImage *image;
@property(nonatomic, strong, nullable) UIImage *selectedImage;
@property(nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic, strong, nullable) UIColor *selectedItemTintColor;
@property(nonatomic, strong, nullable) UIColor *unselectedItemTintColor;
@property(nonatomic, strong, nullable) UIColor *selectedItemTitleColor;

@property(nonatomic, assign) CGFloat contentVerticalMargin;
@property(nonatomic, assign) CGFloat contentHorizontalMargin;
/** The @c accessibilityIdentifier of the accessibility element for this view. */
@property(nonatomic, copy, nullable) NSString *accessibilityElementIdentifier;

/**
 Returns a rect that is the union of all visible content views, inset by
 kMDCButtonNavigationItemViewPointerEffectHoverRectInset. This rect will never be larger than the
 view's bounds.

 This is intended to be used by a @c UIPointerInteractionDelegate when creating a @c UIPointerShape
 for a @c UIPointerStyle.
 */
- (CGRect)pointerEffectHighlightRect;

#pragma mark - Configuring the selection appearance

/**
 Changes the selection state, optionally with animation.

 If @c showsSelectionIndicator is enabled, then the selection indicator will also be animated.
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

/**
 Configures whether an indicator is shown when @c selected is true.

 If NO, then a selection indicator will never been shown regardless of @c selected state.
 */
@property(nonatomic) BOOL showsSelectionIndicator;

/** The size of the selection indicator's bounds. */
@property(nonatomic) CGSize selectionIndicatorSize;

/** The background color of the selection indicator. */
@property(nonatomic) UIColor *selectionIndicatorColor;

#pragma mark - Configuring the ripple appearance

/** The color of the ripple effect shown when the user taps on an item. */
@property(nonatomic, strong, nullable) UIColor *rippleColor;

#pragma mark - Displaying a value in the badge

/**
 The human-readable value, typically numerical, that will be shown for this item's badge.

 The badge will only be visible if the text is a non-empty string. To hide the badge, set this
 property to nil or an empty string.
 */
@property(nonatomic, copy, nullable, direct) NSString *badgeText;

#pragma mark - Configuring a badge's visual appearance

/**
 The default appearance to be used for this item's badge.

 If this item's associated UITabBarItem has set a non-nil badgeColor, then that value will be used
 for the badge instead of the backgroundColor associated with this appearance object.
 */
@property(nonatomic, copy, nonnull) MDCBadgeAppearance *badgeAppearance;

/**
 The background color of this item's badge.

 If not nil, this value will override badgeAppearance.backgroundColor. If nil, then
 badgeAppearance.backgroundColor will be used instead.
 */
@property(nonatomic, strong, nullable, direct) UIColor *badgeColor;

/**
 The color of the text representing this item's badge value.

 This property is a proxy for badgeAppearance.textColor.
 */
@property(nonatomic, copy, null_resettable, direct)
    UIColor *badgeTextColor API_DEPRECATED_WITH_REPLACEMENT("badgeAppearance.textColor",
                                                            ios(12, API_TO_BE_DEPRECATED));

/**
 The font that will be used to display the value of this item's badge.

 This property is a proxy for badgeAppearance.font.
 */
@property(nonatomic, copy, null_resettable, direct)
    UIFont *badgeFont API_DEPRECATED_WITH_REPLACEMENT("badgeAppearance.font",
                                                      ios(12, API_TO_BE_DEPRECATED));

#pragma mark - UILargeContentViewerItem

/**
 The title to display in the large content viewer. If set to nil, this property will return
 @c title.
 */
@property(nonatomic, copy, nullable) NSString *largeContentTitle NS_AVAILABLE_IOS(13_0);

/**
 The image to display in the large content viwer.  If set to nil, the property will return
 @c image . If set to nil (or not set) @c scalesLargeContentImage will return YES otherwise NO.
 */
@property(nonatomic, nullable) UIImage *largeContentImage NS_AVAILABLE_IOS(13_0);

#pragma mark - Unsupported APIs

// Interface builder is not supported.
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
