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

#import <UIKit/UIKit.h>

#import "MaterialButtons.h"
#import "MaterialContainerScheme.h"
#import "MaterialTextFields+ContainedInputView.h"

static NSString *const kExampleTitle = @"MDCBaseTextField";

/**
 Typical use example showing how to place an @c MDCBaseTextField in a UIViewController.
 */
@interface MDCBaseTextFieldTypicalExampleViewController : UIViewController

/** The TextField for this example. */
@property(nonatomic, strong) MDCBaseTextField *textField;

/** The UIButton that makes the textfield stop being the first responder. */
@property(nonatomic, strong) MDCButton *resignFirstResponderButton;

/** The container scheme injected into this example. */
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation MDCBaseTextFieldTypicalExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = kExampleTitle;

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  self.textField = [[MDCBaseTextField alloc] initWithFrame:self.preferredTextFieldFrame];
  self.textField.borderStyle = UITextBorderStyleRoundedRect;
  self.textField.label.text = @"This is a label";
  self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self.view addSubview:self.textField];

  self.resignFirstResponderButton = [self createFirstResponderButton];
  [self.view addSubview:self.resignFirstResponderButton];
}

- (MDCButton *)createFirstResponderButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(resignFirstResponderButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button sizeToFit];
  return button;
}

- (void)resignFirstResponderButtonTapped:(UIButton *)button {
  [self.textField resignFirstResponder];
}

- (CGRect)preferredTextFieldFrame {
  return CGRectMake(15, 120, CGRectGetWidth(self.view.frame) - 30, 50);
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  self.textField.frame = self.preferredTextFieldFrame;
  self.resignFirstResponderButton.frame =
      CGRectMake(CGRectGetMinX(self.textField.frame), CGRectGetMaxY(self.textField.frame) + 20,
                 CGRectGetWidth(self.resignFirstResponderButton.frame),
                 CGRectGetHeight(self.resignFirstResponderButton.frame));
}

@end

#pragma mark - CatalogByConvention

@implementation MDCBaseTextFieldTypicalExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", kExampleTitle ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
