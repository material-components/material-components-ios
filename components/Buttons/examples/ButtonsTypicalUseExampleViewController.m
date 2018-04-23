/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCButtonColorThemer.h"
#import "MDCButtonTypographyThemer.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"
#import "MDCTextButtonThemer.h"
#import "MDCFloatingButtonColorThemer.h"
#import "MDCContainedButtonThemer.h"

#import "supplemental/ButtonsTypicalUseSupplemental.h"

@interface ButtonsTypicalUseExampleViewController ()
@property(nonatomic, strong) MDCFloatingButton *floatingButton;
@end

@implementation ButtonsTypicalUseExampleViewController

- (MDCButton *)buildCustomStrokedButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor colorWithWhite:0.1f alpha:1] forState:UIControlStateNormal];
  button.inkColor = [UIColor colorWithWhite:0 alpha:0.06f];

  [button setBorderWidth:1.0 forState:UIControlStateNormal];
  [button setBorderColor:[UIColor colorWithWhite:0.1f alpha:1] forState:UIControlStateNormal];

  return button;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];

  self.view.backgroundColor = [UIColor whiteColor];
  UIColor *titleColor = [UIColor whiteColor];

  // Contained button

  MDCButton *containedButton = [[MDCButton alloc] init];
  [containedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:containedButton];
  [containedButton sizeToFit];
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

  // Custom stroked button

  MDCButton *strokedButton = [self buildCustomStrokedButton];
  [strokedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:strokedButton];
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toButton:strokedButton];
  [strokedButton sizeToFit];
  [strokedButton addTarget:self
                    action:@selector(didTap:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:strokedButton];

  // Disabled custom stroked button

  MDCButton *disabledStrokedButton = [self buildCustomStrokedButton];
  [disabledStrokedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:disabledStrokedButton];
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toButton:disabledStrokedButton];
  [disabledStrokedButton sizeToFit];
  [disabledStrokedButton addTarget:self
                            action:@selector(didTap:)
                  forControlEvents:UIControlEventTouchUpInside];
  [disabledStrokedButton setEnabled:NO];
  [self.view addSubview:disabledStrokedButton];

  // Floating action button

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton setTitleColor:titleColor forState:UIControlStateNormal];
  [self.floatingButton sizeToFit];
  [self.floatingButton addTarget:self
                          action:@selector(didTap:)
                forControlEvents:UIControlEventTouchUpInside];

  UIImage *plusImage =
      [[UIImage imageNamed:@"Plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.floatingButton setImage:plusImage forState:UIControlStateNormal];
  [MDCFloatingButtonColorThemer applySemanticColorScheme:colorScheme toButton:self.floatingButton];
  [self.view addSubview:self.floatingButton];

  self.buttons = @[
    containedButton, disabledContainedButton, textButton, disabledTextButton, strokedButton,
    disabledStrokedButton, self.floatingButton
  ];

  [self setupExampleViews];
}

- (void)setupExampleViews {
  UILabel *containedButtonLabel = [self addLabelWithText:@"Contained"];
  UILabel *disabledContainedButtonLabel = [self addLabelWithText:@"Disabled Contained"];
  UILabel *textButtonLabel = [self addLabelWithText:@"Text button"];
  UILabel *disabledTextButtonLabel = [self addLabelWithText:@"Disabled text button"];
  UILabel *strokedButtonLabel = [self addLabelWithText:@"Stroked"];
  UILabel *disabledStrokedButtonLabel = [self addLabelWithText:@"Disabled Stroked"];
  UILabel *floatingButtonLabel = [self addLabelWithText:@"Floating Action"];

  self.labels = @[
    containedButtonLabel, disabledContainedButtonLabel, textButtonLabel, disabledTextButtonLabel,
    strokedButtonLabel, disabledStrokedButtonLabel, floatingButtonLabel
  ];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (animated) {
    [self.floatingButton collapse:NO completion:nil];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (animated) {
    [self.floatingButton expand:YES completion:nil];
  }
}

@end
