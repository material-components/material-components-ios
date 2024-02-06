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

#import "MDCButton.h"
#import "M3CButton.h"

NS_ASSUME_NONNULL_BEGIN

static const NSInteger kTextNumberOfLineLimit = 3;
static const CGFloat kImageViewSideLength = 40;
static const CGFloat kLeadingPadding = 16.0f;
static const CGFloat kTextTrailingPadding = 16.0f;
static const CGFloat kButtonContainerTrailingPadding = 8.0f;
static const CGFloat kButtonContainerTrailingPaddingWithM3CButton = 16.0f;
static const CGFloat kTopPaddingSmall = 10.0f;
static const CGFloat kTopPaddingLarge = 24.0f;
static const CGFloat kBottomPadding = 8.0f;
static const CGFloat kButtonHorizontalIntervalSpace = 8.0f;
static const CGFloat kButtonVerticalIntervalSpace = 8.0f;
static const CGFloat kSpaceBetweenIconImageAndTextView = 16.0f;
static const CGFloat kHorizontalSpaceBetweenTextViewAndButton = 24.0f;
static const CGFloat kVerticalSpaceBetweenButtonAndTextView = 12.0f;
static const CGFloat kVerticalSpaceBetweenButtonAndTextViewWithM3CButton = 8.0f;
static const CGFloat kDividerDefaultOpacity = 0.12f;
static const CGFloat kDividerDefaultHeight = 1.0f;
static const CGFloat kTextDefaultOpacity = 0.87f;
static NSString *const kMDCBannerViewImageViewImageKeyPath = @"image";

@interface MDCBannerView ()

@property(nonatomic, readwrite, strong) UIView *contentView;

@property(nonatomic, readwrite, strong) UITextView *textView;

@property(nonatomic, readwrite, strong) UIImageView *imageView;

@property(nonatomic, readwrite, strong) MDCButton *leadingButton;
@property(nonatomic, readwrite, strong) MDCButton *trailingButton;
@property(nonatomic, readwrite, strong) M3CButton *leadingM3CButton;
@property(nonatomic, readwrite, strong) M3CButton *trailingM3CButton;
@property(nonatomic, readwrite, strong) UIView *buttonContainerView;
@property(nonatomic, readonly, strong) UIButton *currentLeadingButton;
@property(nonatomic, readonly, strong) UIButton *currentTrailingButton;

@property(nonatomic, readwrite, strong) UIView *divider;
@property(nonatomic, readwrite, assign) CGFloat dividerHeight;

// Content constraints
@property(nonatomic, readwrite, strong) NSLayoutConstraint *contentViewConstraintTop;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *contentViewConstraintBottom;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *contentViewConstraintLeft;
@property(nonatomic, readwrite, strong) NSLayoutConstraint *contentViewConstraintRight;

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
@synthesize isM3CButtonEnabled = _isM3CButtonEnabled;

- (instancetype)initForM3 {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _isM3CButtonEnabled = YES;
    [self commonBannerViewInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _isM3CButtonEnabled = NO;
    [self commonBannerViewInit];
  }
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _isM3CButtonEnabled = NO;
    [self commonBannerViewInit];
  }
  return self;
}

