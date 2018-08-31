// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

@interface UIFont (MaterialTypographyPrivate)

/**
 Returns the weight of the font.

 @return A value between -1.0 (very thin) to 1.0 (very thick).

 Regular weight is 0.0.
 */
- (CGFloat)mdc_weight;

/**
 Returns the slant of the font.

 @return more than 0 when italic and 0 when not italic.

 Regular slant is 0.0.
 */
- (CGFloat)mdc_slant;

/**
 Returns an extended description of the font including name, pointsize and weight.
 */
- (nonnull NSString *)mdc_extendedDescription;

@end
