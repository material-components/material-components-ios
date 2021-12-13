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

#import "MDCMinimumOS.h"  // IWYU pragma: keep

/**
 An indication of the actions that might be required in a given context.

 Common uses include showing the number of unread emails in an inbox or the number of unread
 messages in a chat room.

 The background color of the badge can be changed through the backgroundColor property like a
 typical UIView.

 ## Outer borders vs inner borders

 CALayer's borderColor and borderWidth properties will create an inner border, meaning the border
 will be drawn within the bounds of the view. This will, in effect, cause the content of the badge
 to be constrained by the border; this is rarely what is intended when it comes to badges.

 Instead, we want the border to be drawn on the outer edge of the badge. To do so, we "fake" an
 outer border by expanding the fitted size of the badge by the border width. We then use the same
 standard CALayer borderColor and borderWidth properties under the hood, but due to the expansion of
 the badge's size it gives the impression of being drawn on the outside of the border.

 To add an outer border, use borderColor and borderWidth instead of self.layer's equivalent
 properties. Using borderColor enables the color to react to trait collections, and modifying
 borderWidth invalidates layout and size considerations.

 Note that adding an outer border will cause the badge's origin to effectively shift on both the x
 and y axis by `borderWidth` units. While technically accurate, it can be conceptually unexpected
 because the border is supposed to be on the outer edge of the view. To compensate for this, be sure
 to adjust your badge's x/y values by -borderWidth.
 */
__attribute__((objc_subclassing_restricted))
@interface MDCBadgeView : UIView

#pragma mark - Displaying a value in the badge

/** The human-readable value, typically numerical, that will be shown for this badge. */
@property(nonatomic, copy, nullable, direct) NSString *text;

#pragma mark - Configuring the badge's visual appearance

/** The color of the text representing the value. */
@property(nonatomic, strong, null_resettable, direct) UIColor *textColor;

/** The font that will be used to display the value. */
@property(nonatomic, strong, null_resettable, direct) UIFont *font;

/**
 The color of the border surrounding the badge.

 Use this property instead of self.layer.borderColor. This property allows the badge to support
 a border color that responds to trait collection changes.
 */
@property(nonatomic, strong, nullable, direct) UIColor *borderColor;

/**
 The width of the border surrounding the badge.

 Use this property instead of self.layer.borderWidth. Setting this property will cause the badge's
 intrinsic size and layout to be invalidated.
 */
@property(nonatomic, direct) CGFloat borderWidth;

#pragma mark - Unsupported APIs

// Interface builder is not supported.
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
