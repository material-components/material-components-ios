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
#import "MaterialTypography.h"

static const NSInteger kTextNumberOfLineLimit = 3;
static const CGFloat kImageViewSideLength = 40;
static const CGFloat kLeadingPadding = 16.0f;
static const CGFloat kTrailingPadding = 8.0f;
static const CGFloat kTopPaddingSmall = 10.0f;
static const CGFloat kTopPaddingLarge = 24.0f;
static const CGFloat kBottomPadding = 8.0f;
static const CGFloat kButtonHorizontalIntervalSpace = 8.0f;
static const CGFloat kButtonVerticalIntervalSpace = 8.0f;
static const CGFloat kSpaceBetweenIconImageAndTextLabel = 16.0f;
static const CGFloat kHorizontalSpaceBetweenTextLabelAndButton = 24.0f;
static const CGFloat kVerticalSpaceBetweenButtonAndTextLabel = 12.0f;
static const CGFloat kDividerDefaultOpacity = 0.12f;
static const CGFloat kDividerDefaultHeight = 1.0f;
static NSString *const kMDCBannerViewImageViewImageKeyPath = @"image";

@interface MDCBannerView ()

@property(nonatomic, readwrite, strong) UILabel *textLabel;

@property(nonatomic, readwrite, strong) UIImageView *imageView;

@property(nonatomic, readwrite, strong) MDCButton *leadingButton;
@property(nonatomic, readwrite, strong) MDCButton *trailingButton;
@property(nonatomic, readwrite, strong) UIView *buttonContainerView;

@property(nonatomic, readwrite, strong) UIView *divider;
@property(nonatomic, readwrite, assign) CGFloat dividerHeight;

// Image constraints
@property(nonatomic, readwrite, strong) NSLayoutConstraint *imageViewConstraintLeading;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *imageViewConstraintCenterY;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *imageViewConstraintTopLarge;

// Text Label constraints
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textLabelConstraintLeadingWithMargin;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textLabelConstraintLeadingWithImage;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textLabelConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textLabelConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textLabelConstraintCenterY;
// Buttons constraints
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintLeading;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintWidthWithLeadingButton;
@property(nonatomic, readwrite, strong) NSLayoutConstraint
    *buttonContainerConstraintLeadingWithTextLabel;  // The horizontal constraint between button
                                                     // container and text label.
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintTopWithMargin;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintTopWithImageViewGreater;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintTopWithTextLabel;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintTopWithTextLabelGreater;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintBottom;

@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintLeading;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintCenterY;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *leadingButtonConstraintTrailingWithTrailingButton;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintBottom;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintTrailing;

@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintHeight;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintBottom;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintLeading;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintWidth;

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
  _bannerViewLayoutStyle = MDCBannerViewLayoutStyleAutomatic;

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
  imageView.hidden = YES;
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

  // Create Divider
  UIView *divider = [[UIView alloc] init];
  divider.translatesAutoresizingMaskIntoConstraints = NO;
  divider.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:kDividerDefaultOpacity];
  _dividerHeight = kDividerDefaultHeight;
  [self addSubview:divider];
  _divider = divider;

  [self setupConstraints];
}

- (void)setBannerViewLayoutStyle:(MDCBannerViewLayoutStyle)bannerViewLayoutStyle {
  _bannerViewLayoutStyle = bannerViewLayoutStyle;
  if (bannerViewLayoutStyle == MDCBannerViewLayoutStyleSingleRow) {
    // Only leadingButton is supported in MDCBannerViewLayoutStyleSingleRow.
    self.trailingButton.hidden = YES;
  }
}

- (void)setDividerColor:(UIColor *)dividerColor {
  self.divider.backgroundColor = dividerColor;
}

- (UIColor *)dividerColor {
  return self.divider.backgroundColor;
}

#pragma mark - Constraints Helpers

- (void)setupConstraints {
  [self setUpImageViewConstraints];
  [self setUpTextLabelConstraints];
  [self setUpButtonContainerConstraints];
  [self setUpButtonsConstraints];
  [self setUpDividerConstraints];
}

