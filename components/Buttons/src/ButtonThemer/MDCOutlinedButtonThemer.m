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

#import "MDCOutlinedButtonThemer.h"

#import "MaterialButtons+ColorThemer.h"
#import "MaterialButtons+TypographyThemer.h"

@implementation MDCOutlinedButtonThemer

+ (void)applyScheme:(nonnull id<MDCButtonScheming>)scheme
           toButton:(nonnull MDCButton *)button {
  [MDCOutlinedButtonColorThemer applySemanticColorScheme:scheme.colorScheme toButton:button];
  [MDCButtonTypographyThemer applyTypographyScheme:scheme.typographyScheme toButton:button];
  button.minimumSize = CGSizeMake(0, scheme.minimumHeight);
  button.layer.cornerRadius = scheme.cornerRadius;

  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
      UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [button setBorderWidth:1.f forState:state];
  }
}

@end
