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

#import "UIView+MaterialElevationResponding.h"

#import "MDCElevation.h"

@implementation UIView (MaterialElevationResponding)

- (CGFloat)mdc_baseElevation {
  CGFloat totalElevation = 0;

  if ([self conformsToProtocol:@protocol(MDCElevation)]) {
    id<MDCElevation> elevatableSelf = (id<MDCElevation>)self;
    if ([elevatableSelf respondsToSelector:@selector(mdc_overrideBaseElevation)]) {
      return elevatableSelf.mdc_overrideBaseElevation;
    }
  }

  if (!self.superview) {
    return totalElevation;
  }
  UIView *current = self.superview;

  while (current != nil) {
    id<MDCElevation> elevatableCurrent = [current conformingObjectInResponderChain];
    if (elevatableCurrent) {
      if ([elevatableCurrent respondsToSelector:@selector(mdc_overrideBaseElevation)]) {
        totalElevation += elevatableCurrent.mdc_overrideBaseElevation;
        break;
      }
      totalElevation += elevatableCurrent.mdc_currentElevation;
    }
    current = current.superview;
  }
  return totalElevation;
}

/**
 Checks whether a @c UIView or it's managing @c UIViewController conform to @c
 MDCElevation.

 @returns the conforming @c UIView then @c UIViewController, otherwise @c nil.
 */
- (id<MDCElevation>)conformingObjectInResponderChain {
  if ([self conformsToProtocol:@protocol(MDCElevation)]) {
    return (id<MDCElevation>)self;
  }

  UIResponder *nextResponder = self.nextResponder;
  if ([nextResponder isKindOfClass:[UIViewController class]] &&
      [nextResponder conformsToProtocol:@protocol(MDCElevation)]) {
    return (id<MDCElevation>)nextResponder;
  }

  return nil;
}

@end
