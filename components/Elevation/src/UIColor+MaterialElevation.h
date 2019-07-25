// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MaterialElevation)

/// Returns a color that takes the specified elevation value into account.
/// @param elevation The elevation to use when resolving the color.
- (UIColor *)resolvedColorWithElevation:(CGFloat)elevation;

/// Returns a color that takes the specified elevation value and traits into account.
/// @param traitCollection The traits to use when resolving the color.
/// @param elevation The elevation to use when resolving the color.
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)traitCollection
                                 andElevation:(CGFloat)elevation API_AVAILABLE(ios(13.0));

@end

NS_ASSUME_NONNULL_END
