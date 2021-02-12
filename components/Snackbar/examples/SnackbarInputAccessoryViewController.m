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

#import <UIKit/UIKit.h>

#import "MaterialSnackbar.h"

@interface SnackbarInputAccessoryViewController : UIViewController

@property(nonatomic, strong) UITextField *textField;

@end

@implementation SnackbarInputAccessoryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  UIToolbar *toolbar =
      [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
  UIButton *button =
      [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
  button.contentMode = UIViewContentModeCenter;
  [button setTitle:@"Show Snackbar" forState:UIControlStateNormal];
  [button setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(handleSend:)
      forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  toolbar.items = @[ buttonItem ];

  _textField = [[UITextField alloc]
      initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
  _textField.inputAccessoryView = toolbar;
  _textField.backgroundColor = UIColor.whiteColor;
  _textField.text = @"Tap Me";
  [self.view addSubview:_textField];
}

- (void)viewWillLayoutSubviews {
  _textField.center = self.view.center;
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
  [MDCSnackbarManager.defaultManager showMessage:message];
}

@end

@implementation SnackbarInputAccessoryViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Snackbar", @"Snackbar Input Accessory" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
