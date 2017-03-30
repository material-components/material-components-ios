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
#import "MDCTextInputLayoutCoordinator.h"

@interface MDCTextView () <MDCControlledTextInput>

@property(nonatomic, strong) MDCTextInputLayoutCoordinator *coordinator;
@property(nonatomic, assign, getter=isEditing) BOOL editing;

@end

@implementation MDCTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
  self = [super initWithFrame:frame textContainer:textContainer];
  if (self) {
    [self commonMDCTextViewInitialization];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCTextViewInitialization];
  }

  return self;
}
- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)commonMDCTextViewInitialization {
  self.scrollEnabled = NO;
  self.textContainer.lineFragmentPadding = 0;

  _coordinator = [[MDCTextInputLayoutCoordinator alloc] initWithTextInput:self isMultiline:YES];

  self.tintColor = MDCTextInputCursorColor();
  self.textColor = _coordinator.textColor;
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

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];

  [_coordinator layoutSubviewsOfInput];
}

- (void)updateConstraints {
  [_coordinator updateConstraintsOfInput];

  [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

#pragma mark - Properties Implementation

- (NSAttributedString *)attributedPlaceholder {
  return _coordinator.attributedPlaceholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  _coordinator.attributedPlaceholder = attributedPlaceholder;
}

- (BOOL)hidesPlaceholderOnInput {
  return _coordinator.hidesPlaceholderOnInput;
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  _coordinator.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
}

- (UILabel *)leadingUnderlineLabel {
  return _coordinator.leadingUnderlineLabel;
}

- (NSString *)placeholder {
  return self.coordinator.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [self.coordinator setPlaceholder:placeholder];
}

- (UIFont *)placeholderFont {
  return self.placeholderLabel.font;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
  self.placeholderLabel.font = placeholderFont;
}

- (UILabel *)placeholderLabel {
  return _coordinator.placeholderLabel;
}

- (UIColor *)textColor {
  return _coordinator.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [super setTextColor:textColor];
  _coordinator.textColor = textColor;
}

// Always set the text container insets based upon style of the text field.
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
  [super setTextContainerInset:[_coordinator textContainerInset]];
}

- (UILabel *)trailingUnderlineLabel {
  return _coordinator.trailingUnderlineLabel;
}

- (UIColor *)underlineColor {
  return _coordinator.underlineColor;
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
  _coordinator.underlineColor = underlineColor;
}

- (CGFloat)underlineHeight {
  return _coordinator.underlineHeight;
}

- (void)setUnderlineHeight:(CGFloat)underlineHeight {
  _coordinator.underlineHeight = underlineHeight;
}

#pragma mark - UITextView Property Overrides

- (void)setText:(NSString *)text {
  [super setText:text];
  [_coordinator didSetText];
}

- (void)setFont:(UIFont *)font {
  if (self.font != font) {
    [super setFont:font];
    self.textContainerInset = UIEdgeInsetsZero;
    [_coordinator didSetFont];
  }
}

- (void)setEditable:(BOOL)editable {
  [super setEditable:editable];
  _coordinator.enabled = editable;
}

#pragma mark - MDCControlledTextField

- (CGRect)textRectThatFitsForBounds:(CGRect)bounds {
  return UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
}

#pragma mark - UIAccessibility

- (NSString *)accessibilityValue {
  return [self.text length] ? self.text : self.placeholder;
}

#pragma mark - UITextView Notification Observation

- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.editing = YES;
  [_coordinator didBeginEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  self.editing = NO;
  [_coordinator didEndEditing];
}

- (void)textViewDidChange:(UITextView *)textView {
  [_coordinator didChange];
  CGSize currentSize = self.bounds.size;
  CGSize requiredSize = [self sizeThatFits:CGSizeMake(currentSize.width, CGFLOAT_MAX)];
  if (currentSize.height != requiredSize.height && self.delegate &&
      [self.delegate respondsToSelector:@selector(textView:didChangeContentSize:)]) {
    id<MDCTextViewLayoutDelegate> delegate = (id<MDCTextViewLayoutDelegate>)self.delegate;
    [delegate textView:self didChangeContentSize:requiredSize];
  }
}

@end
