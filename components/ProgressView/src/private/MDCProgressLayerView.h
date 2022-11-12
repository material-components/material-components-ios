// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 A view used to provide a non-gradient multicolored animation for MDCProgressView's progress bar.
 */
__attribute__((objc_subclassing_restricted))
@interface MDCProgressLayerView : UIView

/**
 Determines the colors displayed in the progress view, and the order in which they will be
 displayed. Defaults to nil. If this property is nil, no animations will occur.
 */
@property(nonatomic, nullable, copy) NSArray<UIColor *> *colors;

/**
 Starts the progress bar's indeterminate animations.
 */
- (void)startAnimating;

/**
 Stops the progress bar's indeterminate animations.
 */
- (void)stopAnimating;

NS_ASSUME_NONNULL_END

@end
