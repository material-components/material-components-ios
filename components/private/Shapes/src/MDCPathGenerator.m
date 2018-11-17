// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCPathGenerator.h"

#import "MaterialMath.h"

@interface MDCPathCommand : NSObject
- (void)applyToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform;
@end

@interface MDCPathLineCommand : MDCPathCommand
@property(nonatomic, assign) CGPoint point;
@end

@interface MDCPathArcCommand : MDCPathCommand
@property(nonatomic, assign) CGPoint point;
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;
@property(nonatomic, assign) BOOL clockwise;
@end

@interface MDCPathArcToCommand : MDCPathCommand
@property(nonatomic, assign) CGPoint start;
@property(nonatomic, assign) CGPoint end;
@property(nonatomic, assign) CGFloat radius;
@end

@interface MDCPathCurveCommand : MDCPathCommand
@property(nonatomic, assign) CGPoint control1;
@property(nonatomic, assign) CGPoint control2;
@property(nonatomic, assign) CGPoint end;
@end

@interface MDCPathQuadCurveCommand : MDCPathCommand
@property(nonatomic, assign) CGPoint control;
@property(nonatomic, assign) CGPoint end;
@end

@implementation MDCPathGenerator {
  NSMutableArray *_operations;
  CGPoint _startPoint;
  CGPoint _endPoint;
}

+ (nonnull instancetype)pathGenerator {
  return [[self alloc] initWithStartPoint:CGPointZero];
}

+ (instancetype)pathGeneratorWithStartPoint:(CGPoint)start {
  return [[self alloc] initWithStartPoint:start];
}

- (instancetype)initWithStartPoint:(CGPoint)start {
  if (self = [super init]) {
    _operations = [NSMutableArray array];

    _startPoint = start;
    _endPoint = start;
  }
  return self;
}

- (void)addLineToPoint:(CGPoint)point {
  MDCPathLineCommand *op = [[MDCPathLineCommand alloc] init];
  op.point = point;
  [_operations addObject:op];

  _endPoint = point;
}

- (void)addArcWithCenter:(CGPoint)center
                  radius:(CGFloat)radius
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
               clockwise:(BOOL)clockwise {
  MDCPathArcCommand *op = [[MDCPathArcCommand alloc] init];
  op.point = center;
  op.radius = radius;
  op.startAngle = startAngle;
  op.endAngle = endAngle;
  op.clockwise = clockwise;
  [_operations addObject:op];

  _endPoint = CGPointMake(center.x + radius * MDCCos(endAngle),
                          center.y + radius * MDCSin(endAngle));
}

- (void)addArcWithTangentPoint:(CGPoint)tangentPoint
                       toPoint:(CGPoint)toPoint
                        radius:(CGFloat)radius {
  MDCPathArcToCommand *op = [[MDCPathArcToCommand alloc] init];
  op.start = tangentPoint;
  op.end = toPoint;
  op.radius = radius;
  [_operations addObject:op];

  _endPoint = toPoint;
}

- (void)addCurveWithControlPoint1:(CGPoint)controlPoint1
                    controlPoint2:(CGPoint)controlPoint2
                          toPoint:(CGPoint)toPoint {
  MDCPathCurveCommand *op = [[MDCPathCurveCommand alloc] init];
  op.control1 = controlPoint1;
  op.control2 = controlPoint2;
  op.end = toPoint;
  [_operations addObject:op];

  _endPoint = toPoint;
}

- (void)addQuadCurveWithControlPoint:(CGPoint)controlPoint
                             toPoint:(CGPoint)toPoint {
  MDCPathQuadCurveCommand *op = [[MDCPathQuadCurveCommand alloc] init];
  op.control = controlPoint;
  op.end = toPoint;
  [_operations addObject:op];

  _endPoint = toPoint;
}

- (void)appendToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform {
  for (MDCPathCommand *op in _operations) {
    [op applyToCGPath:cgPath transform:transform];
  }
}

@end

@implementation MDCPathCommand

- (void)applyToCGPath:(CGMutablePathRef)__unused cgPath
            transform:(CGAffineTransform *)__unused transform {
  // no-op
}

@end

@implementation MDCPathLineCommand

- (void)applyToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform {
  CGPathAddLineToPoint(cgPath, transform, self.point.x, self.point.y);
}

@end

@implementation MDCPathArcCommand
- (void)applyToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform {
  CGPathAddArc(cgPath,
               transform,
               self.point.x,
               self.point.y,
               self.radius,
               self.startAngle,
               self.endAngle,
               self.clockwise);
}
@end

@implementation MDCPathArcToCommand

- (void)applyToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform {
  CGPathAddArcToPoint(cgPath,
                      transform,
                      self.start.x,
                      self.start.y,
                      self.end.x,
                      self.end.y,
                      self.radius);
}

@end

@implementation MDCPathCurveCommand

- (void)applyToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform {
  CGPathAddCurveToPoint(cgPath,
                        transform,
                        self.control1.x,
                        self.control1.y,
                        self.control2.x,
                        self.control2.y,
                        self.end.x,
                        self.end.y);
}

@end

@implementation MDCPathQuadCurveCommand

- (void)applyToCGPath:(CGMutablePathRef)cgPath transform:(CGAffineTransform *)transform {
  CGPathAddQuadCurveToPoint(cgPath,
                            transform,
                            self.control.x,
                            self.control.y,
                            self.end.x,
                            self.end.y);
}

@end
