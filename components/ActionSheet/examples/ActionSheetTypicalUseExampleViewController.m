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

#import "ActionSheetTypicalUseExampleViewController.h"

#import "MaterialActionSheet.h"
#import "MaterialActionSheet+Theming.h"
#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

@interface ActionSheetTypicalUseExampleViewController ()

@property(nonatomic, strong) MDCButton *showButton;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;

@end

@implementation ActionSheetTypicalUseExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"Action Sheet";
    _containerScheme = [[MDCContainerScheme alloc] init];
    _showButton = [[MDCButton alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.containerScheme.colorScheme == nil) {
    self.containerScheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];;
  }

  if (self.containerScheme.typographyScheme == nil) {
    self.containerScheme.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  [self.showButton setTitle:@"Show action sheet" forState:UIControlStateNormal];
  [self.showButton sizeToFit];
  [self.showButton applyContainedThemeWithScheme:self.containerScheme];
  [self.showButton addTarget:self
                  action:@selector(showActionSheet)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.showButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.showButton.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
}

- (void)showActionSheet {
  MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
  MDCActionSheetAction *homeAction =
      [MDCActionSheetAction actionWithTitle:@"Home" image:[UIImage imageNamed:@"Home"] handler:nil];
  MDCActionSheetAction *favoriteAction =
      [MDCActionSheetAction actionWithTitle:@"Favorite"
                                      image:[UIImage imageNamed:@"Favorite"]
                                    handler:^(MDCActionSheetAction *action) {
                                      NSLog(@"Favorite Action");
                                    }];
  MDCActionSheetAction *emailAction =
      [MDCActionSheetAction actionWithTitle:@"Email"
                                      image:[UIImage imageNamed:@"Email"]
                                    handler:^(MDCActionSheetAction *action) {
                                      NSLog(@"Email Action");
                                    }];
  [actionSheet addAction:homeAction];
  [actionSheet addAction:favoriteAction];
  [actionSheet addAction:emailAction];
  [actionSheet applyThemeWithScheme:self.containerScheme];
  [self presentViewController:actionSheet animated:YES completion:nil];
}

@end

@implementation ActionSheetTypicalUseExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Action Sheet", @"Action Sheet" ],
    @"primaryDemo" : @YES,
    @"presentable" : @NO
  };
}

@end
