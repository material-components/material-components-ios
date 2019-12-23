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

  if (!self.colorScheme) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  if (!self.typographyScheme) {
    self.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self setupExampleViews:@[
    @"Simple Snackbar",
    @"Snackbar with Action Button",
    @"Snackbar with Long Text",
    @"Attributed Text Example",
    @"Color Themed Snackbar",
    @"Customize Font Example",
    @"De-Customize Example",
    @"Customized Message Using Block",
    @"Non Transient Snackbar",
  ]];
  self.title = @"Snackbar";
  _legacyMode = YES;
  _dynamicType = NO;
  self.navigationItem.rightBarButtonItems = @[
    [[UIBarButtonItem alloc] initWithTitle:@"Legacy"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(toggleModes)],
    [[UIBarButtonItem alloc] initWithTitle:@"DT Off"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(toggleDynamicType)]
  ];
  MDCSnackbarManager.delegate = self;
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
  [MDCSnackbarManager mdc_setAdjustsFontForContentSizeCategory:_dynamicType];
}

#pragma mark - Event Handling

- (void)showSimpleSnackbar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  message.focusOnShow = YES;
  [MDCSnackbarManager showMessage:message];
}

- (void)showSnackbarWithAction:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  message.action = action;
  message.enableRippleBehavior = YES;
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
                                       attributes:@{MDCSnackbarMessageBoldAttributeName : @YES}]];
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
  [MDCSnackbarManager setButtonTitleColor:MDCPalette.purplePalette.tint400
                                 forState:UIControlStateNormal];
  [MDCSnackbarManager setButtonTitleColor:MDCPalette.purplePalette.tint700
                                 forState:UIControlStateHighlighted];
  MDCSnackbarManager.messageTextColor = MDCPalette.greenPalette.tint500;
  [MDCSnackbarManager showMessage:message];
}

- (void)showCustomizedSnackbar:(id)sender {
  UIFont *customMessageFont = [UIFont fontWithName:@"Zapfino" size:14];
  NSAssert(customMessageFont, @"Unable to instantiate font");
  MDCSnackbarManager.messageFont = customMessageFont;

  UIFont *customButtonFont = [UIFont fontWithName:@"ChalkDuster" size:14];
  NSAssert(customButtonFont, @"Unable to instantiate font");
  MDCSnackbarManager.buttonFont = customButtonFont;

  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Customized Fonts";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Fancy";
  message.action = action;

  [MDCSnackbarManager showMessage:message];
}

- (void)showDecustomizedSnackbar:(id)sender {
  MDCSnackbarManager.messageFont = nil;
  MDCSnackbarManager.buttonFont = nil;
  [MDCSnackbarManager setButtonTitleColor:nil forState:UIControlStateNormal];
  [MDCSnackbarManager setButtonTitleColor:nil forState:UIControlStateHighlighted];
  MDCSnackbarManager.messageTextColor = nil;

  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Back to the standard snackbar";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Okay";
  message.action = action;

  [MDCSnackbarManager showMessage:message];
}

- (void)showCustomizedSnackbarWithActionUsingBlock:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  message.action = action;
  message.enableRippleBehavior = YES;
  message.snackbarMessageWillPresentBlock =
      ^(MDCSnackbarMessage *snackbarMessage, MDCSnackbarMessageView *messageView) {
        messageView.backgroundColor = UIColor.blueColor;
        messageView.messageTextColor = UIColor.whiteColor;
        for (MDCButton *button in messageView.actionButtons) {
          [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
          [button setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
        }
      };
  [MDCSnackbarManager showMessage:message];
}

- (void)showNonTransientSnackbar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  message.automaticallyDismisses = NO;
  message.enableRippleBehavior = YES;
  [MDCSnackbarManager showMessage:message];
}

#pragma mark - UICollectionView

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
    case 7:
      [self showCustomizedSnackbarWithActionUsingBlock:nil];
      break;
    case 8:
      [self showNonTransientSnackbar:nil];
      break;
    default:
      break;
  }
}

- (void)willPresentSnackbarWithMessageView:(nullable MDCSnackbarMessageView *)messageView {
  NSLog(@"A snackbar will be presented");
}

@end
