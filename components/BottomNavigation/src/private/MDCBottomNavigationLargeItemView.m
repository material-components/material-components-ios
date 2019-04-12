// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCBottomNavigationLargeItemView.h"

static const CGFloat kTitleFontScaling = 0.5;
static const CGFloat kTitleFontSize = 35;

static UIImage *_Nullable MDCImageForItem(UITabBarItem *_Nullable item) {
  if (!item) {
    return nil;
  }

  UIImage *image;
  if (@available(iOS 11, *)) {
    image = item.largeContentSizeImage;
  }

  return image ?: item.image;
}

@interface MDCBottomNavigationLargeItemView ()

@property(nonatomic, nullable) UITabBarItem *item;
@property(nonatomic, nonnull) UIImageView *imageView;
@property(nonatomic, nonnull) UILabel *titleLabel;

@end

@implementation MDCBottomNavigationLargeItemView

- (instancetype)initWithTabBarItem:(UITabBarItem *)item {
  self = [super init];
  if (self) {
    _item = item;
    [self commonInitMDCBottomNavigationLargeItemView];
  }

  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInitMDCBottomNavigationLargeItemView];
  }

  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInitMDCBottomNavigationLargeItemView];
  }

  return self;
}

- (void)commonInitMDCBottomNavigationLargeItemView {
  UIColor *contentColor = [UIColor colorWithWhite:(CGFloat)0.15 alpha:(CGFloat)0.95];

  _imageView = [[UIImageView alloc] init];
  _imageView.tintColor = contentColor;
  _imageView.contentMode = UIViewContentModeScaleAspectFit;
  _imageView.image =
      [MDCImageForItem(_item) imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  _imageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:_imageView];

  _titleLabel = [[UILabel alloc] init];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.adjustsFontSizeToFitWidth = YES;
  _titleLabel.minimumScaleFactor = kTitleFontScaling;
  _titleLabel.textColor = contentColor;
  _titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
  _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _titleLabel.text = _item.title;
  _titleLabel.numberOfLines = (_imageView.image) ? 1 : 0;
  [self addSubview:_titleLabel];

  NSDictionary<NSString *, UIView *> *viewDictionary =
      NSDictionaryOfVariableBindings(_imageView, _titleLabel);
  NSArray<NSLayoutConstraint *> *verticalConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageView][_titleLabel]"
                                              options:0
                                              metrics:nil
                                                views:viewDictionary];
  [self addConstraints:verticalConstraints];

  NSLayoutConstraint *imageWidthConstraint =
      [NSLayoutConstraint constraintWithItem:_imageView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeWidth
                                  multiplier:0.4
                                    constant:0];

  NSLayoutConstraint *imageCenterConstraint =
      [NSLayoutConstraint constraintWithItem:_imageView
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                    constant:0];
  [self addConstraints:@[ imageWidthConstraint, imageCenterConstraint ]];

  NSArray<NSLayoutConstraint *> *titleHorizontalConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                              options:0
                                              metrics:nil
                                                views:viewDictionary];
  [self addConstraints:titleHorizontalConstraints];

  if (_titleLabel.text.length > 0) {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
  } else {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
  }

  if (!_imageView.image) {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
  } else {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.6
                                                      constant:0]];
  }
}

@end
