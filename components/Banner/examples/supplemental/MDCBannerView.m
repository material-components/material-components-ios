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

static const CGFloat kimageViewSideLength = 40;
static const NSInteger kTextNumberOfLineLimit = 3;

typedef NS_ENUM(NSInteger, MDCBannerViewLayoutStyle) {
  MDCBannerViewLayoutStyleInvalid = 0,                 // Invalid style
  MDCBannerViewLayoutSingleLineStyle = 1,              // All elements lays on the same line
  MDCBannerViewLayoutMultiLineStackedButtonStyle = 2,  // Multline, stacked button layout
  MDCBannerViewLayoutMultiLineAlignedButtonStyle =
  3  // Multiline style with all buttons on the same line
};

@interface MDCBannerView ()

@property(nonatomic, readwrite, strong) UILabel *textLabel;
@property(nonatomic, readwrite, strong) UIImageView *imageView;
@property(nonatomic, readonly, assign) BOOL isImageSet;
@property(nonatomic, readwrite, strong) UIView *containerView;
@property(nonatomic, readonly, strong) NSArray<MDCButton *> *buttons;

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
  UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
  containerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:containerView];
  _containerView = containerView;

  // Create textLabel
  UILabel *textLabel = [[UILabel alloc] init];
  textLabel.translatesAutoresizingMaskIntoConstraints = NO;
  textLabel.font = [MDCTypography body2Font];
  textLabel.textColor = UIColor.blackColor;
  textLabel.alpha = [MDCTypography body2FontOpacity];
  textLabel.numberOfLines = kTextNumberOfLineLimit;
  textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  [containerView addSubview:textLabel];
  _textLabel = textLabel;

  // Create imageView
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.translatesAutoresizingMaskIntoConstraints = NO;
  NSLayoutConstraint *iconImageWidthConstraint =
  [NSLayoutConstraint constraintWithItem:imageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:kimageViewSideLength];

  NSLayoutConstraint *iconImageHeightConstraint =
  [NSLayoutConstraint constraintWithItem:imageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:kimageViewSideLength];

  [NSLayoutConstraint
   activateConstraints:@[ iconImageWidthConstraint, iconImageHeightConstraint ]];
  imageView.contentMode = UIViewContentModeCenter;
  imageView.clipsToBounds = YES;
  [containerView addSubview:imageView];
  _imageView = imageView;
}

#pragma mark - Property Setter and Getter

- (BOOL)isImageSet {
  return self.imageView.image != nil;
}

- (void)setLeadingButton:(MDCButton *)leadingButton {
  _leadingButton = leadingButton;
  leadingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:leadingButton];
  [self invalidateIntrinsicContentSize];
}

- (void)setTrailingButton:(MDCButton *)trailingButton {
  _trailingButton = trailingButton;
  trailingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:trailingButton];
  [self invalidateIntrinsicContentSize];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];
  self.containerView.backgroundColor = backgroundColor;
}

// This is a method facilitate during the middle stage of refactoring.
- (NSArray<MDCButton *> *)buttons {
  NSMutableArray<MDCButton *> *mutableArray = [NSMutableArray array];
  if (self.leadingButton) {
    [mutableArray addObject:self.leadingButton];
  }
  if (self.trailingButton) {
    [mutableArray addObject:self.trailingButton];
  }
  return [mutableArray copy];
}

#pragma mark - UIView overrides

- (CGSize)sizeThatFits:(CGSize)size {
  UIImageView *imageView = self.isImageSet ? self.imageView : nil;
  CGSize sizeThatFits = [self sizeThatFits:size
                                 textLabel:self.textLabel
                                 imageView:imageView
                                   buttons:self.buttons];
  return sizeThatFits;
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:self.bounds.size];
}

