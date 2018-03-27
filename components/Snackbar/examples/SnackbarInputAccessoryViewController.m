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

#import <UIKit/UIKit.h>

#import "MaterialPalettes.h"
#import "MaterialSnackbar.h"
#import "supplemental/SnackbarExampleSupplemental.h"

@interface SnackbarInputAccessoryViewController ()

@property(nonatomic, strong) UITextField *inputTextField;

@end

@implementation SnackbarInputAccessoryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  UIToolbar *toolbar =
      [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                  0,
                                                  UIScreen.mainScreen.bounds.size.width,
                                                  50)];
  toolbar.backgroundColor = UIColor.lightGrayColor;

  UITextView *textView =
      [[UITextView alloc] initWithFrame:CGRectMake(0,
                                                   5,
                                                   UIScreen.mainScreen.bounds.size.width/4*3,
                                                   50)];
  textView.backgroundColor = UIColor.lightGrayColor;
  UIBarButtonItem *inputItem = [[UIBarButtonItem alloc] initWithCustomView:textView];
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, UIScreen.mainScreen.bounds.size.width/4-40, 50)];
  button.contentMode = UIViewContentModeCenter;
  [button setTitle:@"Send" forState:UIControlStateNormal];
  [button setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
  [button addTarget:self action:@selector(handleSend:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  toolbar.items = @[inputItem, sendItem];

  _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
  _inputTextField.inputAccessoryView = toolbar;
  _inputTextField.backgroundColor = UIColor.lightGrayColor;
  [self.view addSubview:_inputTextField];


}

- (void)viewWillLayoutSubviews {
  _inputTextField.center = self.view.center;
}

- (void)handleSend:(UIButton *)event {
  [self showSnackbarWithAction];
}


- (void)showSnackbarWithAction {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  message.action = action;
  [MDCSnackbarManager showMessage:message];
}

@end
