/*
 Copyright 2016-present the Material Components for iOS authors. All Rights
 Reserved.

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

#import "MDCTextInputBehavior.h"

#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"
#import "MaterialTypography.h"

#pragma mark - Constants

static const CGFloat MDCTextInputHintTextOpacity = 0.54f;

static NSString *const MDCTextInputBehaviorErrorColorKey = @"MDCTextInputBehaviorErrorColorKey";

static inline UIColor *MDCTextInputInlinePlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

static inline UIColor *MDCTextInputTextErrorColor() {
  // Material Design color palette red at tint 500.
  return [UIColor colorWithRed:211.0f / 255.0f
                         green:67.0f / 255.0f
                          blue:54.0f / 255.0f
                         alpha:[MDCTypography body1FontOpacity]];
}


@interface MDCTextInputBehavior ()

@end

@implementation MDCTextInputBehavior

@synthesize characterLimit = _characterLimit;

@synthesize presentationStyle = _presentationStyle;

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonInitialization];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputBehaviorErrorColorKey];
  // TODO(larche) All properties
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputBehavior *copy = [[[self class] alloc] init];
  // TODO(larche) All properties
  return copy;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextFieldTextDidEndEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

- (void)commonInitialization {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidBeginEditing:)
                        name:UITextFieldTextDidBeginEditingNotification
                      object:self];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidEndEditing:)
                        name:UITextFieldTextDidEndEditingNotification
                      object:self];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidChange:)
                        name:UITextFieldTextDidChangeNotification
                      object:self];
}


#pragma mark - Properties Implementation

- (void)setPresentationStyle:(MDCTextInputPresentationStyle)presentationStyle {
  if (_presentationStyle != presentationStyle) {
    _presentationStyle = presentationStyle;
    [self removeCharacterCountLimit];
    [self updateCharacterCountLimit];
    if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
      self.textInput.underlineColor = [UIColor clearColor];
    }
    [self.textInput setNeedsLayout];
  }
}

#pragma mark - Character Limit Implementation

- (CGSize)trailingUnderlineLabelSize {
  [self.textInput.trailingUnderlineLabel sizeToFit];
  return self.textInput.trailingUnderlineLabel.bounds.size;
}

- (NSUInteger)characterCount {
  return self.characterCounter ? [self.characterCounter characterCountForTextInput:self.textInput]
  : self.textInput.text.length;
}

- (CGRect)characterLimitFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect characterLimitFrame = CGRectZero;
  characterLimitFrame.size = [self.textInput.trailingUnderlineLabel sizeThatFits:bounds.size];
  if ([self shouldLayoutForRTL]) {
    characterLimitFrame.origin.x = 0.0f;
  } else {
    characterLimitFrame.origin.x = CGRectGetMaxX(bounds) - CGRectGetWidth(characterLimitFrame);
  }

  // If its single line full width, position on the line.
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth && ![self.textInput isKindOfClass:[UITextView class]]) {
    characterLimitFrame.origin.y =
    CGRectGetMidY(bounds) - CGRectGetHeight(characterLimitFrame) / 2.0f;
  } else {
    characterLimitFrame.origin.y = CGRectGetMaxY(bounds) - CGRectGetHeight(characterLimitFrame);
  }

  return characterLimitFrame;
}

- (void)removeCharacterCountLimit {
  self.textInput.hidden = YES;
}

- (void)updateCharacterCountLimit {
  if (!self.characterLimit || !self.textInput.isEditing) {
    [self removeCharacterCountLimit];
    return;
  }

  BOOL pastLimit = [self characterCount] > self.characterLimit;

  UIColor *textColor = MDCTextInputInlinePlaceholderTextColor();
  if (pastLimit && self.textInput.isEditing) {
    textColor = MDCTextInputTextErrorColor();
  }

  self.textInput.trailingUnderlineLabel.textColor = textColor;
  [self.textInput.trailingUnderlineLabel sizeToFit];

  [self.textInput insertSubview:self.textInput.trailingUnderlineLabel aboveSubview:self.titleView];
  [self.textInput.underlineView setErroneous:pastLimit];
}

// TODO(larche) Add back in properly.
- (BOOL)shouldLayoutForRTL {
  return NO;
  //  return MDCShouldLayoutForRTL() && MDCRTLCanSupportFullMirroring();
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [_controller didBeginEditing];
}

- (void)textFieldDidEndEditing:(NSNotification *)note {
  [_controller didEndEditing];
}

- (void)textFieldDidChange:(NSNotification *)note {
  [_controller didChange];
}

#pragma mark - Public API

- (void)setErrorText:(NSString *)errorText
    errorAccessibilityValue:(NSString *)errorAccessibilityValue {
}

@end
