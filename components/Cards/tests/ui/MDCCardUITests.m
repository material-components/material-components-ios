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

@interface MDCCardUITests : FBSnapshotTestCase

@end

@implementation MDCCardUITests

- (void)testDefaultCard {
  // Uncomment below to recreate the golden
  //  self.recordMode = YES;

  UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
  backgroundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
  MDCCard *card = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
  [backgroundView addSubview:card];
  card.center = backgroundView.center;

  FBSnapshotVerifyView([self imageViewSnapshotOfView:backgroundView], nil);
}

// TODO: To be extracted into test helper method
- (UIImageView *)imageViewSnapshotOfView:(UIView *)view {
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
    NSAssert(NO, @"This test requires iOS 10.0 or later.");
  }

  UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
  imageView.image = result;
  return imageView;
}

@end
