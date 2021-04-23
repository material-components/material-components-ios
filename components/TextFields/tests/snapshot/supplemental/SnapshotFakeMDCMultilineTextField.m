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

#import "SnapshotFakeMDCMultilineTextField.h"
#import <MDFInternationalization/MDFInternationalization.h>

@implementation SnapshotFakeMDCMultilineTextField {
  BOOL _isEditing;
  BOOL _isEditingOverridden;
  UIUserInterfaceLayoutDirection _effectiveUserInterfaceLayoutDirection;
  BOOL _isEffectiveUserInterfaceLayoutDirectionOverridden;
}

- (BOOL)isEditing {
  if (_isEditingOverridden) {
    return _isEditing;
  }
  return [super isEditing];
}

- (void)MDCtest_setIsEditing:(BOOL)isEditing {
  _isEditingOverridden = YES;
  if (_isEditing == isEditing) {
    return;
  }
  _isEditing = isEditing;

  // MDCTextInputControllers use the UITextField notifications to allow clients to be the text field
  // delegate. As a result, we need to post the relevant notifications when we programmatically
  // change the value of `isEditing` in tests.
  if (_isEditing) {
    [NSNotificationCenter.defaultCenter
        postNotificationName:UITextFieldTextDidBeginEditingNotification
                      object:self];
  } else {
    [NSNotificationCenter.defaultCenter
        postNotificationName:UITextFieldTextDidEndEditingNotification
                      object:self];
  }
}

- (UIUserInterfaceLayoutDirection)effectiveUserInterfaceLayoutDirection {
  if (_isEffectiveUserInterfaceLayoutDirectionOverridden) {
    return _effectiveUserInterfaceLayoutDirection;
  }
  return [super effectiveUserInterfaceLayoutDirection];
}

- (void)MDCtest_setEffectiveUserInterfaceLayoutDirection:(UIUserInterfaceLayoutDirection)direction {
  _isEffectiveUserInterfaceLayoutDirectionOverridden = YES;
  _effectiveUserInterfaceLayoutDirection = direction;
}

#pragma mark - Methods required to conform to UITextInput without warnings.

- (UITextPosition *)beginningOfDocument {
  return self.textView.beginningOfDocument;
}

- (UITextPosition *)endOfDocument {
  return self.textView.endOfDocument;
}

- (BOOL)hasText {
  return self.textView.hasText;
}

- (id<UITextInputDelegate>)inputDelegate {
  return self.textView.inputDelegate;
}

- (void)setInputDelegate:(id<UITextInputDelegate>)inputDelegate {
  self.textView.inputDelegate = inputDelegate;
}

- (UITextRange *)markedTextRange {
  return self.textView.markedTextRange;
}

- (NSDictionary<NSAttributedStringKey, id> *)markedTextStyle {
  return self.textView.markedTextStyle;
}

- (void)setMarkedTextStyle:(NSDictionary<NSAttributedStringKey, id> *)markedTextStyle {
  self.textView.markedTextStyle = markedTextStyle;
}

- (UITextRange *)selectedTextRange {
  return self.textView.selectedTextRange;
}

- (void)setSelectedTextRange:(UITextRange *)selectedTextRange {
  self.textView.selectedTextRange = selectedTextRange;
}

- (void)deleteBackward {
  [self.textView deleteBackward];
}

- (void)insertText:(nonnull NSString *)text {
  [self.textView insertText:text];
}

- (UITextWritingDirection)baseWritingDirectionForPosition:(nonnull UITextPosition *)position
                                              inDirection:(UITextStorageDirection)direction {
  return [self.textView baseWritingDirectionForPosition:position inDirection:direction];
}

- (CGRect)caretRectForPosition:(nonnull UITextPosition *)position {
  return [self.textView caretRectForPosition:position];
}

- (nullable UITextRange *)characterRangeAtPoint:(CGPoint)point {
  return [self.textView characterRangeAtPoint:point];
}

- (nullable UITextRange *)characterRangeByExtendingPosition:(nonnull UITextPosition *)position
                                                inDirection:(UITextLayoutDirection)direction {
  return [self.textView characterRangeByExtendingPosition:position inDirection:direction];
}

- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point {
  return [self.textView closestPositionToPoint:point];
}

- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point
                                        withinRange:(nonnull UITextRange *)range {
  return [self.textView closestPositionToPoint:point withinRange:range];
}

- (NSComparisonResult)comparePosition:(nonnull UITextPosition *)position
                           toPosition:(nonnull UITextPosition *)other {
  return [self.textView comparePosition:position toPosition:other];
}

- (CGRect)firstRectForRange:(nonnull UITextRange *)range {
  return [self.textView firstRectForRange:range];
}

- (NSInteger)offsetFromPosition:(nonnull UITextPosition *)from
                     toPosition:(nonnull UITextPosition *)toPosition {
  return [self.textView offsetFromPosition:from toPosition:toPosition];
}

- (nullable UITextPosition *)positionFromPosition:(nonnull UITextPosition *)position
                                      inDirection:(UITextLayoutDirection)direction
                                           offset:(NSInteger)offset {
  return [self.textView positionFromPosition:position inDirection:direction offset:offset];
}

- (nullable UITextPosition *)positionFromPosition:(nonnull UITextPosition *)position
                                           offset:(NSInteger)offset {
  return [self.textView positionFromPosition:position offset:offset];
}

- (nullable UITextPosition *)positionWithinRange:(nonnull UITextRange *)range
                             farthestInDirection:(UITextLayoutDirection)direction {
  return [self.textView positionWithinRange:range farthestInDirection:direction];
}

- (void)replaceRange:(nonnull UITextRange *)range withText:(nonnull NSString *)text {
  [self.textView replaceRange:range withText:text];
}

- (nonnull NSArray<UITextSelectionRect *> *)selectionRectsForRange:(nonnull UITextRange *)range {
  return [self.textView selectionRectsForRange:range];
}

- (void)setBaseWritingDirection:(UITextWritingDirection)writingDirection
                       forRange:(nonnull UITextRange *)range {
  return [self.textView setBaseWritingDirection:writingDirection forRange:range];
}

- (void)setMarkedText:(nullable NSString *)markedText selectedRange:(NSRange)selectedRange {
  [self.textView setMarkedText:markedText selectedRange:selectedRange];
}

- (nullable NSString *)textInRange:(nonnull UITextRange *)range {
  return [self.textView textInRange:range];
}

- (nullable UITextRange *)textRangeFromPosition:(nonnull UITextPosition *)fromPosition
                                     toPosition:(nonnull UITextPosition *)toPosition {
  return [self.textView textRangeFromPosition:fromPosition toPosition:toPosition];
}

- (void)unmarkText {
  [self.textView unmarkText];
}

- (id<UITextInputTokenizer>)tokenizer {
  return self.textView.tokenizer;
}

@end
