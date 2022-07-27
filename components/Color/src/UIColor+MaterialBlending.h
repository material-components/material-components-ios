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

#import <UIKit/UIKit.h>

@interface UIColor (MaterialBlending)

/**
 Blending a color over a background color using Alpha compositing technique.
 More info about Alpha compositing: https://en.wikipedia.org/wiki/Alpha_compositing

 @param color UIColor value that sits on top.
 @param backgroundColor UIColor on the background.
 */
+ (nonnull UIColor *)mdc_blendColor:(nonnull UIColor *)color
                withBackgroundColor:(nonnull UIColor *)backgroundColor;

@end
