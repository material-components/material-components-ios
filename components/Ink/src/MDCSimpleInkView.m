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

@interface MDCSimpleInkView ()

@property(nonatomic, strong) MDCSimpleInkLayer *inkLayer;

@end

@implementation MDCSimpleInkView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _inkColor = [UIColor colorWithWhite:0 alpha:0.08f];
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.inkLayer.frame = frame;
}

- (void)startInkAtPoint:(CGPoint)point
             completion:(MDCSimpleInkCompletionBlock)completionBlock {
  self.inkLayer = [MDCSimpleInkLayer layer];
  self.inkLayer.inkColor = self.inkColor;
  self.inkLayer.completionBlock = completionBlock;
  self.inkLayer.opacity = 0;
  self.inkLayer.frame = self.bounds;
  [self.layer addSublayer:self.inkLayer];
  [self.inkLayer startAnimationAtPoint:point];
}

- (void)endInkAnimated:(BOOL)animated {
  if (!animated) {
    self.inkLayer.endAnimationDelay = 0;
  }
  [self.inkLayer endAnimation];
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
      break;
    case UIGestureRecognizerStateEnded:
      [self.delegate inkView:self didTouchUpFromPoint:point];
      [self endInkAnimated:YES];
      break;
    case UIGestureRecognizerStateCancelled:
      break;
    case UIGestureRecognizerStateFailed:
      break;
  }
}

- (void)setInkColor:(UIColor *)inkColor {
  _inkColor = inkColor;
  self.inkLayer.inkColor = inkColor;
}

@end
