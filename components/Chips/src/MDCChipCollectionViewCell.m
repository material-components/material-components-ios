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

#import <CoreGraphics/CoreGraphics.h>

#import "MDCChipCollectionViewCell.h"

#import "private/MDCChipView+Private.h"

static NSString *const MDCChipCollectionViewCellChipViewKey =
    @"MDCChipCollectionViewCellChipViewKey";

@implementation MDCChipCollectionViewCell

- (instancetype)initWithFrame:(CGRect)rect {
  if (self = [super initWithFrame:rect]) {
    _chipView = [self createChipView];
    [self.contentView addSubview:_chipView];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    _chipView = [aDecoder decodeObjectForKey:MDCChipCollectionViewCellChipViewKey];
    // _chipView is already added to the view hierarchy by UIView initWithCoder.
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];

  [aCoder encodeObject:self.chipView forKey:MDCChipCollectionViewCellChipViewKey];
}

- (void)setBounds:(CGRect)bounds {
  [super setBounds:bounds];

  // We update selected state here in the event that the MDCChipView will resize upon selection.
  // This way any layout changes on selection can be animated.
  _chipView.selected = self.selected;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  BOOL animated = NO;
  if (self.alwaysAnimateResize) {
    BOOL isFrameNonzero = !CGRectIsEmpty(_chipView.frame) && !CGRectIsEmpty(self.bounds);
    BOOL isFrameDifferent = !CGRectEqualToRect(_chipView.frame, self.bounds);

    animated = isFrameNonzero && isFrameDifferent;
  }

  if (animated) {
    [UIView animateWithDuration:0.25 animations:^{
      self.chipView.frame = self.bounds;
      [self.chipView layoutIfNeeded];
    }];
  } else {
    _chipView.frame = self.bounds;
  }
}

- (MDCChipView *)createChipView {
  return [[MDCChipView alloc] init];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [_chipView sizeThatFits:size];
}

- (CGSize)intrinsicContentSize {
  return [_chipView intrinsicContentSize];
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];

  if (self.alwaysAnimateResize && [_chipView willChangeSizeWithSelectedValue:selected]) {
    // Since MDCChipView can resize when it is selected, if a resize will occur we need to delay our
    // selected state update until our next layout.
    [self setNeedsLayout];
  } else {
    _chipView.selected = selected;
  }
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];

  _chipView.highlighted = highlighted;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  if (view == _chipView) {
    // We want the collection view cell to be responsible for managing selected and highlighted
    // states, so we highjack touches that go to the chip view. Touches on the accessory view will
    // still pass through for cases like delete buttons.
    return self;
  }
  return view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  [_chipView startTouchBeganAnimationAtPoint:[self locationFromTouches:touches]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  [_chipView startTouchEndedAnimationAtPoint:[self locationFromTouches:touches]];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  [_chipView startTouchEndedAnimationAtPoint:[self locationFromTouches:touches]];
}

- (CGPoint)locationFromTouches:(NSSet<UITouch *> *)touches {
  UITouch *touch = [touches anyObject];
  return [touch locationInView:_chipView];
}

@end
