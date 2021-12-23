// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MDCMinimumOS.h"  // IWYU pragma: keep

@class MDCDotBadgeAppearance;

/** An indication that some non-quantifiable action might be required in a given context. */
__attribute__((objc_subclassing_restricted)) API_AVAILABLE(ios(13.0)) @interface MDCDotBadgeView
    : UIView

#pragma mark - Configuring the badge's visual appearance

/**
 The appearance attributes for this badge.

 Assigning to nil will reset the appearance to reasonable, yet undefined defaults.
 */
@property(nonatomic, copy, null_resettable, direct) MDCDotBadgeAppearance *appearance;

#pragma mark - Unsupported APIs

// Interface builder is not supported.
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
