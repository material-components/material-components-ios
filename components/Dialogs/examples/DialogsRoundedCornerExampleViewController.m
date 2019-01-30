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
#import "MaterialDialogs+Theming.h"
#import "MaterialDialogs.h"

@interface DialogsRoundedCornerSimpleController : UIViewController

@property(nonatomic, strong) MDCButton *dismissButton;

@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation DialogsRoundedCornerSimpleController

- (void)viewDidLoad {
  [super viewDidLoad];

  id<MDCColorScheming> colorScheme =
      self.containerScheme.colorScheme
          ?: [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.view.backgroundColor = colorScheme.backgroundColor;

  self.dismissButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [self.dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  self.dismissButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [self.dismissButton addTarget:self
                         action:@selector(dismiss:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.dismissButton applyTextThemeWithScheme:self.containerScheme];
  [self.view addSubview:self.dismissButton];
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

@interface DialogsRoundedCornerExampleViewController ()

@property(nonatomic, strong) MDCButton *presentButton;
@property(nonatomic, strong) MDCDialogTransitionController *transitionController;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation DialogsRoundedCornerExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
    scheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _containerScheme = scheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];

  id<MDCColorScheming> colorScheme =
      self.containerScheme.colorScheme
          ?: [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.view.backgroundColor = colorScheme.backgroundColor;

  self.presentButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [self.presentButton setTitle:@"Present" forState:UIControlStateNormal];
  [self.presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  self.presentButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [self.presentButton addTarget:self
                         action:@selector(didTapPresent:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.presentButton applyTextThemeWithScheme:self.containerScheme];
  [self.view addSubview:self.presentButton];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_presentButton sizeToFit];
  _presentButton.center =
      CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
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
  [controller applyThemeWithScheme:self.containerScheme];

  [self presentViewController:viewController animated:YES completion:nil];
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
