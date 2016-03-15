/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCFlatButton.h"

#import "privateWasCapitalPrivate/MDCButton+Subclassing.h"

static NSString *const MDCFlatButtonHasOpaqueBackground = @"MDCFlatButtonHasOpaqueBackground";

@implementation MDCFlatButton

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.shouldRaiseOnTouch = NO;
    self.backgroundColor = nil;
    self.inkColor = [UIColor colorWithWhite:0 alpha:CGColorGetAlpha(self.inkColor.CGColor)];
  }
  return self;
}

- (void)setHasOpaqueBackground:(BOOL)hasOpaqueBackground {
  _hasOpaqueBackground = hasOpaqueBackground;
  [self updateBackgroundColor];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    if ([aDecoder containsValueForKey:MDCFlatButtonHasOpaqueBackground]) {
      self.hasOpaqueBackground = [aDecoder decodeBoolForKey:MDCFlatButtonHasOpaqueBackground];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeBool:_hasOpaqueBackground forKey:MDCFlatButtonHasOpaqueBackground];
}

#pragma mark - MDCButton Subclassing

- (BOOL)shouldHaveOpaqueBackground {
  return [super shouldHaveOpaqueBackground] || self.hasOpaqueBackground;
}
@end
