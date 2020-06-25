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

#import "MDCDiscreteDotView.h"

@implementation MDCDiscreteDotView

- (instancetype)init {
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    _inactiveDotColor = UIColor.blackColor;
    _activeDotColor = UIColor.blackColor;
    _activeDotsSegment = CGRectMake(CGFLOAT_MIN, 0, 0, 0);
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  [self setNeedsDisplay];
}

- (void)setActiveDotColor:(UIColor *)activeDotColor {
  _activeDotColor = activeDotColor;
  [self setNeedsDisplay];
}

- (void)setInactiveDotColor:(UIColor *)inactiveDotColor {
  _inactiveDotColor = inactiveDotColor;
  [self setNeedsDisplay];
}

- (void)setActiveDotsSegment:(CGRect)activeDotsSegment {
  CGFloat newMinX = MAX(0, MIN(1, CGRectGetMinX(activeDotsSegment)));
  CGFloat newMaxX = MIN(1, MAX(0, CGRectGetMaxX(activeDotsSegment)));

  _activeDotsSegment = CGRectMake(newMinX, 0, (newMaxX - newMinX), 0);
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];

  if (_numDiscreteDots >= 2) {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    // The "dot" is a circle that gradually transforms into a rounded rectangle.
    // *   At 1- and 2-point track heights, use a circle filling the height.
    // *   At 3- and 4-point track heights, use a vertically-centered circle 2 points tall.
    // *   At greater track heights, create a vertically-centered rounded rectangle 2-points wide
    //     and half the track height.
    CGFloat trackHeight = CGRectGetHeight(self.bounds);
    CGFloat dotHeight = MIN(2, trackHeight);
    CGFloat dotWidth = MIN(2, trackHeight);
    CGFloat circleOriginY = (trackHeight - dotHeight) / 2;
    if (trackHeight > 4) {
      dotHeight = trackHeight / 2;
      circleOriginY = (trackHeight - dotHeight) / 2;
    }
    CGRect dotRect = CGRectMake(0, (trackHeight - dotHeight) / 2, dotWidth, dotHeight);
    // Increment within the bounds
    CGFloat absoluteIncrement = (CGRectGetWidth(self.bounds) - dotWidth) / (_numDiscreteDots - 1);
    // Increment within 0..1
    CGFloat relativeIncrement = (CGFloat)1.0 / (_numDiscreteDots - 1);

    // Allow an extra 10% of the increment to guard against rounding errors excluding dots that
    // should genuinely be within the active segment.
    CGFloat minActiveX = CGRectGetMinX(self.activeDotsSegment) - relativeIncrement * (CGFloat)0.1;
    CGFloat maxActiveX = CGRectGetMaxX(self.activeDotsSegment) + relativeIncrement * (CGFloat)0.1;
    for (NSUInteger i = 0; i < _numDiscreteDots; i++) {
      CGFloat relativePosition = i * relativeIncrement;
      if (minActiveX <= relativePosition && maxActiveX >= relativePosition) {
        [self.activeDotColor setFill];
      } else {
        [self.inactiveDotColor setFill];
      }
      dotRect.origin.x = (i * absoluteIncrement);
      // Clear any previous paths from the context
      CGContextBeginPath(contextRef);
      CGPathRef rectPathRef =
          CGPathCreateWithRoundedRect(dotRect, dotWidth / 2, dotWidth / 2, NULL);
      CGContextAddPath(contextRef, rectPathRef);
      CGContextFillPath(contextRef);
      CGPathRelease(rectPathRef);
    }
  }
}

- (void)setNumDiscreteDots:(NSUInteger)numDiscreteDots {
  _numDiscreteDots = numDiscreteDots;
  [self setNeedsDisplay];
}

@end
