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

#import "MaterialButtons.h"
#import "MDCBannerViewLayout.h"

static const CGFloat kIconImageContainerSideLength = 40.0f;
static const CGFloat kIconImageSideLength = 24.0f;
static const CGFloat kTextColorOpacity = 0.87f;
static const CGFloat kTextFontSize = 14.0f;
static const NSInteger kTextNumberOfLineLimit = 3;
static const NSUInteger kNumberOfButtonsLimit = 2;

@interface MDCBannerView () <MDCBannerViewLayoutDataSource>

@property(nonatomic, readwrite, weak) UILabel *textLabel;
@property(nonatomic, readwrite, weak) UIView *iconImageViewContainer;
@property(nonatomic, readwrite, weak) UIImageView *iconImageView;
@property(nonatomic, readwrite, copy) NSArray<MDCButton *> *buttons;

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

  _buttons = [[NSArray alloc] init];
  self.numberOfButtons = 1;

  UILabel *textLabel = [[UILabel alloc] init];
  textLabel.font = [UIFont systemFontOfSize:kTextFontSize];
  textLabel.textColor = [UIColor colorWithWhite:0 alpha:kTextColorOpacity];
  textLabel.numberOfLines = kTextNumberOfLineLimit;
  textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _textLabel = textLabel;
  [self addSubview:textLabel];
}

#pragma mark - Property Setter and Getter

- (void)setText:(NSString *)text {
  self.textLabel.text = text;
}

- (NSString *)text {
  return self.textLabel.text;
}

- (void)setImage:(UIImage *)image {
  if (image) {
    _image = image;
    if (!self.iconImageViewContainer) {
      CGRect iconImageContainerFrame =
          CGRectMake(0, 0, kIconImageContainerSideLength, kIconImageContainerSideLength);
      UIView *iconImageViewContainer = [[UIView alloc] initWithFrame:iconImageContainerFrame];
      UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
      CGRect iconImageFrame = CGRectMake(0, 0, kIconImageSideLength, kIconImageSideLength);
      iconImageView.frame = iconImageFrame;
      iconImageView.contentMode = UIViewContentModeScaleAspectFit;
      iconImageView.clipsToBounds = YES;
      [iconImageViewContainer addSubview:iconImageView];
      self.iconImageViewContainer = iconImageViewContainer;
      self.iconImageView = iconImageView;
      [self addSubview:iconImageViewContainer];
    } else {
      self.iconImageView.image = image;
    }
  } else {
    _image = nil;
    [self.iconImageViewContainer removeFromSuperview];
    self.iconImageViewContainer = nil;
  }
  [self.layout reloadData];
  [self setNeedsLayout];
}

- (void)setNumberOfButtons:(NSUInteger)numberOfButtons {
  NSAssert(numberOfButtons <= kNumberOfButtonsLimit, @"%@ class doesn't support more than %lu buttons", NSStringFromClass([self class]), (unsigned long)kNumberOfButtonsLimit);
  if (numberOfButtons != self.buttons.count) {
    NSMutableArray *mutableButtons = [self.buttons mutableCopy];
    if (numberOfButtons > self.buttons.count) {
      for (NSUInteger index = self.buttons.count; index < numberOfButtons; ++index) {
        MDCButton *button = [[MDCButton alloc] init];
        [mutableButtons addObject:button];
        [self addSubview:button];
      }
    } else if (numberOfButtons < self.buttons.count) {
      for (NSUInteger index = numberOfButtons; index < self.buttons.count; ++index) {
        MDCButton *lastObject = [mutableButtons lastObject];
        [lastObject removeFromSuperview];
        [mutableButtons removeLastObject];
      }
    }
    self.buttons = [mutableButtons copy];
  }
  [self.layout reloadData];
}

- (NSUInteger)numberOfButtons {
  return self.buttons.count;
}

#pragma mark - UIView overrides

- (CGSize)sizeThatFits:(CGSize)size {
  self.layout = [[MDCBannerViewLayout alloc] initWithSizeToFit:size];
  self.layout.dataSource = self;
  [self.layout reloadData];
  return [self.layout frameSize];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self applyMDCBannerViewLayout:self.layout];
}

#pragma mark - MDCBannerViewLayoutDataSource

- (UILabel *)textLabelForBannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout {
  return self.textLabel;
}

- (UIView *)imageContainerForBannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout {
  return self.iconImageViewContainer;
}

- (NSInteger)numberOfButtonsForBannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout {
  return self.buttons.count;
}

- (UIButton *)bannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout
                 buttonAtIndex:(NSInteger)index {
  return self.buttons[index];
}

#pragma mark - Layout methods

- (void)applyMDCBannerViewLayout:(MDCBannerViewLayout *)layout {
  if (![self isMDCBannerViewLayoutApplicable:layout]) {
    return;
  }

  self.iconImageViewContainer.frame = layout.imageContainerFrame;
  self.iconImageView.center = CGPointMake(CGRectGetWidth(layout.imageContainerFrame) / 2,
                                          CGRectGetHeight(layout.imageContainerFrame) / 2);
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
