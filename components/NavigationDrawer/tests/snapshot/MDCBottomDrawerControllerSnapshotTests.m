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
#import "supplemental/MDCBottomDrawerSnapshotTestMutableTraitCollection.h"
#import "MaterialNavigationDrawer.h"
#import "MaterialNavigationDrawer+Theming.h"

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
@interface MDCBottomDrawerFakeHeaderController : UIViewController <MDCBottomDrawerHeader>
@end

@implementation MDCBottomDrawerFakeHeaderController
@end

/** Fake view controller for the MDCBottomDrawer content for snapshot testing. */
@interface MDCBottomDrawerFakeContentController : UIViewController
@end

@implementation MDCBottomDrawerFakeContentController
@end

/** Snapshot tests for MDCBottomDrawerController's view. */
@interface MDCBottomDrawerControllerSnapshotTests : MDCSnapshotTestCase

/** The view controller of the snapshotted view. */
@property(nonatomic, strong) MDCBottomDrawerViewController *bottomDrawerViewController;

/** The container view controller for the header and content, used for mocking some properties. */
@property(nonatomic, strong) FakeBottomDrawerContainerViewController *containerViewController;

/** Presenting view controller of the Bottom Drawer Container view controller. */
@property(nonatomic, strong) UIViewController *presentingViewController;

/** A container scheme. */
@property(nonatomic, strong) MDCContainerScheme *containerScheme;

@end

