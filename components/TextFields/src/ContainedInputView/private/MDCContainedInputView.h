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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MDCContainedInputViewColorViewModel.h"
#import "MDCContainedInputViewLabelAnimation.h"
#import "MDCContainedInputViewLabelState.h"
#import "MDCContainerStyleVerticalPositioningReference.h"
#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlState.h"

static const CGFloat kMDCContainedInputViewDefaultAnimationDuration = (CGFloat)0.15;

@protocol MDCContainedInputViewStyle;

@protocol MDCContainedInputView <NSObject>

/**
 Dictates the @c MDCContainedInputViewStyle of the text field. Defaults to an instance of
 MDCContainedInputViewStyleBase.
 */
@property(nonatomic, strong, nonnull) id<MDCContainedInputViewStyle> containerStyle;

/**
 Describes the current @c MDCtextControlState of the view.
 */
@property(nonatomic, assign, readonly) MDCTextControlState textControlState;

/**
 Describes the current @c MDCContainedInputViewLabelState of the contained input view. This
 value is affected by things like the view's state, the value for @c canFloatingLabelFloat, and the
 text of the floating label.
 */
@property(nonatomic, assign, readonly) MDCContainedInputViewLabelState labelState;

/**
 The @c label is a label that occupies the text area when there is no text and that floats
 above the text once there is some. It is distinct from a placeholder.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *label;

/**
 The @c normalFont is the contained input view's primary font. The text is this font. The label also
 has this font when it isn't floating.
 */
@property(strong, nonatomic, readonly, nonnull) UIFont *normalFont;

/**
 The @c floatingFont is the font of the label when it's floating.
 */
@property(strong, nonatomic, readonly, nonnull) UIFont *floatingFont;

/**
 This method returns a color scheme for a given state.
 */
- (nonnull MDCContainedInputViewColorViewModel *)containedInputViewColorViewModelForState:
    (MDCTextControlState)textControlState;

/**
 This method sets a color scheme for a given state.
 */
- (void)setContainedInputViewColorViewModel:
            (nonnull MDCContainedInputViewColorViewModel *)containedInputViewColorViewModel
                                   forState:(MDCTextControlState)textFieldState;

@end

@protocol MDCContainedInputViewStyle <NSObject>

/**
 This method allows objects conforming to MDCContainedInputViewStyle to apply themselves to objects
 conforming to MDCContainedInputView with a set of colors represented by an object conforming to
 MDCContainedInputViewColorViewModel.
 */
- (void)applyStyleToContainedInputView:(nonnull id<MDCContainedInputView>)containedInputView;
/**
 This method allows objects conforming to MDCContainedInputViewStyle to remove the styling
 previously applied to objects conforming to MDCContainedInputView.
 */
- (void)removeStyleFrom:(nonnull id<MDCContainedInputView>)containedInputView;

/**
 The method returns a UIFont for the floating label based on the primary text font of the
 MDCContainedInputView.
 */
- (UIFont *_Nonnull)floatingFontWithFont:(nonnull UIFont *)font;

/**
 This method returns an object that tells a Contained Input View where to position it's views
 vertically.
 */
- (nonnull id<MDCContainerStyleVerticalPositioningReference>)positioningReference;

@end
