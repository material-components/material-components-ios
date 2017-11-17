/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCSimpleInkView.h"
#import "MDCSimpleInkGestureRecognizer.h"
#import "private/MDCSimpleInkLayer.h"

@interface MDCSimpleInkView () <MDCSimpleInkLayerDelegate>

@property(nonatomic, strong) MDCSimpleInkLayer *activeInkLayer;
@property(nonatomic, strong) NSMutableArray<MDCSimpleInkLayer *> *inkLayers;
@property(nonatomic, assign) BOOL touchInsideView;

@end

@implementation MDCSimpleInkView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCSimpleInkViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCSimpleInkViewInit];
  }
  return self;
}

- (void)commonMDCSimpleInkViewInit {
  _inkColor = [UIColor colorWithWhite:0 alpha:0.08f];
  _touchInsideView = YES;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.activeInkLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)startInkAtPoint:(CGPoint)point
             completion:(MDCSimpleInkCompletionBlock)completionBlock {
  MDCSimpleInkLayer *inkLayer = [MDCSimpleInkLayer layer];
  inkLayer.animationDelegate = self;
  inkLayer.inkColor = self.inkColor;
  inkLayer.completionBlock = completionBlock;
  inkLayer.opacity = 0;
  inkLayer.frame = self.bounds;
  [self.layer addSublayer:inkLayer];
  [self.inkLayers addObject:inkLayer];
  [inkLayer startAnimationAtPoint:point];
  self.activeInkLayer = inkLayer;
}

- (void)changeInk:(MDCSimpleInkLayer *)inkLayer point:(CGPoint)point {
  BOOL viewContainsPoint = CGRectContainsPoint(self.bounds, point) ? YES : NO;
  if (viewContainsPoint == self.touchInsideView) {
    return;
  }
  self.touchInsideView = viewContainsPoint;
  [inkLayer changeAnimationAtPoint:point];
}

- (void)endInkAtPoint:(CGPoint)point animated:(BOOL)animated {
  [self endInk:self.activeInkLayer point:point animated:animated];
}

- (void)endInk:(MDCSimpleInkLayer *)inkLayer point:(CGPoint)point animated:(BOOL)animated {
  if (!animated) {
    inkLayer.endAnimationDelay = 0;
  }
  [inkLayer endAnimationAtPoint:point];
}

- (void)addInkGestureRecognizer {
  MDCSimpleInkGestureRecognizer *tapGesture =
      [[MDCSimpleInkGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
  [self addGestureRecognizer:tapGesture];
}

- (void)didTap:(MDCSimpleInkGestureRecognizer *)recognizer {
  CGPoint point = [recognizer locationInView:self];
  switch (recognizer.state) {
    case UIGestureRecognizerStatePossible:
      break;
    case UIGestureRecognizerStateBegan:
      [self.delegate inkView:self didTouchDownAtPoint:point];
      [self startInkAtPoint:point completion:self.completionBlock];
      break;
    case UIGestureRecognizerStateChanged:
      [self changeInk:self.activeInkLayer point:point];
      break;
    case UIGestureRecognizerStateEnded:
      [self.delegate inkView:self didTouchUpAtPoint:point];
      [self endInk:self.activeInkLayer point:point animated:YES];
      break;
    case UIGestureRecognizerStateCancelled:
      [self endInk:self.activeInkLayer point:point animated:YES];
      break;
    case UIGestureRecognizerStateFailed:
      [self endInk:self.activeInkLayer point:point animated:YES];
      break;
  }
}

- (void)setInkColor:(UIColor *)inkColor {
  _inkColor = inkColor;
  self.activeInkLayer.inkColor = inkColor;
}

#pragma mark - MDCSimpleInkLayerDelegate

- (void)inkLayerAnimationDidEnd:(MDCSimpleInkLayer *)inkLayer {
  [inkLayer removeFromSuperlayer];
}

@end
