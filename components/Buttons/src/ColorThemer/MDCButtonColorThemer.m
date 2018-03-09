/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCButtonColorThemer.h"

@implementation MDCButtonColorThemer

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
                toButton:(MDCButton *)button {
  [button setBackgroundColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [button setBackgroundColor:colorScheme.primaryLightColor forState:UIControlStateDisabled];
}

+ (void)applyExperimentalColorScheme:(MDCExperimentalColorScheme *)colorScheme toButton:(MDCButton *)button {
  [button setBorderColor:colorScheme.borderColor forState:UIControlStateNormal];
  [button setBackgroundColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [button setBackgroundColor:colorScheme.disabledBackgroundColor forState:UIControlStateDisabled];
  [button setTitleColor:colorScheme.backgroundColor forState:UIControlStateNormal];
  [button setTitleColor:colorScheme.textColor forState:UIControlStateDisabled];
  button.tintColor = colorScheme.backgroundColor;
  button.inkColor = colorScheme.inkColor;
  [button setShadowColor:colorScheme.shadowColor forState:UIControlStateNormal];
}

+ (void)applyExperimentalColorScheme:(MDCExperimentalColorScheme *)colorScheme toFlatButton:(MDCFlatButton *)button {
  [button setBackgroundColor:UIColor.clearColor forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.clearColor forState:UIControlStateDisabled];
  [button setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [button setTitleColor:colorScheme.textColor forState:UIControlStateDisabled];
  button.tintColor = colorScheme.primaryColor;
  button.inkColor = colorScheme.inkColor;
  [button setShadowColor:colorScheme.shadowColor forState:UIControlStateNormal];
}

@end