@implementation MDCBottomDrawerControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
  MDCBottomDrawerFakeHeaderController *headerViewController =
      [[MDCBottomDrawerFakeHeaderController alloc] init];
  headerViewController.view.backgroundColor = UIColor.blueColor;
  MDCBottomDrawerFakeContentController *contentViewController =
      [[MDCBottomDrawerFakeContentController alloc] init];
  contentViewController.view.backgroundColor = UIColor.greenColor;
  self.bottomDrawerViewController.contentViewController = contentViewController;
  self.bottomDrawerViewController.headerViewController = headerViewController;
  self.presentingViewController = [[UIViewController alloc] init];
  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.bottomDrawerViewController = nil;
  self.containerViewController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testPresentedDrawerWithColoredViews {
  // Given
  self.presentingViewController.view.frame = CGRectMake(0, 0, 375, 667);
  self.containerViewController = [[FakeBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:self.presentingViewController
                            trackingScrollView:nil];
  self.containerViewController.contentViewController =
      self.bottomDrawerViewController.contentViewController;
  self.containerViewController.headerViewController =
      self.bottomDrawerViewController.headerViewController;

  // When
  self.bottomDrawerViewController.view.bounds = CGRectMake(0, 0, 375, 667);
  self.bottomDrawerViewController.contentViewController.preferredContentSize =
      CGSizeMake(375, 1000);
  self.bottomDrawerViewController.headerViewController.preferredContentSize = CGSizeMake(375, 80);
  [self.bottomDrawerViewController.view addSubview:self.containerViewController.view];
  [self.bottomDrawerViewController addChildViewController:self.containerViewController];

  // Then
  [self generateSnapshotAndVerifyForView:self.bottomDrawerViewController.view];
}

- (void)testPresentedDrawerWithTheming {
  // Given
  self.presentingViewController.view.frame = CGRectMake(0, 0, 375, 667);
  self.containerViewController = [[FakeBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:self.presentingViewController
                            trackingScrollView:nil];
  self.containerViewController.contentViewController =
      self.bottomDrawerViewController.contentViewController;
  self.containerViewController.headerViewController =
      self.bottomDrawerViewController.headerViewController;

  // When
  self.bottomDrawerViewController.view.bounds = CGRectMake(0, 0, 375, 667);
  self.bottomDrawerViewController.contentViewController.preferredContentSize =
      CGSizeMake(375, 1000);
  self.bottomDrawerViewController.headerViewController.preferredContentSize = CGSizeMake(375, 80);
  [self.bottomDrawerViewController.view addSubview:self.containerViewController.view];
  [self.bottomDrawerViewController addChildViewController:self.containerViewController];
  [self.bottomDrawerViewController applyThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.bottomDrawerViewController.view];
}

- (void)testPresentedDrawerWithThemingWith201907ColorSchemeDefaults {
  // Given
  MDCContainerScheme *tempContainerScheme = [[MDCContainerScheme alloc] init];
  tempContainerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
  self.presentingViewController.view.frame = CGRectMake(0, 0, 375, 667);
  self.containerViewController = [[FakeBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:self.presentingViewController
                            trackingScrollView:nil];
  self.containerViewController.contentViewController =
      self.bottomDrawerViewController.contentViewController;
  self.containerViewController.headerViewController =
      self.bottomDrawerViewController.headerViewController;

  // When
  self.bottomDrawerViewController.view.bounds = CGRectMake(0, 0, 375, 667);
  self.bottomDrawerViewController.contentViewController.preferredContentSize =
      CGSizeMake(375, 1000);
  self.bottomDrawerViewController.headerViewController.preferredContentSize = CGSizeMake(375, 80);
  [self.bottomDrawerViewController.view addSubview:self.containerViewController.view];
  [self.bottomDrawerViewController addChildViewController:self.containerViewController];
  [self.bottomDrawerViewController applyThemeWithScheme:tempContainerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.bottomDrawerViewController.view];
}

- (void)testPresentedDrawerWithColoredViewsWithVerticalSizeClassCompact {
  // Given
  self.presentingViewController.view.frame = CGRectMake(0, 0, 667, 375);
  self.containerViewController = [[FakeBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:self.presentingViewController
                            trackingScrollView:nil];
  self.containerViewController.contentViewController =
      self.bottomDrawerViewController.contentViewController;
  self.containerViewController.headerViewController =
      self.bottomDrawerViewController.headerViewController;

  MDCBottomDrawerSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomDrawerSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.verticalSizeClassOverride = UIUserInterfaceSizeClassCompact;
  self.containerViewController.traitCollectionOverride = traitCollection;
  self.containerViewController.contentViewController =
      self.bottomDrawerViewController.contentViewController;
  self.containerViewController.headerViewController =
      self.bottomDrawerViewController.headerViewController;

  // When
  self.bottomDrawerViewController.view.bounds = CGRectMake(0, 0, 667, 375);
  self.bottomDrawerViewController.contentViewController.preferredContentSize =
      CGSizeMake(667, 1000);
  self.bottomDrawerViewController.headerViewController.preferredContentSize = CGSizeMake(667, 80);
  [self.bottomDrawerViewController.view addSubview:self.containerViewController.view];
  [self.bottomDrawerViewController addChildViewController:self.containerViewController];

  // Then
  [self generateSnapshotAndVerifyForView:self.bottomDrawerViewController.view];
}

- (void)testPresentedDrawerWithShadowElevation {
  // Given
  self.presentingViewController.view.frame = CGRectMake(0, 0, 375, 667);
  self.containerViewController = [[FakeBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:self.presentingViewController
                            trackingScrollView:nil];
  self.containerViewController.contentViewController =
      self.bottomDrawerViewController.contentViewController;
  self.containerViewController.headerViewController =
      self.bottomDrawerViewController.headerViewController;
  self.containerViewController.contentViewController.view.backgroundColor = UIColor.whiteColor;
  self.containerViewController.headerViewController.view.backgroundColor = UIColor.whiteColor;

  // When
  self.containerViewController.drawerShadowColor = UIColor.blueColor;
  self.bottomDrawerViewController.view.bounds = CGRectMake(0, 0, 375, 667);
  self.bottomDrawerViewController.contentViewController.preferredContentSize =
      CGSizeMake(375, 1000);
  self.bottomDrawerViewController.headerViewController.preferredContentSize = CGSizeMake(375, 80);
  [self.bottomDrawerViewController addChildViewController:self.containerViewController];
  [self.bottomDrawerViewController.view addSubview:self.containerViewController.view];
  [self.containerViewController didMoveToParentViewController:self.bottomDrawerViewController];

  // Then
  [self generateSnapshotAndVerifyForView:self.bottomDrawerViewController.view];
}

@end
