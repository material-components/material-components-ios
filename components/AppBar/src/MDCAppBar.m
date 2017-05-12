/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCAppBar.h"

#import "MDCAppBarContainerViewController.h"
#import "MDCAppBarViewController.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "private/MaterialAppBarStrings.h"
#import "private/MaterialAppBarStrings_table.h"

static NSString *const MDCAppBarHeaderViewControllerKey = @"MDCAppBarHeaderViewControllerKey";
static NSString *const MDCAppBarNavigationBarKey = @"MDCAppBarNavigationBarKey";
static NSString *const MDCAppBarHeaderStackViewKey = @"MDCAppBarHeaderStackViewKey";

// The Bundle for string resources.
static NSString *const kMaterialAppBarBundle = @"MaterialAppBar.bundle";

@interface MDCAppBar ()

@property(nonatomic, strong) MDCAppBarViewController *appBarController;

@end

@implementation MDCAppBar

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCAppBarInit];
    [self commonMDCAppBarViewSetup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCAppBarInit];
    if ([aDecoder containsValueForKey:MDCAppBarHeaderViewControllerKey]) {
      _headerViewController = [aDecoder decodeObjectForKey:MDCAppBarHeaderViewControllerKey];
    }

    if ([aDecoder containsValueForKey:MDCAppBarNavigationBarKey]) {
      _navigationBar = [aDecoder decodeObjectForKey:MDCAppBarNavigationBarKey];
      _appBarController.navigationBar = _navigationBar;
    }

    if ([aDecoder containsValueForKey:MDCAppBarHeaderStackViewKey]) {
      _headerStackView = [aDecoder decodeObjectForKey:MDCAppBarHeaderStackViewKey];
      _appBarController.headerStackView = _headerStackView;
    }

    [self commonMDCAppBarViewSetup];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.headerViewController forKey:MDCAppBarHeaderViewControllerKey];
  [aCoder encodeObject:self.navigationBar forKey:MDCAppBarNavigationBarKey];
  [aCoder encodeObject:self.headerStackView forKey:MDCAppBarHeaderStackViewKey];
}

- (void)commonMDCAppBarInit {
  _headerViewController = [[MDCFlexibleHeaderViewController alloc] init];

  // Shadow layer
  MDCFlexibleHeaderView *headerView = _headerViewController.headerView;
  MDCFlexibleHeaderShadowIntensityChangeBlock intensityBlock =
      ^(CALayer *_Nonnull shadowLayer, CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        [(MDCShadowLayer *)shadowLayer setElevation:elevation];
      };
  [headerView setShadowLayer:[MDCShadowLayer layer] intensityDidChangeBlock:intensityBlock];
  _appBarController = [[MDCAppBarViewController alloc] init];
  _headerStackView = _appBarController.headerStackView;
  _navigationBar = _appBarController.navigationBar;
}

- (void)commonMDCAppBarViewSetup {
  [_headerViewController addChildViewController:_appBarController];
  _appBarController.view.frame = _headerViewController.view.bounds;
  [_headerViewController.view addSubview:_appBarController.view];
  [_appBarController didMoveToParentViewController:_headerViewController];

  [_headerViewController.headerView forwardTouchEventsForView:_appBarController.headerStackView];
  [_headerViewController.headerView forwardTouchEventsForView:_appBarController.navigationBar];
}

- (void)addHeaderViewControllerToParentViewController:
        (nonnull UIViewController *)parentViewController {
  [parentViewController addChildViewController:_headerViewController];
}

- (void)addSubviewsToParent {
  MDCFlexibleHeaderViewController *fhvc = self.headerViewController;
  NSAssert(fhvc.parentViewController,
           @"headerViewController does not have a parentViewController. "
           @"Use [self addChildViewController:appBar.headerViewController]. "
           @"This warning only appears in DEBUG builds");
  if (fhvc.view.superview == fhvc.parentViewController.view) {
    return;
  }

  // Enforce the header's desire to fully cover the width of its parent view.
  CGRect frame = fhvc.view.frame;
  frame.origin.x = 0;
  frame.size.width = fhvc.parentViewController.view.bounds.size.width;
  fhvc.view.frame = frame;

  [fhvc.parentViewController.view addSubview:fhvc.view];
  [fhvc didMoveToParentViewController:fhvc.parentViewController];

  [self.navigationBar observeNavigationItem:fhvc.parentViewController.navigationItem];
}

@end
