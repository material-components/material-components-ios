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
static const CGFloat kSpaceBetweenIconImageAndTextView = 16.0f;
static const CGFloat kHorizontalSpaceBetweenTextViewAndButton = 24.0f;
static const CGFloat kVerticalSpaceBetweenButtonAndTextView = 12.0f;
static const CGFloat kDividerDefaultOpacity = 0.12f;
static const CGFloat kDividerDefaultHeight = 1.0f;
static NSString *const kMDCBannerViewImageViewImageKeyPath = @"image";

@interface MDCBannerView ()

@property(nonatomic, readwrite, strong) UITextView *textView;

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

// Text View constraints
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textViewConstraintLeadingWithMargin;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textViewConstraintLeadingWithImage;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textViewConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textViewConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *textViewConstraintCenterY;
// Buttons constraints
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintLeading;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintWidthWithLeadingButton;
@property(nonatomic, readwrite, strong) NSLayoutConstraint
    *buttonContainerConstraintLeadingWithTextView;  // The horizontal constraint between button
                                                    // container and text view.
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintTopWithMargin;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintTopWithImageViewGreater;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintTopWithTextView;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *buttonContainerConstraintTopWithTextViewGreater;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintBottom;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *buttonContainerConstraintHeight;

@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintLeading;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintCenterY;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *leadingButtonConstraintBaseLineWithTrailingButton;
@property(nonatomic, readwrite, strong)
    NSLayoutConstraint *leadingButtonConstraintTrailingWithTrailingButton;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *leadingButtonConstraintHeightZero;

@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintBottom;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintTrailing;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *trailingButtonConstraintHeightZero;

@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintHeight;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintBottom;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintLeading;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *dividerConstraintWidth;

@end

@implementation MDCBannerView

@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;
@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;

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
  self.layoutMargins = UIEdgeInsetsZero;

  // Create textView
  UITextView *textView = [[UITextView alloc] init];
  textView.translatesAutoresizingMaskIntoConstraints = NO;
  textView.font = [MDCTypography body2Font];
  textView.textColor = UIColor.blackColor;
  textView.alpha = [MDCTypography body2FontOpacity];
  textView.textContainer.maximumNumberOfLines = kTextNumberOfLineLimit;
  textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
  textView.textContainer.lineFragmentPadding = 0;
  textView.scrollEnabled = NO;
  textView.editable = NO;
  textView.textAlignment = NSTextAlignmentNatural;
  textView.textContainerInset = UIEdgeInsetsZero;
  textView.backgroundColor = UIColor.clearColor;
  [self addSubview:textView];
  _textView = textView;

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
  leadingButton.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
  [buttonContainerView addSubview:leadingButton];
  _leadingButton = leadingButton;

  MDCButton *trailingButton = [[MDCButton alloc] init];
  trailingButton.translatesAutoresizingMaskIntoConstraints = NO;
  trailingButton.backgroundColor = UIColor.whiteColor;
  trailingButton.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
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

  _mdc_overrideBaseElevation = -1;
}

- (void)setDividerColor:(UIColor *)dividerColor {
  self.divider.backgroundColor = dividerColor;
}

- (UIColor *)dividerColor {
  return self.divider.backgroundColor;
}

- (CGFloat)mdc_currentElevation {
  return 0;
}

#pragma mark - Constraints Helpers

