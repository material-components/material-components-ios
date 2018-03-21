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

#import <UIKit/UIKit.h>

#import "MaterialPalettes.h"
#import "MaterialSnackbar.h"
#import "supplemental/SnackbarExampleSupplemental.h"

@implementation SnackbarSimpleExample {
  BOOL _legacyMode;
  BOOL _dynamicType;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews:@[
      @"Simple Snackbar",
      @"Snackbar with Action Button",
      @"Snackbar with Long Text",
      @"Attributed Text Example",
      @"Color Themed Snackbar",
      @"Customize Font Example",
      @"De-Customize Example"
  ]];
  self.title = @"Snackbar";
  _legacyMode = YES;
  _dynamicType = NO;
  self.navigationItem.rightBarButtonItems =
      @[[[UIBarButtonItem alloc] initWithTitle:@"Legacy"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(toggleModes)],
        [[UIBarButtonItem alloc] initWithTitle:@"DT Off"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(toggleDynamicType)]];
}

- (void)toggleModes {
  _legacyMode = !_legacyMode;
  if (_legacyMode) {
    [self.navigationItem.rightBarButtonItems.firstObject setTitle:@"Legacy"];
  } else {
    [self.navigationItem.rightBarButtonItems.firstObject setTitle:@"New"];
  }
  MDCSnackbarMessage.usesLegacySnackbar = _legacyMode;
}

- (void)toggleDynamicType {
  _dynamicType = !_dynamicType;
  if (_dynamicType) {
    [self.navigationItem.rightBarButtonItems.lastObject setTitle:@"DT On"];
  } else {
    [self.navigationItem.rightBarButtonItems.lastObject setTitle:@"DT Off"];
  }
  [MDCSnackbarMessageView appearance].mdc_adjustsFontForContentSizeCategory = _dynamicType;
}

#pragma mark - Event Handling

- (void)showSimpleSnackbar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  [MDCSnackbarManager showMessage:message];
}

- (void)showSnackbarWithAction:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  message.action = action;
  [MDCSnackbarManager showMessage:message];
}


- (void)showLongSnackbarMessage:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"A red flair silhouetted the jagged edge of a sublime wing.";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  MDCSnackbarMessageActionHandler actionHandler = ^() {
    MDCSnackbarMessage *answerMessage = [[MDCSnackbarMessage alloc] init];
    answerMessage.text = @"The sky was cloudless and of a deep dark blue.";
    [MDCSnackbarManager showMessage:answerMessage];
  };
  action.handler = actionHandler;
  action.title = @"Action";
  message.action = action;

  [MDCSnackbarManager showMessage:message];
}


- (void)showBoldSnackbar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
  [text appendAttributedString:[[NSAttributedString alloc]
                                initWithString:@"Boldly"
                                attributes:@{
                                             MDCSnackbarMessageBoldAttributeName : @YES
                                             }]];
  [text appendAttributedString:[[NSAttributedString alloc]
                                initWithString:@" go where no one has gone before."]];
  message.attributedText = text;

  [MDCSnackbarManager showMessage:message];
}

- (void)showColorThemedSnackbar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  message.action = action;
  [[MDCSnackbarMessageView appearance]
      setButtonTitleColor:MDCPalette.purplePalette.tint400
                 forState:UIControlStateNormal];
  [[MDCSnackbarMessageView appearance]
      setButtonTitleColor:MDCPalette.purplePalette.tint700
                 forState:UIControlStateHighlighted];
  [MDCSnackbarMessageView appearance].messageTextColor = MDCPalette.greenPalette.tint500;
  [MDCSnackbarManager showMessage:message];
}

- (void)showCustomizedSnackbar:(id)sender {
  UIFont *customMessageFont = [UIFont fontWithName:@"Zapfino" size:14.0f];
  NSAssert(customMessageFont, @"Unable to instantiate font");
  [MDCSnackbarMessageView appearance].messageFont = customMessageFont;

  UIFont *customButtonFont = [UIFont fontWithName:@"ChalkDuster" size:14.0f];
  NSAssert(customButtonFont, @"Unable to instantiate font");
  [MDCSnackbarMessageView appearance].buttonFont = customButtonFont;

  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Customized Fonts";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Fancy";
  message.action = action;

  [MDCSnackbarManager showMessage:message];
}

- (void)showDecustomizedSnackbar:(id)sender {
  [MDCSnackbarMessageView appearance].messageFont = nil;
  [MDCSnackbarMessageView appearance].buttonFont = nil;

  // Setting back to the default colors as defined in MDCSnackbarMessageView.h.
  [[MDCSnackbarMessageView appearance] setButtonTitleColor:[UIColor colorWithWhite:1 alpha:0.6f]
                                                  forState:UIControlStateNormal];
  [[MDCSnackbarMessageView appearance] setButtonTitleColor:nil
                                                  forState:UIControlStateHighlighted];
  [MDCSnackbarMessageView appearance].messageTextColor = nil;

  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Back to the standard snackbar";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Okay";
  message.action = action;

  [MDCSnackbarManager showMessage:message];
}

#pragma mark - UICollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
      [self showSimpleSnackbar:nil];
      break;
    case 1:
      [self showSnackbarWithAction:nil];
      break;
    case 2:
      [self showLongSnackbarMessage:nil];
      break;
    case 3:
      [self showBoldSnackbar:nil];
      break;
    case 4:
      [self showColorThemedSnackbar:nil];
      break;
    case 5:
      [self showCustomizedSnackbar:nil];
      break;
    case 6:
      [self showDecustomizedSnackbar:nil];
      break;
    default:
      break;
  }
}

@end
