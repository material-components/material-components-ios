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

@implementation MDCCard {
  UILongPressGestureRecognizer *longPressGestureRecognizer;
  UITapGestureRecognizer *tapGestureRecognizer;
}

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
  self.inkView.layer.zPosition = MAXFLOAT;
  self.userInteractionEnabled = YES;
  [self addSubview:self.inkView];

  self.longPress = NO;
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

- (void)styleForState:(MDCCardsState)state withLocation:(CGPoint)location {
  switch (state) {
    case MDCCardsStateDefault: {
      NSLog(@"DEFAULT with loc: %f %f", location.x, location.y);
      [self.inkView startTouchEndedAnimationAtPoint:location completion:nil];
      self.shadowElevation = 1.f;
      NSLog(@"end %f %@",self.shadowElevation, self.description);
      break;
    }
    case MDCCardsStatePressed: {
      NSLog(@"PRESSED with loc: %f %f", location.x, location.y );
      [self.inkView startTouchBeganAnimationAtPoint:location completion:nil];
      self.shadowElevation = 8.f;
      NSLog(@"start %f %@",self.shadowElevation, self.description);
      break;
    }
    default:
      break;
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  if (self.isUsingCell) {
    [self.nextResponder touchesBegan:touches withEvent:event];
  }
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self styleForState:MDCCardsStatePressed withLocation:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  if (self.isUsingCell) {
    [self.nextResponder touchesBegan:touches withEvent:event];
  }
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self styleForState:MDCCardsStateDefault withLocation:location];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  if (!self.longPress) {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [self styleForState:MDCCardsStateDefault withLocation:location];
  }
}



@end
