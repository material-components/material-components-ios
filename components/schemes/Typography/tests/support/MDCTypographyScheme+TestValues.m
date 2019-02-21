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

#import "MDCTypographyScheme+TestValues.h"

@implementation MDCTypographyScheme (TestValues)

+ (instancetype)typographySchemeWithVaryingFontSize {
  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  typographyScheme.headline1 = [UIFont systemFontOfSize:30];
  typographyScheme.headline2 = [UIFont systemFontOfSize:28];
  typographyScheme.headline3 = [UIFont systemFontOfSize:26];
  typographyScheme.headline4 = [UIFont systemFontOfSize:24];
  typographyScheme.headline5 = [UIFont systemFontOfSize:22];
  typographyScheme.headline6 = [UIFont systemFontOfSize:20];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:18];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:16];
  typographyScheme.body1 = [UIFont systemFontOfSize:14];
  typographyScheme.body2 = [UIFont systemFontOfSize:12];
  typographyScheme.caption = [UIFont systemFontOfSize:10];
  typographyScheme.button = [UIFont systemFontOfSize:8];
  typographyScheme.overline = [UIFont systemFontOfSize:6];
  return typographyScheme;
}

@end
