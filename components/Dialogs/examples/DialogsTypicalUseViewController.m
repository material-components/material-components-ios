// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialDialogs.h"
#import "supplemental/DialogsTypicalUseSupplemental.h"
#import "supplemental/DialogWithPreferredContentSizeViewController.h"

@interface DialogsTypicalUseViewController ()

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

@end

@implementation DialogsTypicalUseViewController

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCollectionView:@[@"Dismissable Programmatic", @"Dismissable Storyboard",
                             @"Non-dismissable Programmatic", @"Open URL"]];
  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  if (indexPath.row == 0) {
    [self didTapProgrammatic];
  } else if (indexPath.row == 1) {
    [self didTapStoryboard];
  } else if (indexPath.row == 2) {
    [self didTapModalProgrammatic];
  } else if (indexPath.row == 3) {
    [self didTapOpenURL];
  }
}

- (IBAction)didTapProgrammatic {
  UIViewController *viewController =
      [[ProgrammaticViewController alloc] initWithNibName:nil bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)didTapModalProgrammatic {
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

- (IBAction)didTapOpenURL {
  UIViewController *viewController =
    [[OpenURLViewController alloc] initWithNibName:nil bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)didTapStoryboard {
  // If you are using this code outside of the MDCCatalog in your own app, your bundle may be nil.
  NSBundle *bundle = [NSBundle bundleForClass:[DialogsTypicalUseViewController class]];
  UIStoryboard *storyboard =
      [UIStoryboard storyboardWithName:@"DialogWithPreferredContentSize" bundle:bundle];
  NSString *identifier = @"DialogID";

  DialogWithPreferredContentSizeViewController *viewController =
      [storyboard instantiateViewControllerWithIdentifier:identifier];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.colorScheme = self.colorScheme;
  viewController.typographyScheme = self.typographyScheme;
  [self presentViewController:viewController animated:YES completion:NULL];
}

@end
