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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MDCCard+Ripple.h"
#import "MaterialRipple.h"

@implementation MDCCard (Ripple)

- (MDCStatefulRippleView *)castedRippleView {
  if (![self.rippleView isKindOfClass:[MDCStatefulRippleView class]]) {
    NSAssert(NO, @"The ripple view needs to be of the kind MDCStatefulRippleView, otherwise"
                 @" a bad change has occurred and the ripple integration will not work.");
    return nil;
  }
  return (MDCStatefulRippleView *)self.rippleView;
}

- (void)cardRippleEnableBetaBehavior:(NSNumber *)enabledValue {
  BOOL enabled = enabledValue.boolValue;
  if (enabled) {
    self.rippleDelegate = self;
    if (self.rippleView == nil) {
      self.rippleView = [[MDCStatefulRippleView alloc] initWithFrame:self.bounds];
      self.rippleView.layer.zPosition = FLT_MAX;
      [self addSubview:self.rippleView];
    }
    if (self.inkView) {
      [self.inkView removeFromSuperview];
    }
  } else {
    self.rippleDelegate = nil;
    if (self.rippleView) {
      [self.rippleView removeFromSuperview];
    }
    [self addSubview:self.inkView];
  }
}

- (void)cardRippleDelegateSetHighlighted:(BOOL)highlighted {
  self.castedRippleView.rippleHighlighted = highlighted;
}

- (void)cardRippleDelegateTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesBegan:touches withEvent:event];
}

- (void)cardRippleDelegateTouchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesMoved:touches withEvent:event];
}

- (void)cardRippleDelegateTouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesEnded:touches withEvent:event];
}

- (void)cardRippleDelegateTouchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesCancelled:touches withEvent:event];
}

@end
