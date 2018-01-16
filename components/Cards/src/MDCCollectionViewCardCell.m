//
//  MDCCollectionViewCardCell.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import "MDCCollectionViewCardCell.h"


@interface MDCCollectionViewCardCell ()

@property(nonatomic, assign) CGPoint lastTouch;

@end

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
  self.editMode = NO;
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

- (void)setLongPressActive:(BOOL)longPressActive withLocation:(CGPoint)location {
  self.longPressActive = longPressActive;
  if (!longPressActive) {
    [self.cardView styleForState:MDCCardsStateDefault
                    withLocation:(CGPoint)location
                  withCompletion:nil];
  }
}

- (void)selectionState:(MDCCardCellSelectionState)state {
  self.editMode = YES;
  [self.cardView.inkView cancelAllAnimationsAnimated:NO];
  switch (state) {
    case MDCCardCellSelectionStateSelect: {
      [self.cardView styleForState:MDCCardsStateSelect
                      withLocation:self.lastTouch
                    withCompletion:nil];
      break;
    }
    case MDCCardCellSelectionStateSelected: {
      [self.cardView styleForState:MDCCardsStateSelected
                      withLocation:CGPointZero
                    withCompletion:nil];
      break;
    }
    case MDCCardCellSelectionStateUnselect: {
      [self.cardView styleForState:MDCCardsStateDefault
                      withLocation:CGPointZero
                    withCompletion:nil];
      break;
    }
    case MDCCardCellSelectionStateUnselected: {
      [self.cardView styleForState:MDCCardsStateDefault
                      withLocation:CGPointZero
                    withCompletion:nil];
      break;

    }
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
  if (!self.editMode) {
    [self.cardView styleForState:MDCCardsStatePressed
                    withLocation:location
                  withCompletion:nil];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  if (!self.editMode) {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [self.cardView styleForState:MDCCardsStateDefault
                    withLocation:location
                  withCompletion:nil];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  if (!self.editMode) {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [self.cardView styleForState:MDCCardsStateDefault
                    withLocation:location
                  withCompletion:nil];
  }
}

@end
