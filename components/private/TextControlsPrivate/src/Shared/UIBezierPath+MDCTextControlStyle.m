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

#import "UIBezierPath+MDCTextControlStyle.h"


// TODO: Consider looking into whether or not the Shapes library already has this functionality, as
// recommended in https://github.com/material-components/material-components-ios/pull/8628.
@implementation UIBezierPath (MDCTextControlStyle)

- (void)mdc_addTopRightCornerFromPoint:(CGPoint)point1
                               toPoint:(CGPoint)point2
                            withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)(M_PI / 2);
  CGFloat endAngle = 0;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [self addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

- (void)mdc_addBottomRightCornerFromPoint:(CGPoint)point1
                                  toPoint:(CGPoint)point2
                               withRadius:(CGFloat)radius {
  CGFloat startAngle = 0;
  CGFloat endAngle = -(CGFloat)((M_PI * 3) / 2);
  CGPoint center = CGPointMake(point2.x, point1.y);
  [self addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

- (void)mdc_addBottomLeftCornerFromPoint:(CGPoint)point1
                                 toPoint:(CGPoint)point2
                              withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)((M_PI * 3) / 2);
  CGFloat endAngle = -(CGFloat)M_PI;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [self addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

- (void)mdc_addTopLeftCornerFromPoint:(CGPoint)point1
                              toPoint:(CGPoint)point2
                           withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)M_PI;
  CGFloat endAngle = -(CGFloat)(M_PI / 2);
  CGPoint center = CGPointMake(point1.x + radius, point2.y + radius);
  [self addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

@end
