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

#import "MDCBannerViewConstants.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"

static const CGFloat kImageViewSideLength = 40;
static const NSInteger kTextNumberOfLineLimit = 3;

typedef NS_ENUM(NSInteger, MDCBannerViewLayoutStyle) {
  MDCBannerViewLayoutSingleLineStyle = 0,              // All elements lays on the same line
  MDCBannerViewLayoutMultiLineStackedButtonStyle = 1,  // Multline, stacked button layout
  MDCBannerViewLayoutMultiLineAlignedButtonStyle = 2,  // Multiline style with all buttons on the same line
};

@interface MDCBannerView ()

@property(nonatomic, readwrite, strong) UILabel *textLabel;

@property(nonatomic, readwrite, strong) UIImageView *imageView;
@property(nonatomic, readonly, assign) BOOL isImageSet;

@property(nonatomic, readwrite, strong) MDCButton *leadingButton;
@property(nonatomic, readwrite, strong) MDCButton *trailingButton;
@property(nonatomic, readwrite, strong) UIView *buttonContainerView;

@property(nonatomic, readwrite, assign) MDCBannerViewLayoutStyle style;

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
  self.backgroundColor = UIColor.whiteColor;

  // Create textLabel
  UILabel *textLabel = [[UILabel alloc] init];
  textLabel.translatesAutoresizingMaskIntoConstraints = NO;
  textLabel.font = [MDCTypography body2Font];
  textLabel.textColor = UIColor.blackColor;
  textLabel.alpha = [MDCTypography body2FontOpacity];
  textLabel.numberOfLines = kTextNumberOfLineLimit;
  textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  [self addSubview:textLabel];
  _textLabel = textLabel;

  // Create imageView
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.translatesAutoresizingMaskIntoConstraints = NO;
  [imageView.widthAnchor constraintEqualToConstant:kImageViewSideLength].active = YES;
  [imageView.heightAnchor constraintEqualToConstant:kImageViewSideLength].active = YES;
  imageView.contentMode = UIViewContentModeCenter;
  imageView.clipsToBounds = YES;
  [self addSubview:imageView];
  _imageView = imageView;

  // Create a button container to organize buttons
  UIView *buttonContainerView = [[UIView alloc] init];
  buttonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:buttonContainerView];
  self.buttonContainerView = buttonContainerView;

  // Create leadingButton and trailingButton
  MDCButton *leadingButton = [[MDCButton alloc] init];
  leadingButton.translatesAutoresizingMaskIntoConstraints = NO;
  leadingButton.backgroundColor = UIColor.whiteColor;
  [buttonContainerView addSubview:leadingButton];
  _leadingButton = leadingButton;

  MDCButton *trailingButton = [[MDCButton alloc] init];
  trailingButton.translatesAutoresizingMaskIntoConstraints = NO;
  trailingButton.backgroundColor = UIColor.whiteColor;
  [buttonContainerView addSubview:trailingButton];
  _trailingButton = trailingButton;
}

#pragma mark - Property Setter and Getter

- (BOOL)isImageSet {
  return self.imageView.image != nil && !self.imageView.hidden;
}

#pragma mark - KVO

// TODO: KVO trailingButton.hidden

#pragma mark - UIView overrides

- (CGSize)sizeThatFits:(CGSize)size {
  MDCBannerViewLayoutStyle style = [self styleForSizeToFit:size];
  CGFloat frameHeight = 0.0f;
  switch (style) {
    case MDCBannerViewLayoutSingleLineStyle: {
      frameHeight += kTopPaddingSmall + kBottomPadding;
      [self.textLabel sizeToFit];
      [self.leadingButton sizeToFit];
      CGFloat maximumHeight = MAX(CGRectGetHeight(self.textLabel.frame),
                                  CGRectGetHeight(self.leadingButton.frame));
      if (self.isImageSet) {
        maximumHeight = MAX(kImageViewSideLength, maximumHeight);
      }
      frameHeight += maximumHeight;
      break;
    }
    case MDCBannerViewLayoutMultiLineAlignedButtonStyle: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextLabelWithSizeToFit:size];
      [self.leadingButton sizeToFit];
      [self.trailingButton sizeToFit];
      frameHeight += MAX(CGRectGetHeight(self.leadingButton.frame),
                         CGRectGetHeight(self.trailingButton.frame));
      break;
    }
    case MDCBannerViewLayoutMultiLineStackedButtonStyle: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextLabelWithSizeToFit:size];
      [self.leadingButton sizeToFit];
      [self.trailingButton sizeToFit];
      frameHeight += CGRectGetHeight(self.leadingButton.frame) + CGRectGetHeight(self.trailingButton.frame) + kButtonVerticalIntervalSpace;
      break;
    }
  }
  return CGSizeMake(size.width, frameHeight);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (![self isImageSet]) {
    self.imageView.hidden = YES;
  }
}

