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

#import "MaterialButtons+Theming.h"
#import "MaterialCollections.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialDialogs.h"
#import "MaterialTypographyScheme.h"

#pragma mark - DialogsTypicalUseExampleViewController

@interface DialogsTypicalUseExampleViewController : UIViewController
@property(nonatomic, strong, nullable) id<MDCContainerScheming> containerScheme;
@property(nonatomic, strong, nullable) NSArray *modes;
@property(nonatomic, strong, nullable) MDCButton *button;
@end

@implementation DialogsTypicalUseExampleViewController

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

  id<MDCColorScheming> colorScheme =
      self.containerScheme.colorScheme
          ?: [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.view.backgroundColor = colorScheme.backgroundColor;

  MDCButton *dismissButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  self.button = dismissButton;
  dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
  [dismissButton setTitle:@"Show Alert Dialog" forState:UIControlStateNormal];
  [dismissButton addTarget:self
                    action:@selector(showAlert:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:dismissButton];

  [dismissButton applyTextThemeWithScheme:self.containerScheme];

  [self.view addConstraints:@[
    [NSLayoutConstraint constraintWithItem:dismissButton
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0],
    [NSLayoutConstraint constraintWithItem:dismissButton
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0]
  ]];
}

- (void)showAlert:(UIButton *)button {
  NSString *titleString = @"Reset Settings?";
  NSString *messageString = @"This will reset your device to its default factory settings.";

  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:titleString
                                                                   message:messageString];
  alert.mdc_adjustsFontForContentSizeCategory = YES;
  alert.enableRippleBehavior = YES;
  MDCActionHandler handler = ^(MDCAlertAction *action) {
    NSLog(@"action pressed: %@", action.title);
  };

  MDCAlertAction *agreeAaction = [MDCAlertAction actionWithTitle:@"Cancel"
                                                        emphasis:MDCActionEmphasisLow
                                                         handler:handler];
  [alert addAction:agreeAaction];

  MDCAlertAction *disagreeAaction = [MDCAlertAction actionWithTitle:@"Accept"
                                                           emphasis:MDCActionEmphasisLow
                                                            handler:handler];
  [alert addAction:disagreeAaction];
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
