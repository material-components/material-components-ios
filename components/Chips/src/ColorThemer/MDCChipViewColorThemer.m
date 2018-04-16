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

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
                 toInputChipView:(MDCChipView *)inputChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:inputChipView stroked:NO];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
          toStrokedInputChipView:(MDCChipView *)strokedInputChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:strokedInputChipView stroked:YES];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
                toChoiceChipView:(MDCChipView *)choiceChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:choiceChipView stroked:NO];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
         toStrokedChoiceChipView:(MDCChipView *)strokedChoiceChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:strokedChoiceChipView stroked:YES];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
                toActionChipView:(MDCChipView *)actionChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:actionChipView stroked:NO];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
         toStrokedActionChipView:(MDCChipView *)strokedActionChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:strokedActionChipView stroked:YES];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
                toFilterChipView:(MDCChipView *)filterChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:filterChipView stroked:NO];
}

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
         toStrokedFilterChipView:(MDCChipView *)strokedFilterChipView {
  [self applyBaseSemanticColorScheme:colorScheme toChipView:strokedFilterChipView stroked:YES];
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
