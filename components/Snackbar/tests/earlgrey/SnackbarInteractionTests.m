/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

@import XCTest;
@import EarlGrey;

@interface SnackbarEarlGreyTests : XCTestCase

@end

@implementation SnackbarEarlGreyTests

+ (void)returnToMainScreen {
  // Leave the Demo view
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"back_bar_button")]
      performAction:grey_tap()];
  // Leave the Snackbar view
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"back_bar_button")]
      performAction:grey_tap()];
  // Scroll to the top of the main screen
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"collectionView")]
   performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
}

- (void)testSliding {
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"collectionView")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeBottom)];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"Snackbar")] performAction:grey_tap()];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"CellDemo")] performAction:grey_tap()];

  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"Simple Snackbar")]
      performAction:grey_tap()];
  [SnackbarEarlGreyTests returnToMainScreen];
}

@end
