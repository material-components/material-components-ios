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

#import "MDCBottomNavigationItemView.h"
#import "MDCBottomNavigationItemBadge.h"

static const CGFloat kMDCBottomNavigationItemViewTitleFontSize = 12.f;

// The duration of the selection transition animation.
static const NSTimeInterval kMDCBottomNavigationItemViewTransitionDuration = 0.180f;

@interface MDCBottomNavigationItemView ()

@property(nonatomic, strong) MDCBottomNavigationItemBadge *badge;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIImage *unselectedImage;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation MDCBottomNavigationItemView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationItemViewInit {
  self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

  _selectedItemTintColor = [UIColor blackColor];
  _unselectedItemTintColor = [UIColor grayColor];

  _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self addSubview:_iconImageView];

  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.text = _title;
  _label.font = [UIFont systemFontOfSize:kMDCBottomNavigationItemViewTitleFontSize];
  _label.textAlignment = NSTextAlignmentCenter;
  _label.textColor = _selectedItemTintColor;
  [self addSubview:_label];

  _badge = [[MDCBottomNavigationItemBadge alloc] initWithFrame:CGRectZero];
  [self addSubview:_badge];

  if (!_badgeValue) {
    _badge.hidden = YES;
  }

  _button = [[UIButton alloc] initWithFrame:self.bounds];
  _button.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self addSubview:_button];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat labelHeight = [self sizeForText:self.title
                                     font:self.label.font
                         boundingRectSize:self.bounds.size].height;
  self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), labelHeight);
  [self setSelected:self.selected];
}

- (CGSize)sizeForText:(NSString *)text
                 font:(UIFont *)font
     boundingRectSize:(CGSize)boundingRectSize {
  CGRect rect = [text boundingRectWithSize:boundingRectSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{ NSFontAttributeName:font }
                                   context:nil];
  return rect.size;
}

- (UIImage *)colorizeImage:(UIImage *)image color:(UIColor *)color {
  UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIGraphicsBeginImageContextWithOptions(image.size, NO, newImage.scale);
  [color set];
  [newImage drawInRect:CGRectMake(0, 0, image.size.width, newImage.size.height)];
  newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

#pragma mark - Setters

- (void)setSelected:(BOOL)selected {
  [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  _selected = selected;

  CGPoint iconImageViewCenter =
      CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds) - CGRectGetHeight(self.bounds) * 0.1f);
  if (selected) {
    if (self.titleHideState == MDCBottomNavigationBarTitleHideStateDefault ||
        self.titleHideState == MDCBottomNavigationBarTitleHideStateNever) {
      self.label.hidden = NO;
    } else if (self.titleHideState == MDCBottomNavigationBarTitleHideStateAlways) {
      self.label.hidden = YES;
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    self.label.textColor = self.selectedItemTintColor;
    self.iconImageView.image = self.selectedImage;
  } else {
    if (self.titleHideState == MDCBottomNavigationBarTitleHideStateDefault ||
        self.titleHideState == MDCBottomNavigationBarTitleHideStateAlways) {
      self.label.hidden = YES;
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    } else if (self.titleHideState == MDCBottomNavigationBarTitleHideStateNever) {
      self.label.hidden = NO;
    }
    self.label.textColor = self.unselectedItemTintColor;
    self.iconImageView.image = self.unselectedImage;
  }
  CGPoint badgeCenter =
      CGPointMake(CGRectGetMidX(self.bounds) + CGRectGetWidth(self.iconImageView.bounds) / 2,
                  iconImageViewCenter.y - CGRectGetMidX(self.iconImageView.bounds));
  self.label.center =
      CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds) + CGRectGetHeight(self.bounds) * 0.25f);
  if (animated) {
    [UIView animateWithDuration:kMDCBottomNavigationItemViewTransitionDuration animations:^(void) {
      self.iconImageView.center = iconImageViewCenter;
      self.badge.center = badgeCenter;
    }];
  } else {
    self.iconImageView.center = iconImageViewCenter;
    self.badge.center = badgeCenter;
  }
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
  self.label.textColor = self.selectedItemTintColor;
  self.selectedImage = [self colorizeImage:self.image color:self.selectedItemTintColor];
}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  _unselectedItemTintColor = unselectedItemTintColor;
  self.unselectedImage = [self colorizeImage:self.image color:self.unselectedItemTintColor];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  _badge.badgeColor = badgeColor;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  _badgeValue = badgeValue;
  _badge.badgeValue = badgeValue;
  if (!_badgeValue) {
    _badge.hidden = YES;
  } else {
    _badge.hidden = NO;
  }
}

- (void)setImage:(UIImage *)image {
  _image = image;

  self.selectedImage = [self colorizeImage:image color:self.selectedItemTintColor];
  self.unselectedImage = [self colorizeImage:image color:self.unselectedItemTintColor];

  _iconImageView.image = self.unselectedImage;
  [_iconImageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
  _title = title;
  _label.text = _title;
  [_label sizeToFit];
}

@end
