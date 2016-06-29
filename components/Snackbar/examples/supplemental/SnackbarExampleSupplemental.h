/*
 Copyright 2016-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MaterialButtons.h"
#import "MaterialSwitch.h"
#import "MaterialTypography.h"

@interface SnackbarExample : UIViewController

@property(nonatomic) MDCRaisedButton *snackbarButton;

- (void)setupExampleViews;

@end

@interface SnackbarActionExample : SnackbarExample

@end

@interface SnackbarBoldExample : SnackbarExample

@end

@interface SnackbarOverlayViewExample : SnackbarExample

/** The floating action button shown in the bottom right corner. */
@property(nonatomic) MDCFloatingButton *floatingButton;

@end

@interface SnackbarSimpleExample : SnackbarExample

@end

@interface SnackbarSuspensionExample : SnackbarExample

@property(nonatomic) MDCRaisedButton *groupAButton;
@property(nonatomic) MDCRaisedButton *groupBButton;
@property(nonatomic) MDCRaisedButton *allMessagesButton;

@property(nonatomic) MDCSwitch *groupASwitch;
@property(nonatomic) MDCSwitch *groupBSwitch;
@property(nonatomic) MDCSwitch *allMessagesSwitch;

@property(nonatomic) UILabel *groupALabel;
@property(nonatomic) UILabel *groupBLabel;
@property(nonatomic) UILabel *allLabel;

@end
