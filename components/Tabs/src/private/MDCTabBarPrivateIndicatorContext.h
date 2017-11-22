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

#import <UIKit/UIKit.h>

#import "MDCTabBarIndicatorContext.h"

/// Concrete implementation of a tab indicator context.
@interface MDCTabBarPrivateIndicatorContext : NSObject <MDCTabBarIndicatorContext>

- (null_unspecified instancetype)init NS_UNAVAILABLE;

/// Designated initializer which creates a context from members.
- (nonnull instancetype)initWithItem:(nonnull UITabBarItem *)item
                              bounds:(CGRect)bounds
                        contentFrame:(CGRect)contentFrame NS_DESIGNATED_INITIALIZER;

@end
