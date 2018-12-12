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

@property (strong, nonatomic) UIScrollView *scrollView;

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
  [self positionScrollView];
  [self positionScrollViewSubviews];
  [self updateScrollViewContentSize];
}

- (void)addSubviews {
  [self addScrollView];
  [self addResignFirstResponderButton];
  [self addFilledTextField];
  [self addOutlinedTextField];
  [self addUiTextField];
}

- (void)positionScrollView {
  CGFloat originX = self.view.bounds.origin.x;
  CGFloat originY = self.view.bounds.origin.y;
  CGFloat width = self.view.bounds.size.width;
  CGFloat height = self.view.bounds.size.height;
  if (@available(iOS 11.0, *)) {
    originX += self.view.safeAreaInsets.left;
    originY += self.view.safeAreaInsets.top;
    width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
    height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  }
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.scrollView.frame = frame;
}

- (void)positionScrollViewSubviews {
  CGFloat padding = 30;
  CGFloat resignFirstResponderButtonMinX = padding;
  CGFloat resignFirstResponderButtonMinY = padding;
  CGFloat resignFirstResponderButtonWidth = CGRectGetWidth(self.resignFirstResponderButton.frame);
  CGFloat resignFirstResponderButtonHeight = CGRectGetHeight(self.resignFirstResponderButton.frame);
  CGRect resignFirstResponderButtonFrame = CGRectMake(resignFirstResponderButtonMinX,
                                                      resignFirstResponderButtonMinY,
                                                      resignFirstResponderButtonWidth,
                                                      resignFirstResponderButtonHeight);
  self.resignFirstResponderButton.frame = resignFirstResponderButtonFrame;

  CGFloat textFieldWidth = CGRectGetWidth(self.scrollView.frame) - (2 * padding);
  CGSize textFieldFittingSize = CGSizeMake(textFieldWidth, CGFLOAT_MAX);
  
  CGFloat filledTextFieldMinX = padding;
  CGFloat filledTextFieldMinY = resignFirstResponderButtonMinY + resignFirstResponderButtonHeight + padding;
  CGSize filledTextFieldSize = [self.filledTextField sizeThatFits:textFieldFittingSize];
  CGRect filledTextFieldButtonFrame = CGRectMake(filledTextFieldMinX,
                                                 filledTextFieldMinY,
                                                 filledTextFieldSize.width,
                                                 filledTextFieldSize.height);
  self.filledTextField.frame = filledTextFieldButtonFrame;

  CGFloat outlinedTextFieldMinX = padding;
  CGFloat outlinedTextFieldMinY = filledTextFieldMinY + filledTextFieldSize.height + padding;
  CGSize outlinedTextFieldSize = [self.outlinedTextField sizeThatFits:textFieldFittingSize];
  CGRect outlinedTextFieldFrame = CGRectMake(outlinedTextFieldMinX,
                                             outlinedTextFieldMinY,
                                             outlinedTextFieldSize.width,
                                             outlinedTextFieldSize.height);
  self.outlinedTextField.frame = outlinedTextFieldFrame;
  
  CGFloat uiTextFieldMinX = padding;
  CGFloat uiTextFieldMinY = outlinedTextFieldMinY + outlinedTextFieldSize.height + padding;
  CGRect uiTextFieldFrame = CGRectMake(uiTextFieldMinX,
                                       uiTextFieldMinY,
                                       textFieldWidth,
                                       CGRectGetHeight(self.uiTextField.frame));
  self.uiTextField.frame = uiTextFieldFrame;
}

- (void)updateScrollViewContentSize {
  CGFloat maxX = 0;
  CGFloat maxY = 0;
  for (UIView *subview in self.scrollView.subviews) {
    CGFloat subViewMaxX = CGRectGetMaxX(subview.frame);
    if (subViewMaxX > maxX) {
      maxX = subViewMaxX;
    }
    CGFloat subViewMaxY = CGRectGetMaxY(subview.frame);
    if (subViewMaxY > maxY) {
      maxY = subViewMaxY;
    }
  }
  self.scrollView.contentSize = CGSizeMake(maxX, maxY);
}


- (void)addScrollView {
  self.scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:self.scrollView];
}


- (void)addResignFirstResponderButton {
  self.resignFirstResponderButton = [[MDCButton alloc] init];
  [self.resignFirstResponderButton setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [self.resignFirstResponderButton addTarget:self
                  action:@selector(buttonTapped:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.resignFirstResponderButton applyContainedThemeWithScheme:self.containerScheme];
  [self.resignFirstResponderButton sizeToFit];
  [self.scrollView addSubview:self.resignFirstResponderButton];
}

- (void)addFilledTextField {
  self.filledTextField = [[SimpleTextField alloc] init];
  self.filledTextField.textFieldStyle = TextFieldStyleFilled;
  self.filledTextField.placeholder = @"This is a placeholder";
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
  self.filledTextField.leadingUnderlineLabel.text = @"Vivamus finibus egestas dolor, id facilisis lacus hendrerit ac. Nunc molestie dolor felis, et rutrum tellus tristique sit amet. Donec sollicitudin, nisi ac suscipit mattis, orci urna gravida sem, non molestie mi est sed leo.";
  self.filledTextField.trailingUnderlineLabel.text = @"Hello world";
  [self.filledTextField sizeToFit];
  [self.scrollView addSubview:self.filledTextField];
}


- (void)addOutlinedTextField {
  self.outlinedTextField = [[SimpleTextField alloc] init];
  self.outlinedTextField.textFieldStyle = TextFieldStyleOutline;
  self.outlinedTextField.placeholder = @"placeholder";
  self.outlinedTextField.canPlaceholderFloat = YES;
  self.outlinedTextField.leadingViewMode = UITextFieldViewModeNever;
  self.outlinedTextField.trailingViewMode = UITextFieldViewModeNever;
  self.outlinedTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.outlinedTextField.underlineLabelDrawPriority = UnderlineLabelDrawPriorityCustom;

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

  [self.scrollView addSubview:self.outlinedTextField];
}

- (void)addUiTextField {
  self.uiTextField = [[UITextField alloc] init];
  self.uiTextField.borderStyle = UITextBorderStyleRoundedRect;
  self.uiTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.uiTextField.leftViewMode = UITextFieldViewModeNever;

  CGRect accessoryViewFrame = CGRectMake(0, 0, 20, 20);
  UILabel *accessoryView = [[UILabel alloc] initWithFrame:accessoryViewFrame];
  accessoryView.backgroundColor = [UIColor magentaColor];
  accessoryView.text = @"L";
  self.uiTextField.leftView = accessoryView;

  [self.scrollView addSubview:self.uiTextField];
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
