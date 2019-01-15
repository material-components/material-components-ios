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

#import "SimpleTextField.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import <MaterialComponents/MDCMath.h>

#import "MDCInputViewContainerStyler.h"

#import "SimpleTextFieldLayout.h"
#import "SimpleTextFieldLayoutUtils.h"
#import "SimpleTextFieldColorSchemeAdapter.h"

#import <Foundation/Foundation.h>



@interface SimpleTextField ()

@property(strong, nonatomic) UIFont *floatingPlaceholderFont;
@property(strong, nonatomic) UIFont *placeholderFont;

@property(strong, nonatomic) UIButton *clearButton;
@property(strong, nonatomic) UIImageView *clearButtonImageView;
@property(strong, nonatomic) UILabel *placeholderLabel;

@property(strong, nonatomic) UILabel *leftUnderlineLabel;
@property(strong, nonatomic) UILabel *rightUnderlineLabel;

@property(strong, nonatomic) SimpleTextFieldLayout *layout;

@property(strong, nonatomic) MDCInputViewContainerStyler *containerStyler;


@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property(nonatomic, assign) TextFieldState textFieldState;
@property(nonatomic, assign) PlaceholderState placeholderState;

@end

// TODO: Go through UITextField.h and make sure you consider the entire public API
@implementation SimpleTextField

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonSimpleTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonSimpleTextFieldInit];
  }
  return self;
}

- (void)commonSimpleTextFieldInit {
  [self addObservers];
  [self initializeProperties];
  [self setUpPlaceholderLabel];
  [self setUpUnderlineLabels];
  [self setUpClearButton];
  [self setUpStyleLayers];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark View Setup

- (void)initializeProperties {
  [self setUpCanPlaceholderFloat];
  [self setUpLayoutDirection];
  [self setUpFonts];
  [self setUpContainerScheme];
  [self setUpPlaceholderState];
  [self setUpTextFieldState];
}

- (void)setUpCanPlaceholderFloat {
  self.canPlaceholderFloat = YES;
}

- (void)setUpTextFieldState {
  self.textFieldState = [self determineCurrentTextFieldState];
}

- (void)setUpPlaceholderState {
  self.placeholderState = [self determineCurrentPlaceholderState];
}

- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)setUpFonts {
  self.placeholderFont = [self determineEffectiveFont];
  self.floatingPlaceholderFont = [self floatingPlaceholderFontWithFont:[self determineEffectiveFont]
                                                        containerStyle:self.containerStyle];
}

- (void)setUpContainerScheme {
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] init];
  self.containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
}

- (void)setUpUnderlineLabels {
  self.leftUnderlineLabel = [[UILabel alloc] init];
  self.rightUnderlineLabel = [[UILabel alloc] init];
  [self addSubview:self.leftUnderlineLabel];
  [self addSubview:self.rightUnderlineLabel];
}

- (void)setUpPlaceholderLabel {
  self.placeholderLabel = [[UILabel alloc] init];
  [self addSubview:self.placeholderLabel];
}

- (void)setUpClearButton {
  CGRect clearButtonFrame =
      CGRectMake(0, 0, kClearButtonTouchTargetSideLength, kClearButtonTouchTargetSideLength);
  self.clearButton = [[UIButton alloc] initWithFrame:clearButtonFrame];
  [self.clearButton addTarget:self
                       action:@selector(clearButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];

  CGRect clearButtonImageViewRect =
      CGRectMake(0, 0, kClearButtonImageViewSideLength, kClearButtonImageViewSideLength);
  self.clearButtonImageView = [[UIImageView alloc] initWithFrame:clearButtonImageViewRect];
  UIImage *clearButtonImage =
      [[self untintedClearButtonImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.clearButtonImageView.image = clearButtonImage;
  [self.clearButton addSubview:self.clearButtonImageView];
  [self addSubview:self.clearButton];
  self.clearButtonImageView.center = self.clearButton.center;
}

- (void)setUpStyleLayers {
  self.containerStyler = [[MDCInputViewContainerStyler alloc] init];
}


- (void)addObservers {
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidEndEditingWithNotification:)
             name:UITextFieldTextDidEndEditingNotification
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidBeginEditingWithNotification:)
             name:UITextFieldTextDidBeginEditingNotification
           object:nil];
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
  self.textFieldState = [self determineCurrentTextFieldState];
  self.placeholderState = [self determineCurrentPlaceholderState];
  SimpleTextFieldColorSchemeAdapter *colorAdapter =
  [[SimpleTextFieldColorSchemeAdapter alloc] initWithColorScheme:self.containerScheme.colorScheme
                                                  textFieldState:self.textFieldState];
  [self applyColorAdapter:colorAdapter];
  [self applyTypographyScheme:self.containerScheme.typographyScheme];
  CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
  self.layout = [self calculateLayoutWithTextFieldSize:fittingSize];
}

