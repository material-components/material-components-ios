// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCAlertColorThemer.h"

//#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialDialogs.h"

@implementation MDCAlertColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toAlertController:(nonnull MDCAlertController *)alertController {
  alertController.titleColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  alertController.messageColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  //alertController.buttonTitleColor = colorScheme.primaryColor;
  alertController.titleIconTintColor = colorScheme.primaryColor;
  alertController.scrimColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.32];

  MDCButtonScheme *lowEmphasisButtonScheme = [[MDCButtonScheme alloc] init];
  //MDCSemanticColorScheme *lowEmphasisColorScheme = [(MDCSemanticColorScheme *)colorScheme copy];
  MDCSemanticColorScheme *lowEmphasisColorScheme = [[MDCSemanticColorScheme alloc] init];
  lowEmphasisColorScheme.primaryColor = UIColor.cyanColor;
  lowEmphasisButtonScheme.colorScheme = lowEmphasisColorScheme;
  [alertController configureLowEmphasisActions:^(MDCButton * _Nonnull actionButton) {
    [MDCTextButtonThemer applyScheme:lowEmphasisButtonScheme toButton:actionButton];
  }];

  MDCButtonScheme *highEmphasisButtonScheme = [[MDCButtonScheme alloc] init];
  //MDCSemanticColorScheme *highEmphasisColorScheme = [(MDCSemanticColorScheme *)colorScheme copy];
  MDCSemanticColorScheme *highEmphasisColorScheme = [[MDCSemanticColorScheme alloc] init];
  highEmphasisColorScheme.primaryColor = UIColor.blueColor;
  highEmphasisButtonScheme.colorScheme = highEmphasisColorScheme;
  [alertController configureHighEmphasisActions:^(MDCButton * _Nonnull actionButton) {
    [MDCContainedButtonThemer applyScheme:highEmphasisButtonScheme toButton:actionButton];
  }];
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme {
  #if defined(__IPHONE_9_0) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
  [[MDCButton appearanceWhenContainedInInstancesOfClasses:@[[MDCAlertController class]]]
      setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  #else
  [[MDCButton appearanceWhenContainedIn:[MDCAlertController class], nil]
      setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  #endif
}

@end
