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

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCButton *)button {
  [self resetUIControlStatesForButtonTheming:button];
  [button setBackgroundColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [button setBackgroundColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f]
                    forState:UIControlStateDisabled];
  [button setTitleColor:colorScheme.onPrimaryColor forState:UIControlStateNormal];
  [button setTitleColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:0.26f]
               forState:UIControlStateDisabled];
  button.disabledAlpha = 1.f;
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                    toFlatButton:(nonnull MDCFlatButton *)flatButton {
  [self resetUIControlStatesForButtonTheming:flatButton];
  [flatButton setBackgroundColor:UIColor.clearColor forState:UIControlStateNormal];
  [flatButton setBackgroundColor:UIColor.clearColor forState:UIControlStateDisabled];
  [flatButton setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [flatButton setTitleColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:0.26f]
                   forState:UIControlStateDisabled];
  flatButton.disabledAlpha = 1.f;
}

+ (void)resetUIControlStatesForButtonTheming:(nonnull MDCButton *)button {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
      UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [button setBackgroundColor:nil forState:state];
    [button setTitleColor:nil forState:state];
  }
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                  toRaisedButton:(nonnull MDCRaisedButton *)raisedButton {
  [self applySemanticColorScheme:colorScheme toButton:raisedButton];
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
                toButton:(MDCButton *)button {
  [button setBackgroundColor:colorScheme.primaryColor forState:UIControlStateNormal];
  if ([colorScheme respondsToSelector:@selector(primaryLightColor)]) {
    [button setBackgroundColor:colorScheme.primaryLightColor forState:UIControlStateDisabled];
  }
}

@end