- (void)updateConstraints {
  CGSize sizeToFit = CGSizeMake(CGRectGetWidth(self.bounds) -
                                (self.layoutMargins.left + self.layoutMargins.right), CGRectGetHeight(self.bounds));
  UIImageView *imageView = self.isImageSet ? self.imageView : nil;
  MDCBannerViewLayoutStyle style = [self styleForSizeToFit:sizeToFit
                                                 textLabel:self.textLabel
                                                 imageView:imageView
                                                   buttons:self.buttons];
  [self updateConstraintsWithLayoutStyle:style];

  [super updateConstraints];
}

#pragma mark - Layout methods

- (void)updateConstraintsWithLayoutStyle:(MDCBannerViewLayoutStyle)layoutStyle {
  // Set Container
  NSLayoutConstraint *containerLeadingConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeLeadingMargin
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *containerTrailingConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTrailingMargin
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *containerTopConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTopMargin
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *containerBottomConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottomMargin
                                  multiplier:1
                                    constant:0];
  [self addConstraints:@[
    containerLeadingConstraint, containerTrailingConstraint, containerTopConstraint,
    containerBottomConstraint
  ]];

  // Set Elements
  if (layoutStyle == MDCBannerViewLayoutSingleLineStyle) {
    if (self.isImageSet) {
      NSLayoutConstraint *iconLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *iconTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:kTopPaddingSmall];
      NSLayoutConstraint *iconBottomConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:-kBottomPadding];
      NSLayoutConstraint *textLabelLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.imageView
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:kSpaceBetweenIconImageAndTextLabel];
      NSLayoutConstraint *buttonCenterConstraint =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.imageView
                                       attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                        constant:0];
      [NSLayoutConstraint activateConstraints:@[
        iconLeadingConstraint, iconTopConstraint, iconBottomConstraint, textLabelLeadingConstraint,
        buttonCenterConstraint
      ]];
    } else {
      NSLayoutConstraint *textLabelLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *buttonTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:kTopPaddingSmall];
      NSLayoutConstraint *buttonBottomConstraint =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:-kBottomPadding];
      [NSLayoutConstraint activateConstraints:@[
        textLabelLeadingConstraint, buttonTopConstraint, buttonBottomConstraint
      ]];
    }
    NSLayoutConstraint *buttonLeadingConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:self.textLabel
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:kHorizontalSpaceBetweenTextLabelAndButton];
    NSLayoutConstraint *textLabelCenterConstraint =
        [NSLayoutConstraint constraintWithItem:self.textLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.buttons[0]
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    NSLayoutConstraint *buttonTrailingConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-kTrailingPadding];
    [NSLayoutConstraint activateConstraints:@[
      buttonLeadingConstraint, textLabelCenterConstraint, buttonTrailingConstraint
    ]];
  } else if (layoutStyle == MDCBannerViewLayoutMultiLineStackedButtonStyle) {
    if (self.isImageSet) {
      NSLayoutConstraint *iconLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *iconTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:kTopPaddingLarge];
      NSLayoutConstraint *textLabelLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.imageView
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:kSpaceBetweenIconImageAndTextLabel];
      NSLayoutConstraint *button1TopConstraintWithIcon =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                          toItem:self.imageView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:kVerticalSpaceBetweenButtonAndTextLabel];
      [NSLayoutConstraint activateConstraints:@[
        iconLeadingConstraint, iconTopConstraint, textLabelLeadingConstraint,
        button1TopConstraintWithIcon
      ]];
    } else {
      NSLayoutConstraint *textLabelLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      [NSLayoutConstraint activateConstraints:@[ textLabelLeadingConstraint ]];
    }
    NSLayoutConstraint *textLabelTopConstraint =
        [NSLayoutConstraint constraintWithItem:self.textLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:kTopPaddingLarge];
    NSLayoutConstraint *textLabelTrailingConstraint =
        [NSLayoutConstraint constraintWithItem:self.textLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-kTrailingPadding];

    NSLayoutConstraint *button1TrailingConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-kTrailingPadding];
    NSLayoutConstraint *button1TopConstraintWithTextLabel =
        [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textLabel
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:kVerticalSpaceBetweenButtonAndTextLabel];
    button1TopConstraintWithTextLabel.priority = UILayoutPriorityDefaultLow - 1;
    NSLayoutConstraint *button2TopConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.buttons[0]
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:kButtonVerticalIntervalSpace];
    NSLayoutConstraint *button2TrailingConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-kTrailingPadding];
    NSLayoutConstraint *button2BottomConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:-kBottomPadding];
    [NSLayoutConstraint activateConstraints:@[
      textLabelTopConstraint, textLabelTrailingConstraint, button1TrailingConstraint,
      button1TopConstraintWithTextLabel, button2TopConstraint, button2TrailingConstraint,
      button2BottomConstraint
    ]];
  } else if (layoutStyle == MDCBannerViewLayoutMultiLineAlignedButtonStyle) {
    if (self.isImageSet) {
      NSLayoutConstraint *iconLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *iconTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.imageView
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:kTopPaddingLarge];
      NSLayoutConstraint *textLabelLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.imageView
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:kSpaceBetweenIconImageAndTextLabel];
      NSLayoutConstraint *button1TopConstraintWithIcon =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                          toItem:self.imageView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:kVerticalSpaceBetweenButtonAndTextLabel];
      [NSLayoutConstraint activateConstraints:@[
        iconLeadingConstraint, iconTopConstraint, textLabelLeadingConstraint,
        button1TopConstraintWithIcon
      ]];
    } else {
      NSLayoutConstraint *textLabelLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      [NSLayoutConstraint activateConstraints:@[ textLabelLeadingConstraint ]];
    }
    NSLayoutConstraint *textLabelTopConstraint =
        [NSLayoutConstraint constraintWithItem:self.textLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:kTopPaddingLarge];
    NSLayoutConstraint *textLabelTrailingConstraint =
        [NSLayoutConstraint constraintWithItem:self.textLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-kTrailingPadding];
    NSLayoutConstraint *button1TopConstraintWithTextLabel =
        [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textLabel
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:kVerticalSpaceBetweenButtonAndTextLabel];
    button1TopConstraintWithTextLabel.priority = UILayoutPriorityDefaultLow - 1;
    NSLayoutConstraint *button2TopConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.buttons[0]
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0];
    NSLayoutConstraint *button2LeadingConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.buttons[0]
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:kButtonHorizontalIntervalSpace];
    NSLayoutConstraint *button2TrailingConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.containerView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-kTrailingPadding];
    [NSLayoutConstraint activateConstraints:@[
      textLabelTopConstraint, textLabelTrailingConstraint, button1TopConstraintWithTextLabel,
      button2TopConstraint, button2LeadingConstraint, button2TrailingConstraint
    ]];
  }
}

