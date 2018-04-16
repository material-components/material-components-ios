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

#import "MDCChipViewColorThemer.h"

@implementation MDCChipViewColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                      toChipView:(nonnull MDCChipView *)chipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:chipView stroked:NO];
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toStrokedChipView:(nonnull MDCChipView *)strokedChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:strokedChipView stroked:YES];
}

+ (void)applyBaseSemanticColorScheme:(id<MDCColorScheming>)colorScheme
                          toChipView:(MDCChipView *)chipView
                             stroked:(BOOL)stroked {
  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];

  UIColor *backgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:colorScheme.surfaceColor];

  [MDCChipViewColorThemer resetUIControlStatesForChipTheming:chipView];
  [chipView setBackgroundColor:backgroundColor forState:UIControlStateNormal];
  [chipView setTitleColor:textColor forState:UIControlStateNormal];
  if (stroked) {
    [chipView setBackgroundColor:colorScheme.surfaceColor forState:UIControlStateNormal];
    [chipView setBorderColor:backgroundColor forState:UIControlStateNormal];
  }
}

+ (void)resetUIControlStatesForChipTheming:(nonnull MDCChipView *)chipView {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
  UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [chipView setBackgroundColor:nil forState:state];
    [chipView setTitleColor:nil forState:state];
    [chipView setBorderColor:nil forState:state];
  }
}

@end
