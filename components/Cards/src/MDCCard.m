//
//  MDCCards.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import "MDCCard.h"
#import "MaterialIcons+ic_check_circle.h"
#import <MDFTextAccessibility/MDFTextAccessibility.h>

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
  self.inkView.layer.zPosition = MAXFLOAT;
  if (self.isUsingCell) {
    self.userInteractionEnabled = NO;
  }
  [self addSubview:self.inkView];

  self.longPress = NO;
  UIImage *circledCheck = [MDCIcons imageFor_ic_check_circle];
  circledCheck = [circledCheck imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.selectedImageView = [[UIImageView alloc]
                            initWithImage:circledCheck];
  self.selectedImageView.center = CGPointMake(self.bounds.size.width - 8 - (circledCheck.size.width/2),
                                              8 + (circledCheck.size.height/2));
  self.selectedImageView.layer.zPosition = MAXFLOAT - 1;
  [self addSubview:self.selectedImageView];
  self.selectedImageView.hidden = YES;
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
  self.layer.shadowPath = [self boundingPath].CGPath;
  return ((MDCShadowLayer *)self.layer).elevation;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  super.backgroundColor = backgroundColor;
  UIColor *checkColor =
    [MDFTextAccessibility textColorOnBackgroundColor:backgroundColor
                                     targetTextAlpha:1.f
                                             options:MDFTextAccessibilityOptionsNone];
  [self.selectedImageView setTintColor:checkColor];
}

- (void)styleForState:(MDCCardsState)state withLocation:(CGPoint)location {
  switch (state) {
    case MDCCardsStateDefault: {
      self.selectedImageView.hidden = YES;
//      NSLog(@"DEFAULT with loc: %f %f", location.x, location.y);
      [self.inkView startTouchEndedAnimationAtPoint:location completion:nil];
      self.shadowElevation = 1.f;
//      NSLog(@"end %f %@",self.shadowElevation, self.description);
      break;
    }
    case MDCCardsStatePressed: {
//      NSLog(@"PRESSED with loc: %f %f", location.x, location.y );
      [self.inkView startTouchBeganAnimationAtPoint:location completion:nil];
      self.shadowElevation = 8.f;
//      NSLog(@"start %f %@",self.shadowElevation, self.description);
      break;
    }
    case MDCCardsStateSelected: {
      self.selectedImageView.hidden = NO;
      self.shadowElevation = 1.f;
      [self.inkView startTouchBeganAnimationAtPoint:location completion:nil];
      break;
    }
    default:
      break;
  }
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.cornerRadius;
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self styleForState:MDCCardsStatePressed withLocation:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self styleForState:MDCCardsStateDefault withLocation:location];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self styleForState:MDCCardsStateDefault withLocation:location];
}



@end
