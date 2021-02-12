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

#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialDialogs.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

static NSString *const kTitleString = @"Reset Settings?";
static NSString *const kMessageString =
    @"This will reset your device to its default factory settings.";

#pragma mark - DialogsTypicalUseExampleViewController

@interface DialogsTypicalUseExampleViewController : UIViewController
@property(nonatomic, strong, nullable) id<MDCContainerScheming> containerScheme;
@end

@implementation DialogsTypicalUseExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
    scheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
    scheme.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
    _containerScheme = scheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  MDCButton *defaultButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  defaultButton.translatesAutoresizingMaskIntoConstraints = NO;
  [defaultButton setTitle:@"Material Alert" forState:UIControlStateNormal];
  [defaultButton addTarget:self
                    action:@selector(showMaterialAlert:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:defaultButton];

  [defaultButton applyTextThemeWithScheme:self.containerScheme];

  MDCButton *emphasisButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  emphasisButton.translatesAutoresizingMaskIntoConstraints = NO;
  [emphasisButton setTitle:@"Material Alert With Styled Actions" forState:UIControlStateNormal];
  [emphasisButton addTarget:self
                     action:@selector(showStyledActionsAlert:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:emphasisButton];

  [emphasisButton applyTextThemeWithScheme:self.containerScheme];

  [self.view.centerXAnchor constraintEqualToAnchor:defaultButton.centerXAnchor].active = YES;
  [self.view.centerYAnchor constraintEqualToAnchor:defaultButton.centerYAnchor].active = YES;
  [self.view.centerXAnchor constraintEqualToAnchor:emphasisButton.centerXAnchor].active = YES;
  [emphasisButton.topAnchor constraintEqualToAnchor:defaultButton.bottomAnchor constant:8.0f]
      .active = YES;
}

- (void)showMaterialAlert:(UIButton *)button {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:kTitleString
                                                                   message:kMessageString];
  alert.mdc_adjustsFontForContentSizeCategory = YES;
  alert.enableRippleBehavior = YES;
  MDCActionHandler handler = ^(MDCAlertAction *action) {
    NSLog(@"action pressed: %@", action.title);
  };

  [alert addAction:[MDCAlertAction actionWithTitle:@"Accept" handler:handler]];
  [alert addAction:[MDCAlertAction actionWithTitle:@"Cancel" handler:handler]];

  [alert applyThemeWithScheme:self.containerScheme];
  [self presentViewController:alert animated:YES completion:NULL];
}

- (void)showStyledActionsAlert:(UIButton *)button {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:kTitleString
                                                                   message:kMessageString];
  alert.mdc_adjustsFontForContentSizeCategory = YES;
  alert.enableRippleBehavior = YES;
  MDCActionHandler handler = ^(MDCAlertAction *action) {
    NSLog(@"action pressed: %@", action.title);
  };

  [alert addAction:[MDCAlertAction actionWithTitle:@"Accept"
                                          emphasis:MDCActionEmphasisHigh
                                           handler:handler]];
  [alert addAction:[MDCAlertAction actionWithTitle:@"Cancel"
                                          emphasis:MDCActionEmphasisMedium
                                           handler:handler]];

  [alert applyThemeWithScheme:self.containerScheme];
  [self presentViewController:alert animated:YES completion:NULL];
}

@end

#pragma mark - DialogsTypicalUseExampleViewController - CatalogByConvention

@implementation DialogsTypicalUseExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Dialogs", @"Dialogs (Catalog)" ],
    @"description" : @"Dialogs inform users about a task and can contain critical information, "
                     @"require decisions, or involve multiple tasks.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation DialogsTypicalUseExampleViewController (SnapshotTestingByConvention)

- (void)testPresented {
  if (self.presentedViewController) {
    [self dismissViewControllerAnimated:NO completion:nil];
  }
  [self showMaterialAlert:nil];
}

- (void)testActionEmphasis {
  if (self.presentedViewController) {
    [self dismissViewControllerAnimated:NO completion:nil];
  }
  [self showStyledActionsAlert:nil];
}

@end
