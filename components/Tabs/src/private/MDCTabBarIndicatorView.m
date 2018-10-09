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

#import "MDCTabBarIndicatorView.h"

#import "MDCTabBarIndicatorAttributes.h"

/** Content view that displays a filled path and supports animation between states. */
@interface MDCTabBarIndicatorShapeView: UIView

/** The path to display. It will be filled using the view's tintColor. */
@property(nonatomic, nullable) UIBezierPath *path;

@end

@implementation MDCTabBarIndicatorView {
  /// View responsible for drawing the indicator's path.
  MDCTabBarIndicatorShapeView *_shapeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCTabBarIndicatorViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCTabBarIndicatorViewInit];
  }
  return self;
}

#pragma mark - Public

- (void)applySelectionIndicatorAttributes:(MDCTabBarIndicatorAttributes *)attributes {
  _shapeView.path = attributes.path;
}

#pragma mark - Private

- (void)commonMDCTabBarIndicatorViewInit {
  // Fill the indicator with the shape.
  _shapeView = [[MDCTabBarIndicatorShapeView alloc] initWithFrame:self.bounds];
  _shapeView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:_shapeView];
}

@end

#pragma mark -

@implementation MDCTabBarIndicatorShapeView

- (UIBezierPath *)path {
  CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
  CGPathRef cgPath = shapeLayer.path;
  return cgPath ? [UIBezierPath bezierPathWithCGPath:cgPath] : nil;
}

- (void)setPath:(UIBezierPath *)path {
  CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
  shapeLayer.path = path.CGPath;
}

#pragma mark - CALayerDelegate

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
  id<CAAction> action = [super actionForLayer:layer forKey:event];
  // Support implicit animation of paths.
  if ((!action || action == [NSNull null]) && (layer == self.layer) && [event isEqual:@"path"]) {
    return [CABasicAnimation animationWithKeyPath:event];
  }
  return action;
}

#pragma mark - UIView

+ (Class)layerClass {
  return [CAShapeLayer class];
}

- (void)tintColorDidChange {
  [super tintColorDidChange];

  // Update layer fill color
  CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
  shapeLayer.fillColor = self.tintColor.CGColor;
}

@end
