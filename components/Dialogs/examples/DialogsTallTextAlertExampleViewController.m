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

#import <MaterialComponents/MaterialContainerScheme.h>
#import <MaterialComponents/MaterialDialogs+Theming.h>
#import "MDCAlertController+ButtonForAction.h"
#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialDialogs.h"

@interface DialogsTallTextAlertExampleViewController : UIViewController

@end

@interface DialogsTallTextAlertExampleViewController () <MDCDialogPresentationControllerDelegate>

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end
@implementation DialogsTallTextAlertExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];

  MDCButton *presentButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [presentButton setTitle:[NSString stringWithFormat:@"Dialog with large Urdu text"]
                 forState:UIControlStateNormal];
  [presentButton addTarget:self
                    action:@selector(didTapPresent:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:presentButton];
  presentButton.translatesAutoresizingMaskIntoConstraints = NO;
  [presentButton applyOutlinedThemeWithScheme:self.containerScheme];

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
                                multiplier:1
                                  constant:0],
  ]];
}

- (IBAction)didTapPresent:(id)sender {
  NSString *networkFailureInUrdu = @"براہ کرم اپنا نیٹ ورک کنکشن چیک کریں اور دوبارہ کوشش کریں۔";
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:nil
                                                                   message:networkFailureInUrdu];

  MDCAlertAction *retryAction = [MDCAlertAction actionWithTitle:@"دوبارہ کوشش کریں" handler:nil];
  MDCAlertAction *cancelAction = [MDCAlertAction actionWithTitle:@"منسوخ کریں" handler:nil];
  [alert addAction:retryAction];
  [alert addAction:cancelAction];
  [alert applyThemeWithScheme:self.containerScheme];

  NSString *urduFontName = @"NotoNastaliqUrdu";
  UIFont *dialogBodyFont = [UIFont systemFontOfSize:20.0];
  UIFont *dialogButtonFont = [UIFont systemFontOfSize:20.0];
  // Noto Nastaliq Urdu was added in iOS 11, and is an extremely tall
  // font for any given nominal point size.
  dialogBodyFont = [UIFont fontWithName:urduFontName size:20.0];
  dialogButtonFont = [UIFont fontWithName:urduFontName size:20.0];
  alert.messageFont = dialogBodyFont;
  MDCButton *buttonForRetryAction = [alert buttonForAction:retryAction];
  buttonForRetryAction.titleLabel.font = dialogButtonFont;
  MDCButton *buttonForCancelAction = [alert buttonForAction:cancelAction];
  buttonForCancelAction.titleLabel.font = dialogButtonFont;

  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Dialogs", @"Dialog with Tall Text" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation DialogsTallTextAlertExampleViewController (SnapshotTestingByConvention)

- (void)testPresented {
  if (self.presentedViewController) {
    [self dismissViewControllerAnimated:NO completion:nil];
  }
  [self didTapPresent:nil];
}

@end