- (void)commonBannerViewInit {
  self.backgroundColor = UIColor.whiteColor;
  _bannerViewLayoutStyle = MDCBannerViewLayoutStyleAutomatic;
  self.layoutMargins = UIEdgeInsetsZero;
  self.contentEdgeInsets = UIEdgeInsetsZero;

  UIView *contentView = [[UIView alloc] init];
  contentView.translatesAutoresizingMaskIntoConstraints = NO;
  _contentView = contentView;
  [self addSubview:contentView];

  // Create textView
  UITextView *textView = [[UITextView alloc] init];
  textView.translatesAutoresizingMaskIntoConstraints = NO;
  textView.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
  textView.textColor = UIColor.blackColor;
  textView.alpha = kTextDefaultOpacity;
  textView.textContainer.maximumNumberOfLines = kTextNumberOfLineLimit;
  textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
  textView.textContainer.lineFragmentPadding = 0;
  textView.scrollEnabled = NO;
  textView.editable = NO;
  textView.textAlignment = NSTextAlignmentNatural;
  textView.textContainerInset = UIEdgeInsetsZero;
  textView.backgroundColor = UIColor.clearColor;
  [contentView addSubview:textView];
  _textView = textView;

  // Create imageView
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.translatesAutoresizingMaskIntoConstraints = NO;
  [imageView.widthAnchor constraintEqualToConstant:kImageViewSideLength].active = YES;
  [imageView.heightAnchor constraintEqualToConstant:kImageViewSideLength].active = YES;
  imageView.contentMode = UIViewContentModeCenter;
  imageView.clipsToBounds = YES;
  imageView.hidden = YES;
  [contentView addSubview:imageView];
  _imageView = imageView;

  // Create a button container to organize buttons
  UIView *buttonContainerView = [[UIView alloc] init];
  buttonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
  [contentView addSubview:buttonContainerView];
  self.buttonContainerView = buttonContainerView;

  // Create leadingButton and trailingButton
  MDCButton *leadingButton = [[MDCButton alloc] init];
  leadingButton.translatesAutoresizingMaskIntoConstraints = NO;
  leadingButton.backgroundColor = UIColor.whiteColor;
  _leadingButton = leadingButton;

  MDCButton *trailingButton = [[MDCButton alloc] init];
  trailingButton.translatesAutoresizingMaskIntoConstraints = NO;
  trailingButton.backgroundColor = UIColor.whiteColor;
  _trailingButton = trailingButton;

  // Create leadingM3CButton and trailingM3CButton
  M3CButton *leadingM3CButton = [[M3CButton alloc] init];
  leadingM3CButton.translatesAutoresizingMaskIntoConstraints = NO;
  leadingM3CButton.backgroundColor = UIColor.whiteColor;
  _leadingM3CButton = leadingM3CButton;

  M3CButton *trailingM3CButton = [[M3CButton alloc] init];
  trailingM3CButton.translatesAutoresizingMaskIntoConstraints = NO;
  trailingM3CButton.backgroundColor = UIColor.whiteColor;
  _trailingM3CButton = trailingM3CButton;

  // Add the appropriate set of buttons to the container view.
  if (_isM3CButtonEnabled) {
    _currentLeadingButton = leadingM3CButton;
    _currentTrailingButton = trailingM3CButton;
    [buttonContainerView addSubview:leadingM3CButton];
    [buttonContainerView addSubview:trailingM3CButton];
  } else {
    _currentLeadingButton = leadingButton;
    _currentTrailingButton = trailingButton;
    [buttonContainerView addSubview:leadingButton];
    [buttonContainerView addSubview:trailingButton];
  }

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

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
  _contentEdgeInsets = contentEdgeInsets;

  self.contentViewConstraintBottom.constant = -contentEdgeInsets.bottom;
  self.contentViewConstraintTop.constant = contentEdgeInsets.top;
  self.contentViewConstraintLeft.constant = contentEdgeInsets.left;
  self.contentViewConstraintRight.constant = -contentEdgeInsets.right;
}

- (CGFloat)mdc_currentElevation {
  return 0;
}

#pragma mark - Constraints Helpers

- (void)setupConstraints {
  [self setUpContentConstraints];
  [self setUpImageViewConstraints];
  [self setUpTextViewConstraints];
  [self setUpButtonContainerConstraints];
  [self setUpButtonsConstraints];
  [self setUpDividerConstraints];
}

