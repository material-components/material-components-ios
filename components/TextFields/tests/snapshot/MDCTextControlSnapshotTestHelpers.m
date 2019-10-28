// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import <UIKit/UIKit.h>

#import "MDCTextControlSnapshotTestHelpers.h"

// This timeout value is intended to be temporary. These snapshot tests currently take longer than
// we'd want them to. They don't come close to 30 seconds.
static const NSTimeInterval kTextFieldValidationAnimationTimeout = 30.0;

@implementation MDCTextControlSnapshotTestHelpers

#pragma mark Validation

+ (void)validateTextControl:(UIView<MDCTextControl> *)textControl
               withTestCase:(MDCSnapshotTestCase *)testCase {
  [MDCTextControlSnapshotTestHelpers forceLayoutOfTextControl:textControl];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"text_control_validation_expectation"];
  dispatch_async(dispatch_get_main_queue(), ^{
    // We take a snapshot of the text control so we don't have to remove it from the app
    // host's key window. Removing the text control from the app host's key window
    // before validation can affect the textt control's editing behavior, which has a
    // large effect on the appearance of the text control.
    UIView *textControlSnapshot = [textControl snapshotViewAfterScreenUpdates:YES];
    [MDCTextControlSnapshotTestHelpers generateSnapshotAndVerifyForView:textControlSnapshot
                                                           withTestCase:testCase];
    [expectation fulfill];
  });
  [testCase waitForExpectations:@[ expectation ] timeout:kTextFieldValidationAnimationTimeout];
}

+ (void)forceLayoutOfTextControl:(UIView<MDCTextControl> *)textControl {
  [textControl sizeToFit];
  [textControl setNeedsLayout];
  [textControl layoutIfNeeded];
}

+ (void)generateSnapshotAndVerifyForView:(UIView *)view
                            withTestCase:(MDCSnapshotTestCase *)testCase {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [testCase snapshotVerifyView:snapshotView];
}

@end
