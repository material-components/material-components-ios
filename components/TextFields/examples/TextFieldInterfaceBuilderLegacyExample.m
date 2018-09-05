//
// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MaterialTextFields.h"

#import "supplemental/TextFieldInterfaceBuilderExampleSupplemental.h"

@interface TextFieldInterfaceBuilderLegacyExample () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet MDCTextField *firstTextField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *firstController;
@property(weak, nonatomic) IBOutlet MDCTextField *lastTextField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *lastController;
@property(weak, nonatomic) IBOutlet MDCTextField *address1TextField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *address1Controller;
@property(weak, nonatomic) IBOutlet MDCTextField *address2TextField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *address2Controller;
@property(weak, nonatomic) IBOutlet MDCMultilineTextField *messageTextField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *messageController;

@end

@implementation TextFieldInterfaceBuilderLegacyExample

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupExampleViews];

  self.firstController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.firstTextField];
  self.lastController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.lastTextField];
  self.address1Controller =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.address1TextField];
  self.address2Controller =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.address2TextField];

  // This will cause the text field to expand on overflow. This is because the default
  // for MDCTextInputControllerFilled is to do so. This overrides any choices in the
  // storyboard because it happens after the storyboard is awoken.
  self.messageController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.messageTextField];
  self.messageTextField.minimumLines = 10;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.address2TextField.text = @"Apt 3F";
}

@end
