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

@implementation MDCSimpleInkView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCSimpleInkViewInit];
  }
  return self;
}

- (void)commonMDCSimpleInkViewInit {
  MDCSimpleInkGestureRecognizer *tapGesture =
      [[MDCSimpleInkGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
  [self addGestureRecognizer:tapGesture];
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.inkLayer.frame = frame;
}

- (void)startInk:(CGPoint)point {
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

- (void)didTap:(MDCSimpleInkGestureRecognizer *)recognizer {
  CGPoint point = [recognizer locationInView:self];
  switch (recognizer.state) {
    case UIGestureRecognizerStatePossible:
      break;
    case UIGestureRecognizerStateBegan:
      [self.delegate didTouchDown];
      [self startInk:point];
      break;
    case UIGestureRecognizerStateChanged:
      break;
    case UIGestureRecognizerStateEnded:
      [self.delegate didTouchUp];
      [self endInk];
      break;
    case UIGestureRecognizerStateCancelled:
      break;
    case UIGestureRecognizerStateFailed:
      break;
  }
}

@end
