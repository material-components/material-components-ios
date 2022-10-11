// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFakeMDCSnackbarManagerDelegate.h"

#import "MDCSnackbarMessageView.h"

@implementation FakeMDCSnackbarManagerDelegate

- (void)snackbarManager:(MDCSnackbarManager *)snackbarManager
    willPresentSnackbarWithMessageView:(MDCSnackbarMessageView *)messageView {
  self.presentedView = messageView;
  if (self.shouldSetSnackbarViewAccessibilityViewIsModal) {
    messageView.accessibilityViewIsModal = YES;
  }
  [self.willPresentExpectation fulfill];
}

- (void)snackbarDidDisappear:(MDCSnackbarManager *)snackbarManager {
  [self.didDisappearExpectation fulfill];
}

- (void)snackbarWillDisappear:(MDCSnackbarManager *)snackbarManager {
  [self.willDisappearExpectation fulfill];
}

- (void)snackbarManager:(MDCSnackbarManager *)snackbarManager
    isPresentingSnackbarWithMessageView:(MDCSnackbarMessageView *)messageView {
  [self.isPresentingExpectation fulfill];
}

@end
