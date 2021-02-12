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

#import "MaterialActionSheet+Theming.h"
#import "MaterialActionSheet.h"
#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

@interface ActionSheetComparisonExample : UIViewController

@property(nonatomic, strong) MDCButton *showMaterialButton;
@property(nonatomic, strong) MDCButton *showUIKitButton;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation ActionSheetComparisonExample

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"Action Sheet";
    _containerScheme = [[MDCContainerScheme alloc] init];
    _showMaterialButton = [[MDCButton alloc] init];
    _showUIKitButton = [[MDCButton alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  id<MDCColorScheming> colorScheme;
  if (self.containerScheme.colorScheme != nil) {
    colorScheme = self.containerScheme.colorScheme;
  } else {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }

  self.view.backgroundColor = colorScheme.backgroundColor;
  [self.showMaterialButton setTitle:@"Show Material Action sheet" forState:UIControlStateNormal];
  [self.showMaterialButton sizeToFit];
  [self.showUIKitButton setTitle:@"Show UIKit Action sheet" forState:UIControlStateNormal];
  [self.showUIKitButton sizeToFit];
  [self.showMaterialButton applyContainedThemeWithScheme:self.containerScheme];
  [self.showMaterialButton addTarget:self
                              action:@selector(showMaterialActionSheet)
                    forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.showMaterialButton];
  [self.showUIKitButton applyContainedThemeWithScheme:self.containerScheme];
  [self.showUIKitButton addTarget:self
                           action:@selector(showUIKitActionSheet)
                 forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.showUIKitButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.showMaterialButton.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
  CGPoint UIKitCenter = self.showMaterialButton.center;
  UIKitCenter.y += CGRectGetHeight(self.showMaterialButton.frame) * 2;
  self.showUIKitButton.center = UIKitCenter;
}

- (void)showMaterialActionSheet {
  MDCActionSheetController *actionSheet =
      [MDCActionSheetController actionSheetControllerWithTitle:@"Action Sheet Title"
                                                       message:@"Action Sheet Message"];
  MDCActionSheetAction *homeAction =
      [MDCActionSheetAction actionWithTitle:@"Home"
                                      image:[UIImage imageNamed:@"ic_home"]
                                    handler:^(MDCActionSheetAction *action) {
                                      NSLog(@"Home Action");
                                    }];
  MDCActionSheetAction *favoriteAction =
      [MDCActionSheetAction actionWithTitle:@"Favorite"
                                      image:[UIImage imageNamed:@"ic_favorite"]
                                    handler:^(MDCActionSheetAction *action) {
                                      NSLog(@"Favorite Action");
                                    }];
  MDCActionSheetAction *emailAction =
      [MDCActionSheetAction actionWithTitle:@"Email"
                                      image:[UIImage imageNamed:@"ic_email"]
                                    handler:^(MDCActionSheetAction *action) {
                                      NSLog(@"Email Action");
                                    }];
  [actionSheet addAction:homeAction];
  [actionSheet addAction:favoriteAction];
  [actionSheet addAction:emailAction];
  [actionSheet applyThemeWithScheme:self.containerScheme];
  [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showUIKitActionSheet {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"Alert Title"
                                          message:@"Alert Message"
                                   preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction *homeAction = [UIAlertAction actionWithTitle:@"Home"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
  [alertController addAction:homeAction];
  UIAlertAction *favoriteAction = [UIAlertAction actionWithTitle:@"Favorite"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
  [alertController addAction:favoriteAction];
  UIAlertAction *emailAction = [UIAlertAction actionWithTitle:@"Email"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil];
  [alertController addAction:emailAction];
  if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    alertController.popoverPresentationController.sourceView = self.showUIKitButton;
  }
  [self presentViewController:alertController animated:YES completion:nil];
}

@end

@implementation ActionSheetComparisonExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Action Sheet", @"Material : UIKit Comparison" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO
  };
}

@end