- (void)postLayoutSubviews {
  [self applyContainerViewStyle:self.containerStyle
                textFieldState:self.textFieldState
               viewBounds:self.bounds
      floatingPlaceholderFrame:self.layout.placeholderFrameFloating
       topRowBottomRowDividerY:self.layout.topRowBottomRowDividerY
         isFloatingPlaceholder:self.placeholderState == PlaceholderStateFloating];
  [self layOutPlaceholderWithState:self.placeholderState];
  self.clearButton.frame = self.layout.clearButtonFrame;
  self.clearButton.hidden = self.layout.clearButtonHidden;
  self.leftUnderlineLabel.frame = self.layout.leftUnderlineLabelFrame;
  self.rightUnderlineLabel.frame = self.layout.rightUnderlineLabelFrame;
  self.leftView.hidden = self.layout.leftViewHidden;
  self.rightView.hidden = self.layout.rightViewHidden;
  // TODO: Consider hiding views that don't actually fit in the frame
}

- (SimpleTextFieldLayout *)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize {
  UIFont *effectiveFont = [self determineEffectiveFont];
  UIFont *floatingFont = [self floatingPlaceholderFontWithFont:effectiveFont
                                                containerStyle:self.containerStyle];
  CGFloat normalizedCustomUnderlineLabelDrawPriority =
      [self normalizedCustomUnderlineLabelDrawPriority:self.customUnderlineLabelDrawPriority];
  return [[SimpleTextFieldLayout alloc]
                 initWithTextFieldSize:textFieldSize
                        containerStyle:self.containerStyle
                                  text:self.text
                           placeholder:self.placeholder
                                  font:effectiveFont
               floatingPlaceholderFont:floatingFont
                   canPlaceholderFloat:self.canPlaceholderFloat
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
                                 isRTL:[self isRTL]
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
  SimpleTextFieldLayout *layout = [self calculateLayoutWithTextFieldSize:fittingSize];
  return CGSizeMake(width, layout.calculatedHeight);
}

#pragma mark UITextField Accessor Overrides

- (void)setFont:(UIFont *)font {
  [super setFont:font];
  [self setUpFonts];
}

- (void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.attributedText = nil;
  self.placeholderLabel.text = [placeholder copy];
}

- (NSString *)placeholder {
  return self.placeholderLabel.text;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.placeholderLabel.text = [attributedPlaceholder string];
  self.placeholderLabel.attributedText = [attributedPlaceholder copy];
  // TODO: Actually support this by incorporating it into the layout calculations
}

- (NSAttributedString *)attributedPlaceholder {
  return self.placeholderLabel.attributedText;
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
    return self.rightUnderlineLabel;
  } else {
    return self.leftUnderlineLabel;
  }
}