- (void)updateConstraints {
  MDCBannerViewLayoutStyle style = [self styleForSizeToFit:self.bounds.size];
  [self updateConstraintsWithLayoutStyle:style];

  [super updateConstraints];
}

#pragma mark - Layout methods

- (void)updateConstraintsWithLayoutStyle:(MDCBannerViewLayoutStyle)layoutStyle {
  // Set Elements
  if (layoutStyle == MDCBannerViewLayoutSingleLineStyle) {
    if (self.isImageSet) {
      [self.imageView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:kLeadingPadding].active = YES;
      [self.imageView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor constant:kTopPaddingSmall].active = YES;
      [self.imageView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor constant:-kBottomPadding].active = YES;
      [self.textLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:kSpaceBetweenIconImageAndTextLabel].active = YES;
    } else {
      [self.textLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:kLeadingPadding].active = YES;
    }
    [self.buttonContainerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.textLabel.trailingAnchor constant:kHorizontalSpaceBetweenTextLabelAndButton].active = YES;
    NSLayoutConstraint *buttonContainerLeadingConstraint = [self.buttonContainerView.leadingAnchor constraintEqualToAnchor:self.textLabel.trailingAnchor constant:kHorizontalSpaceBetweenTextLabelAndButton];
    buttonContainerLeadingConstraint.priority = UILayoutPriorityDefaultHigh;
    buttonContainerLeadingConstraint.active = YES;
    [self.buttonContainerView.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor constant:-kTrailingPadding].active = YES;
    [self.buttonContainerView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor constant:kTopPaddingSmall].active = YES;
    [self.buttonContainerView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor constant:-kBottomPadding].active = YES;
    [self.textLabel.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor].active = YES;
  } else {
    if (self.isImageSet) {
      [self.imageView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:kLeadingPadding].active = YES;
      [self.imageView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor constant:kTopPaddingLarge].active = YES;
      [self.textLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:kSpaceBetweenIconImageAndTextLabel].active = YES;
      [self.buttonContainerView.topAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.bottomAnchor constant:kVerticalSpaceBetweenButtonAndTextLabel].active = YES;
    } else {
      [self.textLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:kLeadingPadding].active = YES;
      [self.buttonContainerView.topAnchor constraintGreaterThanOrEqualToAnchor:self.textLabel.bottomAnchor constant:kVerticalSpaceBetweenButtonAndTextLabel].active = YES;
    }
    [self.textLabel.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor constant:kTopPaddingLarge].active = YES;
    [self.textLabel.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor constant:-kTrailingPadding].active = YES;
    NSLayoutConstraint *buttonContainerTopConstraint = [self.buttonContainerView.topAnchor constraintEqualToAnchor:self.textLabel.bottomAnchor constant:kVerticalSpaceBetweenButtonAndTextLabel];
    buttonContainerTopConstraint.priority = UILayoutPriorityDefaultLow;
    buttonContainerTopConstraint.active = YES;
    [self.buttonContainerView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:kLeadingPadding].active = YES;
    [self.buttonContainerView.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor constant:-kTrailingPadding].active = YES;
    [self.buttonContainerView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor constant:-kBottomPadding].active = YES;
  }

  [self updateButtonsConstraintsWithLayoutStyle:layoutStyle];
}

#pragma mark - Layout helpers

