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

#import "SimpleTextFieldManualLayoutExampleViewController.h"

#import "MaterialButtons.h"

#import "SimpleTextField.h"
#import "MaterialColorScheme.h"
#import "MaterialButtons+Theming.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h"


@interface SimpleTextFieldManualLayoutExampleViewController ()

@property (strong, nonatomic) MDCButton *resignFirstResponderButton;
@property (strong, nonatomic) SimpleTextField *filledTextField;
@property (strong, nonatomic) SimpleTextField *outlinedTextField;
@property (strong, nonatomic) UITextField *uiTextField;

@property (strong, nonatomic) MDCContainerScheme *containerScheme;

@end

@implementation SimpleTextFieldManualLayoutExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self setUpSchemes];
  [self addSubviews];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self positionSubviews];
}

- (void)addSubviews {
  [self addResignFirstResponderButton];
  [self addFilledTextField];
  [self addOutlinedTextField];
  [self addUiTextField];
}

- (void)positionSubviews {
  CGFloat appBarSafeArea = CGRectGetMinY(self.view.bounds);
  if (@available(iOS 11.0, *)) {
    appBarSafeArea = self.view.safeAreaInsets.top;
  }
  
  CGFloat padding = 30;
  CGFloat resignFirstResponderButtonMinX = padding;
  CGFloat resignFirstResponderButtonMinY = appBarSafeArea + padding;
  CGFloat resignFirstResponderButtonWidth = CGRectGetWidth(self.resignFirstResponderButton.frame);
  CGFloat resignFirstResponderButtonHeight = CGRectGetHeight(self.resignFirstResponderButton.frame);
  CGRect resignFirstResponderButtonFrame = CGRectMake(resignFirstResponderButtonMinX,
                                                      resignFirstResponderButtonMinY,
                                                      resignFirstResponderButtonWidth,
                                                      resignFirstResponderButtonHeight);
  self.resignFirstResponderButton.frame = resignFirstResponderButtonFrame;

  CGFloat filledTextFieldMinX = padding;
  CGFloat filledTextFieldMinY = resignFirstResponderButtonMinY + resignFirstResponderButtonHeight + padding;
  [self.filledTextField sizeToFit];
  CGFloat filledTextFieldWidth = CGRectGetWidth(self.filledTextField.frame);
  CGFloat filledTextFieldHeight = CGRectGetHeight(self.filledTextField.frame);
  CGRect filledTextFieldButtonFrame = CGRectMake(filledTextFieldMinX,
                                                 filledTextFieldMinY,
                                                 filledTextFieldWidth,
                                                 filledTextFieldHeight);
  self.filledTextField.frame = filledTextFieldButtonFrame;

  CGFloat outlinedTextFieldMinX = padding;
  CGFloat outlinedTextFieldMinY = filledTextFieldMinY + filledTextFieldHeight + padding;
  [self.outlinedTextField sizeToFit];
  CGFloat outlinedTextFieldWidth = CGRectGetWidth(self.outlinedTextField.frame);
  CGFloat outlinedTextFieldHeight = CGRectGetHeight(self.outlinedTextField.frame);
  CGRect outlinedTextFieldFrame = CGRectMake(outlinedTextFieldMinX,
                                             outlinedTextFieldMinY,
                                             outlinedTextFieldWidth,
                                             outlinedTextFieldHeight);
  self.outlinedTextField.frame = outlinedTextFieldFrame;
  
  CGFloat uiTextFieldMinX = padding;
  CGFloat uiTextFieldMinY = outlinedTextFieldMinY + outlinedTextFieldHeight + padding;
  CGFloat uiTextFieldWidth = CGRectGetWidth(self.uiTextField.frame);
  CGFloat uiTextFieldHeight = CGRectGetHeight(self.uiTextField.frame);
  CGRect uiTextFieldFrame = CGRectMake(uiTextFieldMinX,
                                       uiTextFieldMinY,
                                       uiTextFieldWidth,
                                       uiTextFieldHeight);
  self.uiTextField.frame = uiTextFieldFrame;
}

