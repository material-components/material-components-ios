/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTabBarUnderlineIndicatorTemplate.h"

#import "MDCTabBarIndicatorAttributes.h"
#import "MDCTabBarIndicatorContext.h"

@implementation MDCTabBarUnderlineIndicatorTemplate

- (MDCTabBarIndicatorAttributes *)
    indicatorAttributesForContext:(MDCTabBarIndicatorContext *)context {
  CGRect bounds = context.bounds;
  MDCTabBarIndicatorAttributes *attributes = [[MDCTabBarIndicatorAttributes alloc] init];
  attributes.path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(bounds), CGRectGetMaxY(bounds) - 2,CGRectGetWidth(bounds), 2)];
  return attributes;
}

@end
