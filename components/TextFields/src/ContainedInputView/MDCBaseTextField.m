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

#import "MDCBaseTextField.h"

#import <Foundation/Foundation.h>

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialMath.h"
#import "MaterialTypography.h"
#import "private/MDCBaseTextFieldLayout.h"
#import "private/MDCContainedInputAssistiveLabelView.h"
#import "private/MDCContainedInputViewColorViewModel.h"
#import "private/MDCContainedInputViewLabelAnimation.h"
#import "private/MDCContainedInputViewStyleBase.h"
#import "private/MDCContainedInputViewStylePathDrawingUtils.h"

@interface MDCBaseTextField () <MDCContainedInputView>

@property(strong, nonatomic) UILabel *label;
@property(nonatomic, strong) MDCContainedInputAssistiveLabelView *assistiveLabelView;
@property(strong, nonatomic) MDCBaseTextFieldLayout *layout;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
@property(nonatomic, assign) MDCContainedInputViewState containedInputViewState;
@property(nonatomic, assign) MDCContainedInputViewLabelState labelState;
@property(nonatomic, assign) NSTimeInterval animationDuration;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, MDCContainedInputViewColorViewModel *> *colorViewModels;

@end

@implementation MDCBaseTextField
@synthesize preferredContainerHeight = _preferredContainerHeight;
@synthesize assistiveLabelDrawPriority = _assistiveLabelDrawPriority;
@synthesize customAssistiveLabelDrawPriority = _customAssistiveLabelDrawPriority;
@synthesize containerStyle = _containerStyle;
@synthesize labelBehavior = _labelBehavior;
@synthesize placeholderColor = _placeholderColor;

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBaseTextFieldInit];
  }
  return self;
}

- (void)commonMDCBaseTextFieldInit {
  [self initializeProperties];
  [self setUpColorViewModels];
  [self setUpLabel];
  [self setUpAssistiveLabels];
}

#pragma mark View Setup

- (void)initializeProperties {
  self.font = [self uiTextFieldDefaultFont];
  self.labelBehavior = MDCTextControlLabelBehaviorFloats;
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  self.labelState = [self determineCurrentLabelState];
  self.containedInputViewState = [self determineCurrentContainedInputViewState];
  self.containerStyle = [[MDCContainedInputViewStyleBase alloc] init];
  self.animationDuration = 0.15;
  self.colorViewModels = [[NSMutableDictionary alloc] init];
}

- (void)setUpColorViewModels {
  self.colorViewModels[@(MDCContainedInputViewStateNormal)] =
      [[MDCContainedInputViewColorViewModel alloc] initWithState:MDCContainedInputViewStateNormal];
  self.colorViewModels[@(MDCContainedInputViewStateFocused)] =
      [[MDCContainedInputViewColorViewModel alloc] initWithState:MDCContainedInputViewStateFocused];
  self.colorViewModels[@(MDCContainedInputViewStateDisabled)] =
      [[MDCContainedInputViewColorViewModel alloc]
          initWithState:MDCContainedInputViewStateDisabled];
}

- (void)setUpAssistiveLabels {
  self.assistiveLabelDrawPriority = MDCContainedInputViewAssistiveLabelDrawPriorityTrailing;
  self.assistiveLabelView = [[MDCContainedInputAssistiveLabelView alloc] init];
  CGFloat assistiveFontSize = MDCRound([UIFont systemFontSize] * (CGFloat)0.75);
  UIFont *assistiveFont = [UIFont systemFontOfSize:assistiveFontSize];
  self.assistiveLabelView.leftAssistiveLabel.font = assistiveFont;
  self.assistiveLabelView.rightAssistiveLabel.font = assistiveFont;
  [self addSubview:self.assistiveLabelView];
}

- (void)setUpLabel {
  self.label = [[UILabel alloc] initWithFrame:self.bounds];
  [self addSubview:self.label];
}

