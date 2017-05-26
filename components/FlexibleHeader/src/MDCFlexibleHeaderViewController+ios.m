/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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
#if TARGET_OS_IOS

#import "MDCFlexibleHeaderViewController.h"

#import "MDCFlexibleHeaderView.h"
#import "MDFTextAccessibility.h"

static inline BOOL ShouldUseLightStatusBarOnBackgroundColor(UIColor *color) {
  if (CGColorGetAlpha(color.CGColor) < 1) {
    return NO;
  }

  // We assume that the light iOS status text is white and not big enough to be considered "large"
  // text according to the W3CAG 2.0 spec.
  return [MDFTextAccessibility textColor:[UIColor whiteColor]
                 passesOnBackgroundColor:color
                                 options:MDFTextAccessibilityOptionsNone];
}

@implementation MDCFlexibleHeaderViewController (iOS)

- (UIStatusBarStyle)preferredStatusBarStyle {
  return (ShouldUseLightStatusBarOnBackgroundColor(self.headerView.backgroundColor)
              ? UIStatusBarStyleLightContent
              : UIStatusBarStyleDefault);
}

- (BOOL)prefersStatusBarHidden {
  return self.headerView.prefersStatusBarHidden;
}

// Only include this logic when supporting pre-iOS 8 devices.
#if !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
  [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

  // Check if we're on iOS 8 and above and the new method will be called.
  if (![UIViewController instancesRespondToSelector:@selector(viewWillTransitionToSize:
                                                             withTransitionCoordinator:)]) {
    [_headerView interfaceOrientationWillChange];
  }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

  // Check if we're on iOS 8 and above and the new method will be called.
  if (![UIViewController instancesRespondToSelector:@selector(viewWillTransitionToSize:
                                                             withTransitionCoordinator:)]) {
    [_headerView interfaceOrientationIsChanging];
  }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

  // Check if we're on iOS 8 and above and the new method will be called.
  if (![UIViewController instancesRespondToSelector:@selector(viewWillTransitionToSize:
                                                             withTransitionCoordinator:)]) {
    [_headerView interfaceOrientationDidChange];
  }
}

#endif  // #if !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)

@end

#endif // #if TARGET_OS_IOS
