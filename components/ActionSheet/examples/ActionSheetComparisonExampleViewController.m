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

#import "ActionSheetComparisonExampleViewController.h"

#import "MaterialActionSheet+Theming.h"
#import "MaterialActionSheet.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialButtons.h"

@interface ActionSheetComparisonExampleViewController ()

@property(nonatomic, strong) MDCButton *showMaterialButton;
@property(nonatomic, strong) MDCButton *showUIKitButton;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;

@end

@implementation ActionSheetComparisonExampleViewController {
  MDCButtonScheme *_buttonScheme;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"Action Sheet";
    _colorScheme = [[MDCSemanticColorScheme alloc] init];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
    _showMaterialButton = [[MDCButton alloc] init];
    _showUIKitButton = [[MDCButton alloc] init];
    _buttonScheme = [[MDCButtonScheme alloc] init];
  }
  return self;
}

- (MDCContainerScheme *)containerScheme {
  if (!_containerScheme) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  _containerScheme.colorScheme = self.colorScheme;
  _containerScheme.typographyScheme = self.typographyScheme;
  return _containerScheme;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = _colorScheme.backgroundColor;
  [_showMaterialButton setTitle:@"Show Material Action sheet" forState:UIControlStateNormal];
  [_showMaterialButton sizeToFit];
  [_showUIKitButton setTitle:@"Show UIKit Action sheet" forState:UIControlStateNormal];
  [_showUIKitButton sizeToFit];
  _buttonScheme.colorScheme = _colorScheme;
  _buttonScheme.typographyScheme = _typographyScheme;
  [MDCContainedButtonThemer applyScheme:_buttonScheme toButton:_showMaterialButton];
  [_showMaterialButton addTarget:self
                          action:@selector(showMaterialActionSheet)
                forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_showMaterialButton];
  [MDCContainedButtonThemer applyScheme:_buttonScheme toButton:_showUIKitButton];
  [_showUIKitButton addTarget:self
                       action:@selector(showUIKitActionSheet)
             forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_showUIKitButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  _showMaterialButton.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
  CGPoint UIKitCenter = _showMaterialButton.center;
  UIKitCenter.y += CGRectGetHeight(_showMaterialButton.frame) * 2;
  _showUIKitButton.center = UIKitCenter;
}

- (void)showMaterialActionSheet {
  MDCActionSheetController *actionSheet =
      [MDCActionSheetController actionSheetControllerWithTitle:@"Action Sheet Title"
                                                       message:@"Action Sheet Message"];
  MDCActionSheetAction *homeAction =
      [MDCActionSheetAction actionWithTitle:@"Home"
                                      image:[UIImage imageNamed:@"Home"]
                                    handler:^(MDCActionSheetAction *action) {
                                      NSLog(@"Home Action");
                                    }];
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

  [self presentViewController:alertController animated:YES completion:nil];
}

@end

@implementation ActionSheetComparisonExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Action Sheet", @"Material : UIKit Comparison" ],
    @"primaryDemo" : @YES,
    @"presentable" : @NO
  };
}

@end