#pragma mark UIView Overrides

- (void)layoutSubviews {
  [self preLayoutSubviews];
  [super layoutSubviews];
  [self postLayoutSubviews];
}

// UITextField's sizeToFit calls this method and then also calls setNeedsLayout.
// When the system calls this method the size parameter is the view's current size.
- (CGSize)sizeThatFits:(CGSize)size {
  return [self preferredSizeWithWidth:size.width];
}

- (CGSize)intrinsicContentSize {
  return [self preferredSizeWithWidth:CGRectGetWidth(self.bounds)];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

#pragma mark Layout

- (void)preLayoutSubviews {
  self.containedInputViewState = [self determineCurrentContainedInputViewState];
  self.labelState = [self determineCurrentLabelState];
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:self.containedInputViewState];
  [self applyColorViewModel:colorViewModel withLabelState:self.labelState];
  CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
  self.layout = [self calculateLayoutWithTextFieldSize:fittingSize];
}

- (void)postLayoutSubviews {
  [MDCContainedInputViewLabelAnimation layOutLabel:self.label
                                             state:self.labelState
                                  normalLabelFrame:self.layout.labelFrameNormal
                                floatingLabelFrame:self.layout.labelFrameFloating
                                        normalFont:self.normalFont
                                      floatingFont:self.floatingFont];
  [self.containerStyle applyStyleToContainedInputView:self];
  self.assistiveLabelView.frame = self.layout.assistiveLabelViewFrame;
  self.assistiveLabelView.layout = self.layout.assistiveLabelViewLayout;
  [self.assistiveLabelView setNeedsLayout];
  self.leftView.hidden = self.layout.leftViewHidden;
  self.rightView.hidden = self.layout.rightViewHidden;
}

- (CGRect)textRectFromLayout:(MDCBaseTextFieldLayout *)layout
                  labelState:(MDCContainedInputViewLabelState)labelState {
  CGRect textRect = layout.textRectNormal;
  if (labelState == MDCContainedInputViewLabelStateFloating) {
    textRect = layout.textRectFloating;
  }
  return textRect;
}

- (CGRect)adjustTextAreaFrame:(CGRect)textRect
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame {
  CGFloat systemDefinedHeight = CGRectGetHeight(parentClassTextAreaFrame);
  CGFloat minY = CGRectGetMidY(textRect) - (systemDefinedHeight * (CGFloat)0.5);
  return CGRectMake(CGRectGetMinX(textRect), minY, CGRectGetWidth(textRect), systemDefinedHeight);
}

- (CGFloat)clearButtonSideLength {
  static dispatch_once_t onceToken;
  static CGRect systemClearButtonRect;
  UITextField *textField = self.textFieldPrototype;
  dispatch_once(&onceToken, ^{
    systemClearButtonRect = [textField clearButtonRectForBounds:textField.bounds];
  });
  CGFloat sideLength = CGRectGetHeight(systemClearButtonRect);
  return sideLength > 0 ? sideLength : 19.0;
}

- (MDCBaseTextFieldLayout *)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize {
  CGFloat normalizedCustomAssistiveLabelDrawPriority =
      [self normalizedCustomAssistiveLabelDrawPriority:self.customAssistiveLabelDrawPriority];
  return [[MDCBaseTextFieldLayout alloc]
                 initWithTextFieldSize:textFieldSize
                  positioningReference:[self createPositioningReference]
                                  text:self.text
                                  font:self.normalFont
                          floatingFont:self.floatingFont
                                 label:self.label
                              leftView:self.leftView
                          leftViewMode:self.leftViewMode
                             rightView:self.rightView
                         rightViewMode:self.rightViewMode
                 clearButtonSideLength:[self clearButtonSideLength]
                       clearButtonMode:self.clearButtonMode
                    leftAssistiveLabel:self.assistiveLabelView.leftAssistiveLabel
                   rightAssistiveLabel:self.assistiveLabelView.rightAssistiveLabel
            assistiveLabelDrawPriority:self.assistiveLabelDrawPriority
      customAssistiveLabelDrawPriority:normalizedCustomAssistiveLabelDrawPriority
              preferredContainerHeight:self.preferredContainerHeight
                                 isRTL:self.isRTL
                             isEditing:self.isEditing];
}

