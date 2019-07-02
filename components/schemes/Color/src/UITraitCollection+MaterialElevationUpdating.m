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

#import <objc/runtime.h>

#import "UITraitCollection+MaterialElevationUpdating.h"

@interface UITraitCollection ()
@property(nonatomic, readwrite) CGFloat materialElevation;
@end

@implementation UITraitCollection (MaterialElevationUpdating)

+ (UITraitCollection *)traitCollectionWithMaterialElevation:(CGFloat)materialElevation {
  UITraitCollection *traitCollection = [[UITraitCollection alloc] init];
  traitCollection.materialElevation = materialElevation;
  return traitCollection;
}

+ (UITraitCollection *)traitCollectionWithTraitsFromCollectionsIncludingElevation:
    (NSArray<UITraitCollection *> *)traitCollections {
  UITraitCollection *traitCollection =
      [self traitCollectionWithTraitsFromCollections:traitCollections];
  for (UITraitCollection *collection in traitCollections) {
    if (collection.materialElevation > 0) {
      traitCollection.materialElevation = collection.materialElevation;
    }
  }
  return traitCollection;
}

- (void)setMaterialElevation:(CGFloat)materialElevation {
  objc_setAssociatedObject(self, @selector(materialElevation), @(materialElevation),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)materialElevation {
  NSNumber *number = objc_getAssociatedObject(self, @selector(materialElevation));
  if (number == nil) {
    return 0;
  }
  return number.doubleValue;
}

- (BOOL)hasDifferentElevationComparedToTraitCollection:(UITraitCollection *)traitCollection {
  if (self.materialElevation != traitCollection.materialElevation) {
    return YES;
  }
  return NO;
}

@end
