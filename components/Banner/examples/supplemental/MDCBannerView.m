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
#import "MDCBannerViewLayout.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"

static const CGFloat kIconImageViewSideLength = 40;
static const NSInteger kTextNumberOfLineLimit = 3;
#if DEBUG
static const NSUInteger kNumberOfButtonsLimit = 2;
#endif

@interface MDCBannerView ()

@property(nonatomic, readwrite, strong) UILabel *textLabel;
@property(nonatomic, readwrite, strong) UIImageView *iconImageView;
@property(nonatomic, readwrite, strong) UIView *containerView;

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
  self.backgroundColor = UIColor.whiteColor;
  UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
  containerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:containerView];
  _containerView = containerView;

  _buttons = [[NSMutableArray alloc] init];

  UILabel *textLabel = [[UILabel alloc] init];
  textLabel.translatesAutoresizingMaskIntoConstraints = NO;
  textLabel.font = [MDCTypography body2Font];
  textLabel.textColor = UIColor.blackColor;
  textLabel.alpha = [MDCTypography body2FontOpacity];
  textLabel.numberOfLines = kTextNumberOfLineLimit;
  textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  [self.containerView addSubview:textLabel];
  _textLabel = textLabel;
}

#pragma mark - Property Setter and Getter

- (void)setText:(NSString *)text {
  self.textLabel.text = text;
  [self invalidateIntrinsicContentSize];
}

- (NSString *)text {
  return self.textLabel.text;
}

- (void)setIcon:(UIImage *)icon {
  if (icon == nil) {
    [self.iconImageView removeFromSuperview];
    self.iconImageView = nil;
    [self invalidateIntrinsicContentSize];
  } else if (self.iconImageView == nil) {
    CGRect iconImageViewFrame =
        CGRectMake(0, 0, kIconImageViewSideLength, kIconImageViewSideLength);
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:iconImageViewFrame];
    iconImageView.image = icon;
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *iconImageWidthConstraint =
        [NSLayoutConstraint constraintWithItem:iconImageView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1
                                      constant:kIconImageViewSideLength];

    NSLayoutConstraint *iconImageHeightConstraint =
        [NSLayoutConstraint constraintWithItem:iconImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1
                                      constant:kIconImageViewSideLength];

    [NSLayoutConstraint
        activateConstraints:@[ iconImageWidthConstraint, iconImageHeightConstraint ]];

    iconImageView.contentMode = UIViewContentModeCenter;
    iconImageView.clipsToBounds = YES;
    self.iconImageView = iconImageView;
    [self.containerView addSubview:self.iconImageView];
    [self invalidateIntrinsicContentSize];
  } else {
    self.iconImageView.image = icon;
  }
  [self setNeedsLayout];
}

- (UIImage *)icon {
  return self.iconImageView.image;
}

- (void)setButtons:(NSMutableArray<MDCButton *> *_Nonnull)buttons {
  NSAssert(buttons.count <= kNumberOfButtonsLimit, @"%@ doesn't support more than %lu buttons",
           NSStringFromClass([self class]), (unsigned long)kNumberOfButtonsLimit);
  _buttons = buttons;
  for (MDCButton *button in buttons) {
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:button];
  }
  [self invalidateIntrinsicContentSize];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];
  self.containerView.backgroundColor = backgroundColor;
}

- (void)setTextFont:(UIFont *)textFont {
  self.textLabel.font = textFont;
  [self invalidateIntrinsicContentSize];
}

- (UIFont *)textFont {
  return self.textLabel.font;
}

- (void)setTextColor:(UIColor *)textColor {
  self.textLabel.textColor = textColor;
}

- (UIColor *)textColor {
  return self.textLabel.textColor;
}

- (void)setIconTintColor:(UIColor *)iconTintColor {
  self.iconImageView.tintColor = iconTintColor;
}

- (UIColor *)iconTintColor {
  return self.iconImageView.tintColor;
}

#pragma mark - UIView overrides