- (id<MDCContainerStyleVerticalPositioningReference>)createPositioningReference {
  return [self.containerStyle
      positioningReferenceWithFloatingFontLineHeight:self.floatingFont.lineHeight
                                normalFontLineHeight:self.normalFont.lineHeight
                                       textRowHeight:self.normalFont.lineHeight
                                    numberOfTextRows:1
                                             density:0
                            preferredContainerHeight:self.preferredContainerHeight];
}

- (CGFloat)normalizedCustomAssistiveLabelDrawPriority:(CGFloat)customPriority {
  CGFloat value = customPriority;
  if (value < 0) {
    value = 0;
  } else if (value > 1) {
    value = 1;
  }
  return value;
}

- (CGSize)preferredSizeWithWidth:(CGFloat)width {
  CGSize fittingSize = CGSizeMake(width, CGFLOAT_MAX);
  MDCBaseTextFieldLayout *inputTextFieldLayout =
      [self calculateLayoutWithTextFieldSize:fittingSize];
  return CGSizeMake(width, inputTextFieldLayout.calculatedHeight);
}

#pragma mark UITextField Accessor Overrides

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  [self setNeedsLayout];
}

- (void)setLeftViewMode:(UITextFieldViewMode)leftViewMode {
  NSLog(@"Setting leftViewMode is not recommended. Consider setting leadingViewMode and "
        @"trailingViewMode instead.");
  [self mdc_setLeftViewMode:leftViewMode];
}

- (void)setRightViewMode:(UITextFieldViewMode)rightViewMode {
  NSLog(@"Setting rightViewMode is not recommended. Consider setting leadingViewMode and "
        @"trailingViewMode instead.");
  [self mdc_setRightViewMode:rightViewMode];
}

- (void)setLeftView:(UIView *)leftView {
  NSLog(@"Setting rightView and leftView are not recommended. Consider setting leadingView and "
        @"trailingView instead.");
  [self mdc_setLeftView:leftView];
}

- (void)setRightView:(UIView *)rightView {
  NSLog(@"Setting rightView and leftView are not recommended. Consider setting leadingView and "
        @"trailingView instead.");
  [self mdc_setRightView:rightView];
}

#pragma mark Custom Accessors

- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
  _animationDuration = animationDuration;
  self.containerStyle.animationDuration = animationDuration;
}

- (NSString *)labelText {
  return self.label.text;
}

- (void)setLabelText:(nullable NSString *)labelText {
  self.label.text = [labelText copy];
}

- (UILabel *)leadingAssistiveLabel {
  if ([self isRTL]) {
    return self.assistiveLabelView.rightAssistiveLabel;
  } else {
    return self.assistiveLabelView.leftAssistiveLabel;
  }
}

- (UILabel *)trailingAssistiveLabel {
  if ([self isRTL]) {
    return self.assistiveLabelView.leftAssistiveLabel;
  } else {
    return self.assistiveLabelView.rightAssistiveLabel;
  }
}

- (void)setTrailingView:(UIView *)trailingView {
  if ([self isRTL]) {
    [self mdc_setLeftView:trailingView];
  } else {
    [self mdc_setRightView:trailingView];
  }
}

- (UIView *)trailingView {
  if ([self isRTL]) {
    return self.leftView;
  } else {
    return self.rightView;
  }
}

- (void)setLeadingView:(UIView *)leadingView {
  if ([self isRTL]) {
    [self mdc_setRightView:leadingView];
  } else {
    [self mdc_setLeftView:leadingView];
  }
}

