//
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

#import "TextFieldExample.h"

#import "MaterialTextFields.h"

@interface TextFieldExample ()

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TextFieldExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

  self.title = @"Material Text Fields";

  MDCTextField *textFieldDefaultCharMax = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldDefaultCharMax];

  textFieldDefaultCharMax.placeholder = @"Enter up to 50 characters";
  textFieldDefaultCharMax.delegate = self;

  // Second the controller is created to manage the text field
  MDCTextInputController *textFieldControllerDefaultCharMax = [[MDCTextInputController alloc] initWithTextInput: textFieldDefaultCharMax];
  textFieldControllerDefaultCharMax.characterCountMax = 50;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Typical Use" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"Text fields allow users to input text into your app. They are a direct connection to your users' thoughts and intentions via on-screen, or physical, keyboard. The Material Design Text Fields take the familiar element to a new level by adding useful animations, character counts, helper text and error states.";
}

@end
