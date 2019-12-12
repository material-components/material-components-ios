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
#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialContainerScheme.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialDialogs.h"

static const CGFloat kCornerRadiusThemed = 3;
static const CGFloat kCornerRadiusUnthemed = 12;

@interface DialogsRoundedCornerSimpleController : UIViewController

@property(nonatomic, strong) MDCButton *dismissButton;

@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation DialogsRoundedCornerSimpleController

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.containerScheme == nil) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.dismissButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [self.dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  self.dismissButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [self.dismissButton addTarget:self
                         action:@selector(dismiss:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.dismissButton];

  [self.dismissButton applyTextThemeWithScheme:self.containerScheme];
  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_dismissButton sizeToFit];
  _dismissButton.center =
      CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (CGSize)preferredContentSize {
  return CGSizeMake(200.0, 140.0);
}

- (IBAction)dismiss:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end

@interface DialogsRoundedCornerExampleViewController () <MDCDialogPresentationControllerDelegate>

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation DialogsRoundedCornerExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.containerScheme == nil) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];

  MDCButton *presentButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [presentButton setTitle:[NSString stringWithFormat:@"Themed -- override radius to: %.1f",
                                                     kCornerRadiusThemed]
                 forState:UIControlStateNormal];
  [presentButton addTarget:self
                    action:@selector(didTapPresentThemed:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:presentButton];

  MDCButton *unthemedButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [unthemedButton setTitle:[NSString stringWithFormat:@"Un-Themed -- override radius to: %.1f",
                                                      kCornerRadiusUnthemed]
                  forState:UIControlStateNormal];
  [unthemedButton addTarget:self
                     action:@selector(didTapPresentDefault:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:unthemedButton];

  presentButton.translatesAutoresizingMaskIntoConstraints = NO;
  unthemedButton.translatesAutoresizingMaskIntoConstraints = NO;

  [self.view addConstraints:@[
    [NSLayoutConstraint constraintWithItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:presentButton
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:presentButton
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:(CGFloat)1.1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:unthemedButton
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:unthemedButton
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:(CGFloat)0.9
                                  constant:0],
  ]];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  [presentButton applyTextThemeWithScheme:self.containerScheme];
  [unthemedButton applyTextThemeWithScheme:self.containerScheme];
}

// Theming the presentation controller, and manually overriding
// the default corner radius set by the themer,
- (IBAction)didTapPresentThemed:(id)sender {
  DialogsRoundedCornerSimpleController *viewController =
      [[DialogsRoundedCornerSimpleController alloc] initWithNibName:nil bundle:nil];

  // Make sure to store a strong reference to the transitionController.
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.containerScheme = self.containerScheme;

  MDCDialogPresentationController *controller = viewController.mdc_dialogPresentationController;
  controller.dialogPresentationControllerDelegate = self;

  // Apply a presentation theme, which, among other things, sets the dialog's corner radius to 4.
  [controller applyThemeWithScheme:self.containerScheme];

  // To override the corner radius set by the themer, update the presentation controller's radius.
  // The following line will override the value set by the themer, setting 6.0 as the final value:
  viewController.mdc_dialogPresentationController.dialogCornerRadius = kCornerRadiusThemed;

  // Do not set the corner radius directly on the view if applying a presentation controller
  // themer. This next line is ignored bcasue applyThemeWithScheme: takes precedence:
  viewController.view.layer.cornerRadius = 24.0;  // AVOID!

  [self presentViewController:viewController animated:YES completion:nil];
}

// NOT theming the presentation controller, while manually setting the corner radius
- (IBAction)didTapPresentDefault:(id)sender {
  DialogsRoundedCornerSimpleController *viewController =
      [[DialogsRoundedCornerSimpleController alloc] initWithNibName:nil bundle:nil];

  // Make sure to store a strong reference to the transitionController.
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.containerScheme = self.containerScheme;

  // Setting the presented dialog's corner radius on an un-themed dialog is ok:
  viewController.view.layer.cornerRadius = kCornerRadiusUnthemed;  // OK!

  [self presentViewController:viewController animated:YES completion:nil];
}

- (void)dialogPresentationControllerDidDismiss:
    (MDCDialogPresentationController *)dialogPresentationController {
  NSLog(@"You just dismissed a dialog with rounded corners");
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Dialogs", @"Dialog with Rounded Corners" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
