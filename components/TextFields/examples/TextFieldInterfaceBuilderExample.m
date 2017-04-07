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

#import <Foundation/Foundation.h>
#import "TextFieldInterfaceBuilderExampleSupplemental.h"

@import MaterialComponents.MaterialTextFields;

@interface TextFieldInterfaceBuilderExample () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet MDCTextField *firstTextField;
@property(nonatomic, strong) MDCTextInputController *firstController;
@property(weak, nonatomic) IBOutlet MDCTextField *lastTextField;
@property(nonatomic, strong) MDCTextInputController *lastController;
@property(weak, nonatomic) IBOutlet MDCTextField *address1TextField;
@property(nonatomic, strong) MDCTextInputController *address1Controller;
@property(weak, nonatomic) IBOutlet MDCTextField *address2TextField;
@property(nonatomic, strong) MDCTextInputController *address2Controller;


@end

@implementation TextFieldInterfaceBuilderExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"MDCTextFields";

  [self setupExampleViews];

  self.firstController = [[MDCTextInputController alloc] initWithTextInput:self.firstTextField];
  self.firstController.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;
  self.lastController = [[MDCTextInputController alloc] initWithTextInput:self.lastTextField];
  self.lastController.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;
  self.address1Controller = [[MDCTextInputController alloc] initWithTextInput:self.address1TextField];
  self.address1Controller.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;
  self.address2Controller = [[MDCTextInputController alloc] initWithTextInput:self.address2TextField];
  self.address2Controller.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;
}

@end

@implementation TextFieldInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Storyboard (Objective C)" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TextFieldInterfaceBuilderExample";
}

@end
