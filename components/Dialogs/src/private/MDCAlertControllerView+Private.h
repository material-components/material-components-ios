// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MDCAlertActionManager.h"

@interface MDCAlertControllerView ()

@property(nonatomic, nonnull, strong) UILabel *titleLabel;
@property(nonatomic, nonnull, strong) UILabel *messageLabel;
@property(nonatomic, nullable, strong) UIView *accessoryView;

@property(nonatomic, nullable, weak) MDCAlertActionManager *actionManager;

/** The scroll view that holds the @c titleLabel. */
@property(nonatomic, nonnull, strong) UIScrollView *titleScrollView;

/** The scroll view that holds the @c messageLabel. */
@property(nonatomic, nonnull, strong) UIScrollView *contentScrollView;

/** The scroll view that holds all of the buttons created for each action. */
@property(nonatomic, nonnull, strong) UIScrollView *actionsScrollView;

- (void)addActionButton:(nonnull MDCButton *)button;
+ (void)styleAsTextButton:(nonnull MDCButton *)button;

- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize;

- (CGSize)calculateActionsSizeThatFitsWidth:(CGFloat)boundingWidth;

- (void)updateFonts;

/**
 Affects the fallback behavior for when a scaled font is not provided.

 If @c YES, the font size will adjust even if a scaled font has not been provided for
 a given @c UIFont property on this component.

 If @c NO, the font size will only be adjusted if a scaled font has been provided.

 Default value is @c YES.
 */
@property(nonatomic, assign) BOOL adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;

/**
 The margins around the title icon or the title icon view against the dialog
 edges (top, leading, trailing) and the title (bottom). Note that the actual
 bottom space is the smallest between titleImageInsets.bottom and
 titleInsets.top.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 20, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets titleIconInsets;

/**
 The margins around the title against the dialog frame and its neighbor elements.
 If a title icon is presented, the minimum titleInsets.top and titleIconInsets.bottom is used.
 If a message is presented, the minimum titleInsets.bottom and contentInsets.top is used.
 If there is no message, titleInsets.bottom is used.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 20, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets titleInsets;

/**
 The margins around the message, the content view or the accessory view against the dialog edges
 and its neighbor elements, the title and the actions.
 If a title is presented, the minimum of titleInsets.bottom and contentInsets.top is used.
 The actual space between the content and the actions additive. It's is contentInsets.minimum PLUS
 actionsInsets.top.

 Custom implementations of the accessory view will be given this frame to present their content in.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 28, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets contentInsets;

/**
 The margins around the actions against the dialog edges and its neighbot, the title or message.
 Unlike other neigboring elements, icons top margin is additive, adding the actionsInsets.top to the
 bottom of its top neigbor - either the title or the message. That is order to afford engou margin
 space in case the content scrolls.

 Default value is UIEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8).
 */
@property(nonatomic, assign) UIEdgeInsets actionsInsets;

/**
 The space between action buttons in horizontal layout, if more than one button is presented.

 Default value is 8.
 */
@property(nonatomic, assign) CGFloat actionsHorizontalMargin;

/**
 The space between the action buttons in vertical layout, if more than one button is presented.

 Default value is 12.
 */
@property(nonatomic, assign) CGFloat actionsVerticalMargin;

@end
