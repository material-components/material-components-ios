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
 A set of Contained Input View states outlined in the Material guidelines. These states overlap and
 extend UIControlState.
 */
typedef NS_OPTIONS(NSInteger, MDCContainedInputViewState) {
  MDCContainedInputViewStateNormal = 1 << 0,
  MDCContainedInputViewStateFocused = 1 << 1,
  MDCContainedInputViewStateActivated = 1 << 2,
  MDCContainedInputViewStateErrored = 1 << 3,
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
 This enum allows us to differentiate between traditional UITextField placeholders and the
 "floating" style customary in Text Fields outlined in the Material guidelines.
 */
typedef NS_ENUM(NSUInteger, MDCContainedInputViewPlaceholderState) {
  /**
   The state of having no placeholder.
   */
  MDCContainedInputViewPlaceholderStateNone,
  /**
   The state of having a floating placeholder.
   */
  MDCContainedInputViewPlaceholderStateFloating,
  /**
   The state of having a non-floating placeholder.
   */
  MDCContainedInputViewPlaceholderStateNormal,
};

@protocol MDCContainedInputViewStyle;
@protocol MDCContainedInputViewColorScheming;

@protocol MDCContainedInputView <NSObject>
/**
 Dictates the @c MDCContainerStyle of the text field. Defaults to an instance of
 MDCContainerStyleBase.
 */
@property(nonatomic, strong, nonnull) id<MDCContainedInputViewStyle> containerStyle;

/**
 Describes the current @c MDCContainerStyle of the text field based off its UIControlState and the
 current values for @c isActivated and @c isErrored.
 */
@property(nonatomic, assign, readonly) MDCContainedInputViewState containedInputViewState;

/**
 Describes the current @c MDCContainedInputViewPlaceholderState of the contained input view based
 off its UIControlState,  the value of the @c canPlaceholderFloat property, and the value of its
 placeholder text.
 */
@property(nonatomic, assign, readonly) MDCContainedInputViewPlaceholderState placeholderState;

/**
 The @c leadingUnderlineLabel can be used to display helper or error text.
 */
@property(strong, nonatomic, readonly, nonnull) UILabel *placeholderLabel;
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
 When set to YES, the placeholder floats above the input text instead of disappearing. When
 set to NO it disappears.

 @note The default is YES.
 @note When set to YES, the text field will reserve space for the floating placeholder in the
 layout, which will result in a text field that requires more height to render properly. Consider
 resizing the text field after setting this property, perhaps by calling @c -sizeToFit.
 */
@property(nonatomic, assign) BOOL canPlaceholderFloat;

/**
 This property toggles a state (similar to @c isHighlighted, @c isEnabled, @c isSelected, etc.) that
 is part of a general interpretation of the states outlined in the Material guidelines for Text
 Fields. See the @c MDCContainedInputViewState enum for more information.
 */
@property(nonatomic, assign) BOOL isErrored;

/**
 This property toggles a state (similar to @c isHighlighted, @c isEnabled, @c isSelected, etc.) that
 is part of a general interpretation of the states outlined in the Material guidelines for Text
 Fields. See the @c MDCContainedInputViewState enum for more information.
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
@property(nonatomic, assign, readonly) CGRect containerRect;

/**
 This API allows the user to override the default main content area height. The main content area is
 the part of the view where the where the data input happens. It is located above the underline
 label area. If this property is set to a value that's lower than the default main content area
 height the value will be ignored. Minimum heights are enforced.
 */
@property(nonatomic, assign) CGFloat preferredMainContentAreaHeight;

/**
 This API allows the user to override the default underline label area height. The underline label
 area is the part of the view where the underline labels are. It is located below the main content
 area. If this property is set to a value that's lower than the default underline label area height
 the value will be ignored. Minimum heights are enforced.
 */
@property(nonatomic, assign) CGFloat preferredUnderlineLabelAreaHeight;

@end

/**
 This protocol represents a set of colors that are semantically meaningful and specific to
 MDCContainedInputView. Each property corresponds to the color of a single view that an
 MDCContainedInputView manages at a given point of time.
 */
@protocol MDCContainedInputViewColorScheming <NSObject>
@property(strong, nonatomic, readonly, nonnull) UIColor *textColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *underlineLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *placeholderLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *clearButtonTintColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *errorColor;
@end

/**
 A base implementation of MDCContainedInputViewColorScheming. Intended to be subclassed.
 */
@interface MDCContainedInputViewColorScheme : NSObject <MDCContainedInputViewColorScheming>
@property(strong, nonatomic, nonnull) UIColor *textColor;
@property(strong, nonatomic, nonnull) UIColor *underlineLabelColor;
@property(strong, nonatomic, nonnull) UIColor *placeholderLabelColor;
@property(strong, nonatomic, nonnull) UIColor *clearButtonTintColor;
@property(strong, nonatomic, nonnull) UIColor *errorColor;
@end

@protocol MDCContainedInputViewStyleDensityInforming;

@protocol MDCContainedInputViewStyle <NSObject>
@property(strong, nonatomic, nonnull) id<MDCContainedInputViewStyleDensityInforming>
    densityInformer;
- (nonnull id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state;
- (void)applyStyleToContainedInputView:(nonnull id<MDCContainedInputView>)inputView
    withContainedInputViewColorScheming:(nonnull id<MDCContainedInputViewColorScheming>)colorScheme;
- (void)removeStyleFrom:(nonnull id<MDCContainedInputView>)containedInputView;
- (CGFloat)floatingPlaceholderFontSizeScaleFactor;
@end

@protocol MDCContainedInputViewStyleDensityInforming <NSObject>
@property(nonatomic, assign) CGFloat verticalDensity;
- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight;
- (CGFloat)contentAreaTopPaddingFloatingPlaceholderWithFloatingPlaceholderMaxY:
    (CGFloat)floatingPlaceholderMaxY;
- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingPlaceholderMaxY:
    (CGFloat)floatingPlaceholderMaxY;
- (CGFloat)containerBottomVerticalPadding;
@end

@interface MDCContainerStyleBase : NSObject <MDCContainedInputViewStyle>
- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
@end

@interface MDCContainerStyleBaseDensityInformer
    : NSObject <MDCContainedInputViewStyleDensityInforming>
@end

@interface MDCContainedInputViewPlaceholderManager : NSObject
- (UIFont *)floatingPlaceholderFontWithFont:(UIFont *)font
                             containerStyle:(id<MDCContainedInputViewStyle>)containerStyle;
- (void)layOutPlaceholderWithPlaceholderLabel:(UILabel *)placeholderLabel
                                        state:
                                            (MDCContainedInputViewPlaceholderState)placeholderState
                                  normalFrame:(CGRect)normalFrame
                                floatingFrame:(CGRect)floatingFrame
                                   normalFont:(UIFont *)normalFont
                                 floatingFont:(UIFont *)floatingFont;
@end
