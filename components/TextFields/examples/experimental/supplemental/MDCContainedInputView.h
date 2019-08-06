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

#import "MDCContainedInputViewLabelAnimator.h"
#import "MDCContainedInputViewLabelState.h"
#import "MDCTextControlLabelBehavior.h"

/**
 A set of Contained Input View states outlined in the Material guidelines. These states overlap with
 and extend UIControlState.
 */
typedef NS_OPTIONS(NSInteger, MDCContainedInputViewState) {
  /**
   The default state of the contained input view.
   */
  MDCContainedInputViewStateNormal = 1 << 0,
  /**
   The state the view is in during normal editing.
   */
  MDCContainedInputViewStateFocused = 1 << 1,
  /**
   The disabled state.
   */
  MDCContainedInputViewStateDisabled = 1 << 2,
};

// TODO: Remove this.
static const UIControlState UIControlStateEditing = 1 << 16;

// TODO: Get rid of __unused attribute
__unused static MDCContainedInputViewState MDCContainedInputViewStateWithUIControlState(
    UIControlState controlState) {
  if ((controlState & UIControlStateDisabled) == UIControlStateDisabled) {
    return MDCContainedInputViewStateDisabled;
  } else if ((controlState & UIControlStateEditing) == UIControlStateEditing) {
    return MDCContainedInputViewStateFocused;
  } else {
    return MDCContainedInputViewStateNormal;
  }
}

/**
 Dictates the relative importance of the underline labels, and the order in which they are laid out.
 */
typedef NS_ENUM(NSUInteger, MDCContainedInputViewAssistiveLabelDrawPriority) {
  /**
   When the priority is @c .leading, the @c leadingAssistiveLabel will be laid out first within the
   horizontal space available for @b both underline labels. Any remaining space will then be given
   for the @c trailingAssistiveLabel.
   */
  MDCContainedInputViewAssistiveLabelDrawPriorityLeading,
  /**
   When the priority is @c .trailing, the @c trailingAssistiveLabel will be laid out first within
   the horizontal space available for @b both underline labels. Any remaining space will then be
   given for the @c leadingAssistiveLabel.
   */
  MDCContainedInputViewAssistiveLabelDrawPriorityTrailing,
  /**
   When the priority is @c .custom, the @c customAssistiveLabelDrawPriority property will be used to
   divide the space available for the two underline labels.
   */
  MDCContainedInputViewAssistiveLabelDrawPriorityCustom,
};

@protocol MDCContainedInputViewStyler;
@protocol MDCContainedInputViewColorScheming;

@protocol MDCContainedInputView <NSObject>
/**
 */
// TODO: Add property docs
@property(nonatomic, strong, nonnull) MDCContainedInputViewLabelAnimator *labelAnimator;

/**
 Dictates the @c MDCContainerStyler of the text field. Defaults to an instance of
 MDCContainerStylerBase.
 */
@property(nonatomic, strong, nonnull) id<MDCContainedInputViewStyler> containerStyler;

/**
 Describes the current @c MDCContainedInputViewState of the view.
 */
@property(nonatomic, assign, readonly) MDCContainedInputViewState containedInputViewState;

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
 The @c leadingAssistiveLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingAssistiveLabel;

/**
 The @c trailingAssistiveLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingAssistiveLabel;

/**
 This property is used to determine how much horizontal space to allot for each of the two underline
 labels.

 @note The default value is MDCContainedInputViewAssistiveLabelDrawPriorityTrailing. The rationale
 behind this is it is less likely to have long explanatory error text and more likely to have short
 text, like a character counter. It is better to draw the short text first and use whatever space is
 leftover for the longer text, which may wrap to new lines.
 */
@property(nonatomic, assign)
    MDCContainedInputViewAssistiveLabelDrawPriority underlineLabelDrawPriority;

/**
 When @c underlineLabelDrawPriority is set to @c .custom the value of this property helps determine
 what percentage of the available width each underline label gets. It can be thought of as a
 divider. A value of @c 0 would result in the trailing underline label getting all the available
 width. A value of @c 1 would result in the leading underline label getting all the available width.
 A value of @c .5 would result in each underline label getting 50% of the available width.
 */
@property(nonatomic, assign) CGFloat customAssistiveLabelDrawPriority;

/**
 This method returns a color scheme for a given state.
 */
- (nonnull id<MDCContainedInputViewColorScheming>)containedInputViewColorSchemingForState:
    (MDCContainedInputViewState)containedInputViewState;

/**
 This method sets a color scheme for a given state.
 */
- (void)setContainedInputViewColorScheming:
            (nonnull id<MDCContainedInputViewColorScheming>)containedInputViewColorScheming
                                  forState:(MDCContainedInputViewState)textFieldState;

