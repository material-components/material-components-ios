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

#import "InputTextFieldManualLayoutExampleViewController.h"

#import "MaterialButtons.h"

#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"
#import "supplemental/MDCInputTextField.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h"

#import "supplemental/MDCFilledTextField+MaterialTheming.h"
#import "supplemental/MDCFilledTextField.h"
#import "supplemental/MDCOutlinedTextField+MaterialTheming.h"
#import "supplemental/MDCOutlinedTextField.h"

#import "supplemental/MDCInputTextField+MaterialTheming.h"

static const NSUInteger kDefaultHorizontalPadding = 20;
static const NSUInteger kDefaultVerticalPadding = 20;

@interface SimpleTextFieldManualLayoutExampleViewController ()

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) NSArray *scrollViewSubviews;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation SimpleTextFieldManualLayoutExampleViewController

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
  [self addObservers];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addSubviews];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self layoutScrollView];
  [self layoutScrollViewSubviews];
  [self updateScrollViewContentSize];
  [self updateButtonThemes];
  [self updateLabelColors];
}

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addSubviews {
  self.scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:self.scrollView];
  self.scrollViewSubviews = @[
    [self createToggleErrorButton], [self createFirstResponderButton],
    [self createLabelWithText:@"Default MDCFilledTextField:"], [self createDefaultFilledTextField],
    [self createLabelWithText:@"Material MDCFilledTextField:"],
    [self createMaterialFilledTextField],
    [self createLabelWithText:@"Default MDCOutlinedTextField:"],
    [self createDefaultOutlinedTextField],
    [self createLabelWithText:@"Material MDCOutlinedTextField:"],
    [self createMaterialOutlinedTextField],
    //    [self createLabelWithText:@"Default MDCInputTextField:"],
    //    [self createDefaultInputTextField],
    //    [self createLabelWithText:@"Material MDCInputTextField:"],
    //    [self createMaterialInputTextField],
  ];
  for (UIView *view in self.scrollViewSubviews) {
    [self.scrollView addSubview:view];
  }
}

- (void)layoutScrollView {
  CGFloat originX = CGRectGetMinX(self.view.bounds);
  CGFloat originY = CGRectGetMinY(self.view.bounds);
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);
  if (@available(iOS 11.0, *)) {
    originX += self.view.safeAreaInsets.left;
    originY += self.view.safeAreaInsets.top;
    width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
    height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  }
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.scrollView.frame = frame;
}

- (void)layoutScrollViewSubviews {
  CGFloat viewMinX = kDefaultHorizontalPadding;
  CGFloat viewMinY = kDefaultHorizontalPadding;
  for (UIView *view in self.scrollViewSubviews) {
    CGSize viewSize = view.frame.size;
    CGFloat textFieldWidth =
        CGRectGetWidth(self.scrollView.frame) - (2 * kDefaultHorizontalPadding);
    if ([view isKindOfClass:[MDCInputTextField class]]) {
      viewSize = CGSizeMake(textFieldWidth, CGRectGetHeight(view.frame));
    }
    CGRect viewFrame = CGRectMake(viewMinX, viewMinY, viewSize.width, viewSize.height);
    view.frame = viewFrame;
    [view sizeToFit];
    viewMinY = viewMinY + CGRectGetHeight(view.frame) + kDefaultVerticalPadding;
  }
}

- (void)updateScrollViewContentSize {
  CGFloat maxX = CGRectGetWidth(self.scrollView.bounds);
  CGFloat maxY = CGRectGetHeight(self.scrollView.bounds);
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
  self.scrollView.contentSize = CGSizeMake(maxX, maxY + kDefaultHorizontalPadding);
}

