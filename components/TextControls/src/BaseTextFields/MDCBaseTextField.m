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
#import "MaterialTextControlsPrivate+BaseStyle.h"
#import "MaterialTextControlsPrivate+Shared.h"
#import "private/MDCBaseTextFieldLayout.h"

@interface MDCBaseTextField () <MDCTextControl>

@property(strong, nonatomic) UILabel *label;
@property(nonatomic, strong) MDCTextControlAssistiveLabelView *assistiveLabelView;
@property(strong, nonatomic) MDCBaseTextFieldLayout *layout;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
@property(nonatomic, assign) MDCTextControlState textControlState;
@property(nonatomic, assign) MDCTextControlLabelState labelState;
@property(nonatomic, assign) NSTimeInterval animationDuration;

/**
 This property maps MDCTextControlStates as NSNumbers to
 MDCTextControlColorViewModels.
 */
@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, MDCTextControlColorViewModel *> *colorViewModels;

@end

@implementation MDCBaseTextField
@synthesize containerStyle = _containerStyle;
@synthesize assistiveLabelDrawPriority = _assistiveLabelDrawPriority;
@synthesize customAssistiveLabelDrawPriority = _customAssistiveLabelDrawPriority;
@synthesize preferredContainerHeight = _preferredContainerHeight;

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
  [self observeContentSizeCategoryNotifications];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark View Setup

- (void)initializeProperties {
  self.animationDuration = kMDCTextControlDefaultAnimationDuration;
  self.labelBehavior = MDCTextControlLabelBehaviorFloats;
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  self.labelState = [self determineCurrentLabelState];
  self.textControlState = [self determineCurrentTextControlState];
  self.containerStyle = [[MDCTextControlStyleBase alloc] init];
  self.colorViewModels = [[NSMutableDictionary alloc] init];
}

- (void)setUpColorViewModels {
  self.colorViewModels[@(MDCTextControlStateNormal)] =
      [[MDCTextControlColorViewModel alloc] initWithState:MDCTextControlStateNormal];
  self.colorViewModels[@(MDCTextControlStateEditing)] =
      [[MDCTextControlColorViewModel alloc] initWithState:MDCTextControlStateEditing];
  self.colorViewModels[@(MDCTextControlStateDisabled)] =
      [[MDCTextControlColorViewModel alloc] initWithState:MDCTextControlStateDisabled];
}

- (void)setUpAssistiveLabels {
  self.assistiveLabelDrawPriority = MDCTextControlAssistiveLabelDrawPriorityTrailing;
  self.assistiveLabelView = [[MDCTextControlAssistiveLabelView alloc] init];
  CGFloat assistiveFontSize = MDCRound([UIFont systemFontSize] * (CGFloat)0.75);
  UIFont *assistiveFont = [UIFont systemFontOfSize:assistiveFontSize];
  self.assistiveLabelView.leftAssistiveLabel.font = assistiveFont;
  self.assistiveLabelView.rightAssistiveLabel.font = assistiveFont;
  [self addSubview:self.assistiveLabelView];
}

