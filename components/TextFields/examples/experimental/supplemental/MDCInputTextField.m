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

#import "MDCInputTextField.h"

#import <Foundation/Foundation.h>

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCContainerStylerPathDrawingUtils.h"
#import "MDCInputTextFieldLayout.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

#import "MDCContainedInputUnderlineLabelView.h"

@interface MDCInputTextField () <MDCContainedInputView>

@property(strong, nonatomic) UIButton *clearButton;
@property(strong, nonatomic) UIImageView *clearButtonImageView;
@property(strong, nonatomic) UILabel *floatingLabel;
@property(strong, nonatomic) UILabel *placeholderLabel;

@property(strong, nonatomic) MDCInputTextFieldLayout *layout;

@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property(nonatomic, assign) MDCContainedInputViewState containedInputViewState;
@property(nonatomic, assign) MDCContainedInputViewFloatingLabelState floatingLabelState;
@property(nonatomic, assign) BOOL isPlaceholderVisible;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, id<MDCContainedInputViewColorScheming>> *colorSchemes;

@property(nonatomic, strong) MDCContainedInputViewFloatingLabelManager *floatingLabelManager;

@property(nonatomic, strong) MDCContainedInputUnderlineLabelView *underlineLabelView;

@end

@implementation MDCInputTextField
@synthesize preferredMainContentAreaHeight = _preferredMainContentAreaHeight;
@synthesize preferredUnderlineLabelAreaHeight = _preferredUnderlineLabelAreaHeight;
@synthesize underlineLabelDrawPriority = _underlineLabelDrawPriority;
@synthesize customUnderlineLabelDrawPriority = _customUnderlineLabelDrawPriority;
@synthesize containerStyler = _containerStyler;
@synthesize isActivated = _isActivated;
@synthesize isErrored = _isErrored;
@synthesize canFloatingLabelFloat = _canFloatingLabelFloat;

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCInputTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCInputTextFieldInit];
  }
  return self;
}

- (void)commonMDCInputTextFieldInit {
  [self initializeProperties];
  [self setUpFloatingLabel];
  [self setUpPlaceholderLabel];
  [self setUpFloatingLabelManager];
  [self setUpUnderlineLabels];
  [self setUpClearButton];
  [self setUpContainerStyler];
}

#pragma mark View Setup

- (void)initializeProperties {
  [self setUpCanFloatingLabelFloat];
  [self setUpLayoutDirection];
  [self setUpFloatingLabelState];
  [self setUpContainedInputViewState];
  [self setUpColorSchemesDictionary];
}

- (void)setUpCanFloatingLabelFloat {
  self.canFloatingLabelFloat = YES;
}

- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)setUpFloatingLabelState {
  self.floatingLabelState = [self determineCurrentFloatingLabelState];
}

- (void)setUpContainedInputViewState {
  self.containedInputViewState = [self determineCurrentContainedInputViewState];
}

- (void)setUpColorSchemesDictionary {
  self.colorSchemes = [[NSMutableDictionary alloc] init];
}

- (void)setUpContainerStyler {
  self.containerStyler = [[MDCContainerStylerBase alloc] init];
}

- (void)setUpStateDependentColorSchemesForStyle:(id<MDCContainedInputViewStyler>)containerStyler {
  id<MDCContainedInputViewColorScheming> normalColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  id<MDCContainedInputViewColorScheming> focusedColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  id<MDCContainedInputViewColorScheming> activatedColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];

  id<MDCContainedInputViewColorScheming> erroredColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];

  id<MDCContainedInputViewColorScheming> disabledColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];
}

- (void)setUpUnderlineLabels {
  self.underlineLabelDrawPriority = MDCContainedInputViewUnderlineLabelDrawPriorityTrailing;
  self.underlineLabelView = [[MDCContainedInputUnderlineLabelView alloc] init];
  CGFloat underlineFontSize = MDCRound([UIFont systemFontSize] * (CGFloat)0.75);
  UIFont *underlineFont = [UIFont systemFontOfSize:underlineFontSize];
  self.underlineLabelView.leftUnderlineLabel.font = underlineFont;
  self.underlineLabelView.rightUnderlineLabel.font = underlineFont;
  [self addSubview:self.underlineLabelView];
}