- (MDCButton *)createFirstResponderButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(resignFirstResponderButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

- (MDCButton *)createToggleErrorButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Toggle error" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(toggleErrorButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

- (UILabel *)createLabelWithText:(NSString *)text {
  UILabel *label = [[UILabel alloc] init];
  label.textColor = self.containerScheme.colorScheme.primaryColor;
  label.font = self.containerScheme.typographyScheme.subtitle2;
  label.text = text;
  return label;
}

//- (MDCInputTextField *)createFilledTextFieldWithMaximalDensity {
//  MDCInputTextField *textField = [self createFilledTextField];
//  textField.containerStyler.positioningDelegate.verticalDensity = 1.0;
//  return textField;
//}
//
//- (MDCInputTextField *)createFilledTextFieldWithMinimalDensity {
//  MDCInputTextField *textField = [self createFilledTextField];
//  textField.containerStyler.positioningDelegate.verticalDensity = 0.0;
//  return textField;
//}

- (MDCFilledTextField *)createDefaultFilledTextField {
  MDCFilledTextField *textField = [[MDCFilledTextField alloc] init];
  //  textField.containerStyler.positioningDelegate.verticalDensity = 0.5;
  textField.mdc_adjustsFontForContentSizeCategory = YES;
  textField.placeholder = @"555-555-5555";
  textField.floatingLabel.text = @"Phone number";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.leadingUnderlineLabel.numberOfLines = 0;
  textField.leadingUnderlineLabel.text = @"This is a string.";
  return textField;
}

- (MDCFilledTextField *)createMaterialFilledTextField {
  MDCFilledTextField *textField = [self createDefaultFilledTextField];
  [textField applyThemeWithScheme:self.containerScheme];
  return textField;
}

//- (MDCInputTextField *)createOutlinedTextFieldWithMaximalDensity {
//  MDCInputTextField *textField = [self createOutlinedTextField];
//  textField.containerStyler.positioningDelegate.verticalDensity = 1.0;
//  return textField;
//}
//
//- (MDCInputTextField *)createOutlinedTextFieldWithMinimalDensity {
//  MDCInputTextField *textField = [self createOutlinedTextField];
//  textField.containerStyler.positioningDelegate.verticalDensity = 0.0;
//  return textField;
//}

- (MDCOutlinedTextField *)createDefaultOutlinedTextField {
  MDCOutlinedTextField *textField = [[MDCOutlinedTextField alloc] init];
  //  textField.containerStyler.positioningDelegate.verticalDensity = 0.5;
  //  textField.placeholder = @"This is a placeholder";
  //  textField.floatingLabel.text = @"This is a floating label";
  textField.placeholder = @"555-555-5555";
  textField.floatingLabel.text = @"Phone number";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.mdc_adjustsFontForContentSizeCategory = YES;
  return textField;
}

- (MDCOutlinedTextField *)createMaterialOutlinedTextField {
  MDCOutlinedTextField *textField = [self createDefaultOutlinedTextField];
  [textField applyThemeWithScheme:self.containerScheme];
  return textField;
}

- (MDCInputTextField *)createDefaultInputTextField {
  MDCInputTextField *textField = [[MDCInputTextField alloc] init];
  textField.placeholder = @"This is a placeholder";
  textField.floatingLabel.text = @"This is a floating label";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  return textField;
}

- (MDCInputTextField *)createMaterialInputTextField {
  MDCInputTextField *textField = [self createDefaultInputTextField];
  [textField applyThemeWithScheme:self.containerScheme];
  return textField;
}

#pragma mark Private

- (void)updateButtonThemes {
  [self.allButtons enumerateObjectsUsingBlock:^(MDCButton *button, NSUInteger idx, BOOL *stop) {
    if (self.isErrored) {
      MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
      colorScheme.primaryColor = colorScheme.errorColor;
      MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
      containerScheme.colorScheme = colorScheme;
      [button applyContainedThemeWithScheme:containerScheme];
    } else {
      [button applyOutlinedThemeWithScheme:self.containerScheme];
    }
  }];
}

- (void)updateTextFieldStates {
  [self.allTextFields
      enumerateObjectsUsingBlock:^(MDCInputTextField *textField, NSUInteger idx, BOOL *stop) {
        textField.isErrored = self.isErrored;
        BOOL isEven = idx % 2 == 0;
        if (textField.isErrored) {
          if (isEven) {
            textField.leadingUnderlineLabel.text = @"Suspendisse quam elit, mattis sit amet justo "
                                                   @"vel, venenatis lobortis massa. Donec metus "
                                                   @"dolor.";
          } else {
            textField.leadingUnderlineLabel.text = @"This is an error.";
          }
        } else {
          if (isEven) {
            textField.leadingUnderlineLabel.text = @"This is helper text.";
          } else {
            textField.leadingUnderlineLabel.text = nil;
          }
        }
      }];
  [self.view setNeedsLayout];
}

- (void)updateLabelColors {
  [self.allLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
    id<MDCColorScheming> colorScheme = self.containerScheme.colorScheme;
    UIColor *textColor = self.isErrored ? colorScheme.errorColor : colorScheme.primaryColor;
    label.textColor = textColor;
  }];
}

- (NSArray<MDCInputTextField *> *)allTextFields {
  return [self allViewsOfClass:[MDCInputTextField class]];
}

- (NSArray<MDCButton *> *)allButtons {
  return [self allViewsOfClass:[MDCButton class]];
}

- (NSArray<UILabel *> *)allLabels {
  return [self allViewsOfClass:[UILabel class]];
}

- (NSArray *)allViewsOfClass:(Class)class {
  return [self.scrollViewSubviews
      objectsAtIndexes:[self.scrollViewSubviews indexesOfObjectsPassingTest:^BOOL(
                                                    UIView *view, NSUInteger idx, BOOL *stop) {
        return [view isKindOfClass:class];
      }]];
}

- (void)keyboardWillShow:(NSNotification *)notification {
  CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notification {
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark IBActions

- (void)resignFirstResponderButtonTapped:(UIButton *)button {
  [self.allTextFields
      enumerateObjectsUsingBlock:^(MDCInputTextField *textField, NSUInteger idx, BOOL *stop) {
        [textField resignFirstResponder];
      }];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  self.isErrored = !self.isErrored;
  [self updateButtonThemes];
  [self updateTextFieldStates];
  [self updateLabelColors];
}

#pragma mark Catalog By Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"Input Text Field (Manual Layout)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
