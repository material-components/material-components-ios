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

#import "MDCCardCollectionCell+Ripple.h"
#import "MaterialRipple.h"

@implementation MDCCardCollectionCell (Ripple)

- (MDCStatefulRippleView *)castedRippleView {
  if (![self.rippleView isKindOfClass:[MDCStatefulRippleView class]]) {
    NSAssert(NO, @"The ripple view needs to be of the kind MDCStatefulRippleView, otherwise"
                 @" a bad change has occurred and the ripple integration will not work.");
    return nil;
  }
  return (MDCStatefulRippleView *)self.rippleView;
}

- (void)cardCellRippleEnableBetaBehavior:(NSNumber *)enabledValue {
  BOOL enabled = enabledValue.boolValue;
  if (enabled) {
    self.rippleDelegate = self;
    // With the new states implementation the selectedImageView doesn't need to be hidden as
    // there can be an image apparent not only when the cell is selected, but rather
    // depending on the setImage:ForState: API.
    self.selectedImageView.hidden = NO;
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
    self.selectedImageView.hidden = YES;
    if (self.rippleView) {
      [self.rippleView removeFromSuperview];
    }
    [self addSubview:self.inkView];
  }
}

- (void)cardCellRippleDelegateSetSelected:(BOOL)selected {
  if (!self.selectable) {
    return;
  }
  self.castedRippleView.selected = selected;
  [self updateCardCellVisuals];
}

- (void)cardCellRippleDelegateSetHighlighted:(BOOL)highlighted {
  self.castedRippleView.rippleHighlighted = highlighted;
  [self updateCardCellVisuals];
}

- (void)cardCellRippleDelegateSetSelectable:(BOOL)selectable {
  self.castedRippleView.allowsSelection = selectable;
}

- (UIImage *)cardCellRippleDelegateUpdateImage:(UIImage *)image {
  // TODO(#6661): CardCollectionCell's state system doesn't incorporate multiple states occuring
  // simultaneously. When the card is selected and highlighted it should take the image of
  // MDCCardCellStateSelected.
  if (self.castedRippleView.selected) {
    image = [self imageForState:MDCCardCellStateSelected];
  }
  return image;
}

- (UIColor *)cardCellRippleDelegateUpdateImageTintColor:(UIColor *)imageTintColor {
  // TODO(#6661): CardCollectionCell's state system doesn't incorporate multiple states occuring
  // simultaneously. When the card is selected and highlighted it should take the image tint of
  // MDCCardCellStateSelected.
  if (self.castedRippleView.selected) {
    imageTintColor = [self imageTintColorForState:MDCCardCellStateSelected];
  }
  return imageTintColor;
}

- (void)updateCardCellVisuals {
  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
  [self updateImage];
  [self updateImageAlignment];
  [self updateImageTintColor];
}

- (MDCCardCellState)cardCellRippleDelegateState {
  if (self.selected && self.selectable) {
    return MDCCardCellStateSelected;
  } else if (self.dragged) {
    return MDCCardCellStateDragged;
  } else if (self.highlighted) {
    return MDCCardCellStateHighlighted;
  } else {
    return MDCCardCellStateNormal;
  }
}

- (void)cardCellRippleDelegateTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesBegan:touches withEvent:event];
}

- (void)cardCellRippleDelegateTouchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesMoved:touches withEvent:event];
}

- (void)cardCellRippleDelegateTouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.castedRippleView touchesEnded:touches withEvent:event];
  if (self.dragged) {
    self.dragged = NO;
  }
}

- (void)cardCellRippleDelegateTouchesCancelled:(NSSet<UITouch *> *)touches
                                     withEvent:(UIEvent *)event {
  [self.castedRippleView touchesCancelled:touches withEvent:event];
  if (self.dragged) {
    self.dragged = NO;
  }
}

- (void)cardCellRippleDelegateSetDragged:(BOOL)dragged {
  self.castedRippleView.dragged = dragged;
  if (dragged) {
    self.highlighted = NO;
  }
  [self updateCardCellVisuals];
}

@end
