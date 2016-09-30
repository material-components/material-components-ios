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

#import "DialogsTypicalUseSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialDialogs.h"

@interface DialogsTypicalUseViewController ()

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

@end

@implementation DialogsTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];
}

- (IBAction)didTapProgrammatic:(id)sender {
  UIViewController *viewController =
      [[ProgrammaticViewController alloc] initWithNibName:nil bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)didTapModalProgrammatic:(id)sender {
  UIViewController *viewController =
      [[ProgrammaticViewController alloc] initWithNibName:nil bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  [self presentViewController:viewController animated:YES completion:NULL];

  MDCDialogPresentationController *presentationController =
      viewController.mdc_dialogPresentationController;
  if (presentationController) {
    presentationController.dismissOnBackgroundTap = NO;
  }
}

- (IBAction)didTapStoryboard:(id)sender {
  // If you are using this code outside of the MDCCatalog in your own app, your bundle may be nil.
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  UIStoryboard *storyboard =
      [UIStoryboard storyboardWithName:@"DialogWithPreferredContentSize" bundle:bundle];
  NSString *identifier = @"DialogID";

  UIViewController *viewController =
      [storyboard instantiateViewControllerWithIdentifier:identifier];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  [self presentViewController:viewController animated:YES completion:NULL];
}

@end
