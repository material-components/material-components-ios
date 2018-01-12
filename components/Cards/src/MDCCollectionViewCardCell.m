//
//  MDCCollectionViewCardCell.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import "MDCCollectionViewCardCell.h"

@implementation MDCCollectionViewCardCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.cardView = [[MDCCard alloc] initWithFrame:self.contentView.bounds
                   withIsUsingCollectionViewCell:YES];
  self.cardView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.contentView addSubview:self.cardView];
  self.cornerRadius = 4.f;
  self.shadowElevation = 1.f;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  super.backgroundColor = backgroundColor;
  self.cardView.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return self.cardView.backgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  self.cardView.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.cardView.cornerRadius;
}

- (void)setShadowElevation:(CGFloat)elevation {
  [self.cardView setShadowElevation:elevation];
}

- (CGFloat)shadowElevation {
  return self.cardView.shadowElevation;
}

- (void)setLongPressActive:(BOOL)longPressActive {
  self.cardView.longPress = longPressActive;
}

- (void)setLongPressActive:(BOOL)longPressActive withLocation:(CGPoint)location {
  self.longPressActive = longPressActive;
  if (!longPressActive) {
    [self.cardView styleForState:MDCCardsStateDefault withLocation:(CGPoint)location];
  }
}

- (BOOL)longPressActive {
  return self.cardView.longPress;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self.cardView styleForState:MDCCardsStatePressed withLocation:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self.cardView styleForState:MDCCardsStateDefault withLocation:location];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self.cardView styleForState:MDCCardsStateDefault withLocation:location];
  [super touchesCancelled:touches withEvent:event];
}

@end
