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

#import <UIKit/UIKit.h>

#import "BottomSheetDummyStaticViewController.h"
#import "BottomSheetPresenterViewController.h"
#import "MaterialBottomSheet.h"

@interface BottomSheetSimpleExample : BottomSheetPresenterViewController
    <UIViewControllerTransitioningDelegate>
@end

@implementation BottomSheetSimpleExample

- (void)presentBottomSheet {
  BottomSheetDummyStaticViewController *viewController =
      [[BottomSheetDummyStaticViewController alloc] init];
  viewController.transitioningDelegate = self;
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  [self presentViewController:viewController animated:YES completion:nil];
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  MDCBottomSheetPresentationController *presentationController =
      [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                           presentingViewController:presenting];
  return presentationController;
}

@end

@implementation BottomSheetSimpleExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom Sheet", @"Static content" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end

@interface BottomSheetTallExample : BottomSheetPresenterViewController
    <UIViewControllerTransitioningDelegate>
@end

@implementation BottomSheetTallExample

- (void)presentBottomSheet {
  BottomSheetDummyStaticViewController *viewController =
      [[BottomSheetDummyStaticViewController alloc] init];
  viewController.transitioningDelegate = self;
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.preferredContentSize = CGSizeMake(0, self.view.frame.size.height * 0.75);
  [self presentViewController:viewController animated:YES completion:nil];
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  MDCBottomSheetPresentationController *presentationController =
  [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                       presentingViewController:presenting];
  return presentationController;
}

@end

@implementation BottomSheetTallExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom Sheet", @"Custom size static content" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
