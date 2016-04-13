/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "ButtonsSimpleExampleViewController.h"

#import "MaterialButtons.h"
#import "MaterialTypography.h"

@implementation ButtonsSimpleExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Raised button and label

  MDCRaisedButton *raisedButton = [[MDCRaisedButton alloc] init];
  [raisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [raisedButton sizeToFit];
  [raisedButton addTarget:self
                   action:@selector(didTap:)
         forControlEvents:UIControlEventTouchUpInside];
  raisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButton];

  UILabel *raisedButtonLabel = [[UILabel alloc] init];
  raisedButtonLabel.text = @"Raised";
  raisedButtonLabel.font = [MDCTypography captionFont];
  raisedButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [raisedButtonLabel sizeToFit];
  raisedButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButtonLabel];

  // Disabled raised button and label

  MDCRaisedButton *disabledRaisedButton = [[MDCRaisedButton alloc] init];
  [disabledRaisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [disabledRaisedButton sizeToFit];
  [disabledRaisedButton addTarget:self
                           action:@selector(didTap:)
                 forControlEvents:UIControlEventTouchUpInside];
  [disabledRaisedButton setEnabled:NO];
  disabledRaisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledRaisedButton];

  UILabel *disabledRaisedButtonLabel = [[UILabel alloc] init];
  disabledRaisedButtonLabel.text = @"Disabled Raised";
  disabledRaisedButtonLabel.font = [MDCTypography captionFont];
  disabledRaisedButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [disabledRaisedButtonLabel sizeToFit];
  disabledRaisedButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledRaisedButtonLabel];

  // Flat button and label

  MDCFlatButton *flatButton = [[MDCFlatButton alloc] init];
  [flatButton setTitle:@"Button" forState:UIControlStateNormal];
  [flatButton setCustomTitleColor:[UIColor grayColor]];
  [flatButton sizeToFit];
  [flatButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  flatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:flatButton];

  UILabel *flatButtonLabel = [[UILabel alloc] init];
  flatButtonLabel.text = @"Flat";
  flatButtonLabel.font = [MDCTypography captionFont];
  flatButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [flatButtonLabel sizeToFit];
  flatButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:flatButtonLabel];

  // Disabled flat button and label

  MDCFlatButton *disabledFlatButton = [[MDCFlatButton alloc] init];
  [disabledFlatButton setTitle:@"Button" forState:UIControlStateNormal];
  [disabledFlatButton setCustomTitleColor:[UIColor grayColor]];
  [disabledFlatButton sizeToFit];
  [disabledFlatButton addTarget:self
                         action:@selector(didTap:)
               forControlEvents:UIControlEventTouchUpInside];
  [disabledFlatButton setEnabled:NO];
  disabledFlatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledFlatButton];

  UILabel *disabledFlatButtonLabel = [[UILabel alloc] init];
  disabledFlatButtonLabel.text = @"Disabled Flat";
  disabledFlatButtonLabel.font = [MDCTypography captionFont];
  disabledFlatButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [disabledFlatButtonLabel sizeToFit];
  disabledFlatButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledFlatButtonLabel];

  // Floating action button and label

  MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
  [floatingButton setTitle:@"+" forState:UIControlStateNormal];
  [floatingButton sizeToFit];
  [floatingButton addTarget:self
                     action:@selector(didTap:)
           forControlEvents:UIControlEventTouchUpInside];
  floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:floatingButton];

  UILabel *floatingButtonLabel = [[UILabel alloc] init];
  floatingButtonLabel.text = @"Floating Action";
  floatingButtonLabel.font = [MDCTypography captionFont];
  floatingButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [floatingButtonLabel sizeToFit];
  floatingButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:floatingButtonLabel];

  NSDictionary *views = @{
    @"raised" : raisedButton,
    @"raisedLabel" : raisedButtonLabel,
    @"disabledRaised" : disabledRaisedButton,
    @"disabledRaisedLabel" : disabledRaisedButtonLabel,
    @"flat" : flatButton,
    @"flatLabel" : flatButtonLabel,
    @"disabledFlat" : disabledFlatButton,
    @"disabledFlatLabel" : disabledFlatButtonLabel,
    @"floating" : floatingButton,
    @"floatingLabel" : floatingButtonLabel
  };

  NSDictionary *metrics = @{ @"smallVMargin" : @24.0,
                             @"largeVMargin" : @56.0,
                             @"smallHMargin" : @24.0,
                             @"buttonHeight" : @(raisedButton.bounds.size.height),
                             @"fabHeight" : @(floatingButton.bounds.size.height) };

  // Vertical column of buttons
  NSString *buttonLayoutConstraints =
      @"V:[raised]-smallVMargin-"
       "[disabledRaised]-largeVMargin-"
       "[flat]-smallVMargin-"
       "[disabledFlat]-largeVMargin-"
       "[floating]";

  // Vertical column of labels
  NSString *labelLayoutConstraints =
      @"V:[raisedLabel(buttonHeight)]-smallVMargin-"
       "[disabledRaisedLabel(buttonHeight)]-largeVMargin-"
       "[flatLabel(buttonHeight)]-smallVMargin-"
       "[disabledFlatLabel(buttonHeight)]-largeVMargin-"
       "[floatingLabel(fabHeight)]";

  // Horizontal alignment between the two columns
  NSString *columnConstraints = @"[raisedLabel(100)]-smallHMargin-[raised]";

  // Center view horizontally on the left edge of one of the buttons
  [self.view addConstraint:
                 [NSLayoutConstraint constraintWithItem:flatButton
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterX
                                             multiplier:1.f
                                               constant:12.f]];

  // Center view vertically on the flat button (it's the middlemost)
  [self.view addConstraint:
                 [NSLayoutConstraint constraintWithItem:flatButton
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                               constant:0.f]];

  // Center buttons in their column
  [self.view addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:buttonLayoutConstraints
                                                         options:NSLayoutFormatAlignAllCenterX
                                                         metrics:metrics
                                                           views:views]];
  // Left align labels in their column
  [self.view addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:labelLayoutConstraints
                                                         options:NSLayoutFormatAlignAllLeft
                                                         metrics:metrics
                                                           views:views]];

  // Vertically align first element in label column to first element in button column
  [self.view addConstraint:
                 [NSLayoutConstraint constraintWithItem:raisedButton
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:raisedButtonLabel
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                               constant:0.f]];

  // Position label column left of button column, wide enough to accommodate label text
  [self.view addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:columnConstraints
                                                         options:0
                                                         metrics:metrics
                                                           views:views]];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Buttons", @"Buttons" ];
}

+ (NSString *)catalogDescription {
  return @"Buttons is a collection of Material Design buttons, including a flat button, a raised"
          " button and a floating action button.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end
