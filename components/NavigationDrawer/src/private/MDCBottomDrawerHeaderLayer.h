// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 MDCBottomDrawerHeaderLayer handles the shape calculations for
 MDCBottomDrawerContainerViewController.
 */
@interface MDCBottomDrawerHeaderLayer : NSObject

/**
 Creates an object for animating the corner radius of a mask layer

 @param maxCornerRadius The maximum corner radius for the animation
 @param minimumCornerRadius The minimum corner radius for the animation
 @note Must set a view for this to work
 */
- (nonnull instancetype)initWithMaxCornerRadius:(CGFloat)maxCornerRadius
                            minimumCornerRadius:(CGFloat)minimumCornerRadius;

/**
 The view that will be masked
 */
@property(nonatomic, strong, nullable) UIView *view;

/**
 Masks the view that we want to mask
 */
- (void)mask;

/**
 Animates the mask layers corner radius on the view

 @param percentage The precentage from maximum corner radius to minimum corner radius values can be
 from 0.0 to 1.0
 */
- (void)animateWithPercentage:(CGFloat)percentage;

@end
