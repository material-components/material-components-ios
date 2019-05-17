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

#import "MDCBaseTextFieldManualLayoutExampleViewController.h"

#import "MDCBaseTextField.h"

static const NSUInteger kDefaultHorizontalPadding = 20;
static const NSUInteger kDefaultVerticalPadding = 20;

@interface MDCBaseTextFieldManualLayoutExampleViewController ()

@property(strong, nonatomic) MDCBaseTextField *textField;
@end

@implementation MDCBaseTextFieldManualLayoutExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] init];
    containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
    self.containerScheme = containerScheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addTextField];
  [self positionTextField];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self positionTextField];
}

- (void)addTextField {
  self.textField = [[MDCBaseTextField alloc] init];
  self.textField.borderStyle = UITextBorderStyleRoundedRect;
  [self.view addSubview:self.textField];
}

- (void)positionTextField {
  CGFloat textFieldWidth = CGRectGetWidth(self.view.frame) - (2 * kDefaultHorizontalPadding);
  CGFloat textFieldMinY = 0;
  if (@available(iOS 11.0, *)) {
    textFieldMinY = self.view.safeAreaInsets.top + kDefaultVerticalPadding;
  } else {
    textFieldMinY = 120;
  }
  CGRect initialFrame = CGRectMake(kDefaultHorizontalPadding, textFieldMinY, textFieldWidth, 70);
  self.textField.frame = initialFrame;
}

#pragma mark Private

#pragma mark Catalog By Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Fields Beta", @"Base Text Field (Manual Layout)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
