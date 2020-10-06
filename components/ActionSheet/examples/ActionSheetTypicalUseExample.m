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
#import "MaterialTypographyScheme.h"

@interface ActionSheetTypicalUseExample : UIViewController <MDCActionSheetControllerDelegate>

@property(nonatomic, strong) MDCButton *showButton;
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation ActionSheetTypicalUseExample

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

  id<MDCColorScheming> colorScheme;
  if (self.containerScheme.colorScheme != nil) {
    colorScheme = self.containerScheme.colorScheme;
  } else {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }

  self.view.backgroundColor = colorScheme.backgroundColor;
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
      [MDCActionSheetAction actionWithTitle:@"Home"
                                      image:[UIImage imageNamed:@"ic_home"]
                                    handler:nil];
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
  actionSheet.delegate = self;
  self.actionSheet = actionSheet;
  [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - MDCActionSheetControllerDelegate
- (void)actionSheetControllerDidDismiss:(MDCActionSheetController *)actionSheetController {
  NSLog(@"Did dismiss");
}

- (void)actionSheetControllerDismissalAnimationCompleted:
    (MDCActionSheetController *)actionSheetController {
  NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end

@implementation ActionSheetTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Action Sheet", @"Action Sheet" ],
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation ActionSheetTypicalUseExample (SnapshotTestingByConvention)

- (void)testDefaults {
  // Given
  [self resetStates];
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme = containerScheme;

  // When
  [self showActionSheet];
}

- (void)testDynamic201907ColorScheme {
  // Given
  [self resetStates];
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
  self.containerScheme = containerScheme;

  // When
  [self showActionSheet];
}

- (void)resetStates {
  [self.actionSheet dismissViewControllerAnimated:NO completion:nil];
  self.actionSheet = nil;
}

@end
