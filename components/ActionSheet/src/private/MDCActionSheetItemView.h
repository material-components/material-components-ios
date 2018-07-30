/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialInk.h"
#import "../MDCActionSheetController.h"

@interface MDCActionSheetItemView : UITableViewCell

/** Cells must be created with cellWithAction: */
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

/** Cells must be created with cellWithAction: */
- (nonnull instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/** Cells must be created with cellWithAction: */
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
  The action contains the title, icon, and handler
  If you need to change any of the three you must pass a new action in.
*/
@property(nonatomic, nonnull, readonly) MDCActionSheetAction *action;

@property(nonatomic, nullable) UIFont *font;

@property(nonatomic, nullable) UIColor *labelColor;

@property(nonatomic, nullable) UIColor *iconColor;

@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;


@end

@interface MDCACtionSheetHeaderView : UIView

/** */
- (nonnull instancetype)initWithTitle:(NSString *)title;

- (nonnull instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

/** Header must be created with either headerWithTitle: */
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/** Header must be created with either headerWithTitle: */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/** The text that will applied to the title of the action sheet controller. */
@property(nonatomic, nullable) NSString *title;

/** The text that will applied to the message of the action sheet controller. */
@property(nonatomic, nullable) NSString *message;

/** The font applied to the title of the action sheet controller. */
@property(nonatomic, nullable) UIFont *titleFont;

/** The font applied to the message of the action sheet controller. */
@property(nonatomic, nullable) UIFont *messageFont;

/** The color applied to the title of the action sheet controller. */
@property(nonatomic, nullable) UIColor *titleColor;

/** The color applied to the message of the action sheet controller. */
@property(nonatomic, nullable) UIColor *messageColor;

@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;


@end
