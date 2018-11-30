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

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import "MaterialCards.h"

@interface MDCCardSnapshotTests : FBSnapshotTestCase

@end

@implementation MDCCardSnapshotTests

// TODO: To be extracted into FBSnapshotTestCase common subclass
- (void)setUp {
  [super setUp];
  self.agnosticOptions = FBSnapshotTestCaseAgnosticOptionOS;
}

- (void)testDefaultCard {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  // Given
  MDCCard *card = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
  UIView *backgroundView = [self addBackgroundViewToView:card];

  // Then
  [self snapshotVerifyView:backgroundView];
}

// TODO: To be extracted into FBSnapshotTestCase common subclass
- (UIView *)addBackgroundViewToView:(UIView *)view {
  UIView *backgroundView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds) + 20,
                                               CGRectGetHeight(view.bounds) + 20)];
  backgroundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
  [backgroundView addSubview:view];
  view.center = backgroundView.center;
  return backgroundView;
}

// TODO: To be extracted into FBSnapshotTestCase common subclass
- (void)snapshotVerifyView:(UIView *)view {
  // TODO(https://github.com/material-components/material-components-ios/issues/5888)
  // Support multiple OS versions for snapshots
  if (NSProcessInfo.processInfo.operatingSystemVersion.majorVersion != 11 ||
      NSProcessInfo.processInfo.operatingSystemVersion.minorVersion != 2 ||
      NSProcessInfo.processInfo.operatingSystemVersion.patchVersion != 0) {
    NSLog(@"Skipping this test. Snapshot tests currently only run on iOS 11.2.");
    return;
  }

  UIImage *result = nil;

  if (@available(iOS 10, *)) {
    UIGraphicsImageRenderer *renderer =
        [[UIGraphicsImageRenderer alloc] initWithSize:view.frame.size];
    result = [renderer imageWithActions:^(UIGraphicsImageRendererContext *_Nonnull context) {
      BOOL success = [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
      NSAssert(success, @"View %@ must draw correctly", view);
    }];

    NSAssert(result != nil, @"View %@ must render image", view);
  } else {
    NSLog(@"Skipping this test. Snapshot tests require iOS 10.0 or later.");
    return;
  }

  UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
  imageView.image = result;

  FBSnapshotVerifyView(imageView, nil);
}

@end