- (void)setUpLabel {
  self.label = [[UILabel alloc] init];
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

/**
 UITextField layout methods such as @c -textRectForBounds: and @c -editingRectForBounds: are called
 within @c -layoutSubviews. The exact values of the CGRects MDCBaseTextField returns from these
 methods depend on many factors, and are calculated alongside all the other frames of
 MDCBaseTextField's subviews. To ensure that these values are known before UITextField's layout
 methods expect them, they are determined by this method, which is called before the superclass's @c
 -layoutSubviews in the layout cycle.
 */
- (void)preLayoutSubviews {
  self.textControlState = [self determineCurrentTextControlState];
  self.labelState = [self determineCurrentLabelState];
  MDCTextControlColorViewModel *colorViewModel =
      [self textControlColorViewModelForState:self.textControlState];
  [self applyColorViewModel:colorViewModel withLabelState:self.labelState];
  CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
  self.layout = [self calculateLayoutWithTextFieldSize:fittingSize];
}

- (void)postLayoutSubviews {
  self.label.hidden = self.labelState == MDCTextControlLabelStateNone;
  self.assistiveLabelView.frame = self.layout.assistiveLabelViewFrame;
  self.assistiveLabelView.layout = self.layout.assistiveLabelViewLayout;
  [self.assistiveLabelView setNeedsLayout];
  self.leftView.hidden = self.layout.leftViewHidden;
  self.rightView.hidden = self.layout.rightViewHidden;
  [self animateLabel];
  [self.containerStyle applyStyleToTextControl:self animationDuration:self.animationDuration];
}

- (CGRect)textRectFromLayout:(MDCBaseTextFieldLayout *)layout
                  labelState:(MDCTextControlLabelState)labelState {
  CGRect textRect = layout.textRectNormal;
  if (labelState == MDCTextControlLabelStateFloating) {
    textRect = layout.textRectFloating;
  }
  return textRect;
}

/**
 To understand this method one must understand that the CGRect UITextField returns from @c
 -textRectForBounds: does not actually represent the CGRect of visible text in UITextField. It
 represents the CGRect of an internal "field editing" class, which has a height that is
 significantly taller than the text (@c font.lineHeight) itself. Providing a height in @c
 -textRectForBounds: that differs from the height determined by the superclass results in a text
 field with poor text rendering, sometimes to the point of the text not being visible. By taking the
 desired CGRect of the visible text from the layout object, giving it the height preferred by the
 superclass's implementation of @c -textRectForBounds:, and then ensuring that this new CGRect has
 the same midY as the original CGRect, we are able to take control of the text's positioning.
 */
- (CGRect)adjustTextAreaFrame:(CGRect)textRect
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame {
  CGFloat systemDefinedHeight = CGRectGetHeight(parentClassTextAreaFrame);
  CGFloat minY = CGRectGetMidY(textRect) - (systemDefinedHeight * (CGFloat)0.5);
  return CGRectMake(CGRectGetMinX(textRect), minY, CGRectGetWidth(textRect), systemDefinedHeight);
}

- (MDCBaseTextFieldLayout *)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize {
  CGFloat clampedCustomAssistiveLabelDrawPriority =
      [self clampedCustomAssistiveLabelDrawPriority:self.customAssistiveLabelDrawPriority];
  CGFloat clearButtonSideLength = [self clearButtonSideLengthWithTextFieldSize:textFieldSize];
  id<MDCTextControlVerticalPositioningReference> positioningReference =
      [self createPositioningReference];
  return [[MDCBaseTextFieldLayout alloc]
                 initWithTextFieldSize:textFieldSize
                  positioningReference:positioningReference
                                  text:self.text
                                  font:self.normalFont
                          floatingFont:self.floatingFont
                                 label:self.label
                              leftView:self.leftView
                          leftViewMode:self.leftViewMode
                             rightView:self.rightView
                         rightViewMode:self.rightViewMode
                 clearButtonSideLength:clearButtonSideLength
                       clearButtonMode:self.clearButtonMode
                    leftAssistiveLabel:self.assistiveLabelView.leftAssistiveLabel
                   rightAssistiveLabel:self.assistiveLabelView.rightAssistiveLabel
            assistiveLabelDrawPriority:self.assistiveLabelDrawPriority
      customAssistiveLabelDrawPriority:clampedCustomAssistiveLabelDrawPriority
                                 isRTL:self.isRTL
                             isEditing:self.isEditing];
}

- (id<MDCTextControlVerticalPositioningReference>)createPositioningReference {
  return [self.containerStyle
      positioningReferenceWithFloatingFontLineHeight:self.floatingFont.lineHeight
                                normalFontLineHeight:self.normalFont.lineHeight
                                       textRowHeight:self.normalFont.lineHeight
                                    numberOfTextRows:self.numberOfVisibleTextRows
                                             density:0
                            preferredContainerHeight:self.preferredContainerHeight];
}

- (CGFloat)clampedCustomAssistiveLabelDrawPriority:(CGFloat)customPriority {
  CGFloat value = customPriority;
  if (value < 0) {
    value = 0;
  } else if (value > 1) {
    value = 1;
  }
  return value;
}

- (CGFloat)clearButtonSideLengthWithTextFieldSize:(CGSize)textFieldSize {
  CGRect bounds = CGRectMake(0, 0, textFieldSize.width, textFieldSize.height);
  CGRect systemPlaceholderRect = [super clearButtonRectForBounds:bounds];
  return systemPlaceholderRect.size.height;
}

- (CGSize)preferredSizeWithWidth:(CGFloat)width {
  CGSize fittingSize = CGSizeMake(width, CGFLOAT_MAX);
  MDCBaseTextFieldLayout *layout = [self calculateLayoutWithTextFieldSize:fittingSize];
  return CGSizeMake(width, layout.calculatedHeight);
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
}

- (void)mdc_setRightView:(UIView *)rightView {
  [super setRightView:rightView];
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

#pragma mark MDCTextControl accessors

- (void)setLabelBehavior:(MDCTextControlLabelBehavior)labelBehavior {
  if (_labelBehavior == labelBehavior) {
    return;
  }
  _labelBehavior = labelBehavior;
  [self setNeedsLayout];
}

- (void)setContainerStyle:(id<MDCTextControlStyle>)containerStyle {
  id<MDCTextControlStyle> oldStyle = _containerStyle;
  if (oldStyle) {
    [oldStyle removeStyleFrom:self];
  }
  _containerStyle = containerStyle;
  [_containerStyle applyStyleToTextControl:self animationDuration:0];
}

- (CGRect)containerFrame {
  return CGRectMake(0, 0, CGRectGetWidth(self.frame), self.layout.containerHeight);
}

- (CGFloat)numberOfVisibleTextRows {
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
// @c rightView, even though @c rightView is nil. The RTL-aware wrappers around these APIs that
// MDCBaseTextField introduce handle this situation more accurately.
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
  if (self.labelState == MDCTextControlLabelStateFloating) {
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

#pragma mark UITextField Drawing Overrides

- (void)drawPlaceholderInRect:(CGRect)rect {
  if (self.shouldPlaceholderBeVisible) {
    [super drawPlaceholderInRect:rect];
  }
}

#pragma mark Fonts

- (UIFont *)normalFont {
  return self.font ?: [self uiTextFieldDefaultFont];
}

- (UIFont *)floatingFont {
  return [self.containerStyle floatingFontWithNormalFont:self.normalFont];
}

- (UIFont *)uiTextFieldDefaultFont {
  static dispatch_once_t onceToken;
  static UIFont *font;
  dispatch_once(&onceToken, ^{
    font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  });
  return font;
}

#pragma mark Dynamic Type

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  if (@available(iOS 10.0, *)) {
    [super setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
    self.leadingAssistiveLabel.adjustsFontForContentSizeCategory =
        adjustsFontForContentSizeCategory;
    self.trailingAssistiveLabel.adjustsFontForContentSizeCategory =
        adjustsFontForContentSizeCategory;
  }
}

- (void)observeContentSizeCategoryNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self setNeedsLayout];
}

#pragma mark MDCTextControlState

- (MDCTextControlState)determineCurrentTextControlState {
  return [self textControlStateWithIsEnabled:self.isEnabled isEditing:self.isEditing];
}

- (MDCTextControlState)textControlStateWithIsEnabled:(BOOL)isEnabled isEditing:(BOOL)isEditing {
  if (isEnabled) {
    if (isEditing) {
      return MDCTextControlStateEditing;
    } else {
      return MDCTextControlStateNormal;
    }
  } else {
    return MDCTextControlStateDisabled;
  }
}

#pragma mark Placeholder

- (BOOL)shouldPlaceholderBeVisible {
  return [self shouldPlaceholderBeVisibleWithPlaceholder:self.placeholder
                                                    text:self.text
                                              labelState:self.labelState];
}

- (BOOL)shouldPlaceholderBeVisibleWithPlaceholder:(NSString *)placeholder
                                             text:(NSString *)text
                                       labelState:(MDCTextControlLabelState)labelState {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;

  if (hasPlaceholder) {
    if (hasText) {
      return NO;
    } else {
      if (labelState == MDCTextControlLabelStateNormal) {
        return NO;
      } else {
        return YES;
      }
    }
  } else {
    return NO;
  }
}

#pragma mark Label

- (void)animateLabel {
  __weak MDCBaseTextField *weakSelf = self;
  [MDCTextControlLabelAnimation animateLabel:self.label
                                       state:self.labelState
                            normalLabelFrame:self.layout.labelFrameNormal
                          floatingLabelFrame:self.layout.labelFrameFloating
                                  normalFont:self.normalFont
                                floatingFont:self.floatingFont
                           animationDuration:self.animationDuration
                                  completion:^(BOOL finished) {
                                    if (finished) {
                                      // Ensure that the label position is correct in case of
                                      // competing animations.
                                      [weakSelf positionLabel];
                                    }
                                  }];
}

- (void)positionLabel {
  if (self.labelState == MDCTextControlLabelStateFloating) {
    self.label.frame = self.layout.labelFrameFloating;
    self.label.hidden = NO;
  } else if (self.labelState == MDCTextControlLabelStateNormal) {
    self.label.frame = self.layout.labelFrameNormal;
    self.label.hidden = NO;
  } else {
    self.label.frame = CGRectZero;
    self.label.hidden = YES;
  }
}

- (BOOL)canLabelFloat {
  return self.labelBehavior == MDCTextControlLabelBehaviorFloats;
}

- (MDCTextControlLabelState)determineCurrentLabelState {
  return [self labelStateWithLabel:self.label
                              text:self.text
                     canLabelFloat:self.canLabelFloat
                         isEditing:self.isEditing];
}

- (MDCTextControlLabelState)labelStateWithLabel:(UILabel *)label
                                           text:(NSString *)text
                                  canLabelFloat:(BOOL)canLabelFloat
                                      isEditing:(BOOL)isEditing {
  BOOL hasFloatingLabelText = label.text.length > 0;
  BOOL hasText = text.length > 0;
  if (hasFloatingLabelText) {
    if (canLabelFloat) {
      if (isEditing) {
        return MDCTextControlLabelStateFloating;
      } else {
        if (hasText) {
          return MDCTextControlLabelStateFloating;
        } else {
          return MDCTextControlLabelStateNormal;
        }
      }
    } else {
      if (hasText) {
        return MDCTextControlLabelStateNone;
      } else {
        return MDCTextControlLabelStateNormal;
      }
    }
  } else {
    return MDCTextControlLabelStateNone;
  }
}

#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Coloring

- (void)applyColorViewModel:(MDCTextControlColorViewModel *)colorViewModel
             withLabelState:(MDCTextControlLabelState)labelState {
  UIColor *labelColor = [UIColor clearColor];
  if (labelState == MDCTextControlLabelStateNormal) {
    labelColor = colorViewModel.normalLabelColor;
  } else if (labelState == MDCTextControlLabelStateFloating) {
    labelColor = colorViewModel.floatingLabelColor;
  }
  self.textColor = colorViewModel.textColor;
  self.leadingAssistiveLabel.textColor = colorViewModel.leadingAssistiveLabelColor;
  self.trailingAssistiveLabel.textColor = colorViewModel.trailingAssistiveLabelColor;
  self.label.textColor = labelColor;
}

- (void)setTextControlColorViewModel:(MDCTextControlColorViewModel *)colorViewModel
                            forState:(MDCTextControlState)textControlState {
  if (colorViewModel) {
    self.colorViewModels[@(textControlState)] = colorViewModel;
  }
}

- (MDCTextControlColorViewModel *)textControlColorViewModelForState:
    (MDCTextControlState)textControlState {
  MDCTextControlColorViewModel *colorViewModel = self.colorViewModels[@(textControlState)];
  if (!colorViewModel) {
    colorViewModel = [[MDCTextControlColorViewModel alloc] initWithState:textControlState];
  }
  return colorViewModel;
}

#pragma mark Accessibility Overrides

- (NSString *)accessibilityLabel {
  NSString *superAccessibilityLabel = [super accessibilityLabel];
  if (superAccessibilityLabel.length > 0) {
    return superAccessibilityLabel;
  }

  NSMutableArray *accessibilityLabelComponents = [NSMutableArray new];
  if (self.label.text.length > 0) {
    [accessibilityLabelComponents addObject:self.label.text];
  }
  if (self.leadingAssistiveLabel.text.length > 0) {
    [accessibilityLabelComponents addObject:self.leadingAssistiveLabel.text];
  }
  if (self.trailingAssistiveLabel.text.length > 0) {
    [accessibilityLabelComponents addObject:self.trailingAssistiveLabel.text];
  }

  if (accessibilityLabelComponents.count > 0) {
    return [accessibilityLabelComponents componentsJoinedByString:@", "];
  }

  return nil;
}

#pragma mark Color Accessors

- (void)setNormalLabelColor:(nonnull UIColor *)labelColor forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.normalLabelColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)normalLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.normalLabelColor;
}

- (void)setFloatingLabelColor:(nonnull UIColor *)labelColor forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.floatingLabelColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)floatingLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.floatingLabelColor;
}

- (void)setTextColor:(nonnull UIColor *)labelColor forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.textColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)textColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.textColor;
}

- (void)setLeadingAssistiveLabelColor:(nonnull UIColor *)leadingAssistiveLabelColor
                             forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.leadingAssistiveLabelColor = leadingAssistiveLabelColor;
  [self setNeedsLayout];
}

- (nonnull UIColor *)leadingAssistiveLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.leadingAssistiveLabelColor;
}

- (void)setTrailingAssistiveLabelColor:(nonnull UIColor *)trailingAssistiveLabelColor
                              forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.trailingAssistiveLabelColor = trailingAssistiveLabelColor;
  [self setNeedsLayout];
}

- (nonnull UIColor *)trailingAssistiveLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.trailingAssistiveLabelColor;
}

@end