- (void)setupConstraints {
  [self setUpImageViewConstraints];
  [self setUpTextViewConstraints];
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

- (void)setUpTextViewConstraints {
  self.textViewConstraintTop =
      [self.textView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor
                                              constant:kTopPaddingLarge];
  self.textViewConstraintCenterY =
      [self.textView.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
  self.textViewConstraintTrailing =
      [self.textView.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor
                                                   constant:-kTrailingPadding];
  self.textViewConstraintLeadingWithImage =
      [self.textView.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor
                                                  constant:kSpaceBetweenIconImageAndTextView];
  self.textViewConstraintLeadingWithMargin =
      [self.textView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor
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
  self.buttonContainerConstraintLeadingWithTextView = [self.buttonContainerView.leadingAnchor
      constraintEqualToAnchor:self.textView.trailingAnchor
                     constant:kHorizontalSpaceBetweenTextViewAndButton];
  self.buttonContainerConstraintTopWithMargin =
      [self.buttonContainerView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor
                                                         constant:kTopPaddingSmall];
  self.buttonContainerConstraintTopWithImageViewGreater = [self.buttonContainerView.topAnchor
      constraintGreaterThanOrEqualToAnchor:self.imageView.bottomAnchor
                                  constant:kVerticalSpaceBetweenButtonAndTextView];
  self.buttonContainerConstraintTopWithTextView = [self.buttonContainerView.topAnchor
      constraintEqualToAnchor:self.textView.bottomAnchor
                     constant:kVerticalSpaceBetweenButtonAndTextView];
  self.buttonContainerConstraintTopWithTextView.priority = UILayoutPriorityDefaultLow;
  self.buttonContainerConstraintTopWithTextViewGreater = [self.buttonContainerView.topAnchor
      constraintGreaterThanOrEqualToAnchor:self.textView.bottomAnchor
                                  constant:kVerticalSpaceBetweenButtonAndTextView];
  self.buttonContainerConstraintHeight = [self.buttonContainerView.heightAnchor
      constraintGreaterThanOrEqualToAnchor:self.leadingButton.heightAnchor
                                  constant:0];
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
  self.leadingButtonConstraintBaseLineWithTrailingButton = [self.leadingButton.lastBaselineAnchor
      constraintEqualToAnchor:self.trailingButton.lastBaselineAnchor];
  self.leadingButtonConstraintTrailingWithTrailingButton =
      [self.leadingButton.trailingAnchor constraintEqualToAnchor:self.trailingButton.leadingAnchor
                                                        constant:-kButtonHorizontalIntervalSpace];
  [self.leadingButton setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                      forAxis:UILayoutConstraintAxisHorizontal];
  [self.leadingButton setContentHuggingPriority:UILayoutPriorityRequired
                                        forAxis:UILayoutConstraintAxisHorizontal];
  self.leadingButtonConstraintHeightZero =
      [self.leadingButton.heightAnchor constraintEqualToConstant:0.f];
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
  self.trailingButtonConstraintHeightZero =
      [self.trailingButton.heightAnchor constraintEqualToConstant:0.f];
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
  self.textViewConstraintLeadingWithMargin.active = NO;
  self.textViewConstraintLeadingWithImage.active = NO;
  self.textViewConstraintTrailing.active = NO;
  self.textViewConstraintTop.active = NO;
  self.textViewConstraintCenterY.active = NO;
  self.buttonContainerConstraintLeading.active = NO;
  self.buttonContainerConstraintWidthWithLeadingButton.active = NO;
  self.buttonContainerConstraintLeadingWithTextView.active = NO;
  self.buttonContainerConstraintTrailing.active = NO;
  self.buttonContainerConstraintTopWithMargin.active = NO;
  self.buttonContainerConstraintTopWithImageViewGreater.active = NO;
  self.buttonContainerConstraintTopWithTextView.active = NO;
  self.buttonContainerConstraintTopWithTextViewGreater.active = NO;
  self.buttonContainerConstraintBottom.active = NO;
  self.buttonContainerConstraintHeight.active = NO;
  self.leadingButtonConstraintLeading.active = NO;
  self.leadingButtonConstraintTop.active = NO;
  self.leadingButtonConstraintTrailing.active = NO;
  self.leadingButtonConstraintCenterY.active = NO;
  self.leadingButtonConstraintBaseLineWithTrailingButton.active = NO;
  self.leadingButtonConstraintTrailingWithTrailingButton.active = NO;
  self.leadingButtonConstraintHeightZero.active = NO;
  self.trailingButtonConstraintBottom.active = NO;
  self.trailingButtonConstraintTop.active = NO;
  self.trailingButtonConstraintTrailing.active = NO;
  self.trailingButtonConstraintHeightZero.active = NO;
  self.dividerConstraintBottom.active = NO;
  self.dividerConstraintHeight.active = NO;
  self.dividerConstraintLeading.active = NO;
  self.dividerConstraintWidth.active = NO;
}

#pragma mark - UIView overrides

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];

  [self deactivateAllConstraints];
  [self setNeedsUpdateConstraints];
}

- (CGSize)sizeThatFits:(CGSize)size {
  MDCBannerViewLayoutStyle layoutStyle = [self layoutStyleForSizeToFit:size];
  CGFloat frameHeight = self.layoutMargins.top + self.layoutMargins.bottom;
  CGSize contentSize = [self contentSizeForLayoutSize:size];
  switch (layoutStyle) {
    case MDCBannerViewLayoutStyleSingleRow: {
      frameHeight += kTopPaddingSmall + kBottomPadding;
      CGFloat widthLimit = contentSize.width;
      if (!self.leadingButton.hidden) {
        [self.leadingButton sizeToFit];
        CGFloat buttonWidth = CGRectGetWidth(self.leadingButton.frame);
        widthLimit -= (buttonWidth + kHorizontalSpaceBetweenTextViewAndButton);
      }
      if (!self.imageView.hidden) {
        widthLimit -= kImageViewSideLength;
        widthLimit -= kSpaceBetweenIconImageAndTextView;
      }
      CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(widthLimit, CGFLOAT_MAX)];
      CGFloat maximumHeight = textViewSize.height;
      if (!self.leadingButton.hidden) {
        CGSize leadingButtonSize = [self.leadingButton sizeThatFits:CGSizeZero];
        maximumHeight = MAX(leadingButtonSize.height, maximumHeight);
      }
      if (!self.imageView.hidden) {
        maximumHeight = MAX(kImageViewSideLength, maximumHeight);
      }
      frameHeight += maximumHeight;
      break;
    }
    case MDCBannerViewLayoutStyleMultiRowAlignedButton: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextViewWithSizeToFit:contentSize];
      CGSize leadingButtonSize =
          self.leadingButton.hidden ? CGSizeZero : [self.leadingButton sizeThatFits:CGSizeZero];
      CGSize trailingButtonSize =
          self.trailingButton.hidden ? CGSizeZero : [self.trailingButton sizeThatFits:CGSizeZero];
      frameHeight += MAX(leadingButtonSize.height, trailingButtonSize.height);
      break;
    }
    case MDCBannerViewLayoutStyleMultiRowStackedButton: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextViewWithSizeToFit:contentSize];
      CGSize leadingButtonSize =
          self.leadingButton.hidden ? CGSizeZero : [self.leadingButton sizeThatFits:CGSizeZero];
      CGSize trailingButtonSize =
          self.trailingButton.hidden ? CGSizeZero : [self.trailingButton sizeThatFits:CGSizeZero];
      CGFloat verticalIntervalSpace = kButtonVerticalIntervalSpace;
      if (self.leadingButton.hidden || self.trailingButton.hidden) {
        verticalIntervalSpace = 0.f;
      }
      frameHeight += leadingButtonSize.height + trailingButtonSize.height + verticalIntervalSpace;
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
  if (!CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
    MDCBannerViewLayoutStyle layoutStyle = [self layoutStyleForSizeToFit:self.bounds.size];
    [self updateConstraintsWithLayoutStyle:layoutStyle];
  }

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
    self.textViewConstraintLeadingWithImage.active = YES;
  } else {
    self.textViewConstraintLeadingWithMargin.active = YES;
  }
  self.buttonContainerConstraintTrailing.active = YES;
  self.buttonContainerConstraintBottom.active = YES;
  self.buttonContainerConstraintHeight.active = YES;

  if (layoutStyle == MDCBannerViewLayoutStyleSingleRow) {
    self.imageViewConstraintCenterY.active = YES;
    self.textViewConstraintCenterY.active = YES;
    if (self.trailingButton.hidden) {
      self.buttonContainerConstraintWidthWithLeadingButton.active = YES;
    }
    self.buttonContainerConstraintTopWithMargin.active = YES;
    if (self.leadingButton.hidden) {
      self.textViewConstraintTrailing.active = YES;
    } else {
      self.buttonContainerConstraintLeadingWithTextView.active = YES;
    }
  } else {
    self.imageViewConstraintTopLarge.active = YES;
    if (!self.imageView.hidden) {
      self.buttonContainerConstraintTopWithImageViewGreater.active = YES;
    }
    self.textViewConstraintTop.active = YES;
    self.textViewConstraintTrailing.active = YES;
    self.buttonContainerConstraintTopWithTextViewGreater.active = YES;
    self.buttonContainerConstraintTopWithTextView.active = YES;
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
    self.trailingButtonConstraintHeightZero.active = YES;
  } else {
    if (layoutStyle == MDCBannerViewLayoutStyleMultiRowStackedButton) {
      self.leadingButtonConstraintTop.active = YES;
      self.leadingButtonConstraintTrailing.active = YES;
      self.trailingButtonConstraintTop.active = YES;
    } else {
      self.leadingButtonConstraintTrailingWithTrailingButton.active = YES;
      self.leadingButtonConstraintBaseLineWithTrailingButton.active = YES;
    }
  }
  if (self.leadingButton.hidden) {
    self.leadingButtonConstraintHeightZero.active = YES;
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
  CGSize contentSize = [self contentSizeForLayoutSize:sizeToFit];
  CGFloat remainingWidth = contentSize.width;
  [self.leadingButton sizeToFit];
  if (self.trailingButton.hidden) {
    CGFloat buttonWidth = CGRectGetWidth(self.leadingButton.frame);
    remainingWidth -= (buttonWidth + kHorizontalSpaceBetweenTextViewAndButton);
    if (!self.imageView.hidden) {
      remainingWidth -= kImageViewSideLength;
      remainingWidth -= kSpaceBetweenIconImageAndTextView;
    }
    layoutStyle = [self isAbleToFitTextView:self.textView withWidthLimit:remainingWidth]
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

- (CGFloat)getFrameHeightOfImageViewAndTextViewWithSizeToFit:(CGSize)sizeToFit {
  CGFloat frameHeight = 0;
  CGFloat remainingWidth = sizeToFit.width;
  CGSize textViewSize = CGSizeZero;
  if (!self.imageView.hidden) {
    remainingWidth -= (kImageViewSideLength + kSpaceBetweenIconImageAndTextView);
    textViewSize = [self.textView sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += MAX(textViewSize.height, kImageViewSideLength);
  } else {
    textViewSize = [self.textView sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += textViewSize.height;
  }
  frameHeight += kVerticalSpaceBetweenButtonAndTextView;
  return frameHeight;
}

- (CGSize)contentSizeForLayoutSize:(CGSize)layoutSize {
  CGFloat remainingWidth = layoutSize.width;
  CGFloat marginsPadding = self.layoutMargins.left + self.layoutMargins.right;
  remainingWidth -= marginsPadding;
  remainingWidth -= (kLeadingPadding + kTrailingPadding);
  return CGSizeMake(remainingWidth, layoutSize.height);
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

- (BOOL)isAbleToFitTextView:(UITextView *)textView withWidthLimit:(CGFloat)widthLimit {
  CGSize size = [textView sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  return size.width <= widthLimit;
}

#pragma mark - Font

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)mdc_adjustsFontForContentSizeCategory {
  _mdc_adjustsFontForContentSizeCategory = mdc_adjustsFontForContentSizeCategory;

  if (mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }

  // Set mdc_adjustsFontForContentSizeCategory on buttons
  self.leadingButton.mdc_adjustsFontForContentSizeCategory =
      self.mdc_adjustsFontForContentSizeCategory;
  self.trailingButton.mdc_adjustsFontForContentSizeCategory =
      self.mdc_adjustsFontForContentSizeCategory;

  [self updateBannerFont];
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateBannerFont];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  [self updateBannerFont];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (void)updateBannerFont {
  [self updateTextFont];

  [self invalidateIntrinsicContentSize];
  [self setNeedsUpdateConstraints];
}

- (void)updateTextFont {
  if (self.mdc_adjustsFontForContentSizeCategory) {
    NSAttributedString *attributedText = self.textView.attributedText;
    NSMutableAttributedString *mutableAttributedText = [attributedText mutableCopy];
    UIFont *textFont = self.textView.font;
    if (textFont.mdc_scalingCurve) {
      textFont = [textFont mdc_scaledFontForTraitEnvironment:self];
    }
    self.textView.font = textFont;
    [mutableAttributedText beginEditing];
    __block BOOL hasScalableFont = NO;
    [mutableAttributedText
        enumerateAttribute:NSFontAttributeName
                   inRange:NSMakeRange(0, mutableAttributedText.length)
                   options:0
                usingBlock:^(id value, NSRange range, BOOL *stop) {
                  if (value) {
                    UIFont *previousFont = (UIFont *)value;
                    if (previousFont.mdc_scalingCurve) {
                      hasScalableFont = YES;
                      UIFont *scaledFont = [previousFont mdc_scaledFontForTraitEnvironment:self];
                      [mutableAttributedText removeAttribute:NSFontAttributeName range:range];
                      [mutableAttributedText addAttribute:NSFontAttributeName
                                                    value:scaledFont
                                                    range:range];
                    }
                  }
                }];
    [mutableAttributedText endEditing];
    if (hasScalableFont) {
      self.textView.attributedText = [mutableAttributedText copy];
    }
  }
}

#pragma mark - Accessibility

- (NSArray *)accessibilityElements {
  return @[ self.textView, self.leadingButton, self.trailingButton ];
}

@end
