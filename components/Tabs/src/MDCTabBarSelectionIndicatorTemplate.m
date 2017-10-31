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

#import "MDCTabBarSelectionIndicatorTemplate.h"

@implementation MDCTabBarSelectionIndicatorAttributes

// TODO: NSCOPYING

@end

@interface MDCTabBarItemAttributes ()
@end

@implementation MDCTabBarItemAttributes

- (instancetype)initWithItem:(UITabBarItem *)item
                      bounds:(CGRect)bounds
                contentFrame:(CGRect)contentFrame {
  self = [super init];
  if (self) {
    _item = item;
    _bounds = bounds;
    _contentFrame = contentFrame;
  }
  return self;
}

// TODO: NSOBJECT

@end

@implementation MDCRectangleTabBarSelectionIndicatorTemplate

- (MDCTabBarSelectionIndicatorAttributes *)
    selectionIndicatorAttributesForItemAttributes:(MDCTabBarItemAttributes *)attributes {
  CGRect bounds = attributes.bounds;
  MDCTabBarSelectionIndicatorAttributes *indicatorAttributes =
      [[MDCTabBarSelectionIndicatorAttributes alloc] init];
  indicatorAttributes.path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(bounds), CGRectGetMaxY(bounds) - 2,CGRectGetWidth(bounds), 2)];
  return indicatorAttributes;
}

@end