- (void)setUpContentConstraints {
  self.contentViewConstraintLeft =
      [self.contentView.leftAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leftAnchor
                                                  constant:self.contentEdgeInsets.left];
  self.contentViewConstraintRight =
      [self.contentView.rightAnchor constraintEqualToAnchor:self.layoutMarginsGuide.rightAnchor
                                                   constant:-self.contentEdgeInsets.right];
  self.contentViewConstraintTop =
      [self.contentView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor
                                                 constant:self.contentEdgeInsets.top];
  self.contentViewConstraintBottom =
      [self.contentView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor
                                                    constant:-self.contentEdgeInsets.bottom];
}

- (void)setUpImageViewConstraints {
  self.imageViewConstraintLeading =
      [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                                   constant:kLeadingPadding];
  self.imageViewConstraintTopLarge =
      [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                               constant:kTopPaddingLarge];
  self.imageViewConstraintCenterY =
      [self.imageView.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
}

- (void)setUpTextViewConstraints {
  self.textViewConstraintTop =
      [self.textView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                              constant:kTopPaddingLarge];
  self.textViewConstraintCenterY =
      [self.textView.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
  self.textViewConstraintTrailing =
      [self.textView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                                   constant:-kTextTrailingPadding];
  self.textViewConstraintLeadingWithImage =
      [self.textView.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor
                                                  constant:kSpaceBetweenIconImageAndTextView];
  self.textViewConstraintLeadingWithMargin =
      [self.textView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                                  constant:kLeadingPadding];
}

- (void)setUpButtonContainerConstraints {
  UIButton *leadingButton = self.currentLeadingButton;
  CGFloat verticalSpace = _isM3CButtonEnabled ? kVerticalSpaceBetweenButtonAndTextViewWithM3CButton
                                              : kVerticalSpaceBetweenButtonAndTextView;
  CGFloat trailingPadding = _isM3CButtonEnabled ? kButtonContainerTrailingPaddingWithM3CButton
                                                : kButtonContainerTrailingPadding;

  self.buttonContainerConstraintLeading =
      [self.buttonContainerView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor
                                                             constant:kLeadingPadding];
  self.buttonContainerConstraintWidthWithLeadingButton =
      [self.buttonContainerView.widthAnchor constraintEqualToAnchor:leadingButton.widthAnchor];
  self.buttonContainerConstraintTrailing = [self.buttonContainerView.trailingAnchor
      constraintEqualToAnchor:self.contentView.trailingAnchor
                     constant:-trailingPadding];
  self.buttonContainerConstraintBottom =
      [self.buttonContainerView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                                            constant:-kBottomPadding];
  self.buttonContainerConstraintLeadingWithTextView = [self.buttonContainerView.leadingAnchor
      constraintEqualToAnchor:self.textView.trailingAnchor
                     constant:kHorizontalSpaceBetweenTextViewAndButton];
  self.buttonContainerConstraintTopWithMargin =
      [self.buttonContainerView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                                         constant:kTopPaddingSmall];
  self.buttonContainerConstraintTopWithImageViewGreater = [self.buttonContainerView.topAnchor
      constraintGreaterThanOrEqualToAnchor:self.imageView.bottomAnchor
                                  constant:verticalSpace];
  self.buttonContainerConstraintTopWithTextView =
      [self.buttonContainerView.topAnchor constraintEqualToAnchor:self.textView.bottomAnchor
                                                         constant:verticalSpace];
  self.buttonContainerConstraintTopWithTextView.priority = UILayoutPriorityDefaultLow;
  self.buttonContainerConstraintTopWithTextViewGreater = [self.buttonContainerView.topAnchor
      constraintGreaterThanOrEqualToAnchor:self.textView.bottomAnchor
                                  constant:verticalSpace];
  self.buttonContainerConstraintHeight = [self.buttonContainerView.heightAnchor
      constraintGreaterThanOrEqualToAnchor:leadingButton.heightAnchor
                                  constant:0];
}

- (void)setUpButtonsConstraints {
  UIButton *leadingButton = self.currentLeadingButton;
  UIButton *trailingButton = self.currentTrailingButton;

  self.leadingButtonConstraintLeading = [leadingButton.leadingAnchor
      constraintGreaterThanOrEqualToAnchor:self.buttonContainerView.leadingAnchor];
  self.leadingButtonConstraintTop =
      [leadingButton.topAnchor constraintEqualToAnchor:self.buttonContainerView.topAnchor];
  self.leadingButtonConstraintTrailing = [leadingButton.trailingAnchor
      constraintEqualToAnchor:self.buttonContainerView.trailingAnchor];
  self.leadingButtonConstraintCenterY =
      [leadingButton.centerYAnchor constraintEqualToAnchor:self.buttonContainerView.centerYAnchor];
  self.leadingButtonConstraintBaseLineWithTrailingButton =
      [leadingButton.lastBaselineAnchor constraintEqualToAnchor:trailingButton.lastBaselineAnchor];
  self.leadingButtonConstraintTrailingWithTrailingButton =
      [leadingButton.trailingAnchor constraintEqualToAnchor:trailingButton.leadingAnchor
                                                   constant:-kButtonHorizontalIntervalSpace];
  [leadingButton setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                 forAxis:UILayoutConstraintAxisHorizontal];
  [leadingButton setContentHuggingPriority:UILayoutPriorityRequired
                                   forAxis:UILayoutConstraintAxisHorizontal];
  self.leadingButtonConstraintHeightZero =
      [leadingButton.heightAnchor constraintEqualToConstant:0.f];
  self.trailingButtonConstraintBottom =
      [trailingButton.bottomAnchor constraintEqualToAnchor:self.buttonContainerView.bottomAnchor];
  self.trailingButtonConstraintTop =
      [trailingButton.topAnchor constraintEqualToAnchor:leadingButton.bottomAnchor
                                               constant:kButtonVerticalIntervalSpace];
  self.trailingButtonConstraintTrailing = [trailingButton.trailingAnchor
      constraintEqualToAnchor:self.buttonContainerView.trailingAnchor];
  [trailingButton setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                  forAxis:UILayoutConstraintAxisHorizontal];
  [trailingButton setContentHuggingPriority:UILayoutPriorityRequired
                                    forAxis:UILayoutConstraintAxisHorizontal];
  self.trailingButtonConstraintHeightZero =
      [trailingButton.heightAnchor constraintEqualToConstant:0.f];
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
  self.contentViewConstraintBottom.active = NO;
  self.contentViewConstraintTop.active = NO;
  self.contentViewConstraintLeft.active = NO;
  self.contentViewConstraintRight.active = NO;
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
  UIButton *leadingButton = self.currentLeadingButton;
  UIButton *trailingButton = self.currentTrailingButton;

  MDCBannerViewLayoutStyle layoutStyle = [self layoutStyleForSizeToFit:size];
  CGFloat frameHeight = self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
  CGSize contentSize = [self contentSizeForLayoutSize:size];
  switch (layoutStyle) {
    case MDCBannerViewLayoutStyleSingleRow: {
      frameHeight += kTopPaddingSmall + kBottomPadding;
      CGFloat widthLimit = contentSize.width;
      if (!leadingButton.hidden) {
        [leadingButton sizeToFit];
        CGFloat buttonWidth = CGRectGetWidth(leadingButton.frame);
        widthLimit -= (buttonWidth + kHorizontalSpaceBetweenTextViewAndButton);
      }
      if (!self.imageView.hidden) {
        widthLimit -= kImageViewSideLength;
        widthLimit -= kSpaceBetweenIconImageAndTextView;
      }
      CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(widthLimit, CGFLOAT_MAX)];
      CGFloat maximumHeight = textViewSize.height;
      if (!leadingButton.hidden) {
        CGSize leadingButtonSize = [leadingButton sizeThatFits:CGSizeZero];
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
          leadingButton.hidden ? CGSizeZero : [leadingButton sizeThatFits:CGSizeZero];
      CGSize trailingButtonSize =
          trailingButton.hidden ? CGSizeZero : [trailingButton sizeThatFits:CGSizeZero];
      frameHeight += MAX(leadingButtonSize.height, trailingButtonSize.height);
      break;
    }
    case MDCBannerViewLayoutStyleMultiRowStackedButton: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageViewAndTextViewWithSizeToFit:contentSize];
      CGSize leadingButtonSize =
          leadingButton.hidden ? CGSizeZero : [leadingButton sizeThatFits:CGSizeZero];
      CGSize trailingButtonSize =
          trailingButton.hidden ? CGSizeZero : [trailingButton sizeThatFits:CGSizeZero];
      CGFloat verticalIntervalSpace = kButtonVerticalIntervalSpace;
      if (leadingButton.hidden || trailingButton.hidden) {
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
  UIButton *leadingButton = self.currentLeadingButton;
  UIButton *trailingButton = self.currentTrailingButton;

  [self deactivateAllConstraints];
  self.contentViewConstraintBottom.active = YES;
  self.contentViewConstraintTop.active = YES;
  self.contentViewConstraintLeft.active = YES;
  self.contentViewConstraintRight.active = YES;

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
    if (trailingButton.hidden) {
      self.buttonContainerConstraintWidthWithLeadingButton.active = YES;
    }
    self.buttonContainerConstraintTopWithMargin.active = YES;
    if (leadingButton.hidden) {
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
  UIButton *leadingButton = self.currentLeadingButton;
  UIButton *trailingButton = self.currentTrailingButton;

  if (trailingButton.hidden) {
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
  if (leadingButton.hidden) {
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

  UIButton *leadingButton = self.currentLeadingButton;
  UIButton *trailingButton = self.currentTrailingButton;

  MDCBannerViewLayoutStyle layoutStyle;
  CGSize contentSize = [self contentSizeForLayoutSize:sizeToFit];
  CGFloat remainingWidth = contentSize.width;
  [leadingButton sizeToFit];
  if (trailingButton.hidden) {
    CGFloat buttonWidth = CGRectGetWidth(leadingButton.frame);
    remainingWidth -= (buttonWidth + kHorizontalSpaceBetweenTextViewAndButton);
    if (!self.imageView.hidden) {
      remainingWidth -= kImageViewSideLength;
      remainingWidth -= kSpaceBetweenIconImageAndTextView;
    }
    layoutStyle = [self isAbleToFitTextView:self.textView withWidthLimit:remainingWidth]
                      ? MDCBannerViewLayoutStyleSingleRow
                      : MDCBannerViewLayoutStyleMultiRowAlignedButton;
  } else {
    [trailingButton sizeToFit];
    CGFloat buttonWidth = [self widthSumForButtons:@[ leadingButton, trailingButton ]];
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
  CGFloat verticalSpace = _isM3CButtonEnabled ? kVerticalSpaceBetweenButtonAndTextViewWithM3CButton
                                              : kVerticalSpaceBetweenButtonAndTextView;
  frameHeight += verticalSpace;
  return frameHeight;
}

- (CGSize)contentSizeForLayoutSize:(CGSize)layoutSize {
  CGFloat remainingWidth = layoutSize.width;
  CGFloat marginsPadding = self.layoutMargins.left + self.layoutMargins.right;
  marginsPadding += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
  remainingWidth -= marginsPadding;
  CGFloat trailingPadding = _isM3CButtonEnabled ? kButtonContainerTrailingPaddingWithM3CButton
                                                : kButtonContainerTrailingPadding;
  remainingWidth -= (kLeadingPadding + trailingPadding);
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
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }

  [self setNeedsLayout];
  [self layoutIfNeeded];
}

#pragma mark - Accessibility

- (nullable NSArray *)accessibilityElements {
  UIButton *leadingButton = self.currentLeadingButton;
  UIButton *trailingButton = self.currentTrailingButton;
  return @[ self.textView, leadingButton, trailingButton ];
}

@end

NS_ASSUME_NONNULL_END
