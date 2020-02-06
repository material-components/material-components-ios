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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A hairline is a narrow line shown at the bottom edge of a Flexible Header.

 The hairline can be shown or hidden and its color can be customized.

 This class acts as a controller for a hairline view.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCFlexibleHeaderHairline : NSObject

/**
 Initializes the instance with a given container view.
 */
- (nonnull instancetype)initWithContainerView:(nonnull UIView *)containerView
    NS_DESIGNATED_INITIALIZER;

/**
 The container view to which the hairline should be added.

 Note: this is weak because it is common for the container view to own the hairline instance.
 */
@property(nonatomic, weak, nullable) UIView *containerView;

#pragma mark Configuration

/**
 A Boolean value that governs whether the hairline is hidden.

 Defaults to YES.
 */
@property(nonatomic) BOOL hidden;

/**
 The color of the hairline.

 Defaults to black.
 */
@property(nonatomic, strong, nonnull) UIColor *color;

#pragma mark Unavailable methods

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
