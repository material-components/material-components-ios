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
   This state most closely resembles the @c selected UIControlState.
   */
  MDCContainedInputViewStateActivated = 1 << 2,
  /**
   The error state.
   */
  MDCContainedInputViewStateErrored = 1 << 3,
  /**
   The disabled state.
   */
  MDCContainedInputViewStateDisabled = 1 << 4,
};

/**
 Dictates the relative importance of the underline labels, and the order in which they are laid out.
 */
typedef NS_ENUM(NSUInteger, MDCContainedInputViewUnderlineLabelDrawPriority) {
  /**
   When the priority is @c .leading, the @c leadingUnderlineLabel will be laid out first within the
   horizontal space available for @b both underline labels. Any remaining space will then be given
   for the @c trailingUnderlineLabel.
   */
  MDCContainedInputViewUnderlineLabelDrawPriorityLeading,
  /**
   When the priority is @c .trailing, the @c trailingUnderlineLabel will be laid out first within
   the horizontal space available for @b both underline labels. Any remaining space will then be
   given for the @c leadingUnderlineLabel.
   */
  MDCContainedInputViewUnderlineLabelDrawPriorityTrailing,
  /**
   When the priority is @c .custom, the @c customUnderlineLabelDrawPriority property will be used to
   divide the space available for the two underline labels.
   */
  MDCContainedInputViewUnderlineLabelDrawPriorityCustom,
};

/**
 This enum represents different states the floating label can be in.
 */
typedef NS_ENUM(NSUInteger, MDCContainedInputViewFloatingLabelState) {
  /**
   The state where the floating label is not visible.
   */
  MDCContainedInputViewFloatingLabelStateNone,
  /**
   The state where the floating label is floating.
   */
  MDCContainedInputViewFloatingLabelStateFloating,
  /**
   The state where the floating label is occupying the normal text area.
   */
  MDCContainedInputViewFloatingLabelStateNormal,
};

@protocol MDCContainedInputViewStyler;
@protocol MDCContainedInputViewColorScheming;

@protocol MDCContainedInputView <NSObject>
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
 Describes the current @c MDCContainedInputViewFloatingLabelState of the contained input view. This
 value is affected by things like the view's state, the value for @c canFloatingLabelFloat, and the
 text of the floating label.
 */
@property(nonatomic, assign, readonly) MDCContainedInputViewFloatingLabelState floatingLabelState;

/**
 The @c floatingLabel is a label that occupies the text area when there is no text and that floats
 above the text once there is some. It is distinct from a placeholder.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *floatingLabel;

/**
 The @c leadingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;

/**
 The @c trailingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;

/**
 This property is used to determine how much horizontal space to allot for each of the two underline
 labels.

 @note The default value is MDCContainedInputViewUnderlineLabelDrawPriorityTrailing. The rationale
 behind this is it is less likely to have long explanatory error text and more likely to have short
 text, like a character counter. It is better to draw the short text first and use whatever space is
 leftover for the longer text, which may wrap to new lines.
 */
@property(nonatomic, assign)
    MDCContainedInputViewUnderlineLabelDrawPriority underlineLabelDrawPriority;

/**
 When @c underlineLabelDrawPriority is set to @c .custom the value of this property helps determine
 what percentage of the available width each underline label gets. It can be thought of as a
 divider. A value of @c 0 would result in the trailing underline label getting all the available
 width. A value of @c 1 would result in the leading underline label getting all the available width.
 A value of @c .5 would result in each underline label getting 50% of the available width.
 */
@property(nonatomic, assign) CGFloat customUnderlineLabelDrawPriority;

/**
 When set to YES, the floating label floats when the view becomes the first responder. When
 set to NO it disappears.

 @note The default is YES.
 */
@property(nonatomic, assign) BOOL canFloatingLabelFloat;

/**
 This property toggles the error state (similar to @c isHighlighted, @c isEnabled, @c isSelected,
 etc.) that is part of a general interpretation of the states outlined in the Material guidelines
 for Text Fields. See the @c MDCContainedInputViewState enum for more information.
 */
@property(nonatomic, assign) BOOL isErrored;