- (UIView *)leadingView {
  if ([self isRTL]) {
    return self.rightView;
  } else {
    return self.leftView;
  }
}

- (void)mdc_setLeftView:(UIView *)leftView {
  [super setLeftView:leftView];
  // TODO: Determine if a call to setNeedsLayout is necessary or if super calls it
}

- (void)mdc_setRightView:(UIView *)rightView {
  [super setRightView:rightView];
  // TODO: Determine if a call to setNeedsLayout is necessary or if super calls it
}

- (void)setTrailingViewMode:(UITextFieldViewMode)trailingViewMode {
  if ([self isRTL]) {
    [self mdc_setLeftViewMode:trailingViewMode];
  } else {
    [self mdc_setRightViewMode:trailingViewMode];
  }
}

- (UITextFieldViewMode)trailingViewMode {
  if ([self isRTL]) {
    return self.leftViewMode;
  } else {
    return self.rightViewMode;
  }
}

- (void)setLeadingViewMode:(UITextFieldViewMode)leadingViewMode {
  if ([self isRTL]) {
    [self mdc_setRightViewMode:leadingViewMode];
  } else {
    [self mdc_setLeftViewMode:leadingViewMode];
  }
}

- (UITextFieldViewMode)leadingViewMode {
  if ([self isRTL]) {
    return self.rightViewMode;
  } else {
    return self.leftViewMode;
  }
}

- (void)mdc_setLeftViewMode:(UITextFieldViewMode)leftViewMode {
  [super setLeftViewMode:leftViewMode];
}

- (void)mdc_setRightViewMode:(UITextFieldViewMode)rightViewMode {
  [super setRightViewMode:rightViewMode];
}

- (void)setLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  if (_layoutDirection == layoutDirection) {
    return;
  }
  _layoutDirection = layoutDirection;
  [self setNeedsLayout];
}

- (UIColor *)placeholderColor {
  return _placeholderColor ?: [UIColor lightGrayColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
  _placeholderColor = placeholderColor;
  [self updateAttributedPlaceholder];
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self updateAttributedPlaceholder];
}

#pragma mark MDCContainedInputView accessors

- (void)setLabelBehavior:(MDCTextControlLabelBehavior)labelBehavior {
  if (_labelBehavior == labelBehavior) {
    return;
  }
  _labelBehavior = labelBehavior;
  [self setNeedsLayout];
}

- (void)setContainerStyle:(id<MDCContainedInputViewStyle>)containerStyle {
  id<MDCContainedInputViewStyle> oldStyle = _containerStyle;
  if (oldStyle) {
    [oldStyle removeStyleFrom:self];
  }
  _containerStyle = containerStyle;
  _containerStyle.animationDuration = self.animationDuration;
  [_containerStyle applyStyleToContainedInputView:self];
}

- (CGRect)containerFrame {
  return CGRectMake(0, 0, CGRectGetWidth(self.frame), self.layout.containerHeight);
}

- (CGFloat)numberOfTextRows {
  return 1;
}

#pragma mark UITextField Layout Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectFromLayout:self.layout labelState:self.labelState];
  return [self adjustTextAreaFrame:textRect
      withParentClassTextAreaFrame:[super textRectForBounds:bounds]];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectFromLayout:self.layout labelState:self.labelState];
  return [self adjustTextAreaFrame:textRect
      withParentClassTextAreaFrame:[super editingRectForBounds:bounds]];
}

// The implementations for this method and the method below deserve some context! Unfortunately,
// Apple's RTL behavior with these methods is very unintuitive. Imagine you're in an RTL locale and
// you set @c leftView on a standard UITextField. Even though the property that you set is called @c
// leftView, the method @c -rightViewRectForBounds: will be called. They are treating @c leftView as
// @c rightView, even though @c rightView is nil. It's bonkers.
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
  if ([self isRTL]) {
    return self.layout.rightViewFrame;
  } else {
    return self.layout.leftViewFrame;
  }
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
  if ([self isRTL]) {
    return self.layout.leftViewFrame;
  } else {
    return self.layout.rightViewFrame;
  }
}

