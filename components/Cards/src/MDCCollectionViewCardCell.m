/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionViewCardCell.h"

#import "MaterialIcons+ic_check_circle.h"
#import <MDFTextAccessibility/MDFTextAccessibility.h>

@interface MDCCollectionViewCardCell ()

@property(nonatomic, strong, nullable) UIImageView *selectedImageView;
@property(nonatomic, assign) CGPoint lastTouch;

@end

@implementation MDCCollectionViewCardCell {
  BOOL _inkAnimating;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionViewCardCellInit];
  }
  return self;
}

- (void)commonMDCCollectionViewCardCellInit {
  _cardView = [[MDCCardView alloc] initWithFrame:self.contentView.bounds];
  _cardView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _cardView.userInteractionEnabled = NO;
  self.contentView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.contentView addSubview:self.cardView];
  _inkAnimating = NO;
  self.selecting = NO;

  [self initializeSelectedImage];

  self.cornerRadius = 4.f;
}

- (void)initializeSelectedImage {
  UIImage *circledCheck = [MDCIcons imageFor_ic_check_circle];
  circledCheck = [circledCheck imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.selectedImageView = [[UIImageView alloc] initWithImage:circledCheck];
  self.selectedImageView.center = CGPointMake(
                                              CGRectGetWidth(self.bounds) - (circledCheck.size.width/2) - 8,
                                              (circledCheck.size.height/2) + 8);
  self.selectedImageView.layer.zPosition = MAXFLOAT - 1;
  self.selectedImageView.autoresizingMask =
  (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |
   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin);
  [self.contentView addSubview:self.selectedImageView];
  self.selectedImageView.hidden = YES;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  super.backgroundColor = backgroundColor;
  self.cardView.backgroundColor = backgroundColor;

  /**
   currently the selected check image uses the color
   based on MDFTextAccessibility to fit the background color.
   */
  UIColor *checkColor =
  [MDFTextAccessibility textColorOnBackgroundColor:backgroundColor
                                   targetTextAlpha:1.f
                                           options:MDFTextAccessibilityOptionsNone];
  self.selectedImageTintColor = checkColor;
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

- (void)selectionState:(MDCCardCellSelectionState)state withAnimation:(BOOL)animation {
  self.selecting = YES;
  switch (state) {
    case MDCCardCellSelectionStateSelected: {
      if (animation) {
        _inkAnimating = YES;
        [self.cardView.inkView startTouchBeganAnimationAtPoint:self.lastTouch completion:nil];
      } else {
        if (!_inkAnimating) {
          [self.cardView.inkView cancelAllAnimationsAnimated:NO];
          [self.cardView.inkView addInkSublayerWithoutAnimation];
        }
        _inkAnimating = NO;
        self.selectedImageView.hidden = NO;
      }
      [(MDCShadowLayer *)self.cardView.layer setElevation:
       [self.cardView shadowElevationForState:MDCCardViewStateNormal]];

      break;
    }
    case MDCCardCellSelectionStateUnselected: {
      if (animation) {
        [self.cardView.inkView startTouchEndedAnimationAtPoint:self.lastTouch completion:nil];
      } else {
        [self.cardView.inkView cancelAllAnimationsAnimated:NO];
      }
      [(MDCShadowLayer *)self.cardView.layer setElevation:
       [self.cardView shadowElevationForState:MDCCardViewStateNormal]];
      self.selectedImageView.hidden = YES;
      break;
    }
  }
  self.selectionState = state;
}

- (void)setSelectedImage:(UIImage *)selectedImage {
  [self.selectedImageView setImage:selectedImage];
}

- (UIImage *)selectedImage {
  return self.selectedImageView.image;
}

- (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor {
  [self.selectedImageView setTintColor:selectedImageTintColor];
}

- (UIColor *)selectedImageTintColor {
  return self.selectedImageView.tintColor;
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  if (self.selecting) {
    if (selected) {
      [self selectionState:MDCCardCellSelectionStateSelected withAnimation:NO];
    } else {
      [self selectionState:MDCCardCellSelectionStateUnselected withAnimation:NO];
    }
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
  if (self.selecting) {
    if (!self.selected) {
      [self selectionState:MDCCardCellSelectionStateSelected withAnimation:YES];
    }
  } else {
    [self.cardView styleForState:MDCCardViewStateHighlighted withLocation:location];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  if (self.selecting) {
    if (!self.selected) {
      [self selectionState:MDCCardCellSelectionStateUnselected withAnimation:YES];
    }
  } else {
    [self.cardView styleForState:MDCCardViewStateNormal withLocation:location];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  if (self.selecting) {
    if (!self.selected) {
      [self selectionState:MDCCardCellSelectionStateUnselected withAnimation:YES];
    }
  } else {
    [self.cardView styleForState:MDCCardViewStateNormal withLocation:location];
  }
}

@end
