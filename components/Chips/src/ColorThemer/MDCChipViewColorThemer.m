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
  [MDCChipViewColorThemer resetUIControlStatesForChipTheming:chipView];
  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];
  UIColor *onSurface16Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.16f];

  UIColor *backgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *selectedBackgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:backgroundColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:backgroundColor];
  UIColor *selectedTextColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:selectedBackgroundColor];

  [chipView setInkColor:onSurface16Opacity forState:UIControlStateNormal];
  [chipView setTitleColor:textColor forState:UIControlStateNormal];
  [chipView setBackgroundColor:backgroundColor forState:UIControlStateNormal];

  [chipView setTitleColor:selectedTextColor forState:UIControlStateSelected];
  [chipView setBackgroundColor:selectedBackgroundColor forState:UIControlStateSelected];

  [chipView setTitleColor:[textColor colorWithAlphaComponent:0.38f]
                 forState:UIControlStateDisabled];
  [chipView setBackgroundColor:[backgroundColor colorWithAlphaComponent:0.38f]
                      forState:UIControlStateDisabled];
}

+ (void)applyOutlinedVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                 toChipView:(nonnull MDCChipView *)chipView {
  [MDCChipViewColorThemer resetUIControlStatesForChipTheming:chipView];
  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];
  UIColor *onSurface16Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.16f];
  UIColor *selectedBackgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *borderColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *selectedTextColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:selectedBackgroundColor];

  [chipView setInkColor:onSurface16Opacity forState:UIControlStateNormal];
  [chipView setTitleColor:textColor forState:UIControlStateNormal];
  [chipView setBackgroundColor:colorScheme.surfaceColor forState:UIControlStateNormal];
  [chipView setBorderColor:borderColor forState:UIControlStateNormal];

  [chipView setTitleColor:selectedTextColor forState:UIControlStateSelected];
  [chipView setBackgroundColor:selectedBackgroundColor forState:UIControlStateSelected];
  [chipView setBorderColor:[UIColor clearColor] forState:UIControlStateSelected];

  [chipView setTitleColor:[textColor colorWithAlphaComponent:0.38f]
                 forState:UIControlStateDisabled];
  [chipView setBackgroundColor:[colorScheme.surfaceColor colorWithAlphaComponent:0.38f]
                      forState:UIControlStateDisabled];
  [chipView setBorderColor:[borderColor colorWithAlphaComponent:0.38f]
                  forState:UIControlStateDisabled];
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toStrokedChipView:(nonnull MDCChipView *)strokedChipView {
  [MDCChipViewColorThemer resetUIControlStatesForChipTheming:strokedChipView];
  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];
  UIColor *onSurface16Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.16f];
  UIColor *selectedBackgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *borderColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *selectedTextColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:selectedBackgroundColor];

  [strokedChipView setInkColor:onSurface16Opacity forState:UIControlStateNormal];
  [strokedChipView setTitleColor:textColor forState:UIControlStateNormal];
  [strokedChipView setBackgroundColor:colorScheme.surfaceColor forState:UIControlStateNormal];
  [strokedChipView setBorderColor:borderColor forState:UIControlStateNormal];

  [strokedChipView setTitleColor:selectedTextColor forState:UIControlStateSelected];
  [strokedChipView setBackgroundColor:selectedBackgroundColor forState:UIControlStateSelected];
  [strokedChipView setBorderColor:[UIColor clearColor] forState:UIControlStateSelected];

  [strokedChipView setTitleColor:[textColor colorWithAlphaComponent:0.38f]
                        forState:UIControlStateDisabled];
  [strokedChipView setBackgroundColor:[colorScheme.surfaceColor colorWithAlphaComponent:0.38f]
                             forState:UIControlStateDisabled];
  [strokedChipView setBorderColor:[borderColor colorWithAlphaComponent:0.38f]
                         forState:UIControlStateDisabled];
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
