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

#import "ActionSheetTypicalUse.h"

#import "MaterialActionSheet+ActionSheetThemer.h"
#import "MaterialButtons+ButtonThemer.h"
#import <MaterialComponents/MaterialButtons.h>

@interface ActionSheetTypicalUse ()

@property(nonatomic, strong) MDCButton *showButton;

@end

@implementation ActionSheetTypicalUse {
  MDCButtonScheme *_buttonScheme;
  MDCActionSheetScheme *_actionSheetScheme;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"Action Sheet";
    _colorScheme = [[MDCSemanticColorScheme alloc] init];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
    _showButton = [[MDCButton alloc] init];
    _buttonScheme = [[MDCButtonScheme alloc] init];
    _actionSheetScheme = [[MDCActionSheetScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = _colorScheme.backgroundColor;
  [_showButton setTitle:@"Show action sheet" forState:UIControlStateNormal];
  [_showButton sizeToFit];
  _buttonScheme.colorScheme = _colorScheme;
  _buttonScheme.typographyScheme = _typographyScheme;
  [MDCContainedButtonThemer applyScheme:_buttonScheme toButton:_showButton];
  [_showButton addTarget:self
                  action:@selector(showActionSheet)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_showButton];

  _actionSheetScheme.colorScheme = self.colorScheme;
  _actionSheetScheme.typographyScheme = self.typographyScheme;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  _showButton.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
}



- (void)showActionSheet {
  MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
  MDCActionSheetAction *homeAction = [MDCActionSheetAction actionWithTitle:@"Home"
                                                                 image:[UIImage imageNamed:@"Home"]
                                                               handler:nil];
  MDCActionSheetAction *favoriteAction =
      [MDCActionSheetAction actionWithTitle:@"Favorite"
                                      image:[UIImage imageNamed:@"Favorite"]
                                    handler:^(MDCActionSheetAction *action){
                                      NSLog(@"Favorite Action");
                                    }];
  MDCActionSheetAction *emailAction =
      [MDCActionSheetAction actionWithTitle:@"Email"
                                      image:[UIImage imageNamed:@"Email"]
                                    handler:^(MDCActionSheetAction *action){
                                      NSLog(@"Email Action");
                                    }];
  [actionSheet addAction:homeAction];
  [actionSheet addAction:favoriteAction];
  [actionSheet addAction:emailAction];
  [MDCActionSheetThemer applyScheme:_actionSheetScheme toActionSheetController:actionSheet];
  [self presentViewController:actionSheet animated:YES completion:nil];
}

@end

@implementation ActionSheetTypicalUse (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Action Sheet", @"Action Sheet" ],
    @"primaryDemo" : @YES,
    @"presentable" : @NO
  };
}

@end
