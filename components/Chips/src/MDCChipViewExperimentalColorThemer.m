/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCChipViewExperimentalColorThemer.h"
#import "MaterialThemes.h"
#import "MDCChipView.h"

@implementation MDCChipViewExperimentalColorThemer

+ (void)applyExperimentalColorTheme:(MDCExperimentalColorScheme *)colorScheme toChipView:(MDCChipView *)chip {
  [chip setBorderWidth:1 forState:UIControlStateNormal];
  [chip setBorderWidth:0 forState:UIControlStateHighlighted];
  [chip setBorderWidth:0 forState:UIControlStateHighlighted | UIControlStateSelected];
  [chip setBackgroundColor:colorScheme.backgroundColor forState:UIControlStateNormal];
  [chip setBackgroundColor:[colorScheme.selectionColor colorWithAlphaComponent:0.16f] forState:UIControlStateSelected];
  [chip setBackgroundColor:[colorScheme.selectionColor colorWithAlphaComponent:0.16f] forState:UIControlStateSelected | UIControlStateHighlighted];
  [chip setBackgroundColor:colorScheme.disabledBackgroundColor forState:UIControlStateDisabled];
  [chip setInkColor:colorScheme.inkColor forState:UIControlStateNormal];
  [chip setShadowColor:colorScheme.shadowColor forState:UIControlStateNormal];
  [chip setBorderColor:colorScheme.borderColor forState:UIControlStateNormal];
  [chip setTitleColor:colorScheme.textColor forState:UIControlStateNormal];
}

@end
