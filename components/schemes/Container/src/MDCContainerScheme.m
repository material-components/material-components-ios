// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCContainerScheme.h"

@implementation MDCContainerScheme

- (instancetype)init {
  self = [super init];
  if (self) {
    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  return self;
}

+ (MDCContainerScheme *)resolveScheme:(id<MDCContainerScheming>)scheme
                   forTraitCollection:(UITraitCollection *)traitCollection {
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.typographyScheme = [MDCTypographyScheme resolveScheme:scheme.typographyScheme
                                                     forTraitCollection:traitCollection];
  return containerScheme;
}

#pragma mark - NSMutableCopying

- (id)mutableCopyWithZone:(NSZone *)zone {
  MDCContainerScheme *copy = [[MDCContainerScheme alloc] init];
  copy.colorScheme = [self.colorScheme mutableCopy];
  copy.typographyScheme = [self.typographyScheme mutableCopy];
  copy.shapeScheme = [self.shapeScheme mutableCopy];
  return copy;
}

@end

@implementation MDCContainerScheme (TraitCollectionSupport)

+ (MDCContainerScheme *)resolveScheme:(id<MDCContainerScheming>)scheme
                   forTraitCollection:(UITraitCollection *)traitCollection {
  MDCContainerScheme *copy = [scheme mutableCopy];
  copy.typographyScheme = [MDCTypographyScheme resolveScheme:copy.typographyScheme
                                          forTraitCollection:traitCollection];
  return copy;
}

@end
