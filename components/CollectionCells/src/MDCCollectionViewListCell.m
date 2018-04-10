//
//  MDCCollectionViewListCell.m
//  MaterialComponents
//
//  Created by yar on 4/9/18.
//

#import "MDCCollectionViewListCell.h"

@implementation MDCCollectionViewListCell {
  CGPoint _lastTouch;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;

  [super touchesBegan:touches withEvent:event];
}

- (CGSize)sizeThatFits:(CGSize)size {

}

@end
