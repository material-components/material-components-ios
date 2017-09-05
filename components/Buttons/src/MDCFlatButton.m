/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFlatButton.h"

#import "MaterialShadowElevations.h"
#import "private/MDCButton+Subclassing.h"

static NSString *const MDCFlatButtonHasOpaqueBackground = @"MDCFlatButtonHasOpaqueBackground";

@implementation MDCFlatButton

+ (void)initialize {
  // Default background colors.
  [[MDCFlatButton appearance] setBackgroundColor:[UIColor clearColor]
                                        forState:UIControlStateNormal];
  [[MDCFlatButton appearance] setTitleColor:[UIColor blackColor]
                                   forState:UIControlStateNormal];
  [[MDCFlatButton appearance] setElevation:MDCShadowElevationNone
                                  forState:UIControlStateNormal];
  [[MDCFlatButton appearance] setElevation:MDCShadowElevationNone
                                  forState:UIControlStateHighlighted];
}

- (instancetype)init {
  return [self initWithFrame:CGRectZero];
}

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
