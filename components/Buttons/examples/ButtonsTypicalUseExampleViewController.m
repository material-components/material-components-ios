// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialButtons+ColorThemer.h"
#import "MaterialButtons+TypographyThemer.h"
#import "MaterialTypography.h"
#import "MDCTextButtonThemer.h"

#import "supplemental/ButtonsTypicalUseSupplemental.h"

const CGSize kMinimumAccessibleButtonSize = {64.0, 48.0};

@interface ButtonsTypicalUseExampleViewController ()
@property(nonatomic, strong) MDCFloatingButton *floatingButton;
@end

@implementation ButtonsTypicalUseExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  // Contained button

  MDCButton *containedButton = [[MDCButton alloc] init];
  [containedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:containedButton];
  [containedButton sizeToFit];
  CGFloat containedButtonVerticalInset =
      MIN(0, -(kMinimumAccessibleButtonSize.height - CGRectGetHeight(containedButton.bounds)) / 2);
  CGFloat containedButtonHorizontalInset =
      MIN(0, -(kMinimumAccessibleButtonSize.width - CGRectGetWidth(containedButton.bounds)) / 2);
  containedButton.hitAreaInsets =
      UIEdgeInsetsMake(containedButtonVerticalInset, containedButtonHorizontalInset,
                       containedButtonVerticalInset, containedButtonHorizontalInset);
  [containedButton addTarget:self
                      action:@selector(didTap:)
            forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:containedButton];

  // Disabled contained button

  MDCButton *disabledContainedButton = [[MDCButton alloc] init];
  [disabledContainedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:disabledContainedButton];
  [disabledContainedButton sizeToFit];
  [disabledContainedButton addTarget:self
                              action:@selector(didTap:)
                    forControlEvents:UIControlEventTouchUpInside];
  [disabledContainedButton setEnabled:NO];
  [self.view addSubview:disabledContainedButton];

  // Text button

  MDCButton *textButton = [[MDCButton alloc] init];
  [MDCTextButtonThemer applyScheme:buttonScheme toButton:textButton];
  [textButton setTitle:@"Button" forState:UIControlStateNormal];
  [textButton sizeToFit];
  CGFloat textButtonVerticalInset =
      MIN(0, -(kMinimumAccessibleButtonSize.height - CGRectGetHeight(textButton.bounds)) / 2);
  CGFloat textButtonHorizontalInset =
      MIN(0, -(kMinimumAccessibleButtonSize.width - CGRectGetWidth(textButton.bounds)) / 2);
  textButton.hitAreaInsets =
      UIEdgeInsetsMake(textButtonVerticalInset, textButtonHorizontalInset,
                       textButtonVerticalInset, textButtonHorizontalInset);
  [textButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:textButton];

  // Disabled Text button

  MDCButton *disabledTextButton = [[MDCButton alloc] init];
  [disabledTextButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCTextButtonThemer applyScheme:buttonScheme toButton:disabledTextButton];
  [disabledTextButton sizeToFit];
  [disabledTextButton addTarget:self
                         action:@selector(didTap:)
               forControlEvents:UIControlEventTouchUpInside];
  [disabledTextButton setEnabled:NO];
  [self.view addSubview:disabledTextButton];

  // Outlined button

  MDCButton *outlinedButton = [[MDCButton alloc] init];
  [outlinedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCOutlinedButtonThemer applyScheme:buttonScheme toButton:outlinedButton];
  [outlinedButton sizeToFit];
  CGFloat outlineButtonVerticalInset =
      MIN(0, -(kMinimumAccessibleButtonSize.height - CGRectGetHeight(outlinedButton.frame)) / 2);
  CGFloat outlineButtonHorizontalInset =
      MIN(0, -(kMinimumAccessibleButtonSize.width - CGRectGetWidth(outlinedButton.frame)) / 2);
  outlinedButton.hitAreaInsets =
      UIEdgeInsetsMake(outlineButtonVerticalInset, outlineButtonHorizontalInset,
                       outlineButtonVerticalInset, outlineButtonHorizontalInset);
  [outlinedButton addTarget:self
                    action:@selector(didTap:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:outlinedButton];

  // Disabled outlined button

  MDCButton *disabledOutlinedButton = [[MDCButton alloc] init];
  [disabledOutlinedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCOutlinedButtonThemer applyScheme:buttonScheme toButton:disabledOutlinedButton];
  [disabledOutlinedButton sizeToFit];
  [disabledOutlinedButton addTarget:self
                             action:@selector(didTap:)
                   forControlEvents:UIControlEventTouchUpInside];
  [disabledOutlinedButton setEnabled:NO];
  [self.view addSubview:disabledOutlinedButton];

  // Floating action button

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton sizeToFit];
  [self.floatingButton addTarget:self
                          action:@selector(didTap:)
                forControlEvents:UIControlEventTouchUpInside];

  UIImage *plusImage =
      [[UIImage imageNamed:@"Plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.floatingButton setImage:plusImage forState:UIControlStateNormal];
  [MDCFloatingActionButtonThemer applyScheme:buttonScheme toButton:self.floatingButton];
  self.floatingButton.accessibilityLabel = @"Create";
  [self.view addSubview:self.floatingButton];

  self.buttons = @[
    containedButton, disabledContainedButton, textButton, disabledTextButton, outlinedButton,
    disabledOutlinedButton,self.floatingButton
  ];

  [self setupExampleViews];

  NSMutableArray *accessibilityElements = [@[] mutableCopy];
  for (NSUInteger index = 0; index < self.buttons.count; ++index) {
    [accessibilityElements addObject:self.labels[index]];
    [accessibilityElements addObject:self.buttons[index]];
  }
  self.view.accessibilityElements = [accessibilityElements copy];
}

- (void)setupExampleViews {
  UILabel *containedButtonLabel = [self addLabelWithText:@"Contained"];
  UILabel *disabledContainedButtonLabel = [self addLabelWithText:@"Disabled Contained"];
  UILabel *textButtonLabel = [self addLabelWithText:@"Text button"];
  UILabel *disabledTextButtonLabel = [self addLabelWithText:@"Disabled text button"];
  UILabel *outlinedButtonLabel = [self addLabelWithText:@"Outlined"];
  UILabel *disabledOutlinedButtonLabel = [self addLabelWithText:@"Disabled Outlined"];
  UILabel *floatingButtonLabel = [self addLabelWithText:@"Floating Action"];

  self.labels = @[
    containedButtonLabel, disabledContainedButtonLabel, textButtonLabel, disabledTextButtonLabel,
    outlinedButtonLabel, disabledOutlinedButtonLabel, floatingButtonLabel
  ];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
  if (!UIAccessibilityIsVoiceOverRunning()) {
    if (sender == self.floatingButton) {
      [self.floatingButton
            collapse:YES
          completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                             [self.floatingButton expand:YES completion:nil];
                           });
          }];
    }
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (animated && !UIAccessibilityIsVoiceOverRunning()) {
    [self.floatingButton collapse:NO completion:nil];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (animated && !UIAccessibilityIsVoiceOverRunning()) {
    [self.floatingButton expand:YES completion:nil];
  }
}

@end