- (CGRect)borderRectForBounds:(CGRect)bounds {
  if (!self.containerStyle) {
    return [super borderRectForBounds:bounds];
  }
  return CGRectZero;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  if (self.labelState == MDCContainedInputViewLabelStateFloating) {
    return self.layout.clearButtonFrameFloating;
  }
  return self.layout.clearButtonFrameNormal;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
  if (self.shouldPlaceholderBeVisible) {
    return [super placeholderRectForBounds:bounds];
  }
  return CGRectZero;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
  if (self.shouldPlaceholderBeVisible) {
    [super drawPlaceholderInRect:rect];
  }
}

#pragma mark Fonts

- (UIFont *)font {
  return [super font] ?: [self uiTextFieldDefaultFont];
}

- (UIFont *)normalFont {
  return self.font;
}

- (UIFont *)floatingFont {
  return [self.containerStyle floatingFontWithFont:self.normalFont];
}

- (UIFont *)uiTextFieldDefaultFont {
  UIFont *backupSystemFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  return self.textFieldPrototype.font ?: backupSystemFont;
}

- (UITextField *)textFieldPrototype {
  static dispatch_once_t onceToken;
  static UITextField *textField;
  dispatch_once(&onceToken, ^{
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    textField.text = @"Text";
  });
  return textField;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  if (_mdc_adjustsFontForContentSizeCategory) {
    [self startObservingUIContentSizeCategory];
  } else {
    [self stopObservingUIContentSizeCategory];
  }
  [self updateFontsForDynamicType];
}

- (void)updateFontsForDynamicType {
  if (self.mdc_adjustsFontForContentSizeCategory) {
    UIFont *textFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    UIFont *helperFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption];
    self.font = textFont;
    self.label.font = textFont;
    self.leadingAssistiveLabel.font = helperFont;
    self.leadingAssistiveLabel.font = helperFont;
  }
  [self setNeedsLayout];
}