- (CGSize)sizeThatFits:(CGSize)size {
  self.layout = [[MDCBannerViewLayout alloc] initWithPreferredWidth:self.preferredContentWidth
                                                          textLabel:self.textLabel
                                                      iconContainer:self.iconImageView
                                                            buttons:self.buttons];
  return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.layout.size.height);
}

- (CGSize)intrinsicContentSize {
  self.layout = [[MDCBannerViewLayout alloc] initWithPreferredWidth:self.preferredContentWidth
                                                          textLabel:self.textLabel
                                                      iconContainer:self.iconImageView
                                                            buttons:self.buttons];
  return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.layout.size.height);
}

- (void)updateConstraints {
  self.layout = [[MDCBannerViewLayout alloc] initWithPreferredWidth:self.preferredContentWidth
                                                          textLabel:self.textLabel
                                                      iconContainer:self.iconImageView
                                                            buttons:self.buttons];
  [self updateConstraintsWithLayoutStyle:self.layout.style];

  [super updateConstraints];
}

#pragma mark - Layout methods

- (void)updateConstraintsWithLayoutStyle:(MDCBannerViewLayoutStyle)layoutStyle {
  // Set Container
  NSLayoutConstraint *containerWidthConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1
                                    constant:self.layout.size.width];
  NSLayoutConstraint *containerHeightConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1
                                    constant:self.layout.size.height];
  NSLayoutConstraint *containerCenterXConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *containerCenterYConstraint =
      [NSLayoutConstraint constraintWithItem:self.containerView
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1
                                    constant:0];
  [self addConstraints:@[
    containerWidthConstraint, containerHeightConstraint, containerCenterXConstraint,
    containerCenterYConstraint
  ]];

  // Set Elements
  if (layoutStyle == MDCBannerViewLayoutSingleLineStyle) {
    if (self.iconImageView) {
      NSLayoutConstraint *iconLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *iconTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:kTopPaddingSmall];
      NSLayoutConstraint *iconBottomConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
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
                                          toItem:self.iconImageView
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:kSpaceBetweenIconImageAndTextLabel];
      NSLayoutConstraint *textLabelCenterConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.iconImageView
                                       attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                        constant:0];
      [NSLayoutConstraint activateConstraints:@[
        iconLeadingConstraint, iconTopConstraint, iconBottomConstraint, textLabelLeadingConstraint,
        textLabelCenterConstraint
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
      NSLayoutConstraint *textLabelTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:kTopPaddingSmall];
      NSLayoutConstraint *textLabelBottomConstraint =
          [NSLayoutConstraint constraintWithItem:self.textLabel
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:-kBottomPadding];
      [NSLayoutConstraint activateConstraints:@[
        textLabelLeadingConstraint, textLabelTopConstraint, textLabelBottomConstraint
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
    NSLayoutConstraint *buttonCenterConstraint =
        [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textLabel
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
      buttonLeadingConstraint, buttonCenterConstraint, buttonTrailingConstraint
    ]];
  } else if (layoutStyle == MDCBannerViewLayoutMultiLineStackedButtonStyle) {
    if (self.iconImageView) {
      NSLayoutConstraint *iconLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *iconTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
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
                                          toItem:self.iconImageView
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:kSpaceBetweenIconImageAndTextLabel];
      NSLayoutConstraint *button1TopConstraintWithIcon =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                          toItem:self.iconImageView
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
    button1TopConstraintWithTextLabel.priority = UILayoutPriorityDefaultLow;
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
    if (self.iconImageView) {
      NSLayoutConstraint *iconLeadingConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.containerView
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:kLeadingPadding];
      NSLayoutConstraint *iconTopConstraint =
          [NSLayoutConstraint constraintWithItem:self.iconImageView
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
                                          toItem:self.iconImageView
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:kSpaceBetweenIconImageAndTextLabel];
      NSLayoutConstraint *button1TopConstraintWithIcon =
          [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                          toItem:self.iconImageView
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
    button1TopConstraintWithTextLabel.priority = UILayoutPriorityDefaultLow;
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

@end