- (UILabel *)leftUnderlineLabel {
  return self.underlineLabelView.leftUnderlineLabel;
}

- (UILabel *)rightUnderlineLabel {
  return self.underlineLabelView.rightUnderlineLabel;
}

- (void)setUpFloatingLabel {
  self.floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
  [self addSubview:self.floatingLabel];
}

- (void)setUpPlaceholderLabel {
  self.placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
  [self addSubview:self.placeholderLabel];
}

- (void)setUpFloatingLabelManager {
  self.floatingLabelManager = [[MDCContainedInputViewFloatingLabelManager alloc] init];
}

- (void)setUpClearButton {
  CGFloat clearButtonSideLength = MDCInputTextFieldLayout.clearButtonSideLength;
  CGRect clearButtonFrame = CGRectMake(0, 0, clearButtonSideLength, clearButtonSideLength);
  self.clearButton = [[UIButton alloc] initWithFrame:clearButtonFrame];
  [self.clearButton addTarget:self
                       action:@selector(clearButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];

  CGFloat clearButtonImageViewSideLength = MDCInputTextFieldLayout.clearButtonImageViewSideLength;
  CGRect clearButtonImageViewRect =
      CGRectMake(0, 0, clearButtonImageViewSideLength, clearButtonImageViewSideLength);
  self.clearButtonImageView = [[UIImageView alloc] initWithFrame:clearButtonImageViewRect];
  UIImage *clearButtonImage =
      [[self untintedClearButtonImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.clearButtonImageView.image = clearButtonImage;
  [self.clearButton addSubview:self.clearButtonImageView];
  [self addSubview:self.clearButton];
  self.clearButtonImageView.center = self.clearButton.center;
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
  [self setUpLayoutDirection];
}

#pragma mark Layout

- (void)preLayoutSubviews {
  self.containedInputViewState = [self determineCurrentContainedInputViewState];
  self.floatingLabelState = [self determineCurrentFloatingLabelState];
  self.isPlaceholderVisible = [self shouldPlaceholderBeVisible];
  self.placeholderLabel.font = [self determineEffectiveFont];
  id<MDCContainedInputViewColorScheming> colorScheming =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [self applyMDCContainedInputViewColorScheming:colorScheming];
  CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
  self.layout = [self calculateLayoutWithTextFieldSize:fittingSize];
}

- (void)postLayoutSubviews {
  UIFont *normalFont = [self determineEffectiveFont];
  UIFont *floatingFont = [self.floatingLabelManager floatingFontWithFont:normalFont
                                                         containerStyler:self.containerStyler];
  CGRect adjustedPlaceholderFrame =
      [self adjustTextAreaFrame:self.layout.textRectFloatingLabel
          withParentClassTextAreaFrame:[super textRectForBounds:self.bounds]];
  adjustedPlaceholderFrame = CGRectOffset(adjustedPlaceholderFrame, 0, -1);
  [self.floatingLabelManager layOutPlaceholderLabel:self.placeholderLabel
                                   placeholderFrame:adjustedPlaceholderFrame
                               isPlaceholderVisible:self.isPlaceholderVisible];
  [self.floatingLabelManager layOutFloatingLabel:self.floatingLabel
                                           state:self.floatingLabelState
                                     normalFrame:self.layout.floatingLabelFrameNormal
                                   floatingFrame:self.layout.floatingLabelFrameFloating
                                      normalFont:normalFont
                                    floatingFont:floatingFont];
  id<MDCContainedInputViewColorScheming> colorScheming =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [self.containerStyler applyStyleToContainedInputView:self
                   withContainedInputViewColorScheming:colorScheming];
  self.clearButton.frame = [self clearButtonFrameFromLayout:self.layout
                                         floatingLabelState:self.floatingLabelState];
  self.clearButton.hidden = self.layout.clearButtonHidden;
  self.underlineLabelView.frame = self.layout.underlineLabelViewFrame;
  self.underlineLabelView.layout = self.layout.underlineLabelViewLayout;
  self.leftView.hidden = self.layout.leftViewHidden;
  self.rightView.hidden = self.layout.rightViewHidden;
  // TODO: Consider hiding views that don't actually fit in the frame
}

- (CGRect)clearButtonFrameFromLayout:(MDCInputTextFieldLayout *)layout
                  floatingLabelState:(MDCContainedInputViewFloatingLabelState)floatingLabelState {
  CGRect clearButtonFrame = layout.clearButtonFrame;
  if (floatingLabelState == MDCContainedInputViewFloatingLabelStateFloating) {
    clearButtonFrame = layout.clearButtonFrameFloatingLabel;
  }
  return clearButtonFrame;
}

- (MDCInputTextFieldLayout *)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize {
  UIFont *effectiveFont = [self determineEffectiveFont];
  UIFont *floatingFont = [self.floatingLabelManager floatingFontWithFont:effectiveFont
                                                         containerStyler:self.containerStyler];
  CGFloat normalizedCustomUnderlineLabelDrawPriority =
      [self normalizedCustomUnderlineLabelDrawPriority:self.customUnderlineLabelDrawPriority];
  return [[MDCInputTextFieldLayout alloc]
                  initWithTextFieldSize:textFieldSize
                        containerStyler:self.containerStyler
                                   text:self.text
                            placeholder:self.placeholder
                                   font:effectiveFont
                           floatingFont:floatingFont
                          floatingLabel:self.floatingLabel
                  canFloatingLabelFloat:self.canFloatingLabelFloat
                               leftView:self.leftView
                           leftViewMode:self.leftViewMode
                              rightView:self.rightView
                          rightViewMode:self.rightViewMode
                            clearButton:self.clearButton
                        clearButtonMode:self.clearButtonMode
                     leftUnderlineLabel:self.leftUnderlineLabel
                    rightUnderlineLabel:self.rightUnderlineLabel
             underlineLabelDrawPriority:self.underlineLabelDrawPriority
       customUnderlineLabelDrawPriority:normalizedCustomUnderlineLabelDrawPriority
         preferredMainContentAreaHeight:self.preferredMainContentAreaHeight
      preferredUnderlineLabelAreaHeight:self.preferredUnderlineLabelAreaHeight
                                  isRTL:self.isRTL
                              isEditing:self.isEditing];
}

- (CGFloat)normalizedCustomUnderlineLabelDrawPriority:(CGFloat)customPriority {
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
  MDCInputTextFieldLayout *inputTextFieldLayout =
      [self calculateLayoutWithTextFieldSize:fittingSize];
  return CGSizeMake(width, inputTextFieldLayout.calculatedHeight);
}

#pragma mark UITextField Accessor Overrides

- (void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.attributedText = nil;
  self.placeholderLabel.text = [placeholder copy];
}

- (NSString *)placeholder {
  return self.placeholderLabel.text;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  [super setAttributedPlaceholder:attributedPlaceholder];
  //  self.floatingLabel.text = [attributedPlaceholder string];
  //  self.floatingLabel.attributedText = [attributedPlaceholder copy];
  //  NSLog(@"setting attributedPlaceholder is not currently supported.");
  // TODO: Evaluate if attributedPlaceholder should be supported.
  //}
  //
  //- (NSAttributedString *)attributedPlaceholder {
  //  return self.floatingLabel.attributedText;
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

- (UILabel *)leadingUnderlineLabel {
  if ([self isRTL]) {
    return self.underlineLabelView.rightUnderlineLabel;
  } else {
    return self.underlineLabelView.leftUnderlineLabel;
  }
}

- (UILabel *)trailingUnderlineLabel {
  if ([self isRTL]) {
    return self.underlineLabelView.leftUnderlineLabel;
  } else {
    return self.underlineLabelView.rightUnderlineLabel;
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

- (void)setCanFloatingLabelFloat:(BOOL)canFloatingLabelFloat {
  if (_canFloatingLabelFloat == canFloatingLabelFloat) {
    return;
  }
  _canFloatingLabelFloat = canFloatingLabelFloat;
  [self setNeedsLayout];
}

- (void)setContainerStyler:(id<MDCContainedInputViewStyler>)containerStyler {
  id<MDCContainedInputViewStyler> oldStyle = _containerStyler;
  if (oldStyle) {
    [oldStyle removeStyleFrom:self];
  }
  _containerStyler = containerStyler;
  [self setUpStateDependentColorSchemesForStyle:_containerStyler];
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [_containerStyler applyStyleToContainedInputView:self
               withContainedInputViewColorScheming:colorScheme];
}

#pragma mark MDCContainedInputView accessors

- (void)setIsErrored:(BOOL)isErrored {
  if (_isErrored == isErrored) {
    return;
  }
  _isErrored = isErrored;
  [self setNeedsLayout];
}

- (void)setIsActivated:(BOOL)isActivated {
  if (_isActivated == isActivated) {
    return;
  }
  _isActivated = isActivated;
  [self setNeedsLayout];
}

- (CGRect)textRectFromLayout:(MDCInputTextFieldLayout *)layout
          floatingLabelState:(MDCContainedInputViewFloatingLabelState)floatingLabelState {
  CGRect textRect = layout.textRect;
  if (floatingLabelState == MDCContainedInputViewFloatingLabelStateFloating) {
    textRect = layout.textRectFloatingLabel;
  }
  return textRect;
}

- (CGRect)adjustTextAreaFrame:(CGRect)textRect
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame {
  CGFloat systemDefinedHeight = CGRectGetHeight(parentClassTextAreaFrame);
  CGFloat minY = CGRectGetMidY(textRect) - (systemDefinedHeight * (CGFloat)0.5);
  return CGRectMake(CGRectGetMinX(textRect), minY, CGRectGetWidth(textRect), systemDefinedHeight);
}

- (CGRect)containerFrame {
  return CGRectMake(0, 0, CGRectGetWidth(self.frame), self.layout.topRowBottomRowDividerY);
}

#pragma mark UITextField Layout Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectFromLayout:self.layout
                          floatingLabelState:self.floatingLabelState];
  return [self adjustTextAreaFrame:textRect
      withParentClassTextAreaFrame:[super textRectForBounds:bounds]];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectFromLayout:self.layout
                          floatingLabelState:self.floatingLabelState];
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
  if (!self.containerStyler) {
    return [super borderRectForBounds:bounds];
  }
  return CGRectZero;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
  if (self.floatingLabelState == MDCContainedInputViewFloatingLabelStateNormal) {
    return CGRectZero;
  }
  return [super placeholderRectForBounds:bounds];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  NSDictionary *attributes = @{
    NSFontAttributeName : self.font,
    NSForegroundColorAttributeName : colorScheme.placeholderColor
  };
  [self.placeholder drawInRect:rect withAttributes:attributes];
}

#pragma mark Fonts

- (UIFont *)determineEffectiveFont {
  return self.font ?: [self uiTextFieldDefaultFont];
}

- (UIFont *)uiTextFieldDefaultFont {
  static dispatch_once_t onceToken;
  static UIFont *font;
  dispatch_once(&onceToken, ^{
    font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  });
  return font;
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
    self.floatingLabel.font = textFont;
    self.leadingUnderlineLabel.font = helperFont;
    self.trailingUnderlineLabel.font = helperFont;
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

#pragma mark Text Field State

- (MDCContainedInputViewState)determineCurrentContainedInputViewState {
  return [self containedInputViewStateWithIsEnabled:self.isEnabled
                                          isErrored:self.isErrored
                                          isEditing:self.isEditing
                                         isSelected:self.isSelected
                                        isActivated:self.isActivated];
}

- (MDCContainedInputViewState)containedInputViewStateWithIsEnabled:(BOOL)isEnabled
                                                         isErrored:(BOOL)isErrored
                                                         isEditing:(BOOL)isEditing
                                                        isSelected:(BOOL)isSelected
                                                       isActivated:(BOOL)isActivated {
  if (isEnabled) {
    if (isErrored) {
      return MDCContainedInputViewStateErrored;
    } else {
      if (isEditing) {
        return MDCContainedInputViewStateFocused;
      } else {
        if (isSelected || isActivated) {
          return MDCContainedInputViewStateActivated;
        } else {
          return MDCContainedInputViewStateNormal;
        }
      }
    }
  } else {
    return MDCContainedInputViewStateDisabled;
  }
}

#pragma mark Clear Button

- (UIImage *)untintedClearButtonImage {
  CGFloat sideLength = MDCInputTextFieldLayout.clearButtonImageViewSideLength;
  CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
  UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
  [[UIColor blackColor] setFill];
  [[MDCContainerStylerPathDrawingUtils pathForClearButtonImageWithFrame:rect] fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

#pragma mark Placeholder

- (BOOL)shouldPlaceholderBeVisible {
  return [self shouldPlaceholderBeVisibleWithPlaceholder:self.placeholder
                                      floatingLabelState:self.floatingLabelState
                                                    text:self.text
                                               isEditing:self.isEditing];
}

- (MDCContainedInputViewFloatingLabelState)determineCurrentFloatingLabelState {
  return [self floatingLabelStateWithFloatingLabel:self.floatingLabel
                                              text:self.text
                             canFloatingLabelFloat:self.canFloatingLabelFloat
                                         isEditing:self.isEditing];
}

- (BOOL)shouldPlaceholderBeVisibleWithPlaceholder:(NSString *)placeholder
                               floatingLabelState:
                                   (MDCContainedInputViewFloatingLabelState)floatingLabelState
                                             text:(NSString *)text
                                        isEditing:(BOOL)isEditing {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;

  if (hasPlaceholder) {
    if (hasText) {
      return NO;
    } else {
      if (floatingLabelState == MDCContainedInputViewFloatingLabelStateNormal) {
        return NO;
      } else {
        return YES;
      }
    }
  } else {
    return NO;
  }
}

- (MDCContainedInputViewFloatingLabelState)
    floatingLabelStateWithFloatingLabel:(UILabel *)floatingLabel
                                   text:(NSString *)text
                  canFloatingLabelFloat:(BOOL)canFloatingLabelFloat
                              isEditing:(BOOL)isEditing {
  BOOL hasFloatingLabelText = floatingLabel.text.length > 0;
  BOOL hasText = text.length > 0;
  if (hasFloatingLabelText) {
    if (canFloatingLabelFloat) {
      if (isEditing) {
        return MDCContainedInputViewFloatingLabelStateFloating;
      } else {
        if (hasText) {
          return MDCContainedInputViewFloatingLabelStateFloating;
        } else {
          return MDCContainedInputViewFloatingLabelStateNormal;
        }
      }
    } else {
      if (hasText) {
        return MDCContainedInputViewFloatingLabelStateNone;
      } else {
        return MDCContainedInputViewFloatingLabelStateNormal;
      }
    }
  } else {
    return MDCContainedInputViewFloatingLabelStateNone;
  }
}

#pragma mark User Actions

- (void)clearButtonPressed:(UIButton *)clearButton {
  self.text = nil;
  [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Theming

- (void)applyMDCContainedInputViewColorScheming:
    (id<MDCContainedInputViewColorScheming>)colorScheming {
  self.textColor = colorScheming.textColor;
  self.leadingUnderlineLabel.textColor = colorScheming.underlineLabelColor;
  self.trailingUnderlineLabel.textColor = colorScheming.underlineLabelColor;
  self.floatingLabel.textColor = colorScheming.floatingLabelColor;
  self.placeholderLabel.textColor = colorScheming.placeholderColor;
  self.clearButtonImageView.tintColor = colorScheming.clearButtonTintColor;
}

- (void)setContainedInputViewColorScheming:
            (id<MDCContainedInputViewColorScheming>)simpleTextFieldColorScheming
                                  forState:(MDCContainedInputViewState)containedInputViewState {
  self.colorSchemes[@(containedInputViewState)] = simpleTextFieldColorScheming;
}

- (id<MDCContainedInputViewColorScheming>)containedInputViewColorSchemingForState:
    (MDCContainedInputViewState)containedInputViewState {
  id<MDCContainedInputViewColorScheming> colorScheme =
      self.colorSchemes[@(containedInputViewState)];
  if (!colorScheme) {
    colorScheme = [self.containerStyler defaultColorSchemeForState:containedInputViewState];
  }
  return colorScheme;
}

@end
