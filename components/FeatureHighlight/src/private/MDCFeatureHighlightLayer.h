/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

@interface MDCFeatureHighlightLayer : CAShapeLayer

@property (nonatomic, assign) CGPoint center;

- (void)setCenter:(CGPoint)center radius:(CGFloat)radius animated:(BOOL)animated;

- (void)setFillColor:(CGColorRef)fillColor animated:(BOOL)animated;

- (void)animateRadiusOverKeyframes:(NSArray *)radii
                          keyTimes:(NSArray *)keyTimes
                            center:(CGPoint)center;

- (void)animateFillColorOverKeyframes:(NSArray *)colors keyTimes:(NSArray *)keyTimes;

@end