- (void)setUpImageViewConstraints {
  self.imageViewConstraintLeading =
      [self.imageView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor
                                                   constant:kLeadingPadding];
  self.imageViewConstraintTopLarge =
      [self.imageView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor
                                               constant:kTopPaddingLarge];
  self.imageViewConstraintCenterY =
      [self.imageView.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
}

- (void)setUpTextLabelConstraints {
  self.textLabelConstraintTop =
      [self.textLabel.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor
                                               constant:kTopPaddingLarge];
  self.textLabelConstraintCenterY =
      [self.textLabel.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
  self.textLabelConstraintTrailing =
      [self.textLabel.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor
                                                    constant:-kTrailingPadding];
  self.textLabelConstraintLeadingWithImage =
      [self.textLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor
                                                   constant:kSpaceBetweenIconImageAndTextLabel];
  self.textLabelConstraintLeadingWithMargin =
      [self.textLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor
                                                   constant:kLeadingPadding];
}

- (void)setUpButtonContainerConstraints {
  self.buttonContainerConstraintLeading = [self.buttonContainerView.leadingAnchor
      constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor
                     constant:kLeadingPadding];
  self.buttonContainerConstraintWidthWithLeadingButton =
      [self.buttonContainerView.widthAnchor constraintEqualToAnchor:self.leadingButton.widthAnchor];
  self.buttonContainerConstraintTrailing = [self.buttonContainerView.trailingAnchor
      constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor
                     constant:-kTrailingPadding];
  self.buttonContainerConstraintBottom = [self.buttonContainerView.bottomAnchor
      constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor
                     constant:-kBottomPadding];
  self.buttonContainerConstraintLeadingWithTextLabel = [self.buttonContainerView.leadingAnchor
      constraintEqualToAnchor:self.textLabel.trailingAnchor
                     constant:kHorizontalSpaceBetweenTextLabelAndButton];
  self.buttonContainerConstraintTopWithMargin =
      [self.buttonContainerView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor
                                                         constant:kTopPaddingSmall];
  self.buttonContainerConstraintTopWithImageViewGreater = [self.buttonContainerView.topAnchor
      constraintGreaterThanOrEqualToAnchor:self.imageView.bottomAnchor
                                  constant:kVerticalSpaceBetweenButtonAndTextLabel];
  self.buttonContainerConstraintTopWithTextLabel = [self.buttonContainerView.topAnchor
      constraintEqualToAnchor:self.textLabel.bottomAnchor
                     constant:kVerticalSpaceBetweenButtonAndTextLabel];
  self.buttonContainerConstraintTopWithTextLabel.priority = UILayoutPriorityDefaultLow;
  self.buttonContainerConstraintTopWithTextLabelGreater = [self.buttonContainerView.topAnchor
      constraintGreaterThanOrEqualToAnchor:self.textLabel.bottomAnchor
                                  constant:kVerticalSpaceBetweenButtonAndTextLabel];
}

- (void)setUpButtonsConstraints {
  self.leadingButtonConstraintLeading = [self.leadingButton.leadingAnchor
      constraintGreaterThanOrEqualToAnchor:self.buttonContainerView.leadingAnchor];
  self.leadingButtonConstraintTop =
      [self.leadingButton.topAnchor constraintEqualToAnchor:self.buttonContainerView.topAnchor];
  self.leadingButtonConstraintTrailing = [self.leadingButton.trailingAnchor
      constraintEqualToAnchor:self.buttonContainerView.trailingAnchor];
  self.leadingButtonConstraintCenterY = [self.leadingButton.centerYAnchor
      constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
  self.leadingButtonConstraintTrailingWithTrailingButton =
      [self.leadingButton.trailingAnchor constraintEqualToAnchor:self.trailingButton.leadingAnchor
                                                        constant:-kButtonHorizontalIntervalSpace];
  [self.leadingButton setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                      forAxis:UILayoutConstraintAxisHorizontal];
  [self.leadingButton setContentHuggingPriority:UILayoutPriorityRequired
                                        forAxis:UILayoutConstraintAxisHorizontal];
  self.trailingButtonConstraintBottom = [self.trailingButton.bottomAnchor
      constraintEqualToAnchor:self.buttonContainerView.bottomAnchor];
  self.trailingButtonConstraintTop =
      [self.trailingButton.topAnchor constraintEqualToAnchor:self.leadingButton.bottomAnchor
                                                    constant:kButtonVerticalIntervalSpace];
  self.trailingButtonConstraintTrailing = [self.trailingButton.trailingAnchor
      constraintEqualToAnchor:self.buttonContainerView.trailingAnchor];
  [self.trailingButton setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisHorizontal];
  [self.trailingButton setContentHuggingPriority:UILayoutPriorityRequired
                                         forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setUpDividerConstraints {
  self.dividerConstraintBottom =
      [self.divider.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
  self.dividerConstraintHeight =
      [self.divider.heightAnchor constraintEqualToConstant:self.dividerHeight];
  self.dividerConstraintWidth = [self.divider.widthAnchor constraintEqualToAnchor:self.widthAnchor];
  self.dividerConstraintLeading =
      [self.divider.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
}

- (void)deactivateAllConstraints {
  self.imageViewConstraintLeading.active = NO;
  self.imageViewConstraintTopLarge.active = NO;
  self.imageViewConstraintCenterY.active = NO;
  self.textLabelConstraintLeadingWithMargin.active = NO;
  self.textLabelConstraintLeadingWithImage.active = NO;
  self.textLabelConstraintTrailing.active = NO;
  self.textLabelConstraintTop.active = NO;
  self.textLabelConstraintCenterY.active = NO;
  self.buttonContainerConstraintLeading.active = NO;
  self.buttonContainerConstraintWidthWithLeadingButton.active = NO;
  self.buttonContainerConstraintLeadingWithTextLabel.active = NO;
  self.buttonContainerConstraintTrailing.active = NO;
  self.buttonContainerConstraintTopWithMargin.active = NO;
  self.buttonContainerConstraintTopWithImageViewGreater.active = NO;
  self.buttonContainerConstraintTopWithTextLabel.active = NO;
  self.buttonContainerConstraintTopWithTextLabelGreater.active = NO;
  self.buttonContainerConstraintBottom.active = NO;
  self.leadingButtonConstraintLeading.active = NO;
  self.leadingButtonConstraintTop.active = NO;
  self.leadingButtonConstraintTrailing.active = NO;
  self.leadingButtonConstraintCenterY.active = NO;
  self.leadingButtonConstraintTrailingWithTrailingButton.active = NO;
  self.trailingButtonConstraintBottom.active = NO;
  self.trailingButtonConstraintTop.active = NO;
  self.trailingButtonConstraintTrailing.active = NO;
  self.dividerConstraintBottom.active = NO;
  self.dividerConstraintHeight.active = NO;
  self.dividerConstraintLeading.active = NO;
  self.dividerConstraintWidth.active = NO;
}

#pragma mark - UIView overrides

- (CGSize)sizeThatFits:(CGSize)size {
  MDCBannerViewLayoutStyle layoutStyle = [self layoutStyleForSizeToFit:size];
  CGFloat frameHeight = 0.0f;
  switch (layoutStyle) {
    case MDCBannerViewLayoutStyleSingleRow: {
      frameHeight += kTopPaddingSmall + kBottomPadding;
      CGFloat widthLimit = size.width;
      CGFloat marginsPadding = self.layoutMargins.left + self.layoutMargins.right;
      widthLimit -= marginsPadding;
      widthLimit -= (kLeadingPadding + kTrailingPadding);
      [self.leadingButton sizeToFit];
      CGFloat buttonWidth = CGRectGetWidth(self.leadingButton.frame);
      widthLimit -= (buttonWidth + kHorizontalSpaceBetweenTextLabelAndButton);
      if (!self.imageView.hidden) {
        widthLimit -= kImageViewSideLength;
        widthLimit -= kSpaceBetweenIconImageAndTextLabel;
      }
      CGSize textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(widthLimit, CGFLOAT_MAX)];
      CGSize leadingButtonSize = [self.leadingButton sizeThatFits:CGSizeZero];
      CGFloat maximumHeight = MAX(textLabelSize.height, leadingButtonSize.height);
      if (!self.imageView.hidden) {
        maximumHeight = MAX(kImageViewSideLength, maximumHeight);
      }
      frameHeight += maximumHeight;
      break;
    }
    case MDCBannerViewLayoutStyleMultiRowAlignedButton: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextLabelWithSizeToFit:size];
      CGSize leadingButtonSize = [self.leadingButton sizeThatFits:CGSizeZero];
      CGSize trailingButtonSize = [self.trailingButton sizeThatFits:CGSizeZero];
      frameHeight += MAX(leadingButtonSize.height, trailingButtonSize.height);
      break;
    }
    case MDCBannerViewLayoutStyleMultiRowStackedButton: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextLabelWithSizeToFit:size];
      CGSize leadingButtonSize = [self.leadingButton sizeThatFits:CGSizeZero];
      CGSize trailingButtonSize = [self.trailingButton sizeThatFits:CGSizeZero];
      frameHeight +=
          leadingButtonSize.height + trailingButtonSize.height + kButtonVerticalIntervalSpace;
      break;
    }
    default:
      break;
  }
  if (self.showsDivider) {
    frameHeight += self.dividerHeight;
  }
  return CGSizeMake(size.width, frameHeight);
}

- (CGSize)intrinsicContentSize {
  CGFloat intrinsicContentHeight = [self sizeThatFits:self.bounds.size].height;
  return CGSizeMake(UIViewNoIntrinsicMetric, intrinsicContentHeight);
}

- (void)updateConstraints {
  MDCBannerViewLayoutStyle layoutStyle = [self layoutStyleForSizeToFit:self.bounds.size];
  [self updateConstraintsWithLayoutStyle:layoutStyle];

  [super updateConstraints];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self invalidateIntrinsicContentSize];
}

#pragma mark - Layout methods

- (void)updateConstraintsWithLayoutStyle:(MDCBannerViewLayoutStyle)layoutStyle {
  [self deactivateAllConstraints];

  self.imageViewConstraintLeading.active = YES;
  if (!self.imageView.hidden) {
    self.textLabelConstraintLeadingWithImage.active = YES;
  } else {
    self.textLabelConstraintLeadingWithMargin.active = YES;
  }
  self.buttonContainerConstraintTrailing.active = YES;
  self.buttonContainerConstraintBottom.active = YES;

  if (layoutStyle == MDCBannerViewLayoutStyleSingleRow) {
    self.imageViewConstraintCenterY.active = YES;
    self.textLabelConstraintCenterY.active = YES;
    self.buttonContainerConstraintWidthWithLeadingButton.active = YES;
    self.buttonContainerConstraintLeadingWithTextLabel.active = YES;
    self.buttonContainerConstraintTopWithMargin.active = YES;
  } else {
    self.imageViewConstraintTopLarge.active = YES;
    if (!self.imageView.hidden) {
      self.buttonContainerConstraintTopWithImageViewGreater.active = YES;
    }
    self.textLabelConstraintTop.active = YES;
    self.textLabelConstraintTrailing.active = YES;
    self.buttonContainerConstraintTopWithTextLabelGreater.active = YES;
    self.buttonContainerConstraintTopWithTextLabel.active = YES;
    self.buttonContainerConstraintLeading.active = YES;
  }
  [self updateButtonsConstraintsWithLayoutStyle:layoutStyle];

  if (self.showsDivider) {
    self.dividerConstraintWidth.active = YES;
    self.dividerConstraintLeading.active = YES;
    self.dividerConstraintHeight.active = YES;
    self.dividerConstraintBottom.active = YES;
  }
}

#pragma mark - Layout helpers

- (void)updateButtonsConstraintsWithLayoutStyle:(MDCBannerViewLayoutStyle)layoutStyle {
  if (self.trailingButton.hidden) {
    self.leadingButtonConstraintTrailing.active = YES;
    self.leadingButtonConstraintCenterY.active = YES;
  } else {
    if (layoutStyle == MDCBannerViewLayoutStyleMultiRowStackedButton) {
      self.leadingButtonConstraintTrailing.active = YES;
      self.trailingButtonConstraintTop.active = YES;
    } else {
      self.leadingButtonConstraintTrailingWithTrailingButton.active = YES;
    }
    self.leadingButtonConstraintTop.active = YES;
  }
  self.leadingButtonConstraintLeading.active = YES;
  self.trailingButtonConstraintTrailing.active = YES;
  self.trailingButtonConstraintBottom.active = YES;
}

- (MDCBannerViewLayoutStyle)layoutStyleForSizeToFit:(CGSize)sizeToFit {
  if (self.bannerViewLayoutStyle != MDCBannerViewLayoutStyleAutomatic) {
    return self.bannerViewLayoutStyle;
  }

  MDCBannerViewLayoutStyle layoutStyle;
  CGFloat remainingWidth = sizeToFit.width;
  CGFloat marginsPadding = self.layoutMargins.left + self.layoutMargins.right;
  remainingWidth -= marginsPadding;
  remainingWidth -= (kLeadingPadding + kTrailingPadding);
  [self.leadingButton sizeToFit];
  if (self.trailingButton.hidden) {
    CGFloat buttonWidth = CGRectGetWidth(self.leadingButton.frame);
    remainingWidth -= (buttonWidth + kHorizontalSpaceBetweenTextLabelAndButton);
    if (!self.imageView.hidden) {
      remainingWidth -= kImageViewSideLength;
      remainingWidth -= kSpaceBetweenIconImageAndTextLabel;
    }
    layoutStyle = [self isAbleToFitTextLabel:self.textLabel withWidthLimit:remainingWidth]
                      ? MDCBannerViewLayoutStyleSingleRow
                      : MDCBannerViewLayoutStyleMultiRowAlignedButton;
  } else {
    [self.trailingButton sizeToFit];
    CGFloat buttonWidth = [self widthSumForButtons:@[ self.leadingButton, self.trailingButton ]];
    remainingWidth -= buttonWidth;
    layoutStyle = (remainingWidth > 0) ? MDCBannerViewLayoutStyleMultiRowAlignedButton
                                       : MDCBannerViewLayoutStyleMultiRowStackedButton;
  }
  return layoutStyle;
}

- (CGFloat)getFrameHeightOfImageViewAndTextLabelWithSizeToFit:(CGSize)sizeToFit {
  CGFloat frameHeight = 0;
  CGFloat remainingWidth = sizeToFit.width - kLeadingPadding - kTrailingPadding;
  CGSize textLabelSize = CGSizeZero;
  if (!self.imageView.hidden) {
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

- (BOOL)isAbleToFitTextLabel:(UILabel *)textLabel withWidthLimit:(CGFloat)widthLimit {
  CGSize size = [textLabel.text sizeWithAttributes:@{NSFontAttributeName : textLabel.font}];
  return size.width <= widthLimit;
}

@end
