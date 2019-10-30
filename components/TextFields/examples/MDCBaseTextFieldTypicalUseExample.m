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

static NSString *const kExampleTitle = @"MDCTextControl TextFields";
static CGFloat const kDefaultPadding = 15.0;

/**
 Typical use example showing how to place an @c MDCBaseTextField in a UIViewController.
 */
@interface MDCBaseTextFieldTypicalExampleViewController : UIViewController

/** The MDCBaseTextField for this example. */
@property(nonatomic, strong) MDCBaseTextField *baseTextField;

/** The MDCFilledTextField for this example. */
@property(nonatomic, strong) MDCFilledTextField *filledTextField;

/** The MDCOutlinedTextField for this example. */
@property(nonatomic, strong) MDCOutlinedTextField *outlinedTextField;

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

  self.resignFirstResponderButton = [self createFirstResponderButton];
  [self.view addSubview:self.resignFirstResponderButton];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  self.baseTextField = [[MDCBaseTextField alloc] initWithFrame:self.placeholderTextFieldFrame];
  self.baseTextField.borderStyle = UITextBorderStyleRoundedRect;
  self.baseTextField.label.text = @"This is a label";
  self.baseTextField.placeholder = @"This is placeholder text";
  self.baseTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self.view addSubview:self.baseTextField];

  self.filledTextField = [[MDCFilledTextField alloc] initWithFrame:self.placeholderTextFieldFrame];
  self.filledTextField.label.text = @"This is a label";
  self.filledTextField.placeholder = @"This is placeholder text";
  self.filledTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self.view addSubview:self.filledTextField];

  self.outlinedTextField = [[MDCOutlinedTextField alloc] initWithFrame:self.placeholderTextFieldFrame];
  self.outlinedTextField.label.text = @"This is a label";
  self.outlinedTextField.placeholder = @"This is placeholder text";
  self.outlinedTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self.view addSubview:self.outlinedTextField];
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
  [self.baseTextField resignFirstResponder];
  [self.filledTextField resignFirstResponder];
  [self.outlinedTextField resignFirstResponder];
}

- (CGFloat)preferredResignFirstResponderMinY {
  if (@available(iOS 11.0, *)) {
    return (CGFloat)(self.view.safeAreaInsets.top + kDefaultPadding);
  } else {
    return (CGFloat)120;
  }
}

- (CGFloat)preferredTextFieldWidth {
  return CGRectGetWidth(self.view.frame) - (2 * kDefaultPadding);
}

- (CGRect)placeholderTextFieldFrame {
  return CGRectMake(0, 0, self.preferredTextFieldWidth, 0);
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [self.resignFirstResponderButton sizeToFit];
  [self.baseTextField sizeToFit];
  [self.filledTextField sizeToFit];
  [self.outlinedTextField sizeToFit];

  self.resignFirstResponderButton.frame =
      CGRectMake(kDefaultPadding, self.preferredResignFirstResponderMinY,
                 CGRectGetWidth(self.resignFirstResponderButton.frame),
                 CGRectGetHeight(self.resignFirstResponderButton.frame));

  self.filledTextField.frame = CGRectMake(
      kDefaultPadding, CGRectGetMaxY(self.resignFirstResponderButton.frame) + kDefaultPadding,
      CGRectGetWidth(self.filledTextField.frame), CGRectGetHeight(self.filledTextField.frame));

  self.outlinedTextField.frame = CGRectMake(
      kDefaultPadding, CGRectGetMaxY(self.filledTextField.frame) + kDefaultPadding,
      CGRectGetWidth(self.outlinedTextField.frame), CGRectGetHeight(self.outlinedTextField.frame));

  self.baseTextField.frame = CGRectMake(
      kDefaultPadding, CGRectGetMaxY(self.outlinedTextField.frame) + kDefaultPadding,
      CGRectGetWidth(self.baseTextField.frame), CGRectGetHeight(self.baseTextField.frame));
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