- (void)startObservingUIContentSizeCategory {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateFontsForDynamicType)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)stopObservingUIContentSizeCategory {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

#pragma mark MDCContainedInputViewState

- (MDCContainedInputViewState)determineCurrentContainedInputViewState {
  return [self containedInputViewStateWithIsEnabled:self.isEnabled isEditing:self.isEditing];
}

- (MDCContainedInputViewState)containedInputViewStateWithIsEnabled:(BOOL)isEnabled
                                                         isEditing:(BOOL)isEditing {
  if (isEnabled) {
    if (isEditing) {
      return MDCContainedInputViewStateFocused;
    } else {
      return MDCContainedInputViewStateNormal;
    }
  } else {
    return MDCContainedInputViewStateDisabled;
  }
}

#pragma mark Placeholder

- (BOOL)shouldPlaceholderBeVisible {
  return [self shouldPlaceholderBeVisibleWithPlaceholder:self.placeholder
                                              labelState:self.labelState
                                                    text:self.text
                                               isEditing:self.isEditing];
}

- (BOOL)shouldPlaceholderBeVisibleWithPlaceholder:(NSString *)placeholder
                                       labelState:(MDCContainedInputViewLabelState)labelState
                                             text:(NSString *)text
                                        isEditing:(BOOL)isEditing {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;

  if (hasPlaceholder) {
    if (hasText) {
      return NO;
    } else {
      if (labelState == MDCContainedInputViewLabelStateNormal) {
        return NO;
      } else {
        return YES;
      }
    }
  } else {
    return NO;
  }
}

- (void)updateAttributedPlaceholder {
  NSDictionary *attributes = @{NSForegroundColorAttributeName : self.placeholderColor};
  NSAttributedString *attributedPlaceholder =
      [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
  self.attributedPlaceholder = attributedPlaceholder;
}

#pragma mark Label

- (BOOL)canLabelFloat {
  return self.labelBehavior == MDCTextControlLabelBehaviorFloats;
}

- (MDCContainedInputViewLabelState)determineCurrentLabelState {
  return [self labelStateWithLabel:self.label
                              text:self.text
                     canLabelFloat:self.canLabelFloat
                         isEditing:self.isEditing];
}

- (MDCContainedInputViewLabelState)labelStateWithLabel:(UILabel *)label
                                                  text:(NSString *)text
                                         canLabelFloat:(BOOL)canLabelFloat
                                             isEditing:(BOOL)isEditing {
  BOOL hasFloatingLabelText = label.text.length > 0;
  BOOL hasText = text.length > 0;
  if (hasFloatingLabelText) {
    if (canLabelFloat) {
      if (isEditing) {
        return MDCContainedInputViewLabelStateFloating;
      } else {
        if (hasText) {
          return MDCContainedInputViewLabelStateFloating;
        } else {
          return MDCContainedInputViewLabelStateNormal;
        }
      }
    } else {
      if (hasText) {
        return MDCContainedInputViewLabelStateNone;
      } else {
        return MDCContainedInputViewLabelStateNormal;
      }
    }
  } else {
    return MDCContainedInputViewLabelStateNone;
  }
}

#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Coloring

- (void)applyColorViewModel:(MDCContainedInputViewColorViewModel *)colorViewModel
             withLabelState:(MDCContainedInputViewLabelState)labelState {
  UIColor *labelColor = [UIColor clearColor];
  if (labelState == MDCContainedInputViewLabelStateNormal) {
    labelColor = colorViewModel.normalLabelColor;
  } else if (labelState == MDCContainedInputViewLabelStateFloating) {
    labelColor = colorViewModel.floatingLabelColor;
  }
  self.textColor = colorViewModel.textColor;
  self.leadingAssistiveLabel.textColor = colorViewModel.assistiveLabelColor;
  self.trailingAssistiveLabel.textColor = colorViewModel.assistiveLabelColor;
  self.label.textColor = labelColor;
}

- (void)setContainedInputViewColorViewModel:(MDCContainedInputViewColorViewModel *)colorViewModel
                                   forState:(MDCContainedInputViewState)containedInputViewState {
  if (colorViewModel) {
    self.colorViewModels[@(containedInputViewState)] = colorViewModel;
  }
}

- (MDCContainedInputViewColorViewModel *)containedInputViewColorViewModelForState:
    (MDCContainedInputViewState)containedInputViewState {
  MDCContainedInputViewColorViewModel *colorViewModel =
      self.colorViewModels[@(containedInputViewState)];
  if (!colorViewModel) {
    colorViewModel =
        [[MDCContainedInputViewColorViewModel alloc] initWithState:containedInputViewState];
  }
  return colorViewModel;
}

#pragma mark Color Accessors

- (void)setNormalLabelColor:(nonnull UIColor *)labelColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  colorViewModel.normalLabelColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)normalLabelColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  return colorViewModel.normalLabelColor;
}

- (void)setFloatingLabelColor:(nonnull UIColor *)labelColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  colorViewModel.floatingLabelColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)floatingLabelColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  return colorViewModel.floatingLabelColor;
}

- (void)setTextColor:(nonnull UIColor *)labelColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  colorViewModel.textColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)textColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  return colorViewModel.textColor;
}

- (void)setAssistiveLabelColor:(nonnull UIColor *)assistiveLabelColor
                      forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  colorViewModel.assistiveLabelColor = assistiveLabelColor;
  [self setNeedsLayout];
}

- (UIColor *)assistiveLabelColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  MDCContainedInputViewColorViewModel *colorViewModel =
      [self containedInputViewColorViewModelForState:containedInputViewState];
  return colorViewModel.assistiveLabelColor;
}

@end
