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
#import "MDCCardCollectionCell+Ripple.h"

@implementation MDCCardCollectionCell (Ripple)

- (MDCStatefulRippleView *)castedRippleView {
  return (MDCStatefulRippleView *)self.rippleView;
}

- (void)initializeRipple {
  self.rippleDelegate = self;
  self.selectedImageView.hidden = NO;
  if (self.rippleView == nil) {
    self.rippleView = [[MDCStatefulRippleView alloc] initWithFrame:self.bounds];
    self.rippleView.layer.zPosition = FLT_MAX;
    [self addSubview:self.rippleView];
  }
  if (self.inkView) {
    [self.inkView removeFromSuperview];
  }
}

- (void)setRippleSelected:(BOOL)selected {
  if (!self.selectable) {
    return;
  }
  self.castedRippleView.selected = selected;
  [self updateCardCellVisuals];
}

- (void)setRippleHighlighted:(BOOL)highlighted {
  self.castedRippleView.rippleHighlighted = highlighted;
  [self updateCardCellVisuals];
}

- (void)setRippleSelectable:(BOOL)selectable {
  self.castedRippleView.allowsSelection = selectable;
}

- (UIImage *)updateRippleImage:(UIImage *)image {
  // CardCollectionCell's state system doesn't incorporate multiple states occuring simultaneously.
  // When the card is selected and highlighted it should take the image of MDCCardCellStateSelected.
  if (self.castedRippleView.selected) {
    image = [self imageForState:MDCCardCellStateSelected];
  }
  return image;
}

- (UIColor *)updateRippleImageTintColor:(UIColor *)imageTintColor {
  // CardCollectionCell's state system doesn't incorporate multiple states occuring simultaneously.
  // When the card is selected and highlighted it should take the image tint of
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

- (MDCCardCellState)rippleDelegateState {
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

- (void)rippleDelegateTouchesEnded {
  if (self.dragged) {
    self.dragged = NO;
  }
}

- (void)rippleDelegateTouchesCancelled {
  if (self.dragged) {
    self.dragged = NO;
  }
}

- (void)rippleDelegateSetDragged:(BOOL)dragged {
  self.castedRippleView.dragged = dragged;
  if (dragged) {
    self.highlighted = NO;
  }
  [self updateCardCellVisuals];
}

@end
