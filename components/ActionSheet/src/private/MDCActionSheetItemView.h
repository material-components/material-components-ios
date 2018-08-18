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
- (nonnull instancetype)initWithAction:(MDCActionSheetAction *)action
                       reuseIdentifier:(NSString *)reuseIdentifier;

/** Cells must be created with cellWithAction: */
- (nonnull instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/** Cells must be created with cellWithAction: */
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
  The action contains the title, image, and handler
  If you need to change any of the three you must pass a new action in.
*/
@property(nonatomic, nonnull) MDCActionSheetAction *action;

@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

@property(nonatomic, nonnull, strong) UIFont *actionsFont;

@end

@interface MDCActionSheetHeaderView : UIView

/** */
- (instancetype)initWithTitle:(NSString *)title;

- (nonnull instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

/** Header must be created with either headerWithTitle: */
- (instancetype)initWithFrame:(CGRect)frame;

/** Header must be created with either headerWithTitle: */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@property (nonatomic, nullable, strong) NSString *title;

@property (nonatomic, nullable, strong) NSString *message;

@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;

@property (nonatomic, strong, nonnull) UIFont *titleFont;

@property (nonatomic, strong, nonnull) UIFont *messageFont;

- (void)updateFonts;


@end