#pragma mark - Layout helpers

- (MDCBannerViewLayoutStyle)styleForSizeToFit:(CGSize)sizeToFit
                                    textLabel:(UILabel *)textLabel
                                    imageView:(UIView *)imageView
                                      buttons:(NSArray<MDCButton *> *)buttons {
  MDCBannerViewLayoutStyle style = MDCBannerViewLayoutStyleInvalid;
  CGFloat remainingWidth = sizeToFit.width;
  remainingWidth -= (kLeadingPadding + kTrailingPadding);
  if (buttons.count == 1) {
    CGFloat buttonWidth = [self widthSumForButtons:buttons];
    remainingWidth -= (buttonWidth + kHorizontalSpaceBetweenTextLabelAndButton);
    if (imageView) {
      remainingWidth -= imageView.frame.size.width;
      remainingWidth -= kSpaceBetweenIconImageAndTextLabel;
    }
    style = [self isAbleToFitTextLabel:textLabel
                        withWidthLimit:remainingWidth]
    ? MDCBannerViewLayoutSingleLineStyle
    : MDCBannerViewLayoutMultiLineAlignedButtonStyle;
  } else if (buttons.count == 2) {
    CGFloat buttonWidth = [self widthSumForButtons:buttons];
    remainingWidth -= buttonWidth;
    style = (remainingWidth > 0) ? MDCBannerViewLayoutMultiLineAlignedButtonStyle
    : MDCBannerViewLayoutMultiLineStackedButtonStyle;
  }
  return style;
}

