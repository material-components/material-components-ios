// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

@interface MDCSheetBehavior : UIDynamicBehavior

/**
 * The final center-point for the item to arrive at.
 */
@property(nonatomic) CGPoint targetPoint;

/**
 * The initial velocity for the behavior.
 */
@property(nonatomic) CGPoint velocity;

/**
 * Initializes a @c MDCSheetBehavior.
 * @param item The dynamic item (a view) to apply the sheet behavior to.
 */
- (nonnull instancetype)initWithItem:(nonnull id<UIDynamicItem>)item NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
