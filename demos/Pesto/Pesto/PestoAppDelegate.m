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

#import "PestoAppDelegate.h"
#import "PestoFlexibleHeaderContainerViewController.h"

@interface PestoAppDelegate ()

@end

@implementation PestoAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// setStatusBarHidden:withAnimation: was deprecated in iOS 9.
// Silence the related warning.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [[UIApplication sharedApplication] setStatusBarHidden:YES
                                          withAnimation:NO];
#pragma clang diagnostic pop

  PestoFlexibleHeaderContainerViewController *flexHeadContainerVC =
      [[PestoFlexibleHeaderContainerViewController alloc] init];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  [self.window setRootViewController:flexHeadContainerVC];
  [self.window makeKeyAndVisible];

  return YES;
}

@end
