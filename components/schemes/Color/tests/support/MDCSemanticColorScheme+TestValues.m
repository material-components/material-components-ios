// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCSemanticColorScheme+TestValues.h"

@implementation MDCSemanticColorScheme (TestValues)

+ (instancetype)semanticColorSchemeWithHighContrast {
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = UIColor.redColor;
  colorScheme.primaryColorVariant = [UIColor colorWithRed:1
                                                    green:(CGFloat)0.2
                                                     blue:(CGFloat)0.2
                                                    alpha:1];
  colorScheme.secondaryColor = UIColor.cyanColor;
  colorScheme.errorColor = [UIColor colorWithRed:1 green:(CGFloat).5 blue:0 alpha:1];
  colorScheme.surfaceColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];
  colorScheme.backgroundColor = UIColor.blackColor;
  colorScheme.onPrimaryColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];
  colorScheme.onSecondaryColor = [UIColor colorWithWhite:0 alpha:1];
  colorScheme.onSurfaceColor = UIColor.blackColor;
  colorScheme.onBackgroundColor = UIColor.whiteColor;

  return colorScheme;
}

+ (instancetype)semanticColorSchemeWithVaryingOpacity {
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.05];
  colorScheme.primaryColorVariant = [UIColor colorWithWhite:1 alpha:(CGFloat)0.1];
  colorScheme.secondaryColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.15];
  colorScheme.errorColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.2];
  colorScheme.surfaceColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.25];
  colorScheme.backgroundColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.3];
  colorScheme.onPrimaryColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.35];
  colorScheme.onSecondaryColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.4];
  colorScheme.onSurfaceColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.45];
  colorScheme.onBackgroundColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.5];
  return colorScheme;
}

@end
