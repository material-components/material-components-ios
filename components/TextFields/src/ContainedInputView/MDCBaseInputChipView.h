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

#import "MDCTextControlLabelBehavior.h"

@class MDCBaseInputChipView;
@protocol MDCInputChipViewDelegate <NSObject>
- (void)inputChipViewDidReturn:(nonnull MDCBaseInputChipView *)inputChipView;
- (void)inputChipViewDidDeleteBackwards:(nonnull MDCBaseInputChipView *)inputChipView
                                oldText:(nullable NSString *)oldText
                                newText:(nullable NSString *)newText;
@end

@interface MDCBaseInputChipView : UIControl

@property(weak, nonatomic, nullable) id<MDCInputChipViewDelegate> delegate;

/**
 The @c label is a label that occupies the area the text usually occupies when there is no
 text. It is distinct from the placeholder in that it can move above the text area or disappear to
 reveal the placeholder when editing begins.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *label;

/**
 This property determines the behavior of the textfield's label during editing.
 @note The default is MDCTextControlLabelBehaviorFloats.
 */
@property(nonatomic, assign) MDCTextControlLabelBehavior labelBehavior;

/**
 The @c leadingAssistiveLabel is a label below the text on the leading edge of the view. It can be
 used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingAssistiveLabel;

/**
 The @c trailingAssistiveLabel is a label below the text on the trailing edge of the view. It can be
 used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingAssistiveLabel;

/**
 Indicates whether the text field should automatically update its font when the device’s
 UIContentSizeCategory is changed.
 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.
 Defaults value is NO.
 */
@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/**
 Sets the label color for a given state.
 @param labelColor The UIColor for the given state.
 @param state The UIControlState. The accepted values are UIControlStateNormal,
 UIControlStateDisabled, and UIControlStateEditing, which is a custom MDC
 UIControlState value.
 */
- (void)setLabelColor:(nonnull UIColor *)labelColor forState:(UIControlState)state;
/**
 Returns the label color for a given state.
 @param state The UIControlState.
 */
- (nonnull UIColor *)labelColorForState:(UIControlState)state;

/**
 Sets the text color for a given state.
 @param textColor The UIColor for the given state.
 @param state The UIControlState. The accepted values are UIControlStateNormal,
 UIControlStateDisabled, and UIControlStateEditing, which is a custom MDC
 UIControlState value.
 */
- (void)setTextColor:(nonnull UIColor *)textColor forState:(UIControlState)state;
/**
 Returns the text color for a given state.
 @param state The UIControlState.
 */
- (nonnull UIColor *)textColorForState:(UIControlState)state;

@property(strong, nonatomic, readonly, nonnull) UITextField *textField;
@property(nonatomic, assign) BOOL chipsWrap;
@property(nonatomic, assign) CGFloat chipRowHeight;
@property(nonatomic, assign) CGFloat chipRowSpacing;
- (void)addChip:(nullable UIView *)chip;
@property(nonatomic, assign) CGFloat preferredContainerHeight;
@property(nonatomic, assign) CGFloat preferredNumberOfVisibleRows;

@end
