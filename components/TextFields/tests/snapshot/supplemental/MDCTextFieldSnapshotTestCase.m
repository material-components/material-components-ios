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

#import <XCTest/XCTest.h>

#import "SnapshotFakeMDCTextField.h"
#import "MDCTextFieldSnapshotTestCase.h"

@implementation MDCTextFieldSnapshotTestCase

- (void)setUp {
  [super setUp];

  self.textField = [[SnapshotFakeMDCTextField alloc] init];
}

- (void)tearDown {
  self.textField = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)triggerTextFieldLayout {
  CGSize aSize = [self.textField sizeThatFits:CGSizeMake(300, INFINITY)];
  self.textField.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [self.textField layoutIfNeeded];
}

- (void)generateSnapshotAndVerify {
  [self generateSnapshotAndVerifyWithTolerance:0];
}

- (void)generateSnapshotAndVerifyWithTolerance:(CGFloat)tolerance {
  [self triggerTextFieldLayout];
  UIView *snapshotView = [self addBackgroundViewToView:self.textField];

  // Perform the actual verification.
  [self snapshotVerifyView:snapshotView tolerance:tolerance];
}

@end
