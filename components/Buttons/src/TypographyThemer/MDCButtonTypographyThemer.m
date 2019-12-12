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

#import "MDCButtonTypographyThemer.h"

@implementation MDCButtonTypographyThemer

+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
                     toButton:(nonnull MDCButton *)button {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [button setTitleFont:nil forState:state];
  }
  [button setTitleFont:typographyScheme.button forState:UIControlStateNormal];
}

@end
