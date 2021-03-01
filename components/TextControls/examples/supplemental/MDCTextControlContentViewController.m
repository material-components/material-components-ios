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

#import "MDCTextControlContentViewController.h"

#import "MaterialButtons.h"

#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"


#import "MDCTraitEnvironmentChangeDelegate.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme+Scheming.h"

@interface MDCTextControlContentViewController ()

/**
This scrollview contains all the subviews through which the user interacts with the screen.
*/
@property(strong, nonatomic) UIScrollView *scrollView;

/**
This button allows the user to signal that they want the content size category to decrease.
*/
@property(nonatomic, strong) MDCButton *decreaseContentSizeButton;

/**
This button allows the user to signal that they want the content size category to increase.
*/
@property(nonatomic, strong) MDCButton *increaseContentSizeButton;

/**
 This button allows the user to signal that they want the first responder to resign first responder.
 */
@property(nonatomic, strong) MDCButton *resignFirstResponderButton;

/**
This button allows the user to signal that they want all text controls to become disabled.
*/
@property(nonatomic, strong) MDCButton *toggleDisabledButton;

/**
This button allows the user to signal that they want the view controller to enter an error state.
*/
@property(nonatomic, strong) MDCButton *toggleErrorButton;

/**
This button allows the user to signal that they want the view controller to toggle dark mode.
*/
@property(nonatomic, strong) MDCButton *toggleDarkModeButton;

/**
This button allows the user to signal that they want to toggle the layout direction.
*/
@property(nonatomic, strong) MDCButton *toggleLayoutDirectionButton;

@end

@implementation MDCTextControlContentViewController

#pragma mark Object Lifecycle

#pragma mark View Controller Overrides

- (void)viewDidLoad {
  [super viewDidLoad];

  [self addObservers];
  [self setUpSubviews];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  [self applyThemesToScrollViewSubviews];
  [self enforcePreferredFonts];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self layoutScrollView];
  [self resizeScrollViewSubviews];
  [self layoutScrollViewSubviews];
  [self updateScrollViewContentSize];
}

#pragma mark Setup

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

- (void)setUpSubviews {
  [self createBaseSubviews];
  [self initializeScrollViewSubviewsArray];
  [self addSubviews];
}

- (void)createBaseSubviews {
  self.scrollView = [[UIScrollView alloc] init];
  self.increaseContentSizeButton = [self createIncreaseContentSizeButton];
  self.decreaseContentSizeButton = [self createDecreaseContentSizeButton];
  self.toggleDisabledButton = [self createToggleDisabledButton];
  self.toggleErrorButton = [self createToggleErrorButton];
  self.resignFirstResponderButton = [self createResignFirstResponderButton];
  self.toggleDarkModeButton = [self createToggleDarkModeButton];
  self.toggleLayoutDirectionButton = [self createToggleLayoutDirectionButton];
}

- (MDCButton *)createDecreaseContentSizeButton {
  return [self createContentSizeButtonWithTitle:@"Decrease size"
                                       selector:@selector(decreaseContentSizeButtonTapped:)];
}

- (MDCButton *)createIncreaseContentSizeButton {
  return [self createContentSizeButtonWithTitle:@"Increase size"
                                       selector:@selector(increaseContentSizeButtonTapped:)];
}

- (MDCButton *)createContentSizeButtonWithTitle:(NSString *)title selector:(SEL)selector {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:title forState:UIControlStateNormal];
  [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  button.enabled = YES;
  return button;
}

- (MDCButton *)createToggleDisabledButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Toggle disabled" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(disableButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

- (MDCButton *)createResignFirstResponderButton {
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

- (MDCButton *)createToggleDarkModeButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Toggle dark mode" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(toggleDarkModeButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

- (MDCButton *)createToggleLayoutDirectionButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Toggle layout direction" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(toggleLayoutDirectionButtonTapped:)
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

- (void)initializeScrollViewSubviewsArray {
  self.scrollViewSubviews = @[
    self.toggleErrorButton,
    self.toggleDarkModeButton,
    self.toggleDisabledButton,
    self.toggleLayoutDirectionButton,
    self.decreaseContentSizeButton,
    self.increaseContentSizeButton,
    self.resignFirstResponderButton,
  ];
}

- (void)addSubviews {
  [self.view addSubview:self.scrollView];
  for (UIView *view in self.scrollViewSubviews) {
    [self.scrollView addSubview:view];
  }
}

#pragma mark Custom Layout Methods

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

- (void)resizeScrollViewSubviews {
  [self resizeButtons];
  [self resizeLabels];
}

- (void)resizeButtons {
  [self.allButtons enumerateObjectsUsingBlock:^(MDCButton *button, NSUInteger idx, BOOL *stop) {
    [button sizeToFit];
  }];
}

- (void)resizeLabels {
  [self.allLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
    [label sizeToFit];
  }];
}

