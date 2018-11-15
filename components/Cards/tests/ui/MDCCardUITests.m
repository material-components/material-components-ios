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

- (void)testDefaultCard {
  // Uncomment below to recreate the golden
    self.recordMode = YES;

  UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
  backgroundView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
  MDCCard *card = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
  [backgroundView addSubview:card];
  card.center = backgroundView.center;
  // purposely fail the test
//  card.backgroundColor = UIColor.greenColor;

  [CATransaction flush];
  FBSnapshotVerifyView(backgroundView, nil);
}

@end
