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

#import "MaterialTextFields.h"

@interface TextFieldManualLayoutExample : UIViewController <UITextFieldDelegate>

@property (nonatomic) MDCTextInputController *textFieldControllerFloating;

@end

@implementation TextFieldManualLayoutExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  MDCTextField *textFieldFloating = [[MDCTextField alloc] init];
  [self.view addSubview:textFieldFloating];

  textFieldFloating.placeholder = @"Full Name";
  textFieldFloating.delegate = self;
  textFieldFloating.clearButtonMode = UITextFieldViewModeUnlessEditing;

  self.textFieldControllerFloating = [[MDCTextInputController alloc] initWithTextInput:textFieldFloating];

  self.textFieldControllerFloating.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;
  self.textFieldControllerFloating.textInput.frame = CGRectMake(10, 40, CGRectGetWidth(self.view.bounds)-20, 0);
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self performSelector:@selector(test) withObject:nil afterDelay:2];
//  [self.textFieldControllerFloating.textInput sizeToFit];
}

- (void)test {
  [self.textFieldControllerFloating.textInput sizeToFit];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];

  return NO;
}

@end

@implementation TextFieldManualLayoutExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Manual Layout (Objective C)" ];
}

@end
