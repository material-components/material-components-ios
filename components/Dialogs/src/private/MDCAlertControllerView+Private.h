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

#import "MDCAlertActionManager.h"
#import "MaterialButtons.h"

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
 This enables ordering actions by emphasis when they are vertically aligned.
 When set to @c YES, horizontally trailing actions, which typically have higher
 emphasis, will be displayed on top when presented vertically (for instance, in
 the portrait orientation on smaller devices). When set to @c NO, the higher
 emphasis actions will be displayed on the bottom.

 Default value is @c NO.
*/
@property(nonatomic, assign) BOOL orderVerticalActionsByEmphasis;

/**
 Whether adjustable insets mode is enabled for the dialog view. If set to @c
 YES, a new layout calculation that is customizable by the insets in this header
 file is used to layout the dialog. If set to @c NO, we fall back to the legacy
 layout calculation, ignoring all customized inset values.

 Default value is @c NO.
 */
@property(nonatomic, assign) BOOL enableAdjustableInsets;

/**
 The edge insets around the title icon or title icon view against the dialog
 edges (top, leading, trailing) and the title (bottom). Note that
 `titleIconInsets.bottom` takes precedence over `titleInsets.top`.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 12, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets titleIconInsets;

/**
 The edge insets around the title against the dialog edges or its neighbor
 elements. If either the title icon or title icon view is present, then
 `titleIconInsets.bottom` takes precedence over `titleInsets.top`. If there is
  no message, `titleInsets.bottom` is ignored.


 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 20, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets titleInsets;

/**
 The edge insets around the content view (which includes the message and/or the
 accessory view) against the dialog edges or its neighbor elements, the title
 and the actions.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets contentInsets;

/**
 The edge insets around the actions against the dialog edges and its neighbor,
 which could be any of the other elements: the message, accessory view, title,
 title icon or title icon view.

 Default value is UIEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8).
 */
@property(nonatomic, assign) UIEdgeInsets actionsInsets;

/**
 The horizontal space between the action buttons when the buttons are
 horizontally aligned, and if more than one button is presented.

 Default value is 8.
 */
@property(nonatomic, assign) CGFloat actionsHorizontalMargin;

/**
 The vertical space between the action buttons when the buttons are vertically
 aligned, and if more than one button is presented.

 Default value is 12.
 */
@property(nonatomic, assign) CGFloat actionsVerticalMargin;

/**
 The vertical inset between the accessory view and the message, if both are present.

 Default value is 20.
 */
@property(nonatomic, assign) CGFloat accessoryViewVerticalInset;

@end
