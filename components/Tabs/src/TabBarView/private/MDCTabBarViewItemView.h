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

#import "MDCTabBarViewCustomViewable.h"
#import "MDCTabBarViewItemViewDelegate.h"

#import "MDCBadgeAppearance.h"
#import "MDCBadgeView.h"
#import "MaterialRipple.h"

NS_ASSUME_NONNULL_BEGIN

/** A basic view that displays a title and image for a tab bar item within MDCTabBarView. */
@interface MDCTabBarViewItemView : UIView <MDCTabBarViewCustomViewable>

@property(nonatomic, strong, nullable) id<MDCTabBarViewItemViewDelegate> itemViewDelegate;

/** The image to display when unselected. */
@property(nonatomic, strong, nullable) UIImage *image;

/** The image to display when selected. */
@property(nonatomic, strong, nullable) UIImage *selectedImage;

/** The image view to display the icon. */
@property(nonatomic, strong, nonnull) UIImageView *iconImageView;

/**
 The size of the icon.

 This property is not respected unless a value other than @c CGSizeZero is used.

 @note Defaults to CGSizeZero.
 */
@property(nonatomic, assign) CGSize iconSize;

/** The label to display the title. */
@property(nonatomic, strong, nonnull) UILabel *titleLabel;

/**
 If YES, all ripple behavior will be disabled and a simple highlight effect will be used instead.

 Default value is NO.
 */
@property(nonatomic) BOOL disableRippleBehavior;

#pragma mark - Displaying a value in the badge

/**
 The human-readable value, typically numerical, that will be shown for this item's badge.

 The badge will only be visible if the text is a non-empty string. To hide the badge, set this
 property to nil or an empty string.
 */
@property(nonatomic, copy, nullable) NSString *badgeText;

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
@property(nonatomic, strong, nullable) UIColor *badgeColor;

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

/** The ripple contronller to display the ripple touch effect. */
@property(nonatomic, strong, nullable)
    MDCRippleTouchController *rippleTouchController __deprecated_msg(
        "Enable disableRippleBehavior instead.");

/**
 Offset to shift the badge from its default location.

 Positive x values move the badge toward the trailing edge, and positive y values move the badge
 downward.
 */
@property(nonatomic) CGPoint badgeOffset;

@end

NS_ASSUME_NONNULL_END
