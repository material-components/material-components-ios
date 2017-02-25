/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCTextView.h"

#import "MaterialPalettes.h"
#import "MaterialTypography.h"

#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputController.h"
#import "MDCTextInputTitleView.h"
#import "MDCTextInputUnderlineView.h"

@interface MDCTextView () <MDCControlledTextInput>

@property(nonatomic, strong) MDCTextInputController *controller;
@property(nonatomic, assign, getter=isEditing) BOOL editing;

@end

@implementation MDCTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
  self = [super initWithFrame:frame textContainer:textContainer];
  if (self) {
    self.scrollEnabled = NO;
    self.textContainer.lineFragmentPadding = 0;

    _controller = [[MDCTextInputController alloc] initWithTextField:self isMultiline:YES];

    self.tintColor = MDCTextInputCursorColor();
    self.textColor = _controller.textColor;
    self.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

    self.editable = YES;
    self.textContainerInset = UIEdgeInsetsZero;

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(textViewDidBeginEditing:)
                          name:UITextViewTextDidBeginEditingNotification
                        object:self];
    [defaultCenter addObserver:self
                      selector:@selector(textViewDidEndEditing:)
                          name:UITextViewTextDidEndEditingNotification
                        object:self];
    [defaultCenter addObserver:self
                      selector:@selector(textViewDidChange:)
                          name:UITextViewTextDidChangeNotification
                        object:self];
  }
  return self;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)layoutSubviews {
  BOOL animationsWereEnabled = [UIView areAnimationsEnabled];
  [UIView setAnimationsEnabled:NO];

  [super layoutSubviews];

  [_controller layoutSubviewsWithAnimationsDisabled];

  [UIView setAnimationsEnabled:animationsWereEnabled];
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize tempSize = [super sizeThatFits:size];
  // iOS 7 doesn't display the last line of text unless the height is ceiled.
  tempSize.height = MDCCeil(tempSize.height);
  return tempSize;
}

#pragma mark - Properties Implementation

- (UIColor *)underlineColor {
  return _controller.underlineColor;
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
  _controller.underlineColor = underlineColor;
}

- (NSString *)underlineAccessibilityText {
  return _controller.underlineAccessibilityText;
}

- (void)setUnderlineAccessibilityText:(NSString *)underlineAccessibilityText {
  _controller.underlineAccessibilityText = underlineAccessibilityText;
}

- (NSString *)underlineText {
  return _controller.underlineText;
}

- (void)setUnderlineText:(NSString *)underlineText {
  _controller.underlineText = underlineText;
}

- (UIColor *)underlineTextColor {
  return _controller.underlineTextColor;
}

- (void)setUnderlineTextColor:(UIColor *)underlineTextColor {
  _controller.underlineTextColor = underlineTextColor;
}

- (UIFont *)underlineTextFont {
  return _controller.underlineTextFont;
}

- (void)setUnderlineTextFont:(UIFont *)underlineTextFont {
  _controller.underlineTextFont = underlineTextFont;
}

- (CGFloat)underlineWidth {
  return _controller.underlineWidth;
}

- (void)setUnderlineWidth:(CGFloat)underlineWidth {
  _controller.underlineWidth = underlineWidth;
}

- (NSString *)placeholder {
  return _controller.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  _controller.placeholder = placeholder;
}

- (UIFont *)placeholderFont {
  return _controller.placeholderFont;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
  _controller.placeholderFont = placeholderFont;
}

- (MDCTextInputPresentationStyle)presentationStyle {
  return _controller.presentationStyle;
}

- (void)setPresentationStyle:(MDCTextInputPresentationStyle)presentationStyle {
  if (_controller.presentationStyle != presentationStyle) {
    _controller.presentationStyle = presentationStyle;
    self.textContainerInset = UIEdgeInsetsZero;
  }
}

- (UIColor *)textColor {
  return _controller.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [super setTextColor:textColor];
  _controller.textColor = textColor;
}

- (UIColor *)floatingPlaceholderColor {
  return _controller.floatingPlaceholderColor;
}

- (void)setFloatingPlaceholderColor:(UIColor *)floatingPlaceholderColor {
  _controller.floatingPlaceholderColor = floatingPlaceholderColor;
}

- (CGFloat)floatingPlaceholderScale {
  return _controller.floatingPlaceholderScale;
}

- (void)setFloatingPlaceholderScale:(CGFloat)floatingPlaceholderScale {
  _controller.floatingPlaceholderScale = floatingPlaceholderScale;
}

- (UIColor *)inlinePlaceholderColor {
  return _controller.inlinePlaceholderColor;
}

- (void)setInlinePlaceholderColor:(UIColor *)inlinePlaceholderColor {
  _controller.inlinePlaceholderColor = inlinePlaceholderColor;
}

- (NSUInteger)characterLimit {
  return _controller.characterLimit;
}

- (void)setCharacterLimit:(NSUInteger)characterLimit {
  if (_controller.characterLimit != characterLimit) {
    _controller.characterLimit = characterLimit;
    self.textContainerInset = UIEdgeInsetsZero;
  }
}

- (id<MDCTextInputCharacterCounter>)characterCounter {
  return _controller.characterCounter;
}

- (void)setCharacterCounter:(id<MDCTextInputCharacterCounter>)characterCounter {
  _controller.characterCounter = characterCounter;
}
- (UIColor *)characterLimitColor {
  return _controller.characterLimitColor;
}

- (void)setCharacterLimitColor:(UIColor *)characterLimitColor {
  _controller.characterLimitColor = characterLimitColor;
}

- (UIFont *)characterLimitFont {
  return _controller.characterLimitFont;
}

- (void)setCharacterLimitFont:(UIFont *)characterLimitFont {
  _controller.characterLimitFont = characterLimitFont;
}

// Always set the text container insets based upon style of the text field.
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
  [super setTextContainerInset:[_controller textContainerInset]];
}

#pragma mark - MDCControlledTextField

- (CGRect)textRectThatFitsForBounds:(CGRect)bounds {
  return UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
}

#pragma mark - UIAccessibility

- (NSString *)accessibilityValue {
  return [self.text length] ? self.text : self.placeholder;
}

#pragma mark - UITextView Property Overrides

- (void)setText:(NSString *)text {
  [super setText:text];
  [_controller didSetText];
}

- (void)setFont:(UIFont *)font {
  if (self.font != font) {
    [super setFont:font];
    self.textContainerInset = UIEdgeInsetsZero;
    [_controller didSetFont];
  }
}

- (void)setEditable:(BOOL)editable {
  [super setEditable:editable];
  _controller.enabled = editable;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.editing = YES;
  [_controller didBeginEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  self.editing = NO;
  [_controller didEndEditing];
}

- (void)textViewDidChange:(UITextView *)textView {
  [_controller didChange];
  CGSize currentSize = self.bounds.size;
  CGSize requiredSize = [self sizeThatFits:CGSizeMake(currentSize.width, CGFLOAT_MAX)];
  if (currentSize.height != requiredSize.height && self.delegate &&
      [self.delegate respondsToSelector:@selector(textView:didChangeContentSize:)]) {
    id<MDCTextViewLayoutDelegate> delegate = (id<MDCTextViewLayoutDelegate>)self.delegate;
    [delegate textView:self didChangeContentSize:requiredSize];
  }
}

@end
