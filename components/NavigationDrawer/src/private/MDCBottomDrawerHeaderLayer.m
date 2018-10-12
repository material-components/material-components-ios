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

#import "MDCBottomDrawerHeaderLayer.h"

@implementation MDCBottomDrawerHeaderLayer

- (CALayer *)layerForCornerRadius:(CGFloat)cornerRadius inView:(UIView *)view {
  CAShapeLayer *headerLayer = [[CAShapeLayer alloc] init];
  CGRect safeBounds = CGRectStandardize(view.bounds);
  CGFloat safeHeight = safeBounds.size.height;
  CGFloat safeWidth = safeBounds.size.width;
  CGFloat halfViewHeight = safeHeight / 2;
  CGFloat halfViewWidth = safeWidth / 2;
  CGFloat safeCornerRadius = MIN(cornerRadius, MIN(halfViewWidth, halfViewHeight));
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGPoint origin = CGPointMake(safeCornerRadius, 0);
  [path moveToPoint:origin];
  [path addLineToPoint:CGPointMake(safeWidth - safeCornerRadius, 0)];
  [path addArcWithCenter:CGPointMake(safeWidth - safeCornerRadius, safeCornerRadius)
                  radius:safeCornerRadius
              startAngle:M_PI
                endAngle:-M_PI
               clockwise:YES];
  [path addLineToPoint:CGPointMake(safeWidth, safeHeight)];
  [path addLineToPoint:CGPointMake(0, CGRectGetHeight(view.bounds))];
  [path addArcWithCenter:CGPointMake(safeCornerRadius, safeCornerRadius)
                  radius:safeCornerRadius
              startAngle:-M_PI
                endAngle:M_PI
               clockwise:YES];
  [path closePath];
  headerLayer.path = path.CGPath;
  return headerLayer;
}

@end
