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

#import "DialogsRoundedCornerExampleViewController.h"
#import "MaterialButtons.h"
#import "MaterialDialogs.h"

@interface DialogsRoundedCornerSimpleController : UIViewController

@property(nonatomic, strong) MDCFlatButton *dismissButton;

@end

@implementation DialogsRoundedCornerSimpleController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _dismissButton = [[MDCFlatButton alloc] initWithFrame:CGRectZero];
  [_dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [_dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  _dismissButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin |
      UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin |
      UIViewAutoresizingFlexibleBottomMargin;
  [_dismissButton addTarget:self
                     action:@selector(dismiss:)
           forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:_dismissButton];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_dismissButton sizeToFit];
  _dismissButton.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                      CGRectGetMidY(self.view.bounds));
}

- (CGSize)preferredContentSize {
  return CGSizeMake(200.0, 140.0);
}

- (IBAction)dismiss:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end


@interface DialogsRoundedCornerExampleViewController ()

@property(nonatomic, strong) MDCFlatButton *presentButton;
@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

@end

@implementation DialogsRoundedCornerExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];

  self.view.backgroundColor = [UIColor whiteColor];

  _presentButton = [[MDCFlatButton alloc] initWithFrame:CGRectZero];
  [_presentButton setTitle:@"Present" forState:UIControlStateNormal];
  [_presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  _presentButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin |
      UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin |
      UIViewAutoresizingFlexibleBottomMargin;
  [_presentButton addTarget:self
                     action:@selector(didTapPresent:)
           forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:_presentButton];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_presentButton sizeToFit];
  _presentButton.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                      CGRectGetMidY(self.view.bounds));
}

- (IBAction)didTapPresent:(id)sender {
  DialogsRoundedCornerSimpleController *viewController =
      [[DialogsRoundedCornerSimpleController alloc] initWithNibName:nil bundle:nil];

  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  // sets the dialog's corner radius
  viewController.view.layer.cornerRadius = 24;

  // ensure shadow/tracking layer matches the dialog's corner radius
  MDCDialogPresentationController *controller = viewController.mdc_dialogPresentationController;
  controller.dialogCornerRadius = viewController.view.layer.cornerRadius;

  [self presentViewController:viewController animated:YES completion:NULL];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Dialogs", @"Dialog with Rounded Corners" ],
    @"primaryDemo": @NO,
    @"presentable": @NO,
  };
}

@end
