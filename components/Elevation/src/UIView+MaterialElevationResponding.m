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

#import "MDCElevatable.h"
#import "MDCElevationOverriding.h"

@implementation UIView (MaterialElevationResponding)

- (void)mdc_elevationDidChange {
  CGFloat baseElevation = self.mdc_baseElevation;
  [self mdc_elevationDidChangeWithBaseElevation:baseElevation];
}

- (void)mdc_elevationDidChangeWithBaseElevation:(CGFloat)baseElevation {
  CGFloat elevation = baseElevation;
  id<MDCElevatable> elevatableSelf = [self objectConformingToElevationInResponderChain];
  if (elevatableSelf.mdc_elevationDidChangeBlock) {
    elevation += elevatableSelf.mdc_currentElevation;
    elevatableSelf.mdc_elevationDidChangeBlock(elevatableSelf, elevation);
  }

  for (UIView *subview in self.subviews) {
    [subview mdc_elevationDidChangeWithBaseElevation:elevation];
  }
}

- (CGFloat)mdc_baseElevation {
  CGFloat totalElevation = 0;
  UIView *current = self;

  while (current != nil) {
    id<MDCElevatable> elevatableCurrent = [current objectConformingToElevationInResponderChain];
    if (current != self) {
      totalElevation += elevatableCurrent.mdc_currentElevation;
    }
    id<MDCElevationOverriding> elevatableCurrentOverride =
        [current objectConformingToOverrideInResponderChain];
    if (elevatableCurrentOverride != nil &&
        elevatableCurrentOverride.mdc_overrideBaseElevation >= 0) {
      totalElevation += elevatableCurrentOverride.mdc_overrideBaseElevation;
      break;
    }
    current = current.superview;
  }
  return totalElevation;
}

- (CGFloat)mdc_absoluteElevation {
  CGFloat elevation = self.mdc_baseElevation;
  id<MDCElevatable> elevatableSelf = [self objectConformingToElevationInResponderChain];
  elevation += elevatableSelf.mdc_currentElevation;
  return elevation;
}

/**
 Checks whether a @c UIView or it's managing @c UIViewController conform to @c
 MDCOverrideElevation.

 @returns the conforming @c UIView then @c UIViewController, otherwise @c nil.
 */
- (id<MDCElevationOverriding>)objectConformingToOverrideInResponderChain {
  if ([self conformsToProtocol:@protocol(MDCElevationOverriding)]) {
    return (id<MDCElevationOverriding>)self;
  }

  UIResponder *nextResponder = self.nextResponder;
  if ([nextResponder isKindOfClass:[UIViewController class]] &&
      [nextResponder conformsToProtocol:@protocol(MDCElevationOverriding)]) {
    return (id<MDCElevationOverriding>)nextResponder;
  }

  return nil;
}

/**
 Checks whether a @c UIView or it's managing @c UIViewController conform to @c
 MDCElevation.

 @returns the conforming @c UIView then @c UIViewController, otherwise @c nil.
 */
- (id<MDCElevatable>)objectConformingToElevationInResponderChain {
  if ([self conformsToProtocol:@protocol(MDCElevatable)]) {
    return (id<MDCElevatable>)self;
  }

  UIResponder *nextResponder = self.nextResponder;
  if ([nextResponder isKindOfClass:[UIViewController class]] &&
      [nextResponder conformsToProtocol:@protocol(MDCElevatable)]) {
    return (id<MDCElevatable>)nextResponder;
  }

  return nil;
}

@end
