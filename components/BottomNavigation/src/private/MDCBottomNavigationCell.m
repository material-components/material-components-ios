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

#import "MDCBottomNavigationCell.h"
#import "MDCBottomNavigationCellBadge.h"

static const CGFloat kMDCBottomNavigationCellTitleFontSize = 12.f;

// The duration of the selection transition animation.
static const NSTimeInterval kMDCBottomNavigationCellTransitionDuration = 0.180f;

@interface MDCBottomNavigationCell ()

@property(nonatomic, strong) MDCBottomNavigationCellBadge *badge;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIImage *unselectedImage;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation MDCBottomNavigationCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationCellInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationCellInit {
  self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

  _selectedColor = [UIColor blackColor];
  _unselectedColor = [UIColor grayColor];

  _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self addSubview:_iconImageView];

  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.text = _title;
  _label.font = [UIFont systemFontOfSize:kMDCBottomNavigationCellTitleFontSize];
  _label.textAlignment = NSTextAlignmentCenter;
  _label.textColor = _selectedColor;
  [self addSubview:_label];

  _badge = [[MDCBottomNavigationCellBadge alloc] init];
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
    if (self.titleHideState == MDCBottomNavigationViewTitleHideStateDefault ||
        self.titleHideState == MDCBottomNavigationViewTitleHideStateNever) {
      self.label.hidden = NO;
    } else if (self.titleHideState == MDCBottomNavigationViewTitleHideStateAlways) {
      self.label.hidden = YES;
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    self.label.textColor = self.selectedColor;
    self.iconImageView.image = self.selectedImage;
  } else {
    if (self.titleHideState == MDCBottomNavigationViewTitleHideStateDefault ||
        self.titleHideState == MDCBottomNavigationViewTitleHideStateAlways) {
      self.label.hidden = YES;
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    } else if (self.titleHideState == MDCBottomNavigationViewTitleHideStateNever) {
      self.label.hidden = NO;
    }
    self.label.textColor = self.unselectedColor;
    self.iconImageView.image = self.unselectedImage;
  }
  CGPoint badgeCenter =
      CGPointMake(CGRectGetMidX(self.bounds) + CGRectGetWidth(self.iconImageView.bounds) / 2,
                  iconImageViewCenter.y - CGRectGetMidX(self.iconImageView.bounds));
  self.label.center =
      CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds) + CGRectGetHeight(self.bounds) * 0.25f);
  if (animated) {
    [UIView animateWithDuration:kMDCBottomNavigationCellTransitionDuration animations:^(void) {
      self.iconImageView.center = iconImageViewCenter;
      self.badge.center = badgeCenter;
    }];
  } else {
    self.iconImageView.center = iconImageViewCenter;
    self.badge.center = badgeCenter;
  }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
  _selectedColor = selectedColor;
  self.label.textColor = self.selectedColor;
  self.selectedImage = [self colorizeImage:self.image color:self.selectedColor];
}

- (void)setUnselectedColor:(UIColor *)unselectedColor {
  _unselectedColor = unselectedColor;
  self.unselectedImage = [self colorizeImage:self.image color:self.unselectedColor];
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

  self.selectedImage = [self colorizeImage:image color:self.selectedColor];
  self.unselectedImage = [self colorizeImage:image color:self.unselectedColor];

  _iconImageView.image = self.unselectedImage;
  [_iconImageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
  _title = title;
  _label.text = _title;
  [_label sizeToFit];
}

@end