/**
 Returns the rect surrounding the main content, i.e. the area that the container should be drawn
 around.
 */
@property(nonatomic, assign, readonly) CGRect containerFrame;

/**
 This API allows the user to override the default main content area height. The main content area is
 the part of the view where the where the data input happens. It is located above the underline
 label area. If this property is set to a value that's lower than the default main content area
 height the value will be ignored in the calculation of the view's @c intrinsicContentSize.
 */
@property(nonatomic, assign) CGFloat preferredContainerHeight;

@optional

@property(nonatomic, assign) CGFloat numberOfTextRows;

@end

/**
 This protocol represents a set of colors that are semantically meaningful and specific to
 MDCContainedInputView. Each property corresponds to the color of one or more views that an
 MDCContainedInputView manages at a given point of time.
 */
@protocol MDCContainedInputViewColorScheming <NSObject>
/**
 The color of the contained input view's text.
 */
@property(strong, nonatomic, nonnull) UIColor *textColor;
/**
 The color of the contained input view's underline label.
 */
@property(strong, nonatomic, nonnull) UIColor *underlineLabelColor;
/**
 The color of the contained input view's floating label.
 */
@property(strong, nonatomic, nonnull) UIColor *floatingLabelColor;
/**
 The color of the contained input view's placeholder label.
 */
@property(strong, nonatomic, nonnull) UIColor *placeholderColor;
/**
 The tint color of the contained input view's clear button.
 */
@property(strong, nonatomic, nonnull) UIColor *clearButtonTintColor;
/**
 The color the contained input view should apply during an error state.
 */
@property(strong, nonatomic, nonnull) UIColor *errorColor;
@end

/**
 A base implementation of MDCContainedInputViewColorScheming. Intended to be subclassed for styles
 that include additional elements that need to be colored.
 */
@interface MDCContainedInputViewColorScheme : NSObject <MDCContainedInputViewColorScheming>
@property(strong, nonatomic, nonnull) UIColor *textColor;
@property(strong, nonatomic, nonnull) UIColor *underlineLabelColor;
@property(strong, nonatomic, nonnull) UIColor *floatingLabelColor;
@property(strong, nonatomic, nonnull) UIColor *placeholderColor;
@property(strong, nonatomic, nonnull) UIColor *clearButtonTintColor;
@property(strong, nonatomic, nonnull) UIColor *errorColor;
@end

@protocol MDCContainerStylerPositioningDelegate;

@protocol MDCContainedInputViewStyler <NSObject>

/**
 This method provides a default object conforming to MDCContainedInputViewColorScheming.
 */
- (nonnull id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state;
/**
 This method allows objects conforming to MDCContainedInputViewStyler to apply themselves to objects
 conforming to MDCContainedInputView with a set of colors represented by an object conforming to
 MDCContainedInputViewColorScheming.
 */
- (void)applyStyleToContainedInputView:(nonnull id<MDCContainedInputView>)inputView
    withContainedInputViewColorScheming:(nonnull id<MDCContainedInputViewColorScheming>)colorScheme;
/**
 This method allows objects conforming to MDCContainedInputViewStyler to remove the styling
 previously applied to objects conforming to MDCContainedInputView.
 */
- (void)removeStyleFrom:(nonnull id<MDCContainedInputView>)containedInputView;
/**
 The value returned by this method determines how big the font of the floating label should be when
 it's floating.
 */
- (CGFloat)floatingFontSizeScaleFactor;

- (UIFont *_Nonnull)floatingFontWithFont:(nonnull UIFont *)font;

/**
 This method returns an object that tells a Contained Input View where to position it's views
 vertically.
 */
- (nonnull id<MDCContainerStylerPositioningDelegate>)
    positioningDelegateWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                            normalFontLineHeight:(CGFloat)normalFontLineHeight
                                   textRowHeight:(CGFloat)textRowHeight
                                numberOfTextRows:(CGFloat)numberOfTextRows
                                         density:(CGFloat)density
                        preferredContainerHeight:(CGFloat)preferredContainerHeight
                                      labelState:(MDCContainedInputViewLabelState)labelState
                                   labelBehavior:(MDCTextControlLabelBehavior)labelBehavior;

@end

/**
 Objects conforming to this protocol provide information about the vertical positions of views. This
 helps achieve the variations in floating label position across the filled and outlined styles as
 well as the general density of the views.
 */
@protocol MDCContainerStylerPositioningDelegate <NSObject>

@property(nonatomic, assign, readonly) CGFloat paddingBetweenTopAndFloatingLabel;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenTopAndNormalLabel;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenFloatingLabelAndText;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenTextAndBottom;
@property(nonatomic, assign, readonly) CGFloat paddingAroundAssistiveLabels;
@property(nonatomic, assign, readonly) CGFloat containerHeight;

@end
