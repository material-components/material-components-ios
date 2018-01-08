//
//  MDCCards.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import "MDCCard.h"

@interface MDCCard ()

@property(nonatomic, assign) BOOL isUsingCell;

@end

@implementation MDCCard

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame withIsUsingCollectionViewCell:(BOOL)isUsingCell
{
  self = [super initWithFrame:frame];
  if (self) {
    self.isUsingCell = isUsingCell;
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.cornerRadius = 4.f;

  self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  self.inkView.autoresizingMask =
    (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  self.inkView.usesLegacyInkRipple = NO;
  [self addSubview:self.inkView];
}

- (void)layoutSubviews {
  self.shadowElevation = 1.f;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setShadowElevation:(CGFloat)elevation {
  [(MDCShadowLayer *)self.layer setElevation:elevation];
}

- (CGFloat)shadowElevation {
  return ((MDCShadowLayer *)self.layer).elevation;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self.inkView startTouchBeganAnimationAtPoint:location completion:nil];

  self.shadowElevation = 8.f;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [_inkView startTouchEndedAnimationAtPoint:location completion:nil];

  self.shadowElevation = 1.f;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [_inkView startTouchEndedAnimationAtPoint:location completion:nil];

  self.shadowElevation = 1.f;
}



@end
