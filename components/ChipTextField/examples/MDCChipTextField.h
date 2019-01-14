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

#import "MDCChipView.h"
#import "MDCTextField.h"

@class MDCChipTextField;

@protocol MDCChipTextFieldDelegate <NSObject>

@optional

- (BOOL)chipTextField:(MDCChipTextField *)chipTextField
    shouldAddChipView:(MDCChipView *)chipView
              atIndex:(NSInteger)index;
- (void)chipTextField:(MDCChipTextField *)chipTextField
       didAddChipView:(MDCChipView *)chipView
              atIndex:(NSInteger)index;
- (BOOL)chipTextField:(MDCChipTextField *)chipTextField
    shouldRemoveChipView:(MDCChipView *)chipView
                 atIndex:(NSInteger)index;
- (void)chipTextField:(MDCChipTextField *)chipTextField
    didRemoveChipView:(MDCChipView *)chipView
              atIndex:(NSInteger)index;

- (void)chipTextField:(MDCChipTextField *)chipTextField
    didSelectChipView:(MDCChipView *)chipView
              atIndex:(NSInteger)index;
- (void)chipTextField:(MDCChipTextField *)chipTextField
    didDeselectChipView:(MDCChipView *)chipView
                atIndex:(NSInteger)index;

@end

/*
 MDCChipTextField is a sublcass of MDCTextField which is a subclass of UITextField.
 MDCChipTextField adds chip support to MDCTextField, including adding and removing chips
    and default layout and scrolling support, as specified by the
    [Material Guidelines](https://material.io/design/components/chips.html#input-chips).
*/
@interface MDCChipTextField : MDCTextField

@property(nonatomic, readonly, copy) NSArray<MDCChipView *> *chipViews;

@property(nonatomic, weak) id<MDCChipTextFieldDelegate> chipTextFieldDelegate;

/*
 Appends a chip to the end of the text field.

 To add a chip when hitting the enter key, set a UITextFieldDelegate to the MDCChipTextField
 instance, and listen to the enter key event. Once detected, you can add a chip with the content
 of the text field. Alternatively, you may present a list of options to select from and later
 add a chip with the selected text.

 Example:

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let chipTextField = textField as? MDCChipTextField,
       let chipText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
       chipText.count > 0 {
       chipTextField.appendChip(text: chipText) chipTextField.text = ""
    }
    return true
  }

 @param text The string to display in the chip.
 */
- (void)appendChipWithText:(nonnull NSString *)text NS_SWIFT_NAME(appendChip(text:));

- (void)setChipViewSelected:(BOOL)selected atIndex:(NSInteger)index;

@end
