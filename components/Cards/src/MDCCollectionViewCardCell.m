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
  // Separator defaults.
//  _separatorView = [[UIImageView alloc] initWithFrame:CGRectZero];
//  [self addSubview:_separatorView];

  // Accessory defaults.
//  _accessoryType = MDCCollectionViewCellAccessoryNone;
//  _accessoryInset = kAccessoryInsetDefault;
//  _editingSelectorColor = MDCCollectionViewCellRedColor();
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

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setShadowElevation:(CGFloat)elevation {
  [(MDCShadowLayer *)self.layer setElevation:elevation];
}

- (CGFloat)shadowElevation {
  return ((MDCShadowLayer *)self.layer).elevation;
}

@end
