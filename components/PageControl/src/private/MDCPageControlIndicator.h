/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 * This shape layer provides a circular indicator denoting a page in a page control.
 *
 * @internal
 * @ingroup MaterialPageControl
 */
@interface MDCPageControlIndicator : CAShapeLayer

/** The color of the indicator. */
@property(nonatomic, strong) UIColor *color;

/**
 * Default initializer.
 *
 * @param center The layer position for this indicator.
 * @param radius The radius of this indicator circle.
 */
- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius;

/** Reveals the indicator by scaling from zero to full size while fading in. */
- (void)revealIndicator;

/**
 * Updates the indicator transform.x property along the track by the designated percentage.
 *
 * @param transformX The transform.x value.
 */
- (void)updateIndicatorTransformX:(CGFloat)transformX;

@end
