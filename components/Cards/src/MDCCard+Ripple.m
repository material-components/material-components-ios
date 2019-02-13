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

#import "MaterialRipple.h"
#import "MDCCard+Ripple.h"

@implementation MDCCard (Ripple)

- (MDCStatefulRippleView *)castedRippleView {
  return (MDCStatefulRippleView *)self.rippleView;
}

- (void)initializeRipple {
  self.rippleDelegate = self;
  if (self.rippleView == nil) {
    self.rippleView = [[MDCStatefulRippleView alloc] initWithFrame:self.bounds];
    self.rippleView.layer.zPosition = FLT_MAX;
    [self addSubview:self.rippleView];
  }
  if (self.inkView) {
    [self.inkView removeFromSuperview];
  }
}

- (void)rippleDelegateSetHighlighted:(BOOL)highlighted {
  self.castedRippleView.rippleHighlighted = highlighted;
}

- (void)rippleDelegateTouchesCancelled {
  [self.castedRippleView touchCancelledForSuperview];
}

- (void)rippleDelegateTouchesEnded {
  [self.castedRippleView touchEndedForSuperview];
}

- (void)rippleDelegateTouchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchMovedForSuperview:[touches anyObject] event:event];
}


@end
