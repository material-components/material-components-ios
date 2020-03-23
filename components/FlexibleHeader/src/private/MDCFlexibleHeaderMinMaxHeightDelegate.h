// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCFlexibleHeaderMinMaxHeight;

/**
 The delegate protocol through which MDCFlexibleHeaderMinMaxHeight communicates changes in the
 minimum and maximum height.
 */
@protocol MDCFlexibleHeaderMinMaxHeightDelegate <NSObject>
@required

/**
 Informs the receiver that the maximum height has changed.
 */
- (void)flexibleHeaderMaximumHeightDidChange:(nonnull MDCFlexibleHeaderMinMaxHeight *)safeAreas;

/**
 Informs the receiver that either the minimum or maximum height have changed.
 */
- (void)flexibleHeaderMinMaxHeightDidChange:(nonnull MDCFlexibleHeaderMinMaxHeight *)safeAreas;

@end