- (CGSize)sizeThatFits:(CGSize)sizeToFit
               textLabel:(UILabel *)textLabel
               imageView:(UIView *)imageView
               buttons:(NSArray<MDCButton *> *)buttons {
  CGFloat marginsPadding = self.layoutMargins.left + self.layoutMargins.right;
  CGSize sizeToFitWithoutMargins = CGSizeMake(sizeToFit.width - marginsPadding, sizeToFit.height);
  MDCBannerViewLayoutStyle style = [self styleForSizeToFit:sizeToFitWithoutMargins
                                                 textLabel:textLabel
                                                 imageView:imageView
                                                   buttons:buttons];
  CGFloat frameHeight = 0.0f;
  switch (style) {
    case MDCBannerViewLayoutSingleLineStyle: {
      frameHeight += kTopPaddingSmall + kBottomPadding;
      [self.textLabel sizeToFit];
      NSMutableArray *singleLineViews = [[NSMutableArray alloc] init];
      [singleLineViews addObject:self.textLabel];
      if (imageView) {
        [singleLineViews addObject:imageView];
      }
      [singleLineViews addObjectsFromArray:buttons];
      frameHeight += [self maximumHeightAmongViews:singleLineViews];
      break;
    }
    case MDCBannerViewLayoutMultiLineAlignedButtonStyle: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfWithSizeToFit:sizeToFit
                                               imageView:imageView
                                               textLabel:textLabel];
      frameHeight += [self maximumHeightAmongViews:buttons];
      break;
    }
    case MDCBannerViewLayoutMultiLineStackedButtonStyle: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfWithSizeToFit:sizeToFit
                                               imageView:imageView
                                               textLabel:textLabel];
      frameHeight += [self heightSumForButtons:buttons];
      break;
    }
    case MDCBannerViewLayoutStyleInvalid: {
      break;
    }
  }
  return CGSizeMake(sizeToFit.width, frameHeight);
}

- (CGFloat)getFrameHeightOfWithSizeToFit:(CGSize)sizeToFit
                               imageView:(UIView *)imageView
                               textLabel:(UILabel *)textLabel {
  CGFloat frameHeight = 0;
  CGFloat remainingWidth = sizeToFit.width - kLeadingPadding - kTrailingPadding;
  CGSize textLabelSize = CGSizeZero;
  if (imageView) {
    remainingWidth -= (imageView.frame.size.width + kSpaceBetweenIconImageAndTextLabel);
    textLabelSize = [textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += MAX(textLabelSize.height, CGRectGetHeight(imageView.frame));
  } else {
    textLabelSize = [textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
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

- (CGFloat)heightSumForButtons:(NSArray<__kindof UIButton *> *)buttons {
  CGFloat buttonsHeightSum = 0.0f;
  for (UIButton *button in self.buttons) {
    buttonsHeightSum += CGRectGetHeight(button.frame);
  }
  if (buttons.count > 1) {
    buttonsHeightSum += (self.buttons.count - 1) * kButtonVerticalIntervalSpace;
  }
  return buttonsHeightSum;
}

- (BOOL)isAbleToFitTextLabel:(UILabel *)textLabel
              withWidthLimit:(CGFloat)widthLimit {
  CGSize size =
  [textLabel.text sizeWithAttributes:@{NSFontAttributeName : textLabel.font}];
  return size.width <= widthLimit;
}

- (CGFloat)maximumHeightAmongViews:(NSArray<__kindof UIView *> *)views {
  CGFloat maximumHeight = 0.0f;
  for (UIView *view in views) {
    maximumHeight = MAX(maximumHeight, CGRectGetHeight(view.frame));
  }
  return maximumHeight;
}

@end
