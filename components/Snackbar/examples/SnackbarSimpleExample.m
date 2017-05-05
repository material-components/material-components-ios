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

#import "MaterialSnackbar.h"
#import "SnackbarExampleSupplemental.h"

@implementation SnackbarSimpleExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews:@[
      @"Simple Snackbar",
      @"Snackbar with Action Button",
      @"Attributed Text Example"
  ]];
  self.title = @"Snackbar";
}

#pragma mark - Event Handling

- (void)showSimpleSnacbBar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"Snackbar Message";
  [MDCSnackbarManager showMessage:message];
}


- (void)showActionSnackbar:(id)sender {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"A red flair silhouetted the jagged edge of a sublime wing.";
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  void (^actionHandler)() = ^() {
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



#pragma mark - UICollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
      [self showSimpleSnacbBar:nil];
      break;
    case 1:
      [self showActionSnackbar:nil];
      break;
    case 2:
      [self showBoldSnackbar:nil];
    default:
      break;
  }
}

@end
