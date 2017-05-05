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

static NSString *const kCategoryA = @"CategoryA";
static NSString *const kCategoryB = @"CategoryB";

@interface SnackbarSuspensionExample ()

/** The current suspension token. */
@property(nonatomic) id<MDCSnackbarSuspensionToken> allMessagesToken;

/** Token held when suspending messages from Group A. */
@property(nonatomic) id<MDCSnackbarSuspensionToken> groupAToken;

/** Token held when suspending messages from Group B. */
@property(nonatomic) id<MDCSnackbarSuspensionToken> groupBToken;

@end

@implementation SnackbarSuspensionExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews:@[
      @"Show Category A Message",
      @"Show Category B Message",
      @"Show Message with no category",
      @"Suspend Category A",
      @"Suspend Category B",
      @"Suspend All"]];
  self.title = @"Message Suspension";
}

- (void)showMessageWithPrefix:(NSString *)prefix category:(NSString *)category {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] init];
  NSString *formattedPrefix = [NSString stringWithFormat:@"%@ : ", prefix];
  NSAttributedString *attributedString =
      [[NSAttributedString alloc] initWithString:formattedPrefix
                                      attributes:@{
                                        MDCSnackbarMessageBoldAttributeName : @YES
                                      }];
  [attributedMessage appendAttributedString:attributedString];

  NSAttributedString *attributedStringID =
      [[NSAttributedString alloc] initWithString:[NSUUID UUID].UUIDString];
  [attributedMessage appendAttributedString:attributedStringID];
  message.attributedText = attributedMessage;
  message.category = category;
  [MDCSnackbarManager showMessage:message];
}

#pragma mark - Suspend/Resume

- (void)setSuspendedGroupA:(BOOL)suspended {
  if (suspended && self.groupAToken == nil) {
    self.groupAToken = [MDCSnackbarManager suspendMessagesWithCategory:kCategoryA];
  } else if (!suspended && self.groupAToken != nil) {
    [MDCSnackbarManager resumeMessagesWithToken:self.groupAToken];
    self.groupAToken = nil;
  }
}

- (void)setSuspendedGroupB:(BOOL)suspended {
  if (suspended && self.groupBToken == nil) {
    self.groupBToken = [MDCSnackbarManager suspendMessagesWithCategory:kCategoryB];
  } else if (!suspended && self.groupBToken != nil) {
    [MDCSnackbarManager resumeMessagesWithToken:self.groupBToken];
    self.groupBToken = nil;
  }
}

- (void)setSuspendedAllMessages:(BOOL)suspended {
  if (suspended && self.allMessagesToken == nil) {
    self.allMessagesToken = [MDCSnackbarManager suspendAllMessages];
  } else if (!suspended && self.allMessagesToken != nil) {
    [MDCSnackbarManager resumeMessagesWithToken:self.allMessagesToken];
    self.allMessagesToken = nil;
  }
}

#pragma mark - Event Handling

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
      [self showMessageWithPrefix:@"Category A Message" category:kCategoryA];
      break;
    case 1:
      [self showMessageWithPrefix:@"Category B Message" category:kCategoryB];
      break;
    case 2:
      [self showMessageWithPrefix:@"No Category Message" category:nil];
      break;
    default:
      break;
  }
}

- (void)handleSuspendStateChanged:(UISwitch *)sender {
  BOOL suspended = sender.on;

  // Figure out which token we're dealing with based on which switch sent this message.
  if (sender.tag == 3) {
    [self setSuspendedGroupA:suspended];
  } else if (sender.tag == 4) {
    [self setSuspendedGroupB:suspended];
  } else if (sender.tag == 5) {
    [self setSuspendedAllMessages:suspended];
  }
}

@end
