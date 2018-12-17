// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCNumericValueLabel.h"

#import "MaterialTypography.h"

static const CGFloat kAnchorPointY = (CGFloat)1.15;
static const CGFloat kBezierSmoothingFactor = (CGFloat)0.0625;
static const CGFloat kLabelInsetSize = 6;

@implementation MDCNumericValueLabel {
  CAShapeLayer *_marker;
  UILabel *_label;
}

/**
 Inits a new numeric value label. Note that we expect the frame to be taller than it is wide, in
 order to correctly display the "ice cream cone" shape.
 */
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];

    _marker = [CAShapeLayer layer];
    _marker.fillRule = kCAFillRuleNonZero;
    [self.layer addSublayer:_marker];

    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor whiteColor];  // Default text color, override by setting textColor
    _label.font = [MDCTypography body1Font];  // Default font size, override by setting fontSize
    _label.adjustsFontSizeToFitWidth = YES;
    _label.minimumScaleFactor = (CGFloat)0.7;
    [self addSubview:_label];

    // So that scaling happens in relation to slightly below the thumb track. Also has the nice
    // effect of letting us set the view's "center" to be on the track, but have the view actually
    // appear above the thumb track.
    self.layer.anchorPoint = CGPointMake((CGFloat)0.5, kAnchorPointY);
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat width = self.bounds.size.width;
  CGFloat radius = width / 2;
  CGFloat height = self.bounds.size.height;
  CGFloat bezierSmoothingPixels = height * kBezierSmoothingFactor;

  CGMutablePathRef path = CGPathCreateMutable();

  // We're drawing a shape that looks something like this:
  //   __
  //  (  )
  //   \/

  // Calculate what point on the circle the lines on the bottom should touch. If you're interested
  // in the Math, we found these formulas like this:
  // 1. x^2 + y^2 = r defines the circle
  // 2. y = H - mx defines a family of lines from (0,H) where H is the height of the whole shape
  // 3. Now we try to find m such that the system of equations has only one (x,y) solution that
  //    satisfies both equations. This amounts to finding the line from (0,H) to the circle that
  //    only touches the circle one time.
  // 4. Substitute y = H - mx into first equation. x^2 + (H-mx)^2 = r^2
  // 5. Simplify and set to 0. (1 + m^2)x^2 + (-2Hm)x + (H^2 - r^2) = 0
  // 6. We now have a quadratic equation of the form ax^2 + bx + c = 0. Such equations have only
  //    one solution if and only if the discriminant d = b^2 - 4ac = 0
  // 7. Set discriminant to 0 and solve for m. 0 = (-2Hm)^2 - 4(1 + m^2)(H^2 - r^2)
  // 8. m = sqrt((H^2 - r^2)/(r^2))
  // 9. Now use quadratic formula to solve for x. x = (r * sqrt(H^2 - r^2)) / H
  // 10. Plug into original equation to get y. y = r^2 / H
  CGFloat x = (radius * sqrtf((float)(height * height - radius * radius))) / height;
  CGFloat y = radius * radius / height;

  // Calculate the angles at which the left and right lines touch the circle
  CGFloat angleDelta = atanf((float)(y / x));
  CGFloat startAngle = (float)M_PI - angleDelta;
  CGFloat endAngle = angleDelta;

  CGPathMoveToPoint(path, NULL, radius, height);

  // Draws line from bottom to left side of circle, curving slightly to smooth the shape
  CGPathAddCurveToPoint(path, NULL, radius, height, radius - x, radius + y + bezierSmoothingPixels,
                        radius - x, radius + y);

  // Draw the part of the circle that we need
  CGPathAddArc(path, NULL, radius, radius, radius, startAngle, endAngle, NO);

  // Curve back down from the right side of the circle to the bottom of the shape
  CGPathAddCurveToPoint(path, NULL, radius + x, radius + y + bezierSmoothingPixels, radius, height,
                        radius, height);
  CGPathCloseSubpath(path);

  _marker.path = path;
  CGPathRelease(path);

  // Place the label as well
  _label.frame = CGRectInset(CGRectMake(0, 0, width, width), kLabelInsetSize, kLabelInsetSize);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  _backgroundColor = backgroundColor;
  _marker.fillColor = _backgroundColor.CGColor;
}

- (UIColor *)textColor {
  return _label.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  _label.textColor = textColor;
}

- (CGFloat)fontSize {
  return _label.font.pointSize;
}

- (void)setFontSize:(CGFloat)fontSize {
  _label.font = [[MDCTypography fontLoader] regularFontOfSize:fontSize];
}

- (NSString *)text {
  return _label.text;
}

- (void)setText:(NSString *)text {
  _label.text = text;
}

@end
