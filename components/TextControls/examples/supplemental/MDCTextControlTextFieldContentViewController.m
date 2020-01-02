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

#import "MDCTextControlTextFieldContentViewController.h"

#import "MaterialButtons.h"

#import "MDCBaseTextField.h"
#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"

#import "MDCFilledTextField+MaterialTheming.h"
#import "MDCFilledTextField.h"
#import "MDCOutlinedTextField+MaterialTheming.h"
#import "MDCOutlinedTextField.h"

@interface MDCTextControlTextFieldContentViewController ()
@end

@implementation MDCTextControlTextFieldContentViewController

#pragma mark Setup

- (MDCFilledTextField *)createMaterialFilledTextField {
  MDCFilledTextField *textField = [[MDCFilledTextField alloc] init];
  textField.labelBehavior = MDCTextControlLabelBehaviorFloats;
  textField.placeholder = @"555-555-5555";
  textField.label.text = @"Phone number";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.leadingAssistiveLabel.text = @"This is a string.";
  [textField applyThemeWithScheme:self.containerScheme];
  return textField;
}

- (MDCOutlinedTextField *)createMaterialOutlinedTextField {
  MDCOutlinedTextField *textField = [[MDCOutlinedTextField alloc] init];
  textField.placeholder = @"555-555-5555";
  textField.label.text = @"Phone number";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [textField applyThemeWithScheme:self.containerScheme];
  return textField;
}

- (MDCBaseTextField *)createDefaultBaseTextField {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] init];
  textField.placeholder = @"This is a placeholder";
  textField.label.text = @"This is a floating label";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.borderStyle = UITextBorderStyleRoundedRect;
  return textField;
}

#pragma mark Overrides

- (void)initializeScrollViewSubviewsArray {
  [super initializeScrollViewSubviewsArray];

  NSArray *textFieldRelatedScrollViewSubviews = @[
    [self createLabelWithText:@"MDCFilledTextField:"],
    [self createMaterialFilledTextField],
    [self createLabelWithText:@"MDCOutlinedTextField:"],
    [self createMaterialOutlinedTextField],
    [self createLabelWithText:@"MDCBaseTextField:"],
    [self createDefaultBaseTextField],
  ];
  NSMutableArray *mutableScrollViewSubviews = [self.scrollViewSubviews mutableCopy];
  self.scrollViewSubviews =
      [mutableScrollViewSubviews arrayByAddingObjectsFromArray:textFieldRelatedScrollViewSubviews];
}

- (void)applyThemesToScrollViewSubviews {
  [super applyThemesToScrollViewSubviews];

  [self applyThemesToTextFields];
}

- (void)resizeScrollViewSubviews {
  [super resizeScrollViewSubviews];

  [self resizeTextFields];
}

- (void)enforcePreferredFonts {
  [super enforcePreferredFonts];

  if (@available(iOS 10.0, *)) {
    [self.allTextFields
        enumerateObjectsUsingBlock:^(MDCBaseTextField *textField, NSUInteger idx, BOOL *stop) {
          textField.adjustsFontForContentSizeCategory = YES;
          textField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody
                               compatibleWithTraitCollection:textField.traitCollection];
          textField.leadingAssistiveLabel.font =
              [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2
                  compatibleWithTraitCollection:textField.traitCollection];
          textField.trailingAssistiveLabel.font =
              [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2
                  compatibleWithTraitCollection:textField.traitCollection];
        }];
  }
}

- (void)handleResignFirstResponderTapped {
  [super handleResignFirstResponderTapped];

  [self.allTextFields
      enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger idx, BOOL *stop) {
        [textField resignFirstResponder];
      }];
}

- (void)handleDisableButtonTapped {
  [super handleDisableButtonTapped];

  [self.allTextFields enumerateObjectsUsingBlock:^(UITextField *_Nonnull textField, NSUInteger idx,
                                                   BOOL *_Nonnull stop) {
    textField.enabled = !self.isDisabled;
  }];
}

#pragma mark Private helper methods

- (void)resizeTextFields {
  CGFloat textFieldWidth = CGRectGetWidth(self.view.frame) - (2 * self.defaultPadding);
  [self.allTextFields
      enumerateObjectsUsingBlock:^(MDCBaseTextField *textField, NSUInteger idx, BOOL *stop) {
        CGFloat textFieldMinX = CGRectGetMinX(textField.frame);
        CGFloat textFieldMinY = CGRectGetMinY(textField.frame);
        CGFloat viewHeight = CGRectGetHeight(textField.frame);
        CGRect viewFrame = CGRectMake(textFieldMinX, textFieldMinY, textFieldWidth, viewHeight);
        textField.frame = viewFrame;
        [textField sizeToFit];
      }];
}

- (void)applyThemesToTextFields {
  [self.allTextFields
      enumerateObjectsUsingBlock:^(MDCBaseTextField *textField, NSUInteger idx, BOOL *stop) {
        BOOL isEven = idx % 2 == 0;
        if (self.isErrored) {
          if ([textField isKindOfClass:[MDCFilledTextField class]]) {
            MDCFilledTextField *filledTextField = (MDCFilledTextField *)textField;
            [filledTextField applyErrorThemeWithScheme:self.containerScheme];
          } else if ([textField isKindOfClass:[MDCOutlinedTextField class]]) {
            MDCOutlinedTextField *outlinedTextField = (MDCOutlinedTextField *)textField;
            [outlinedTextField applyErrorThemeWithScheme:self.containerScheme];
          }
          if (isEven) {
            textField.leadingAssistiveLabel.text = @"Suspendisse quam elit, mattis sit amet justo "
                                                   @"vel, venenatis lobortis massa. Donec metus "
                                                   @"dolor.";
          } else {
            textField.leadingAssistiveLabel.text = @"This is an error.";
          }
        } else {
          if ([textField isKindOfClass:[MDCFilledTextField class]]) {
            MDCFilledTextField *filledTextField = (MDCFilledTextField *)textField;
            [filledTextField applyThemeWithScheme:self.containerScheme];
          } else if ([textField isKindOfClass:[MDCOutlinedTextField class]]) {
            MDCOutlinedTextField *outlinedTextField = (MDCOutlinedTextField *)textField;
            [outlinedTextField applyThemeWithScheme:self.containerScheme];
          }
          if (isEven) {
            textField.leadingAssistiveLabel.text = @"This is helper text.";
          } else {
            textField.leadingAssistiveLabel.text = nil;
          }
        }
      }];
}

- (NSArray<MDCBaseTextField *> *)allTextFields {
  return [self allScrollViewSubviewsOfClass:[MDCBaseTextField class]];
}

@end
