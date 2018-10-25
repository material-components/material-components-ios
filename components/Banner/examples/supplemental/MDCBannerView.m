// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBannerView.h"

#import "MDCBannerParams.h"
#import "MDCBannerViewLayout.h"
#import "MDCFlatButton.h"
#import "MaterialColorScheme.h"
#import "MaterialTypography.h"

@interface MDCBannerView ()

@property(nonatomic, readwrite, weak) UILabel *textLabel;
@property(nonatomic, readwrite, weak) UIImageView *iconImageView;
@property(nonatomic, readwrite, strong) NSMutableArray<__kindof UIButton *> *buttons;

@property(nonatomic, readwrite, strong) MDCBannerViewLayout *layout;

@end

@implementation MDCBannerView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonBannerViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonBannerViewInit];
  }
  return self;
}

- (void)commonBannerViewInit {
  self.backgroundColor = [UIColor whiteColor];
  _buttons = [[NSMutableArray alloc] init];
}

#pragma mark - Property Setter and Getter

- (void)setText:(NSString *)text {
  if (text) {
    _text = text;
    UILabel *textLabel = self.textLabel;
    if (!textLabel) {
      textLabel = [[UILabel alloc] init];
      textLabel.font = [MDCTypography body2Font];
      MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
      textLabel.textColor = colorScheme.onSurfaceColor;
      textLabel.numberOfLines = 3;
      textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
      self.textLabel = textLabel;
      [self addSubview:textLabel];
    }
    textLabel.text = text;
  } else {
    _text = nil;
    [self.textLabel removeFromSuperview];
  }
}

- (void)setImage:(UIImage *)image {
  if (image) {
    _image = image;
    if (!self.iconImageView) {
      UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
      iconImageView.frame = CGRectMake(0, 0, kIconImageSideLength, kIconImageSideLength);
      iconImageView.contentMode = UIViewContentModeScaleAspectFit;
      iconImageView.clipsToBounds = YES;
      self.iconImageView = iconImageView;
    } else {
      self.iconImageView.image = image;
    }
  } else {
    _image = nil;
    [self.iconImageView removeFromSuperview];
  }
}

#pragma mark - Banner Views

+ (MDCBannerView *)bannerWithText:(NSString *)text
                            image:(UIImage *)image
                          buttons:(NSArray<__kindof UIButton *> *)buttons
                         delegate:(id<MDCBannerViewDelegate>)delegate {
  MDCBannerView *mdcBannerView = [[MDCBannerView alloc] initWithFrame:CGRectZero];
  mdcBannerView.delegate = delegate;
  mdcBannerView.text = text;
  mdcBannerView.image = image;
  for (UIButton *button in buttons) {
    [mdcBannerView addButton:button];
  }
  return mdcBannerView;
}

#pragma mark - UIView overrides

- (CGSize)sizeThatFits:(CGSize)size {
  self.layout = [[MDCBannerViewLayout alloc] initWithIconImageView:self.iconImageView
                                                         textLabel:self.textLabel
                                                           buttons:self.buttons
                                                         sizeToFit:size];
  return [self.layout frameSize];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self applyMDCBannerViewLayout:self.layout];
}

#pragma mark - APIs

- (void)addButton:(UIButton *)button {
  [self.buttons addObject:button];
  [button addTarget:self
                action:@selector(didTapButton:)
      forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:button];
  [self setNeedsLayout];
}

- (void)removeButton:(UIButton *)button {
  if (![self.buttons containsObject:button]) {
    return;
  }

  [button removeFromSuperview];
  [self.buttons removeObject:button];
}

#pragma mark - Button action handler

- (void)didTapButton:(id)sender {
  UIButton *button = (UIButton *)sender;
  [self.delegate didTapButtonOnMDCBannerView:button];
}

#pragma mark - Layout methods

- (void)applyMDCBannerViewLayout:(MDCBannerViewLayout *)layout {
  if (![self isMDCBannerViewLayoutApplicable:layout]) {
    return;
  }
  self.iconImageView.frame = layout.iconImageViewFrame;
  self.textLabel.frame = layout.textLabelFrame;
  [self.buttons enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
    if (idx >= layout.buttonFrames.count) {
      *stop = YES;
      return;
    }
    UIButton *button = (UIButton *)object;
    CGRect buttonFrame = [layout.buttonFrames[idx] CGRectValue];
    button.frame = buttonFrame;
  }];
}

- (BOOL)isMDCBannerViewLayoutApplicable:(MDCBannerViewLayout *)layout {
  return self.buttons.count == layout.buttonFrames.count;
}

@end