- (UILabel *)trailingUnderlineLabel {
  if ([self isRTL]) {
    return self.leftUnderlineLabel;
  } else {
    return self.rightUnderlineLabel;
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

- (void)setCanPlaceholderFloat:(BOOL)canPlaceholderFloat {
  if (_canPlaceholderFloat == canPlaceholderFloat) {
    return;
  }
  _canPlaceholderFloat = canPlaceholderFloat;
  [self setNeedsLayout];
}

#pragma mark UITextField Layout Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
  return [self adjustTextAreaFrame:self.layout.textAreaFrame
      withParentClassTextAreaFrame:[super textRectForBounds:bounds]];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  return [self adjustTextAreaFrame:self.layout.textAreaFrame
      withParentClassTextAreaFrame:[super editingRectForBounds:bounds]];
}

- (CGRect)adjustTextAreaFrame:(CGRect)textAreaFrame
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame {
  CGFloat systemDefinedHeight = CGRectGetHeight(parentClassTextAreaFrame);
  CGFloat minY = CGRectGetMidY(textAreaFrame) - (systemDefinedHeight * (CGFloat)0.5);
  return CGRectMake(CGRectGetMinX(textAreaFrame), minY, CGRectGetWidth(textAreaFrame),
                    systemDefinedHeight);
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
  if (self.containerStyle == MDCInputViewContainerStyleNone) {
    return [super borderRectForBounds:bounds];
  }
  return CGRectZero;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  return CGRectZero;
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

#pragma mark Text Field State

- (TextFieldState)determineCurrentTextFieldState {
  return [self textFieldStateWithIsEnabled:self.isEnabled
                                 isErrored:self.isErrored
                                 isEditing:self.isEditing
                                isSelected:self.isSelected
                               isActivated:self.isActivated];
}

- (TextFieldState)textFieldStateWithIsEnabled:(BOOL)isEnabled
                                    isErrored:(BOOL)isErrored
                                    isEditing:(BOOL)isEditing
                                   isSelected:(BOOL)isSelected
                                  isActivated:(BOOL)isActivated {
  if (isEnabled) {
    if (isErrored) {
      return TextFieldStateErrored;
    } else {
      if (isEditing) {
        return TextFieldStateFocused;
      } else {
        if (isSelected || isActivated) {
          return TextFieldStateActivated;
        } else {
          return TextFieldStateNormal;
        }
      }
    }
  } else {
    return TextFieldStateDisabled;
  }
}

#pragma mark Clear Button

- (UIImage *)untintedClearButtonImage {
  CGSize clearButtonSize =
      CGSizeMake(kClearButtonImageViewSideLength, kClearButtonImageViewSideLength);
  CGRect rect = CGRectMake(0, 0, clearButtonSize.width, clearButtonSize.height);
  UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
  [[UIColor blackColor] setFill];
  [[self pathForClearButtonImageWithFrame:rect] fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

// This generated code is taken from the MDCTextField.
- (UIBezierPath *)pathForClearButtonImageWithFrame:(CGRect)frame {
  CGRect innerBounds =
      CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2,
                 MDCFloor((frame.size.width - 2) * (CGFloat)0.90909 + (CGFloat)0.5),
                 MDCFloor((frame.size.height - 2) * (CGFloat)0.90909 + (CGFloat)0.5));

  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) +
                                             (CGFloat)0.50000 * innerBounds.size.width,
                                         CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path closePath];
  [ic_clear_path
      moveToPoint:CGPointMake(
                      CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                      CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.45367 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.45367 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.54800 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.54800 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

#pragma mark Placeholder

- (PlaceholderState)determineCurrentPlaceholderState {
  return [self placeholderStateWithPlaceholder:self.placeholder
                                          text:self.text
                           canPlaceholderFloat:self.canPlaceholderFloat
                                     isEditing:self.isEditing];
}

- (void)layOutPlaceholderWithState:(PlaceholderState)placeholderState {
  UIFont *font = nil;
  CGRect frame = CGRectZero;
  BOOL placeholderShouldHide = NO;
  switch (placeholderState) {
    case PlaceholderStateFloating:
      font = self.floatingPlaceholderFont;
      frame = self.layout.placeholderFrameFloating;
      break;
    case PlaceholderStateNormal:
      font = self.placeholderFont;
      frame = self.layout.placeholderFrameNormal;
      break;
    case PlaceholderStateNone:
      font = self.placeholderFont;
      frame = self.layout.placeholderFrameNormal;
      placeholderShouldHide = YES;
      break;
    default:
      break;
  }
  self.placeholderLabel.hidden = placeholderShouldHide;
  __weak typeof(self) weakSelf = self;
  // TODO: Figure out a better way of doing this.
  // One idea: Make it so placeholder animation is actually of a layer transform
  // but at the end you really change the font and frame and stuff.
  [UIView animateWithDuration:kFloatingPlaceholderAnimationDuration
                   animations:^{
                     weakSelf.placeholderLabel.frame = frame;
                     weakSelf.placeholderLabel.font = font;
                   }];
}

- (PlaceholderState)placeholderStateWithPlaceholder:(NSString *)placeholder
                                               text:(NSString *)text
                                canPlaceholderFloat:(BOOL)canPlaceholderFloat
                                          isEditing:(BOOL)isEditing {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;
  if (hasPlaceholder) {
    if (canPlaceholderFloat) {
      if (isEditing) {
        return PlaceholderStateFloating;
      } else {
        if (hasText) {
          return PlaceholderStateFloating;
        } else {
          return PlaceholderStateNormal;
        }
      }
    } else {
      if (hasText) {
        return PlaceholderStateNone;
      } else {
        return PlaceholderStateNormal;
      }
    }
  } else {
    return PlaceholderStateNone;
  }
}

- (UIFont *)floatingPlaceholderFontWithFont:(UIFont *)font
                             containerStyle:(MDCInputViewContainerStyle)containerStyle {
  CGFloat floatingPlaceholderFontSize = 0.0;
  CGFloat outlinedFloatingPlaceholderScale = (CGFloat)41 / (CGFloat)55;
  CGFloat filledFloatingPlaceholderScale = (CGFloat)53 / (CGFloat)71;
  switch (containerStyle) {
    case MDCInputViewContainerStyleNone:
    case MDCInputViewContainerStyleFilled:
    default:
      floatingPlaceholderFontSize =
          (CGFloat)round((double)(font.pointSize * filledFloatingPlaceholderScale));
      break;
    case MDCInputViewContainerStyleOutline:
      floatingPlaceholderFontSize =
          (CGFloat)round((double)(font.pointSize * outlinedFloatingPlaceholderScale));
      break;
  }
  return [font fontWithSize:floatingPlaceholderFontSize];
}

#pragma mark User Actions

- (void)clearButtonPressed:(UIButton *)clearButton {
  self.text = nil;
  // TODO: I'm pretty sure there is a control event or notification UITextField sens or posts here.
  // Add it!
}

// TODO: Do something with these or get rid of them.
#pragma mark Notification Listener Methods

- (void)textFieldDidEndEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

- (void)textFieldDidChangeWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

- (void)textFieldDidBeginEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Style Management

- (void)applyContainerViewStyle:(MDCInputViewContainerStyle)containerStyle
              textFieldState:(TextFieldState)textFieldState
             viewBounds:(CGRect)viewBounds
    floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
     topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
       isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
  CGFloat outlineLineWidth = [self outlineLineWidthForState:textFieldState];
  
  [self.containerStyler applyOutlinedStyle:containerStyle == MDCInputViewContainerStyleOutline
               view:self
      floatingPlaceholderFrame:floatingPlaceholderFrame
       topRowBottomRowDividerY:topRowBottomRowDividerY
         isFloatingPlaceholder:isFloatingPlaceholder
          outlineLineWidth:outlineLineWidth];
  CGFloat underlineThickness = [self underlineThicknessWithTextFieldState:textFieldState];
  [self.containerStyler applyFilledStyle:containerStyle == MDCInputViewContainerStyleFilled
                                       view:self
                    topRowBottomRowDividerY:topRowBottomRowDividerY
      underlineThickness:underlineThickness];
}

- (CGFloat)outlineLineWidthForState:(TextFieldState)textFieldState {
  CGFloat defaultLineWidth = 1;
  switch (textFieldState) {
    case TextFieldStateActivated:
    case TextFieldStateErrored:
    case TextFieldStateFocused:
      defaultLineWidth = 2;
      break;
    case TextFieldStateNormal:
    case TextFieldStateDisabled:
    default:
      break;
  }
  return defaultLineWidth;
}

- (CGFloat)underlineThicknessWithTextFieldState:(TextFieldState)textFieldState {
  CGFloat underlineThickness = 1;
  switch (textFieldState) {
    case TextFieldStateActivated:
    case TextFieldStateErrored:
    case TextFieldStateFocused:
      underlineThickness = 2;
      break;
    case TextFieldStateNormal:
    case TextFieldStateDisabled:
    default:
      break;
  }
  return underlineThickness;
}



#pragma mark Theming

- (void)applyColorAdapter:(SimpleTextFieldColorSchemeAdapter *)colorAdapter {
  self.textColor = colorAdapter.textColor;
  self.leadingUnderlineLabel.textColor = colorAdapter.underlineLabelColor;
  self.trailingUnderlineLabel.textColor = colorAdapter.underlineLabelColor;
  self.placeholderLabel.textColor = colorAdapter.placeholderLabelColor;

  self.clearButtonImageView.tintColor = colorAdapter.clearButtonTintColor;

  self.containerStyler.outlinedSublayer.strokeColor = colorAdapter.outlineColor.CGColor;
  self.containerStyler.filledSublayerUnderline.fillColor = colorAdapter.filledSublayerUnderlineFillColor.CGColor;
  self.containerStyler.filledSublayer.fillColor = colorAdapter.filledSublayerFillColor.CGColor;
}

- (void)applyTypographyScheme:(MDCTypographyScheme *)typographyScheme {
  self.font = typographyScheme.subtitle1;
  self.placeholderFont = typographyScheme.subtitle1;
  self.floatingPlaceholderFont = [self floatingPlaceholderFontWithFont:self.font
                                                        containerStyle:self.containerStyle];
  self.leadingUnderlineLabel.font = typographyScheme.caption;
  self.trailingUnderlineLabel.font = typographyScheme.caption;
}

@end
