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

  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];

  self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];
  UIColor *titleColor = [UIColor whiteColor];

  // Raised button

  MDCRaisedButton *raisedButton = [[MDCRaisedButton alloc] init];
  [raisedButton setTitleColor:titleColor forState:UIControlStateNormal];
  [raisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:raisedButton];
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toRaisedButton:raisedButton];
  [raisedButton sizeToFit];
  [raisedButton addTarget:self
                   action:@selector(didTap:)
         forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:raisedButton];

  // Disabled raised button

  MDCRaisedButton *disabledRaisedButton = [[MDCRaisedButton alloc] init];
  [disabledRaisedButton setTitleColor:titleColor forState:UIControlStateNormal];
  [disabledRaisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:disabledRaisedButton];
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toRaisedButton:disabledRaisedButton];
  [disabledRaisedButton sizeToFit];
  [disabledRaisedButton addTarget:self
                           action:@selector(didTap:)
                 forControlEvents:UIControlEventTouchUpInside];
  [disabledRaisedButton setEnabled:NO];
  [self.view addSubview:disabledRaisedButton];

  // Flat button

  MDCFlatButton *flatButton = [[MDCFlatButton alloc] init];
  [flatButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:flatButton];
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toFlatButton:flatButton];
  [flatButton sizeToFit];
  [flatButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:flatButton];

  // Disabled flat

  MDCFlatButton *disabledFlatButton = [[MDCFlatButton alloc] init];
  [disabledFlatButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:disabledFlatButton];
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toFlatButton:disabledFlatButton];
  [disabledFlatButton sizeToFit];
  [disabledFlatButton addTarget:self
                         action:@selector(didTap:)
               forControlEvents:UIControlEventTouchUpInside];
  [disabledFlatButton setEnabled:NO];
  [self.view addSubview:disabledFlatButton];

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
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toFloatingButton:self.floatingButton];
  [self.floatingButton setTintColor:colorScheme.onSecondaryColor];
  [self.view addSubview:self.floatingButton];

  self.buttons = @[
    raisedButton, disabledRaisedButton, flatButton, disabledFlatButton, strokedButton,
    disabledStrokedButton, self.floatingButton
  ];

  [self setupExampleViews];
}

- (void)setupExampleViews {
  UILabel *raisedButtonLabel = [self addLabelWithText:@"Raised"];
  UILabel *disabledRaisedButtonLabel = [self addLabelWithText:@"Disabled Raised"];
  UILabel *flatButtonLabel = [self addLabelWithText:@"Flat"];
  UILabel *disabledFlatButtonLabel = [self addLabelWithText:@"Disabled Flat"];
  UILabel *strokedButtonLabel = [self addLabelWithText:@"Stroked"];
  UILabel *disabledStrokedButtonLabel = [self addLabelWithText:@"Disabled Stroked"];
  UILabel *floatingButtonLabel = [self addLabelWithText:@"Floating Action"];

  self.labels = @[
    raisedButtonLabel, disabledRaisedButtonLabel, flatButtonLabel, disabledFlatButtonLabel,
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
