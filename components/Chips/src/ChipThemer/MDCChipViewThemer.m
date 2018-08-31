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

#import "MaterialChips+ChipThemer.h"

#import "MaterialChips+ColorThemer.h"
#import "MaterialChips+TypographyThemer.h"

@implementation MDCChipViewThemer

+ (void)applyScheme:(nonnull id<MDCChipViewScheming>)scheme
         toChipView:(nonnull MDCChipView *)chip {
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
      UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [chip setBorderWidth:0 forState:state];
  }
  [MDCChipViewColorThemer applySemanticColorScheme:scheme.colorScheme toChipView:chip];
  [MDCChipViewTypographyThemer applyTypographyScheme:scheme.typographyScheme toChipView:chip];
}

+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCChipViewScheming>)scheme
                            toChipView:(nonnull MDCChipView *)chip {
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
      UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [chip setBorderWidth:1 forState:state];
  }
  [MDCChipViewColorThemer applyOutlinedVariantWithColorScheme:scheme.colorScheme toChipView:chip];
  [MDCChipViewTypographyThemer applyTypographyScheme:scheme.typographyScheme toChipView:chip];
}

@end


