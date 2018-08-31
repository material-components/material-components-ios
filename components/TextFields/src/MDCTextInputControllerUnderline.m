/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInputControllerUnderline.h"

static const CGFloat MDCTextInputControllerUnderlineDefaultUnderlineActiveHeight = 2;
static const CGFloat MDCTextInputControllerUnderlineDefaultUnderlineNormalHeight = 1;

static CGFloat _underlineHeightActiveDefault =
    MDCTextInputControllerUnderlineDefaultUnderlineActiveHeight;
static CGFloat _underlineHeightNormalDefault =
    MDCTextInputControllerUnderlineDefaultUnderlineNormalHeight;

@interface MDCTextInputControllerUnderline ()
@end

@implementation MDCTextInputControllerUnderline

#pragma mark - Properties

+ (CGFloat)underlineHeightActiveDefault {
  return _underlineHeightActiveDefault;
}

+ (void)setUnderlineHeightActiveDefault:(CGFloat)underlineHeightActiveDefault {
  _underlineHeightActiveDefault = underlineHeightActiveDefault;
}

+ (CGFloat)underlineHeightNormalDefault {
  return _underlineHeightNormalDefault;
}

+ (void)setUnderlineHeightNormalDefault:(CGFloat)underlineHeightNormalDefault {
  _underlineHeightNormalDefault = underlineHeightNormalDefault;
}

@end
