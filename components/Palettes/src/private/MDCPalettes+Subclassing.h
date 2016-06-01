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

#import "MDCPalette.h"

// Access to Color creation to be used for Palette creation.
static inline UIColor *ColorFromRGB(uint32_t rgbValue);

// Access to constants to be used for Palette creation.
extern const NSString *kTint50Name;
extern const NSString *kTint100Name;
extern const NSString *kTint200Name;
extern const NSString *kTint300Name;
extern const NSString *kTint400Name;
extern const NSString *kTint500Name;
extern const NSString *kTint600Name;
extern const NSString *kTint700Name;
extern const NSString *kTint800Name;
extern const NSString *kTint900Name;
extern const NSString *kAccent100Name;
extern const NSString *kAccent200Name;
extern const NSString *kAccent400Name;
extern const NSString *kAccent700Name;

@interface MDCPalette (Subclassing)

// Access to MDCPalette creation.
- (instancetype)initWithTints:(NSDictionary *)tints accents:(NSDictionary *)accents;

@end
