// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MaterialCollections.h"
#import "MaterialColorScheme.h"
#import "MaterialSnackbar.h"
#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

@interface SnackbarExample : MDCCollectionViewController
@property(nonatomic) NSArray *choices;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

- (void)setupExampleViews:(NSArray *)choices;
@end

@interface SnackbarOverlayViewExample : SnackbarExample

/** The floating action button shown in the bottom right corner. */
@property(nonatomic) MDCFloatingButton *floatingButton;

@property(nonatomic) UIView *bottomBar;

@property(nonatomic) BOOL isShowingBottomBar;

@end

@interface SnackbarSimpleExample : SnackbarExample <MDCSnackbarManagerDelegate>
@end

@interface SnackbarSuspensionExample : SnackbarExample

- (void)handleSuspendStateChanged:(UISwitch *)sender;

@end

@interface SnackbarInputAccessoryViewController : UIViewController

@end
