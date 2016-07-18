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

#import "private/MDCButton+Subclassing.h"

static NSString *const MDCFlatButtonHasOpaqueBackground = @"MDCFlatButtonHasOpaqueBackground";

// Blue 500 from http://www.google.com/design/spec/style/color.html#color-color-palette .
static const uint32_t MDCFlatButtonDefaultTitleColor = 0x2196F3;

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

@implementation MDCFlatButton

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCFlatButtonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    if ([aDecoder containsValueForKey:MDCFlatButtonHasOpaqueBackground]) {
      self.hasOpaqueBackground = [aDecoder decodeBoolForKey:MDCFlatButtonHasOpaqueBackground];
    }
    [self commonMDCFlatButtonInit];
  }
  return self;
}

- (void)commonMDCFlatButtonInit {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.shouldRaiseOnTouch = NO;
#pragma clang diagnostic pop
  [self setTitleColor:MDCColorFromRGB(MDCFlatButtonDefaultTitleColor)
             forState:UIControlStateNormal];
  [self setBackgroundColor:nil forState:UIControlStateNormal];
  self.inkColor = [UIColor colorWithWhite:0 alpha:0.06f];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeBool:_hasOpaqueBackground forKey:MDCFlatButtonHasOpaqueBackground];
}

#pragma mark - MDCButton Subclassing

- (void)setHasOpaqueBackground:(BOOL)hasOpaqueBackground {
  _hasOpaqueBackground = hasOpaqueBackground;
  [self updateBackgroundColor];
}

- (BOOL)shouldHaveOpaqueBackground {
  return [super shouldHaveOpaqueBackground] || self.hasOpaqueBackground;
}

@end