- (void)addResignFirstResponderButton {
  self.resignFirstResponderButton = [[MDCButton alloc] init];
  [self.resignFirstResponderButton setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [self.resignFirstResponderButton addTarget:self
                  action:@selector(buttonTapped:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.resignFirstResponderButton applyContainedThemeWithScheme:self.containerScheme];
  [self.resignFirstResponderButton sizeToFit];
  [self.view addSubview:self.resignFirstResponderButton];
}

- (void)addFilledTextField {
  CGFloat textFieldWidth = CGRectGetWidth(self.view.frame) - 100;
  CGRect frame = CGRectMake(0, 0, textFieldWidth, 100);
  self.filledTextField = [[SimpleTextField alloc] initWithFrame:frame];
  [self.view addSubview:self.filledTextField];
  self.filledTextField.textFieldStyle = TextFieldStyleFilled;
  self.filledTextField.placeholder = @"placeholder";
  self.filledTextField.canPlaceholderFloat = YES;
  self.filledTextField.leadingViewMode = UITextFieldViewModeWhileEditing;
  self.filledTextField.trailingViewMode = UITextFieldViewModeAlways;
  self.filledTextField.leadingViewMode = UITextFieldViewModeNever;
  self.filledTextField.trailingViewMode = UITextFieldViewModeNever;
  self.filledTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

  CGRect trailingViewFrame = CGRectMake(0, 0, 20, 20);
  UILabel *trailingView = [[UILabel alloc] initWithFrame:trailingViewFrame];
  trailingView.backgroundColor = [UIColor redColor];
  trailingView.text = @"T";
  self.filledTextField.trailingView = trailingView;

  CGRect leadingViewFrame = CGRectMake(0, 0, 20, 20);
  UILabel *leadingView = [[UILabel alloc] initWithFrame:leadingViewFrame];
  leadingView.backgroundColor = [UIColor magentaColor];
  leadingView.text = @"L";
  self.filledTextField.leadingView = leadingView;

  self.filledTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityCustom;
  self.filledTextField.customUnderlineLabelDrawPriority = 0.75;

  self.filledTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityLeading;
  self.filledTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityTrailing;
  // leading and trailing underline views
//  self.filledTextField.leadingUnderlineLabel.text = @"Vivamus finibus egestas dolor, id facilisis lacus hendrerit ac. Nunc molestie dolor felis, et rutrum tellus tristique sit amet. Donec sollicitudin, nisi ac suscipit mattis, orci urna gravida sem, non molestie mi est sed leo.";
//  self.filledTextField.trailingUnderlineLabel.text = @"Hello world";
  [self.filledTextField sizeToFit];
  self.filledTextField.center = CGPointMake(CGRectGetMidX(self.view.frame), 125);
}


- (void)addOutlinedTextField {
  CGFloat textFieldWidth = CGRectGetWidth(self.view.frame) - 100;
  CGRect frame = CGRectMake(0, 0, textFieldWidth, 100);
  self.outlinedTextField = [[SimpleTextField alloc] initWithFrame:frame];
  [self.view addSubview:self.outlinedTextField];
  self.outlinedTextField.textFieldStyle = TextFieldStyleOutline;
  //  self.outlinedTextField.textFieldStyle = TextFieldStyleFilled;
  self.outlinedTextField.placeholder = @"placeholder";
  self.outlinedTextField.canPlaceholderFloat = YES;
  //  self.outlinedTextField.leadingViewMode = UITextFieldViewModeWhileEditing;
  //  self.outlinedTextField.trailingViewMode = UITextFieldViewModeAlways;
  self.outlinedTextField.leadingViewMode = UITextFieldViewModeNever;
  self.outlinedTextField.trailingViewMode = UITextFieldViewModeNever;
  self.outlinedTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

  CGRect trailingViewFrame = CGRectMake(0, 0, 20, 20);
  UILabel *trailingView = [[UILabel alloc] initWithFrame:trailingViewFrame];
  trailingView.backgroundColor = [UIColor redColor];
  trailingView.text = @"T";
  self.outlinedTextField.trailingView = trailingView;

  CGRect leadingViewFrame = CGRectMake(0, 0, 20, 20);
  UILabel *leadingView = [[UILabel alloc] initWithFrame:leadingViewFrame];
  leadingView.backgroundColor = [UIColor magentaColor];
  leadingView.text = @"L";
  self.outlinedTextField.leadingView = leadingView;

  self.outlinedTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityCustom;
//  self.outlinedTextField.customUnderlineLabelDrawPriority = 0.75;
  //  self.outlinedTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityLeading;
  //  self.outlinedTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityTrailing;

  // leading and trailing underline views
//  self.outlinedTextField.leadingUnderlineLabel.text = @"Vivamus finibus egestas dolor, id facilisis lacus hendrerit ac. Nunc molestie dolor felis, et rutrum tellus tristique sit amet. Donec sollicitudin, nisi ac suscipit mattis, orci urna gravida sem, non molestie mi est sed leo.";
//  self.outlinedTextField.trailingUnderlineLabel.text = @"Hello world";
  self.outlinedTextField.center = CGPointMake(CGRectGetMidX(self.view.frame), 225);
//  CGRect frame2 = self.outlinedTextField.frame;
  [self.outlinedTextField sizeToFit];
//  CGRect f = self.outlinedTextField.frame;
//  f.size.height += 70;
//  self.outlinedTextField.frame = f;
  //  self.outlinedTextField.layer.borderColor = UIColor.blueColor.CGColor;
//  self.outlinedTextField.layer.borderWidth = 2;

}

- (void)addUiTextField {
  CGFloat textFieldWidth = CGRectGetWidth(self.view.frame) - 100;
  CGRect frame = CGRectMake(0, 0, textFieldWidth, 50);
  self.uiTextField = [[UITextField alloc] initWithFrame:frame];
  //  self.uiTextField.backgroundColor = [UIColor blueColor];
  self.uiTextField.borderStyle = UITextBorderStyleRoundedRect;
  self.uiTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.uiTextField.leftViewMode = UITextFieldViewModeNever;
  [self.view addSubview:self.uiTextField];

  CGRect accessoryViewFrame = CGRectMake(0, 0, 20, 20);
  UILabel *accessoryView = [[UILabel alloc] initWithFrame:accessoryViewFrame];
  accessoryView.backgroundColor = [UIColor magentaColor];
  accessoryView.text = @"L";
  self.uiTextField.leftView = accessoryView;

  self.uiTextField.center = CGPointMake(CGRectGetMidX(self.view.frame), 275);
}

#pragma mark Theming

- (void)setUpSchemes {
  self.containerScheme = [[MDCContainerScheme alloc] init];
}

#pragma mark UITextFieldDelegate

#pragma mark IBActions

- (void)buttonTapped:(UIButton *)button {
  [self.filledTextField resignFirstResponder];
  [self.outlinedTextField resignFirstResponder];
  [self.uiTextField resignFirstResponder];
}

#pragma mark Catalog By Convention

+ (NSDictionary *)catalogMetadata {
  return @{
           @"breadcrumbs": @[ @"Text Field", @"Simple Text Field (Manual Layout)" ],
           @"primaryDemo": @NO,
           @"presentable": @NO,
           };
}

@end
