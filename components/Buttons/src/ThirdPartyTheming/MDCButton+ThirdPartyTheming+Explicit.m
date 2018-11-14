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

#import "MDCButton+ThirdPartyTheming+Explicit.h"
#import "private/MDCButton+ThirdPartyTheming+Private.h"

@implementation MDCButton (ThirdPartyTheming)

#pragma mark - Today

- (nonnull instancetype)thirdparty_applyContainedThemeWithColorScheme:(nonnull id<ThirdPartyColorScheming>)scheme {
  [self _thirdparty_applyContainedThemeWithColorScheme:scheme];
  return self;
}

- (nonnull instancetype)thirdparty_applyTextThemeWithColorScheme:(nonnull id<ThirdPartyColorScheming>)scheme {
  [self _thirdparty_applyFancyThemeWithColorScheme:scheme];
  return self;
}

- (nonnull instancetype)thirdparty_applyTextThemeWithShapeScheme:(nonnull id<MDCShapeScheming>)scheme {
  [self _thirdparty_applyFancyThemeWithShapeScheme:scheme];
  return self;
}

- (nonnull instancetype)thirdparty_applyTextThemeWithTypographyScheme:(nonnull id<MDCTypographyScheming>)scheme {
  [self _thirdparty_applyFancyThemeWithTypographyScheme:scheme];
  return self;
}

#pragma mark - With a new subsystem

- (nonnull instancetype)applTextThemeWithMotionScheme:(nonnull id<MDCMotionScheming>)scheme {
  [self _thirdparty_applyFancyThemeWithMotionScheme:scheme];
  return self;
}

@end
