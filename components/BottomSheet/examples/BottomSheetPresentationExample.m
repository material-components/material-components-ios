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

#import <UIKit/UIKit.h>

#import "MaterialBottomSheet.h"
#import "MaterialButtons.h"
#import "supplemental/BottomSheetDummyStaticViewController.h"
#import "supplemental/BottomSheetSupplemental.h"

@interface PresentedSheetController : UIViewController
@end

@implementation PresentedSheetController {
  NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>
      *_transitionController;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    MDCBottomSheetTransitionController *transitionController =
        [[MDCBottomSheetTransitionController alloc] init];
    transitionController.dismissOnBackgroundTap = YES;
    _transitionController = transitionController;
    self.transitioningDelegate = _transitionController;
    self.modalPresentationStyle = UIModalPresentationCustom;

    self.view.backgroundColor = UIColor.purpleColor;
    self.view.isAccessibilityElement = YES;
    self.view.accessibilityLabel = @"Example content";
  }
  return self;
}

- (CGSize)preferredContentSize {
  return CGSizeMake(300, 150);
}

@end

@interface PresentedPresenter : BottomSheetPresenterViewController
@end

@implementation PresentedPresenter

- (void)presentBottomSheet {
  PresentedSheetController *bottomSheet = [[PresentedSheetController alloc] init];
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end

@implementation BottomSheetPresentationExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.button setTitle:@"Present Modal Controller" forState:UIControlStateNormal];
}

- (void)presentBottomSheet {
  PresentedPresenter *presenter = [[PresentedPresenter alloc] init];

  UINavigationController *navController =
      [[UINavigationController alloc] initWithRootViewController:presenter];
  presenter.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(exit)];
  navController.modalPresentationStyle = UIModalPresentationFormSheet;
  [self presentViewController:navController animated:YES completion:nil];
}

- (void)exit {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
