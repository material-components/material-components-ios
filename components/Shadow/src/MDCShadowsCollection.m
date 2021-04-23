// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCShadowsCollection.h"

#import "MaterialAvailability.h"
#import "MDCShadow.h"

@implementation MDCShadowsCollection {
  NSDictionary<NSNumber *, MDCShadow *> *_shadowValuesForElevation;
  NSArray<NSNumber *> *_orderedKeys;
}

- (instancetype)initWithShadowValuesForElevation:
    (NSDictionary<NSNumber *, MDCShadow *> *)shadowValuesForElevation {
  self = [super init];
  if (self) {
    _shadowValuesForElevation = [shadowValuesForElevation copy];
    _orderedKeys = [shadowValuesForElevation.allKeys sortedArrayUsingSelector:@selector(compare:)];
  }
  return self;
}

- (MDCShadow *)shadowForElevation:(CGFloat)elevation {
  NSUInteger lookupIndex = [self indexInOrderedKeysOfGivenElevation:elevation];
  // If the value is larger than the largest value in the array, we will return the highest value in
  // the array.
  if (lookupIndex >= _orderedKeys.count) {
    lookupIndex = _orderedKeys.count - 1;
  }

  NSNumber *key = _orderedKeys[lookupIndex];
  return [_shadowValuesForElevation objectForKey:key];
}

- (NSUInteger)indexInOrderedKeysOfGivenElevation:(CGFloat)elevation {
  NSNumber *num = @(elevation);
  NSUInteger index =
      [_orderedKeys indexOfObject:num
                    inSortedRange:NSMakeRange(0, _orderedKeys.count)
                          options:NSBinarySearchingInsertionIndex
                  usingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
                    return [num1 compare:num2];
                  }];
  return index;
}

@end

@implementation MDCShadowsCollectionBuilder {
  NSMutableDictionary<NSNumber *, MDCShadow *> *_shadowValuesForElevation;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _shadowValuesForElevation = [[NSMutableDictionary alloc] init];
  }
  return self;
}

+ (MDCShadowsCollectionBuilder *)builderWithShadow:(MDCShadow *)shadow
                                      forElevation:(CGFloat)elevation {
  MDCShadowsCollectionBuilder *builder = [[self alloc] init];
  [builder addShadow:shadow forElevation:elevation];
  return builder;
}

- (void)addShadow:(MDCShadow *)shadow forElevation:(CGFloat)elevation {
  [_shadowValuesForElevation setObject:shadow forKey:@(elevation)];
}

- (void)addShadowsForElevations:(NSDictionary<NSNumber *, MDCShadow *> *)shadowsForElevations {
  [_shadowValuesForElevation addEntriesFromDictionary:shadowsForElevations];
}

- (MDCShadowsCollection *)build {
  return [[MDCShadowsCollection alloc] initWithShadowValuesForElevation:_shadowValuesForElevation];
}

@end

static UIColor *LightStyleShadowColor(void) {
  static UIColor *lightStyleShadowColor;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    lightStyleShadowColor = [UIColor colorWithRed:0.235 green:0.251 blue:0.263 alpha:1];
  });
  return lightStyleShadowColor;
}

UIColor *MDCShadowColor(void) {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    return [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
      switch (traitCollection.userInterfaceStyle) {
        case UIUserInterfaceStyleUnspecified:
          /* FALLTHROUGH - TODO(b/185199658): Migrate to proper fallthrough logic */
        case UIUserInterfaceStyleLight:
          return LightStyleShadowColor();
        case UIUserInterfaceStyleDark:
          return UIColor.blackColor;
      }
      __builtin_unreachable();
    }];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  return LightStyleShadowColor();
}

MDCShadowsCollection *MDCShadowsCollectionDefault(void) {
  static MDCShadowsCollection *shadowsCollection;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    MDCShadow *shadow = [[MDCShadowBuilder builderWithOpacity:0 radius:0
                                                       offset:CGSizeMake(0, 0)] build];
    MDCShadowsCollectionBuilder *shadowsBuilder =
        [MDCShadowsCollectionBuilder builderWithShadow:shadow forElevation:0];
    NSDictionary<NSNumber *, MDCShadow *> *shadowValuesForElevation = @{
      @1 : [[MDCShadowBuilder builderWithOpacity:0.43 radius:2.5 offset:CGSizeMake(0, 1)] build],
      @3 : [[MDCShadowBuilder builderWithOpacity:0.4 radius:3.25 offset:CGSizeMake(0, 1.25)] build],
      @6 : [[MDCShadowBuilder builderWithOpacity:0.34 radius:4.75
                                          offset:CGSizeMake(0, 2.25)] build],
      @8 : [[MDCShadowBuilder builderWithOpacity:0.42 radius:6 offset:CGSizeMake(0, 3)] build],
      @12 : [[MDCShadowBuilder builderWithOpacity:0.4 radius:7.25 offset:CGSizeMake(0, 5)] build],
    };
    [shadowsBuilder addShadowsForElevations:shadowValuesForElevation];
    shadowsCollection = [shadowsBuilder build];
  });
  return shadowsCollection;
}

void MDCConfigureShadowForView(UIView *view, MDCShadow *shadow, UIColor *shadowColor) {
  // The bezierPathWithRoundedRect API supports both a cornerRadius of 0 (created just a square
  // path) and also rounded corners where the cornerRadius is >0.
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  cornerRadius:view.layer.cornerRadius];

  MDCConfigureShadowForViewWithPath(view, shadow, shadowColor, path.CGPath);
}

void MDCConfigureShadowForViewWithPath(UIView *view, MDCShadow *shadow, UIColor *shadowColor,
                                       CGPathRef path) {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(ios 13.0, *)) {
    shadowColor = [shadowColor resolvedColorWithTraitCollection:view.traitCollection];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  view.layer.shadowColor = shadowColor.CGColor;
  view.layer.shadowOpacity = (float)shadow.opacity;
  view.layer.shadowRadius = shadow.radius;
  view.layer.shadowOffset = shadow.offset;
  view.layer.shadowPath = path;
}
