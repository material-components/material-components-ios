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
  self.pressed = NO;
  // Separator defaults.
//  _separatorView = [[UIImageView alloc] initWithFrame:CGRectZero];
//  [self addSubview:_separatorView];

  // Accessory defaults.
//  _accessoryType = MDCCollectionViewCellAccessoryNone;
//  _accessoryInset = kAccessoryInsetDefault;
//  _editingSelectorColor = MDCCollectionViewCellRedColor();
//  [self addTarget:self
//           action:@selector(touchDragEnter:forEvent:)
// forControlEvents:UIControlEventTouchDragEnter];
}

- (void)touchDragEnter:(__unused MDCCollectionViewCardCell *)cell forEvent:(UIEvent *)event {
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

- (void)isReordering:(BOOL)reordering withLocation:(CGPoint)location {
  if (reordering) {
    self.pressed = YES;
    [self.cardView styleForState:MDCCardsStatePressed withLocation:(CGPoint)location];
  } else {
    self.pressed = NO;
    [self.cardView styleForState:MDCCardsStateDefault withLocation:(CGPoint)location];
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {\
  [super touchesBegan:touches withEvent:event];
  self.pressed = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  self.pressed = NO;
}

@end
