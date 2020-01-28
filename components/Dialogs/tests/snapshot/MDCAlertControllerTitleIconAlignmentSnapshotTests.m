// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialDialogs.h"

@interface MDCAlertControllerTitleIconAlignmentSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCAlertController *alertController;
@end

@implementation MDCAlertControllerTitleIconAlignmentSnapshotTests

- (void)setUp {
  [super setUp];

  self.alertController = [[MDCAlertController alloc] init];
  self.alertController.title = @"Title";
  self.alertController.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"Action"
                                                  emphasis:MDCActionEmphasisHigh
                                                   handler:nil];
  self.alertController.view.bounds = CGRectMake(0, 0, 300, 300);
  [self.alertController addAction:action];
}

- (void)tearDown {
  self.alertController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testAlertControllerWithTitleAlignmentLeftAutomaticallyAdjustTitleIconOn {
  // When
  self.alertController.titleAlignment = NSTextAlignmentLeft;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testAlertControllerWithTitleAlignmentRightAutomaticallyAdjustTitleIconOn {
  // When
  self.alertController.titleAlignment = NSTextAlignmentRight;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testAlertControllerWithTitleAlignmentCenterAutomaticallyAdjustTitleIconOn {
  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentLeftAutomaticallyAdjustTitleIconOffTitleIconAlignedLeading {
  // When
  self.alertController.titleAlignment = NSTextAlignmentLeft;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentLeftAutomaticallyAdjustTitleIconOffTitleIconAlignedCentered {
  // When
  self.alertController.titleAlignment = NSTextAlignmentLeft;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentLeftAutomaticallyAdjustTitleIconOffTitleIconAlignedTrailing {
  // When
  self.alertController.titleAlignment = NSTextAlignmentLeft;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentTrailing;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentCenterAutomaticallyAdjustTitleIconOffTitleIconAlignedLeading {
  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentCenterAutomaticallyAdjustTitleIconOffTitleIconAlignedCentered {
  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentCenterAutomaticallyAdjustTitleIconOffTitleIconAlignedTrailing {
  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentTrailing;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentRightAutomaticallyAdjustTitleIconOffTitleIconAlignedLeading {
  // When
  self.alertController.titleAlignment = NSTextAlignmentRight;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentRightAutomaticallyAdjustTitleIconOffTitleIconAlignedCentered {
  // When
  self.alertController.titleAlignment = NSTextAlignmentRight;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testAlertControllerWithTitleAlignmentRightAutomaticallyAdjustTitleIconOffTitleIconAlignedTrailing {
  // When
  self.alertController.titleAlignment = NSTextAlignmentRight;
  self.alertController.automaticallyAdjustsTitleIconAlignment = NO;
  self.alertController.titleIconAlignment = MDCAlertControllerTitleIconAlignmentTrailing;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

@end