- (void)updateButtonsConstraintsWithLayoutStyle:(MDCBannerViewLayoutStyle)layoutStyle {
  if (self.trailingButton.hidden) {
    [self.leadingButton.trailingAnchor constraintEqualToAnchor:self.buttonContainerView.trailingAnchor].active = YES;
    [self.leadingButton.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor].active = YES;
  } else {
    if (layoutStyle == MDCBannerViewLayoutMultiLineStackedButtonStyle) {
      [self.leadingButton.trailingAnchor constraintEqualToAnchor:self.buttonContainerView.trailingAnchor].active = YES;
      [self.trailingButton.topAnchor constraintEqualToAnchor:self.leadingButton.bottomAnchor constant:kButtonVerticalIntervalSpace].active = YES;
    } else {
      [self.leadingButton.trailingAnchor constraintEqualToAnchor:self.trailingButton.leadingAnchor constant:-kButtonHorizontalIntervalSpace].active = YES;
    }
    [self.leadingButton.topAnchor constraintEqualToAnchor:self.buttonContainerView.topAnchor].active = YES;
    [self.leadingButton.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.buttonContainerView.leadingAnchor].active = YES;
    [self.trailingButton.trailingAnchor constraintEqualToAnchor:self.buttonContainerView.trailingAnchor].active = YES;
    [self.trailingButton.bottomAnchor constraintEqualToAnchor:self.buttonContainerView.bottomAnchor].active = YES;
  }
}

- (MDCBannerViewLayoutStyle)styleForSizeToFit:(CGSize)sizeToFit {
  MDCBannerViewLayoutStyle style;
  CGFloat remainingWidth = sizeToFit.width;
  CGFloat marginsPadding = self.layoutMargins.left + self.layoutMargins.right;
  remainingWidth -= marginsPadding;
  remainingWidth -= (kLeadingPadding + kTrailingPadding);
  if (self.trailingButton.hidden) {
    [self.leadingButton sizeToFit];
    CGFloat buttonWidth = CGRectGetWidth(self.leadingButton.frame);
    remainingWidth -= (buttonWidth + kHorizontalSpaceBetweenTextLabelAndButton);
    if (self.isImageSet) {
      remainingWidth -= kImageViewSideLength;
      remainingWidth -= kSpaceBetweenIconImageAndTextLabel;
    }
    style = [self isAbleToFitTextLabel:self.textLabel
                        withWidthLimit:remainingWidth]
    ? MDCBannerViewLayoutSingleLineStyle
    : MDCBannerViewLayoutMultiLineAlignedButtonStyle;
  } else {
    [self.leadingButton sizeToFit];
    [self.trailingButton sizeToFit];
    CGFloat buttonWidth = [self widthSumForButtons:@[self.leadingButton, self.trailingButton]];
    remainingWidth -= buttonWidth;
    style = (remainingWidth > 0) ? MDCBannerViewLayoutMultiLineAlignedButtonStyle
    : MDCBannerViewLayoutMultiLineStackedButtonStyle;
  }
  return style;
}

- (CGFloat)getFrameHeightOfImageViewAndTextLabelWithSizeToFit:(CGSize)sizeToFit {
  CGFloat frameHeight = 0;
  CGFloat remainingWidth = sizeToFit.width - kLeadingPadding - kTrailingPadding;
  CGSize textLabelSize = CGSizeZero;
  if (self.isImageSet) {
    remainingWidth -= (kImageViewSideLength + kSpaceBetweenIconImageAndTextLabel);
    textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += MAX(textLabelSize.height, kImageViewSideLength);
  } else {
    textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += textLabelSize.height;
  }
  frameHeight += kVerticalSpaceBetweenButtonAndTextLabel;
  return frameHeight;
}

- (CGFloat)widthSumForButtons:(NSArray<__kindof UIButton *> *)buttons {
  CGFloat buttonsWidthSum = 0;
  for (UIButton *button in buttons) {
    buttonsWidthSum += CGRectGetWidth(button.frame);
  }
  if (buttons.count > 1) {
    buttonsWidthSum += (buttons.count - 1) * kButtonHorizontalIntervalSpace;
  }
  return buttonsWidthSum;
}

- (BOOL)isAbleToFitTextLabel:(UILabel *)textLabel
              withWidthLimit:(CGFloat)widthLimit {
  CGSize size =
  [textLabel.text sizeWithAttributes:@{NSFontAttributeName : textLabel.font}];
  return size.width <= widthLimit;
}

@end
