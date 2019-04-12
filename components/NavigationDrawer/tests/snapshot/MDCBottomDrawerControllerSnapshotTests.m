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

#import "../../src/private/MDCBottomDrawerContainerViewController.h"
#import "MaterialNavigationDrawer.h"
#import "supplemental/MDCBottomDrawerSnapshotTestMutableTraitCollection.h"

/** Fake MDCBottomDrawerContainerViewController for snapshot testing. */
@interface FakeBottomDrawerContainerViewController : MDCBottomDrawerContainerViewController

/** Used to set the value of @c traitCollection. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;

@end

@implementation FakeBottomDrawerContainerViewController

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/** Fake view controller for the MDCBottomDrawer header for snapshot testing. */
@interface FakeBottomDrawerHeader : UIViewController <MDCBottomDrawerHeader>
@end

@implementation FakeBottomDrawerHeader
@end

/** Fake view controller for the MDCBottomDrawer content for snapshot testing. */
@interface FakeBottomDrawerContent : UIViewController
@end

@implementation FakeBottomDrawerContent
@end

/** Snapshot tests for MDCBottomDrawerController's view. */
@interface MDCBottomDrawerControllerSnapshotTests : MDCSnapshotTestCase

@end

@implementation MDCBottomDrawerControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //   self.recordMode = YES;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testPresentedDrawerWithColoredViews {
  // Given
  UIViewController *presentingViewController = [[UIViewController alloc] init];
  presentingViewController.view.frame = CGRectMake(0, 0, 375, 667);
  MDCBottomDrawerViewController *viewController = [[MDCBottomDrawerViewController alloc] init];
  FakeBottomDrawerHeader *headerViewController = [[FakeBottomDrawerHeader alloc] init];
  headerViewController.view.backgroundColor = UIColor.blueColor;
  FakeBottomDrawerContent *contentViewController = [[FakeBottomDrawerContent alloc] init];
  contentViewController.view.backgroundColor = UIColor.greenColor;
  viewController.contentViewController = contentViewController;
  viewController.headerViewController = headerViewController;
  FakeBottomDrawerContainerViewController *container =
      [[FakeBottomDrawerContainerViewController alloc]
          initWithOriginalPresentingViewController:presentingViewController
                                trackingScrollView:nil];
  container.contentViewController = viewController.contentViewController;
  container.headerViewController = viewController.headerViewController;

  // When
  viewController.contentViewController.preferredContentSize = CGSizeMake(375, 1000);
  viewController.headerViewController.preferredContentSize = CGSizeMake(375, 80);
  [viewController.view addSubview:container.view];
  [viewController addChildViewController:container];
  viewController.view.frame = CGRectMake(0, 0, 375, 667);

  // Then
  [self generateSnapshotAndVerifyForView:viewController.view];
}

- (void)testPresentedDrawerWithColoredViewsWithVerticalSizeClassCompact {
  // Given
  UIViewController *presentingViewController = [[UIViewController alloc] init];
  presentingViewController.view.frame = CGRectMake(0, 0, 667, 375);
  MDCBottomDrawerViewController *viewController = [[MDCBottomDrawerViewController alloc] init];
  FakeBottomDrawerHeader *headerViewController = [[FakeBottomDrawerHeader alloc] init];
  headerViewController.view.backgroundColor = UIColor.blueColor;
  FakeBottomDrawerContent *contentViewController = [[FakeBottomDrawerContent alloc] init];
  contentViewController.view.backgroundColor = UIColor.greenColor;
  viewController.contentViewController = contentViewController;
  viewController.headerViewController = headerViewController;
  MDCBottomDrawerSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomDrawerSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.verticalSizeClassOverride = UIUserInterfaceSizeClassCompact;
  FakeBottomDrawerContainerViewController *container =
      [[FakeBottomDrawerContainerViewController alloc]
          initWithOriginalPresentingViewController:presentingViewController
                                trackingScrollView:nil];
  container.traitCollectionOverride = traitCollection;
  container.contentViewController = viewController.contentViewController;
  container.headerViewController = viewController.headerViewController;

  // When
  viewController.contentViewController.preferredContentSize = CGSizeMake(667, 1000);
  viewController.headerViewController.preferredContentSize = CGSizeMake(667, 80);
  [viewController.view addSubview:container.view];
  [viewController addChildViewController:container];
  viewController.view.bounds = CGRectMake(0, 0, 667, 375);

  // Then
  [self generateSnapshotAndVerifyForView:viewController.view];
}

@end
