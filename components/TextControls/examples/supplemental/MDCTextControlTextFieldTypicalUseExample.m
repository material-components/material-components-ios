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

#import "MDCTextControlTextFieldTypicalUseExample.h"

#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialTextControls+FilledTextFields.h"
#import "MaterialTextControls+FilledTextFieldsTheming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

static NSString *const kExampleTitle = @"Text fields (typical use)";
static CGFloat const kPadding = 20;

@interface MDCTextControlTextFieldTypicalUseExample ()
@property(strong, nonatomic) MDCFilledTextField *textField;
@property(strong, nonatomic) MDCButton *toggleErrorButton;
@property(nonatomic, assign) BOOL shouldApplyErrorTheming;
@end

@implementation MDCTextControlTextFieldTypicalUseExample

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  self.title = kExampleTitle;

  self.toggleErrorButton = [self createToggleErrorButton];
  [self.view addSubview:self.toggleErrorButton];

  [self.view.leftAnchor constraintEqualToAnchor:self.toggleErrorButton.leftAnchor
                                       constant:-kPadding]
      .active = YES;
  [self.topLayoutGuide.bottomAnchor constraintEqualToAnchor:self.toggleErrorButton.topAnchor
                                                   constant:-kPadding]
      .active = YES;

  self.textField = [self createFilledTextField];
  [self.view addSubview:self.textField];

  [self.view.leftAnchor constraintEqualToAnchor:self.textField.leftAnchor constant:-kPadding]
      .active = YES;
  [self.view.rightAnchor constraintEqualToAnchor:self.textField.rightAnchor constant:kPadding]
      .active = YES;
  [self.toggleErrorButton.bottomAnchor constraintEqualToAnchor:self.textField.topAnchor
                                                      constant:-kPadding]
      .active = YES;
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  [self handleToggleErrorButtonTapped];
}

- (void)handleToggleErrorButtonTapped {
  self.shouldApplyErrorTheming = !self.shouldApplyErrorTheming;
  if (self.shouldApplyErrorTheming) {
    [self.textField applyErrorThemeWithScheme:self.containerScheme];
  } else {
    [self.textField applyThemeWithScheme:self.containerScheme];
  }
}

- (MDCFilledTextField *)createFilledTextField {
  MDCFilledTextField *textField = [[MDCFilledTextField alloc] init];
  textField.translatesAutoresizingMaskIntoConstraints = NO;
  textField.adjustsFontForContentSizeCategory = YES;
  textField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  textField.label.text = @"Label text";
  [textField applyThemeWithScheme:self.containerScheme];
  return textField;
}

- (MDCButton *)createToggleErrorButton {
  MDCButton *button = [[MDCButton alloc] init];
  button.translatesAutoresizingMaskIntoConstraints = NO;
  button.mdc_adjustsFontForContentSizeCategory = YES;
  [button setTitle:@"Toggle error" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(toggleErrorButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

@end

#pragma mark - CatalogByConvention

@implementation MDCTextControlTextFieldTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Controls", kExampleTitle ],
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
