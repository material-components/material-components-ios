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

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.inkLayer.frame = frame;
}

- (void)startInkAtPoint:(CGPoint)point {
  self.inkLayer = [MDCSimpleInkLayer layer];
  self.inkLayer.opacity = 0;
  self.inkLayer.frame = self.bounds;
  [self.layer addSublayer:self.inkLayer];
  [self.inkLayer start:point];
}

- (void)endInk {
  [self.inkLayer end];
}

- (void)endInkNow {
  self.inkLayer.endAnimDelay = 0;
  [self.inkLayer end];
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
      [self startInkAtPoint:point];
      break;
    case UIGestureRecognizerStateChanged:
      break;
    case UIGestureRecognizerStateEnded:
      [self.delegate inkView:self didTouchUpFromPoint:point];
      [self endInk];
      break;
    case UIGestureRecognizerStateCancelled:
      break;
    case UIGestureRecognizerStateFailed:
      break;
  }
}

@end
