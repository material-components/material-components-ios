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

#import "MDCButtonScheme.h"

@implementation MDCButtonScheme

- (instancetype)init {
  self = [super init];
  if (self) {
    _colorScheme = [[MDCSemanticColorScheme alloc] init];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
    _minimumHeight = 36;
    _cornerRadius = (CGFloat)4;
  }
  return self;
}
@end
