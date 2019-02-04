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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A set of Contained Input View states outlined in the Material guidelines. These states overlap and extend UIControlState.
 */
typedef NS_OPTIONS(NSInteger, MDCContainedInputViewState) {
  MDCContainedInputViewStateNormal = 1 << 0, // bits: 0001
  MDCContainedInputViewStateFocused = 1 << 1, // bits: 0010
  MDCContainedInputViewStateActivated = 1 << 2, // bits: 0011
  MDCContainedInputViewStateErrored = 1 << 3, // bits: 0100
  MDCContainedInputViewStateDisabled = 1 << 4, // bits: 0101
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

@protocol MDCContainedInputView <NSObject>
/**
 Dictates the @c MDCContainerStyle of the text field. Defaults to an instance of MDCContainerStyleBase.
 */
@property(nonatomic, strong, nonnull) id<MDCContainedInputViewStyle> containerStyle;

/**
 Describes the current @c MDCContainerStyle of the text field based off its UIControlState and the current values for @c isActivated and @c isErrored.
 */
@property (nonatomic, assign, readonly) MDCContainedInputViewState containedInputViewState;

/**
 The @c leadingUnderlineLabel can be used to display helper or error text.
 */
@property (strong, nonatomic, readonly, nonnull) UILabel *placeholderLabel;
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
@property(nonatomic, assign) MDCContainedInputViewUnderlineLabelDrawPriority underlineLabelDrawPriority;

/**
 When @c underlineLabelDrawPriority is set to @c .custom the value of this property helps determine
 what percentage of the available width each underline label gets. It can be thought of as a
 divider. A value of @c 0 would result in the trailing underline label getting all the available
 width. A value of @c 1 would result in the leading underline label getting all the available width.
 A value of @c .5 would result in each underline label getting 50% of the available width.
 */
@property(nonatomic, assign) CGFloat customUnderlineLabelDrawPriority;

/**
 Returns the rect surrounding the main content, i.e. the area that the container should be drawn around.
 */
@property (nonatomic, assign, readonly) CGRect containerRect;
@end

@protocol MDCContainedInputViewColorScheming <NSObject>
@property(strong, nonatomic, readonly, nonnull) UIColor *textColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *underlineLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *placeholderLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *clearButtonTintColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *errorColor;
@end

@interface MDCContainedInputViewColorScheme : NSObject <MDCContainedInputViewColorScheming>
@property(strong, nonatomic) UIColor *textColor;
@property(strong, nonatomic) UIColor *underlineLabelColor;
@property(strong, nonatomic) UIColor *placeholderLabelColor;
@property(strong, nonatomic) UIColor *clearButtonTintColor;
@property(strong, nonatomic) UIColor *errorColor;
@end

@protocol MDCContainedInputViewStyle <NSObject>
- (nonnull id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:(MDCContainedInputViewState)state;
- (void)applyStyleToContainedInputView:(nonnull id<MDCContainedInputView>)inputView
   withContainedInputViewColorScheming:(nonnull id<MDCContainedInputViewColorScheming>)colorScheme;
- (void)removeStyleFrom:(nonnull id<MDCContainedInputView>)containedInputView;
@end

@protocol MDCContainedInputViewStyleDensityInforming <NSObject>
//@optional

- (CGFloat)spaceBetweenTopAndFloatingPlaceholderWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight;
- (CGFloat)spaceBetweenTopAndTextAreaWithoutFloatingPlaceholderWithTextAreaHeight:(CGFloat)textAreaHeight;
- (CGFloat)spaceBetweenFloatingPlaceholderAndTextAreaWithFloatingPlaceholderMaxY:(CGFloat)textAreaHeight;
- (CGFloat)spaceBetweenTextAreaAndBottomWithoutFloatingPlaceholder:(CGFloat)textAreaHeight;

//- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight;
//- (CGFloat)textRectMinYNormalWithTextHeight:(CGFloat)textHeight;
//- (CGFloat)textRectMinYFloatingPlaceholderWithTextHeight:(CGFloat)textHeight
//                                 floatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
//                                 floatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
//;
//
//
//- (CGFloat)textAreaNormalMinYWithTextHeight:(CGFloat)textHeight;
//- (CGFloat)textAreaFloatingPlaceholderMinYWithTextHeight:(CGFloat)textHeight;
//- (CGFloat)textAreaFloatingPlaceholderMinYWithFont:(UIFont *)font;
//
//- (CGFloat)spaceBetweenFloatingPlaceholderAndTextAreaWithFloatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
//                                                       floatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight;
//- (CGFloat)topRowBottomRowDividerYWithTopRowSubviewMaxY:(CGFloat)topRowSubviewMaxY
//                                   topRowSubviewCenterY:(CGFloat)topRowSubviewCenterY;
//- (CGFloat)floatingPlaceholderFontSizeScaleFactor;
@end

@interface MDCContainerStyleBase : NSObject <MDCContainedInputViewStyle, MDCContainedInputViewStyleDensityInforming>
@end
