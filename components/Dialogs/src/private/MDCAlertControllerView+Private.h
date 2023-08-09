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
#import "MDCAlertControllerView.h"
#import "MDCAlertActionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDCAlertControllerView ()

@property(nonatomic, nonnull, strong) UILabel *titleLabel;
@property(nonatomic, nonnull, strong) UITextView *messageTextView;

/** An optional custom UIView that is displaed under the alert message. */
@property(nonatomic, nullable, strong) UIView *accessoryView;

/**
 By setting this property to @c YES, the accessoryView will be placed on top of the message.

 Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL shouldPlaceAccessoryViewAboveMessage;

/** An optional custom view above the title of the alert. */
@property(nonatomic, strong, nullable) UIView *titleIconView;

@property(nonatomic, nullable, weak) MDCAlertActionManager *actionManager;

/** Whether or not title should pin to the top of the content. If the title does not pin to the top
 * of the content, it will scroll with the message when the message scrolls. */
@property(nonatomic, assign) BOOL titlePinsToTop;

/** The view that holds the @c titleLabel. */
@property(nonatomic, nonnull, strong) UIView *titleView;

/** The scroll view that holds the @c messageTextView, the @c accessoryView, and, when
 * scrollTitleWithContent is @c YES, the @c titleView . */
@property(nonatomic, nonnull, strong) UIScrollView *contentScrollView;

/** The scroll view that holds all of the buttons created for each action. */
@property(nonatomic, nonnull, strong) UIScrollView *actionsScrollView;

/** The backing image view of @c titleIcon. */
@property(nonatomic, nullable, strong) UIImageView *titleIconImageView;

/** The horizontal alignment of @c titleIcon. */
@property(nonatomic, assign) NSTextAlignment titleIconAlignment;

/** The horizontal alignment of @c title. */
@property(nonatomic, assign) NSTextAlignment titleAlignment;

/** The horizontal alignment of @c message. */
@property(nonatomic, assign) NSTextAlignment messageAlignment;

/** The alert actions alignment in horizontal layout. */
@property(nonatomic, assign) MDCContentHorizontalAlignment actionsHorizontalAlignment;

/** The horizontal alignment of the alert's actions when in vertical layout. */
@property(nonatomic, assign)
    MDCContentHorizontalAlignment actionsHorizontalAlignmentInVerticalLayout;

/** Enables ordering actions by emphasis when they are vertically aligned. */
@property(nonatomic, assign) BOOL orderVerticalActionsByEmphasis;

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)addActionButton:(nonnull UIButton *)button;
+ (void)styleAsTextButton:(nonnull MDCButton *)button;
#pragma clang diagnostic pop

/**
 Sets the flag to use `M3CButton` instead of `MDCButton`, this flag would be
 eventually removed when `MDCButton` is deleted.

 Defaults to NO
 */
@property(nonatomic, assign, getter=isM3CButtonEnabled) BOOL M3CButtonEnabled;

- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize;

- (CGSize)calculateActionsSizeThatFitsWidth:(CGFloat)boundingWidth;

- (void)updateFonts;

@end

NS_ASSUME_NONNULL_END
