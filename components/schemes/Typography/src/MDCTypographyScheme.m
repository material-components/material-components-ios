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

#import "MDCTypographyScheme.h"

#import <CoreText/CoreText.h>

@implementation MDCTypographyScheme

- (instancetype)init {
  return [self initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
}

- (instancetype)initWithDefaults:(MDCTypographySchemeDefaults)defaults {
  self = [super init];
  if (self) {
    switch (defaults) {
      case MDCTypographySchemeDefaultsMaterial201804:
#if defined(__IPHONE_8_2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
#pragma clang diagnostic ignored "-Wtautological-pointer-compare"
        _headline1 = [UIFont systemFontOfSize:96.0 weight:UIFontWeightLight];
        _headline2 = [UIFont systemFontOfSize:60.0 weight:UIFontWeightLight];
        _headline3 = [UIFont systemFontOfSize:48.0 weight:UIFontWeightRegular];
        _headline4 = [UIFont systemFontOfSize:34.0 weight:UIFontWeightRegular];
        _headline5 = [UIFont systemFontOfSize:24.0 weight:UIFontWeightRegular];
        _headline6 = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
        _subtitle1 = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
        _subtitle2 = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        _body1 = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
        _body2 = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        _caption = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        _button = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
        _overline = [UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
#pragma clang diagnostic pop
#else
        // TODO(#1296): Remove after we drop support for iOS 8
        _headline1 = [UIFont systemFontOfSize:96.0];
        _headline2 = [UIFont systemFontOfSize:60.0];
        _headline3 = [UIFont systemFontOfSize:48.0];
        _headline4 = [UIFont systemFontOfSize:34.0];
        _headline5 = [UIFont systemFontOfSize:24.0];
        _headline6 = [UIFont systemFontOfSize:20.0];
        _subtitle1 = [UIFont systemFontOfSize:16.0];
        _subtitle2 = [UIFont systemFontOfSize:14.0];
        _body1 = [UIFont systemFontOfSize:16.0];
        _body2 = [UIFont systemFontOfSize:14.0];
        _caption = [UIFont systemFontOfSize:12.0];
        _button = [UIFont systemFontOfSize:14.0];
        _overline = [UIFont systemFontOfSize:12.0];
#endif
        break;
    }
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  MDCTypographyScheme *copy = [[MDCTypographyScheme alloc] init];
  copy.headline1 = self.headline1;
  copy.headline2 = self.headline2;
  copy.headline3 = self.headline3;
  copy.headline4 = self.headline4;
  copy.headline5 = self.headline5;
  copy.headline6 = self.headline6;
  copy.subtitle1 = self.subtitle1;
  copy.subtitle2 = self.subtitle2;
  copy.body1 = self.body1;
  copy.body2 = self.body2;
  copy.caption = self.caption;
  copy.button = self.button;
  copy.overline = self.overline;

  return copy;
}

@end
