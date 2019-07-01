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

#import "MDCDarkMode.h"

#import "MDCSemanticColorScheme.h"

@implementation MDCDarkMode

// static CGFloat ElevationToWhiteOverlayOpacity(CGFloat elevation) {
//  static NSDictionary *opacityLookup = nil;
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    opacityLookup = @{
//            [NSNumber numberWithDouble:0]  : [NSNumber numberWithDouble:0],
//            [NSNumber numberWithDouble:1]  : [NSNumber numberWithDouble:0.05],
//            [NSNumber numberWithDouble:2]  : [NSNumber numberWithDouble:0.07],
//            [NSNumber numberWithDouble:3]  : [NSNumber numberWithDouble:0.08],
//            [NSNumber numberWithDouble:4]  : [NSNumber numberWithDouble:0.09],
//            [NSNumber numberWithDouble:6]  : [NSNumber numberWithDouble:0.11],
//            [NSNumber numberWithDouble:8]  : [NSNumber numberWithDouble:0.12],
//            [NSNumber numberWithDouble:12] : [NSNumber numberWithDouble:0.14],
//            [NSNumber numberWithDouble:16] : [NSNumber numberWithDouble:0.15],
//            [NSNumber numberWithDouble:24] : [NSNumber numberWithDouble:0.16],
//            };
//  });
//
//  NSNumber *index = opacityLookup[[NSNumber numberWithDouble:elevation]];
//  if (index != nil) {
//    return [index doubleValue];
//  } else {
//    NSCAssert(NO, @"%f is not a valid elevation value.", elevation);
//    return 0;
//  }
//}

+ (nonnull UIColor *)lightenBackgroundColor:(nonnull UIColor *)color
                              withElevation:(CGFloat)elevation {
  CGFloat alphaValue = 4.5 * log(elevation + 1) + 2;
  return [MDCSemanticColorScheme blendColor:[UIColor colorWithWhite:1 alpha:alphaValue * 0.01]
                        withBackgroundColor:color];
}

@end