/**
 This property toggles the activated state (similar to @c isHighlighted, @c isEnabled, @c
 isSelected, etc.) that is part of a general interpretation of the states outlined in the Material
 guidelines for Text Fields. See the @c MDCContainedInputViewState enum for more information.
 */
@property(nonatomic, assign) BOOL isActivated;

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
@property(nonatomic, assign) CGFloat preferredMainContentAreaHeight;

/**
 This API allows the user to override the default underline label area height. The underline label
 area is the part of the view where the underline labels are. It is located below the main content
 area. If this property is set to a value that's lower than the default underline label area height
 the value will be ignored in the calculation of the view's @c intrinsicContentSize.
 */
@property(nonatomic, assign) CGFloat preferredUnderlineLabelAreaHeight;

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
@property(strong, nonatomic, readonly, nonnull) UIColor *textColor;
/**
 The color of the contained input view's underline label.
 */
@property(strong, nonatomic, readonly, nonnull) UIColor *underlineLabelColor;
/**
 The color of the contained input view's floating label.
 */
@property(strong, nonatomic, readonly, nonnull) UIColor *floatingLabelColor;
/**
 The color of the contained input view's placeholder label.
 */
@property(strong, nonatomic, readonly, nonnull) UIColor *placeholderColor;
/**
 The tint color of the contained input view's clear button.
 */
@property(strong, nonatomic, readonly, nonnull) UIColor *clearButtonTintColor;
/**
 The color the contained input view should apply during an error state.
 */
@property(strong, nonatomic, readonly, nonnull) UIColor *errorColor;
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

@protocol MDCContainedInputViewStylerPositioningDelegate;

@protocol MDCContainedInputViewStyler <NSObject>

/**
 The style's positioningDelegate. Different implementations of MDCContainedInputView may need
 different vertical positioning delegates for different stylers.
 */
@property(strong, nonatomic, nonnull, readonly) id<MDCContainedInputViewStylerPositioningDelegate>
    positioningDelegate;
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
@end

/**
 Objects conforming to this protocol provide information about the vertical positions of views. This
 helps achieve the variations in floating label position across the filled and outlined styles as
 well as the general density of the views.
 */
@protocol MDCContainedInputViewStylerPositioningDelegate  // <NSObject>
/**
 This is a value between 0 and 1 that determines the visual vertical density of the view.
 */
@property(nonatomic, assign) CGFloat verticalDensity;
/**
 This method returns the mininum Y coordinate of the floating label given its height.
 */
- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingLabelHeight;
/**
 This method returns the top padding of the main content area (where the text is) when the floating
 label is floating.
 */
- (CGFloat)contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:(CGFloat)floatingLabelMaxY;
/**
 This method returns the vertical (top and bottom) padding of the main content area (where the text
 is) when the floating label is in the normal (not floating) state.
 */
- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:(CGFloat)floatingLabelMaxY;
@end

/**
 A base implementation of MDCContainedInputViewStyler.
 */
@interface MDCContainerStylerBase : NSObject <MDCContainedInputViewStyler>
- (nonnull instancetype)initWithPositioningDelegate:
    (nonnull id<MDCContainedInputViewStylerPositioningDelegate>)positioningDelegate;
@end

/**
 A base implementation of MDCContainedInputViewStylerPositioningDelegate.
 */
@interface MDCContainerStylerBasePositioningDelegate
    : NSObject <MDCContainedInputViewStylerPositioningDelegate>
@end

@interface MDCContainedInputViewFloatingLabelManager : NSObject
- (UIFont *_Nonnull)floatingFontWithFont:(nonnull UIFont *)font
                         containerStyler:(nonnull id<MDCContainedInputViewStyler>)containerStyler;
- (void)layOutPlaceholderLabel:(nonnull UILabel *)placeholderLabel
              placeholderFrame:(CGRect)placeholderFrame
          isPlaceholderVisible:(BOOL)isPlaceholderVisible;
- (void)layOutFloatingLabel:(nonnull UILabel *)floatingLabel
                      state:(MDCContainedInputViewFloatingLabelState)floatingLabelState
                normalFrame:(CGRect)normalFrame
              floatingFrame:(CGRect)floatingFrame
                 normalFont:(nonnull UIFont *)normalFont
               floatingFont:(nonnull UIFont *)floatingFont;
@end
