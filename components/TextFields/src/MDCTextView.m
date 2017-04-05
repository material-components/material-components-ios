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

#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputLayoutCoordinator.h"

#import "MaterialPalettes.h"
#import "MaterialTypography.h"

NSString *const MDCTextViewCoordinatorKey = @"MDCTextViewCoordinatorKey";
NSString *const MDCTextViewLayoutDelegateKey = @"MDCTextViewLayoutDelegateKey";

@interface MDCTextView ()

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

    _coordinator = [aDecoder decodeObjectForKey:MDCTextViewCoordinatorKey];
    _layoutDelegate = [aDecoder decodeObjectForKey:MDCTextViewLayoutDelegateKey];
  }
  return self;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeConditionalObject:self.coordinator forKey:MDCTextViewCoordinatorKey];
  [aCoder encodeConditionalObject:self.layoutDelegate forKey:MDCTextViewLayoutDelegateKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextView *copy = [[[self class] alloc] init];

  // Just a pointer value copies.
  copy.coordinator = self.coordinator;
  copy.layoutDelegate = self.layoutDelegate;
  return copy;
}

- (void)commonMDCTextViewInitialization {
  // Just the default but we do support scrolling.
  self.scrollEnabled = NO;
  self.textContainer.lineFragmentPadding = 0;
  // The default backgroundColor is white for UITextViews.
  self.backgroundColor = [UIColor clearColor];

  _coordinator = [[MDCTextInputLayoutCoordinator alloc] initWithTextInput:self];

  self.textColor = _coordinator.textColor;
  self.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

  self.editable = YES;

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

- (UILabel *)placeholderLabel {
  return _coordinator.placeholderLabel;
}

- (id<MDCTextInputPositioningDelegate>)positioningDelegate {
  return _coordinator.positioningDelegate;
}

- (void)setPositioningDelegate:(id<MDCTextInputPositioningDelegate>)positioningDelegate {
  _coordinator.positioningDelegate = positioningDelegate;
}

- (UIColor *)textColor {
  return _coordinator.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [super setTextColor:textColor];
  _coordinator.textColor = textColor;
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

- (void)setEditable:(BOOL)editable {
  [super setEditable:editable];
  _coordinator.enabled = editable;
}

- (void)setFont:(UIFont *)font {
  if (self.font != font) {
    [super setFont:font];
    [_coordinator didSetFont];
  }
}

- (void)setText:(NSString *)text {
  [super setText:text];
  [_coordinator didSetText];
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

#pragma mark - UITextView Notification Observation

- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.editing = YES;
  [_coordinator didBeginEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  self.editing = NO;
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

#pragma mark - Accessibility

- (NSString *)accessibilityValue {
  return [self.text length] ? self.text : self.placeholder;
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _coordinator.mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  [_coordinator mdc_setAdjustsFontForContentSizeCategory:adjusts];
}

@end