- (void)layoutScrollViewSubviews {
  CGFloat viewMinX = self.defaultPadding;
  CGFloat viewMinY = self.defaultPadding;
  for (UIView *view in self.scrollViewSubviews) {
    CGSize viewSize = view.frame.size;
    CGRect viewFrame = CGRectMake(viewMinX, viewMinY, viewSize.width, viewSize.height);
    view.frame = viewFrame;
    viewMinY = viewMinY + CGRectGetHeight(view.frame) + self.defaultPadding;
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
  self.scrollView.contentSize = CGSizeMake(maxX, maxY + self.defaultPadding);
}

- (CGFloat)defaultPadding {
  return 20;
}

#pragma mark Subview configuration

- (void)applyThemesToScrollViewSubviews {
  [self applyThemesToButtons];
  [self updateLabelColors];
}

- (void)applyThemesToButtons {
  [self.allButtons enumerateObjectsUsingBlock:^(MDCButton *button, NSUInteger idx, BOOL *stop) {
    if (self.isErrored) {
      MDCSemanticColorScheme *colorScheme =
          [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
      colorScheme.primaryColor = colorScheme.errorColor;
      MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
      containerScheme.colorScheme = colorScheme;
      [button applyContainedThemeWithScheme:containerScheme];
    } else {
      [button applyOutlinedThemeWithScheme:self.containerScheme];
    }
  }];
}

- (void)updateLabelColors {
  [self.allLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
    id<MDCColorScheming> colorScheme = self.containerScheme.colorScheme;
    UIColor *textColor = self.isErrored ? colorScheme.errorColor : colorScheme.primaryColor;
    label.textColor = textColor;
  }];
}

- (void)enforcePreferredFonts {
}

- (NSArray<MDCButton *> *)allButtons {
  return [self allScrollViewSubviewsOfClass:[MDCButton class]];
}

- (NSArray<UILabel *> *)allLabels {
  return [self allScrollViewSubviewsOfClass:[UILabel class]];
}

- (NSArray *)allScrollViewSubviewsOfClass:(Class)class {
  return [self.scrollViewSubviews
      objectsAtIndexes:[self.scrollViewSubviews indexesOfObjectsPassingTest:^BOOL(
                                                    UIView *view, NSUInteger idx, BOOL *stop) {
        return [view isKindOfClass:class];
      }]];
}

#pragma mark Notification Observing

- (void)keyboardWillShow:(NSNotification *)notification {
  CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notification {
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark IBActions

- (void)resignFirstResponderButtonTapped:(UIButton *)button {
  [self handleResignFirstResponderTapped];
}

- (void)disableButtonTapped:(UIButton *)button {
  [self handleDisableButtonTapped];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  [self handleToggleErrorButtonTapped];
}

- (void)increaseContentSizeButtonTapped:(id)sender {
  [self.traitEnvironmentChangeDelegate
      childViewControllerDidRequestPreferredContentSizeCategoryIncrement:self
                                                          decreaseButton:
                                                              self.decreaseContentSizeButton
                                                          increaseButton:
                                                              self.increaseContentSizeButton];
}

- (void)decreaseContentSizeButtonTapped:(id)sender {
  [self.traitEnvironmentChangeDelegate
      childViewControllerDidRequestPreferredContentSizeCategoryDecrement:self
                                                          decreaseButton:
                                                              self.decreaseContentSizeButton
                                                          increaseButton:
                                                              self.increaseContentSizeButton];
}

- (void)toggleDarkModeButtonTapped:(id)sender {
  [self handleToggleDarkModeButtonTapped];
}

- (void)toggleLayoutDirectionButtonTapped:(id)sender {
  [self handleToggleLayoutDirectionButtonTapped];
}

#pragma mark IBAction handling

- (void)handleToggleDarkModeButtonTapped {
  if (@available(iOS 12.0, *)) {
    UIUserInterfaceStyle currentUserInterfaceStyle = self.traitCollection.userInterfaceStyle;
    UIUserInterfaceStyle newUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
    if (currentUserInterfaceStyle == UIUserInterfaceStyleLight) {
      newUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else if (currentUserInterfaceStyle == UIUserInterfaceStyleDark) {
      newUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
      return;
    }
    [self.traitEnvironmentChangeDelegate
        childViewControllerDidRequestUserInterfaceStyle:self
                                     userInterfaceStyle:newUserInterfaceStyle];
  }
  [self.view setNeedsLayout];
}

- (void)handleToggleErrorButtonTapped {
  self.isErrored = !self.isErrored;
  [self.view setNeedsLayout];
}

- (void)handleDisableButtonTapped {
  self.isDisabled = !self.isDisabled;
  [self.view setNeedsLayout];
}

- (void)handleResignFirstResponderTapped {
}

- (void)handleToggleLayoutDirectionButtonTapped {
  if (@available(iOS 12.0, *)) {
    UITraitEnvironmentLayoutDirection currentTraitEnvironmentLayoutDirection =
        self.traitCollection.layoutDirection;
    UITraitEnvironmentLayoutDirection newTraitEnvironmentLayoutDirection =
        UITraitEnvironmentLayoutDirectionUnspecified;
    if (currentTraitEnvironmentLayoutDirection == UITraitEnvironmentLayoutDirectionRightToLeft) {
      newTraitEnvironmentLayoutDirection = UITraitEnvironmentLayoutDirectionLeftToRight;
    } else if (currentTraitEnvironmentLayoutDirection ==
               UITraitEnvironmentLayoutDirectionLeftToRight) {
      newTraitEnvironmentLayoutDirection = UITraitEnvironmentLayoutDirectionRightToLeft;
    } else {
      return;
    }
    [self.traitEnvironmentChangeDelegate
        childViewControllerDidRequestLayoutDirection:self
                                     layoutDirection:newTraitEnvironmentLayoutDirection];
  }
  [self.view setNeedsLayout];
}

@end
