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

#import "MDCTextControlColorViewModel.h"
#import "MDCTextControlLabelAnimation.h"
#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlLabelState.h"
#import "MDCTextControlState.h"
#import "MDCTextControlVerticalPositioningReference.h"

static const CGFloat kMDCTextControlDefaultAnimationDuration = (CGFloat)0.15;

@protocol MDCTextControlStyle;

@protocol MDCTextControl <NSObject>

/**
 This object represents the style of the text control, i.e. the thing that makes it filled or
 outlined. See the documentation for MDCTextControlStyle for more information on its
 responsibilities.
 */
@property(nonatomic, strong, nonnull) id<MDCTextControlStyle> containerStyle;

/**
 Describes the current @c MDCtextControlState of the view. This value is affected by things like
 UIControlState, as well as whether or not it's editing.
 */
@property(nonatomic, assign, readonly) MDCTextControlState textControlState;

/**
 Describes the current MDCTextControlLabelState of the contained input view. This
 value is affected by things like the view's @c textControlState, its @c labelBehavior, and the
 text of the floating label.
 */
@property(nonatomic, assign, readonly) MDCTextControlLabelState labelState;

/**
 Describes the behavior of the label when the view begins editing.
 */
@property(nonatomic, assign, readonly) MDCTextControlLabelBehavior labelBehavior;

/**
 The @c label is a label that occupies the text area in a resting state with no text and that either
 floats above the text or disappears in an editing state. It is distinct from a placeholder.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *label;

/**
 The @c normalFont is the contained input view's primary font. The text has this font. The label
 also has this font when it isn't floating.
 */
@property(strong, nonatomic, readonly, nonnull) UIFont *normalFont;

/**
 The @c floatingFont is the font of the label when it's floating.
 */
@property(strong, nonatomic, readonly, nonnull) UIFont *floatingFont;

/**
 This method returns a MDCTextControlColorViewModel for a given MDCTextControlState.
 */
- (nonnull MDCTextControlColorViewModel *)textControlColorViewModelForState:
    (MDCTextControlState)textControlState;

/**
 This method sets a MDCTextControlColorViewModel for a given MDCTextControlState.
 */
- (void)setTextControlColorViewModel:
            (nonnull MDCTextControlColorViewModel *)textControlColorViewModel
                            forState:(MDCTextControlState)textFieldState;

@end

@protocol MDCTextControlStyle <NSObject>

/**
 This method allows objects conforming to MDCTextControlStyle to apply themselves to objects
 conforming to MDCTextControl.
 */
- (void)applyStyleToTextControl:(nonnull id<MDCTextControl>)textControl;
/**
 This method allows objects conforming to MDCTextControlStyle to remove the styling
 previously applied to objects conforming to MDCTextControl.
 */
- (void)removeStyleFrom:(nonnull id<MDCTextControl>)textControl;

/**
 The method returns a UIFont for the floating label based on the @c normalFont of the
 view.
 */
- (UIFont *_Nonnull)floatingFontWithNormalFont:(nonnull UIFont *)font;

/**
 This method returns an object that tells the view where to position it's views
 vertically.
 */
- (nonnull id<MDCTextControlVerticalPositioningReference>)
    positioningReferenceWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                              normalFontLineHeight:(CGFloat)normalFontLineHeight
                                     textRowHeight:(CGFloat)textRowHeight
                                  numberOfTextRows:(CGFloat)numberOfTextRows;

@end
