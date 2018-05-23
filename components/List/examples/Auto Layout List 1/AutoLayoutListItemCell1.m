/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "AutoLayoutListItemCell1.h"

#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kDefaultMarginTop = 10.0;
static const CGFloat kDefaultMarginBottom = 10.0;
static const CGFloat kDefaultMarginLeading = 10.0;
static const CGFloat kDefaultMarginTrailing = 10.0;
static const CGFloat kDefaultViewPadding = 10.0;
static const CGFloat kDefaultVerticalLabelPadding = 8.0;

@interface AutoLayoutListItemCell1 ()

#pragma mark Configurable Constraints

@property (strong, nonatomic) UIView *leadingContainer;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerCenterYConstraint;

@property (strong, nonatomic) UIView *trailingContainer;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerCenterYConstraint;

@property (strong, nonatomic) UIView *textContainer;
@property (strong, nonatomic) NSLayoutConstraint *leadingViewTextContainerLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *contentViewTextContainerLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textContainerTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textContainerTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textContainerBottomConstraint;

@property (strong, nonatomic) UILabel *overlineLabel;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelBottomConstraint;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelBottomConstraint;

@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelBottomConstraint;

@end

@implementation AutoLayoutListItemCell1

@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

#pragma mark Object Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
    return self;
  }
  return nil;

}

- (void)commonInit {
  self.typographyScheme = [self defaultTypographyScheme];
  [self createSupportingViews];
  [self setUpLeadingViewContainerConstraints];
  [self setUpTrailingViewContainerConstraints];
  [self setUpTextContainerConstraints];
  [self setUpOverlineLabelConstraints];
  [self setUpTitleLabelConstraints];
  [self setUpDetailLabelConstraints];
}

#pragma mark UICollectionViewCell Overrides

-(void)prepareForReuse {
  [super prepareForReuse];
  self.overlineText = nil;
  self.titleText = nil;
  self.detailText = nil;
  self.leadingView = nil;
  self.trailingView = nil;
  self.automaticallySetTextOffset = NO;
  self.centerLeadingViewVertically = NO;
  self.centerTrailingViewVertically = NO;
  self.typographyScheme = self.defaultTypographyScheme;
}

#pragma mark View Setup

- (void)createSupportingViews {
  // Create leadingContainer
  self.leadingContainer = [[UIView alloc] init];
  self.leadingContainer.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:self.leadingContainer];

  // Create trailingContainer
  self.trailingContainer = [[UIView alloc] init];
  self.trailingContainer.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:self.trailingContainer];

  // Create textContainer
  self.textContainer = [[UIView alloc] init];
  self.textContainer.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:self.textContainer];

  // Create overlineLabel
  self.overlineLabel = [[UILabel alloc] init];
  self.overlineLabel.numberOfLines = 0;
  self.overlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.overlineLabel.textColor = [UIColor blackColor];
  [self.textContainer addSubview:self.overlineLabel];

  // Create titleLabel
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.textColor = [UIColor blackColor];
  [self.textContainer addSubview:self.titleLabel];

  // Create detailLabel
  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.numberOfLines = 0;
  self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.detailLabel.textColor = [UIColor blackColor];
  [self.textContainer addSubview:self.detailLabel];
}

- (void)setUpLeadingViewContainerConstraints {
  // Constrain width
  self.leadingContainerWidthConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerWidthConstraint.active = YES;

  // Constrain height
  self.leadingContainerHeightConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerHeightConstraint.active = YES;

  // Constrain to leading edge
  self.leadingContainerLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerLeadingConstraint.active = YES;

  // Constrain to top
  self.leadingContainerTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerTopConstraint.active = !self.leadingContainerCenterYConstraint;

  // Constrain to bottom
  self.leadingContainerBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.leadingContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerBottomConstraint.active = YES;

  // Constrain to center Y
  self.leadingContainerCenterYConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerCenterYConstraint.active = self.centerLeadingViewVertically;

}

- (void)setUpTrailingViewContainerConstraints {
  // Constrain width
  self.trailingContainerWidthConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerWidthConstraint.active = YES;

  // Constrain height
  self.trailingContainerHeightConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerHeightConstraint.active = YES;

  // Constrain to trailing edge
  self.trailingContainerTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerTrailingConstraint.active = YES;

  // Constrain to top
  self.trailingContainerTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerTopConstraint.active = !self.centerTrailingViewVertically;

  // Constrain to bottom
  self.trailingContainerBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.trailingContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerBottomConstraint.active = YES;

  // Constrain to center Y
  self.trailingContainerCenterYConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerCenterYConstraint.active = self.centerTrailingViewVertically;

}

- (void)setUpTextContainerConstraints {
  // Constrain to top
  self.textContainerTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.textContainerTopConstraint.active = YES;

  // Constrain leading edge to leadingContainer when automaticallySetTextOffset is set to YES
  self.leadingViewTextContainerLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.leadingContainer
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.leadingViewTextContainerLeadingConstraint.active = self.automaticallySetTextOffset;

  // Constrain leading edge to contentView when automaticallySetTextOffset is set to NO
  self.contentViewTextContainerLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.contentViewTextContainerLeadingConstraint.active = !self.automaticallySetTextOffset;

  // Constrain to trailing edge
  self.textContainerTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.trailingContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:-kDefaultViewPadding];
  self.textContainerTrailingConstraint.active = YES;

  // Constrain to bottom
  self.textContainerBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.textContainerBottomConstraint.active = YES;

  // set up overline label constraints

}

- (void)setUpOverlineLabelConstraints {
  // Constrain to top
  // Constrain to top
  self.overlineLabelTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.overlineLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.overlineLabelTopConstraint.active = YES;

  // Constrain to leading edge
  self.overlineLabelLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.overlineLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.overlineLabelLeadingConstraint.active = YES;

  // Constrain to trailing edge
  self.overlineLabelTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.overlineLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.overlineLabelTrailingConstraint.active = YES;

  // Constrain to bottom
  self.overlineLabelBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.overlineLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.overlineLabelBottomConstraint.active = YES; // -kDefaultMarginBottom
}

- (void)setUpTitleLabelConstraints {
  // Constrain to top
  self.titleLabelTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.overlineLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.titleLabelTopConstraint.active = YES;

  // Constrain to leading edge
  self.titleLabelLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.titleLabelLeadingConstraint.active = YES;

  // Constrain to trailing edge
  self.titleLabelTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.titleLabelTrailingConstraint.active = YES;

  // Constrain to bottom
  self.titleLabelBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.titleLabelBottomConstraint.active = YES;
}

- (void)setUpDetailLabelConstraints {
  // Constrain to top
  self.detailLabelTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.titleLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.detailLabelTopConstraint.active = YES;

  // Constrain to leading edge
  self.detailLabelLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.detailLabelLeadingConstraint.active = YES;

  // Constrain to trailing edge
  self.detailLabelTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.detailLabelTrailingConstraint.active = YES;

  // Constrain to bottom
  self.detailLabelBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.textContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.detailLabelBottomConstraint.active = YES;
}

- (void)adjustTextContainerConstraintsAfterTextChange {
  BOOL hasOverline = self.overlineLabel.text.length > 0;
  BOOL hasTitle = self.overlineLabel.text.length > 0;
  BOOL hasDetail = self.overlineLabel.text.length > 0;
  if (hasOverline | hasTitle | hasDetail) {
    self.textContainerTopConstraint.constant = kDefaultMarginTop;
    self.textContainerBottomConstraint.constant = -kDefaultMarginBottom;
  } else {
    self.textContainerTopConstraint.constant = 0;
    self.textContainerBottomConstraint.constant = 0;
  }
}

#pragma mark Accessors

-(void)setTextOffset:(CGFloat)textOffset {
  if (textOffset == _textOffset) {
    return;
  }
  _textOffset = textOffset;
  self.contentViewTextContainerLeadingConstraint.constant = textOffset;
  [self setNeedsLayout];
}

-(void)setLeadingView:(UIView *)leadingView {
  if (leadingView == _leadingView) {
    return;
  }

  [_leadingView removeFromSuperview];
  _leadingView = leadingView;

  if (_leadingView) {
    [self.leadingContainer addSubview:_leadingView];
    self.leadingContainerWidthConstraint.constant = _leadingView.frame.size.width;
    self.leadingContainerHeightConstraint.constant = _leadingView.frame.size.height;
    self.leadingContainerLeadingConstraint.constant = kDefaultMarginLeading;
    self.leadingContainerTopConstraint.constant = kDefaultMarginTop;
    self.leadingContainerBottomConstraint.constant = kDefaultMarginBottom;
    NSLayoutConstraint *constraintCenterX =
    [NSLayoutConstraint constraintWithItem:_leadingView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_leadingContainer
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    constraintCenterX.priority = UILayoutPriorityDefaultHigh;
    constraintCenterX.active = YES;
    NSLayoutConstraint *constraintCenterY =
    [NSLayoutConstraint constraintWithItem:_leadingView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_leadingContainer
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0];
    constraintCenterY.priority = UILayoutPriorityDefaultHigh;
    constraintCenterY.active = YES;
  } else {
    self.leadingContainerWidthConstraint.constant = 0;
    self.leadingContainerHeightConstraint.constant = 0;
    self.leadingContainerLeadingConstraint.constant = 0;
    self.leadingContainerTopConstraint.constant = 0;
    self.leadingContainerBottomConstraint.constant = 0;
  }

  [self setNeedsLayout];
}

-(void)setTrailingView:(UIView *)trailingView {
  if (trailingView == _trailingView) {
    return;
  }

  [_trailingView removeFromSuperview];
  _trailingView = trailingView;

  if (_trailingView) {
    [self.trailingContainer addSubview:_trailingView];
    self.trailingContainerWidthConstraint.constant = _trailingView.frame.size.width;
    self.trailingContainerHeightConstraint.constant = _trailingView.frame.size.height;
    self.trailingContainerTrailingConstraint.constant = -kDefaultMarginTrailing;
    self.trailingContainerTopConstraint.constant = kDefaultMarginTop;
    self.trailingContainerBottomConstraint.constant = kDefaultMarginBottom;
    NSLayoutConstraint *constraintCenterX =
    [NSLayoutConstraint constraintWithItem:_trailingView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_trailingContainer
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    constraintCenterX.priority = UILayoutPriorityDefaultHigh;
    constraintCenterX.active = YES;
    NSLayoutConstraint *constraintCenterY =
    [NSLayoutConstraint constraintWithItem:_trailingView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_trailingContainer
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0];
    constraintCenterY.priority = UILayoutPriorityDefaultHigh;
    constraintCenterY.active = YES;
  } else {
    self.trailingContainerWidthConstraint.constant = 0;
    self.trailingContainerHeightConstraint.constant = 0;
    self.trailingContainerTrailingConstraint.constant = 0;
    self.trailingContainerTopConstraint.constant = 0;
    self.trailingContainerBottomConstraint.constant = 0;
  }

  [self setNeedsLayout];
}

-(void)setOverlineText:(NSString *)overlineText {
  if (overlineText == _overlineText) {
    return;
  }
  _overlineText = overlineText;
  self.overlineLabel.text = _overlineText;

  [self adjustTextContainerConstraintsAfterTextChange];

  [self setNeedsLayout];
}

-(void)setTitleText:(NSString *)titleText {
  if (titleText == _titleText) {
    return;
  }
  _titleText = titleText;
  self.titleLabel.text = _titleText;

  if (_titleText.length > 0) {
    self.titleLabelTopConstraint.constant = kDefaultVerticalLabelPadding;
  } else {
    self.titleLabelTopConstraint.constant = 0;
  }

  [self adjustTextContainerConstraintsAfterTextChange];

  [self setNeedsLayout];
}

-(void)setDetailText:(NSString *)detailText {
  if (detailText == _detailText) {
    return;
  }
  _detailText = detailText;
  self.detailLabel.text = _detailText;

  if (_detailText.length > 0) {
    self.detailLabelTopConstraint.constant = kDefaultVerticalLabelPadding;
  } else {
    self.detailLabelTopConstraint.constant = 0;
  }

  [self adjustTextContainerConstraintsAfterTextChange];

  [self setNeedsLayout];
}

-(void)setAutomaticallySetTextOffset:(BOOL)automaticallySetTextOffset {
  if (automaticallySetTextOffset == _automaticallySetTextOffset) {
    return;
  }
  _automaticallySetTextOffset = automaticallySetTextOffset;
  self.contentViewTextContainerLeadingConstraint.active = NO;
  self.leadingViewTextContainerLeadingConstraint.active = NO;
  if (_automaticallySetTextOffset) {
    self.leadingViewTextContainerLeadingConstraint.active = YES;
    self.leadingViewTextContainerLeadingConstraint.constant = kDefaultViewPadding;
  } else {
    self.contentViewTextContainerLeadingConstraint.active = YES;
  }
  [self setNeedsLayout];
}

-(void)setCenterTrailingViewVertically:(BOOL)centerTrailingViewVertically {
  if (centerTrailingViewVertically == _centerTrailingViewVertically) {
    return;
  }
  _centerTrailingViewVertically = centerTrailingViewVertically;

  self.trailingContainerTopConstraint.active = NO;
  self.trailingContainerCenterYConstraint.active = NO;
  if (_centerTrailingViewVertically) {
    self.trailingContainerCenterYConstraint.active = YES;
  } else {
    self.trailingContainerTopConstraint.active = YES;
  }

  [self setNeedsLayout];
}

-(void)setCenterLeadingViewVertically:(BOOL)centerLeadingViewVertically {
  if (centerLeadingViewVertically == _centerLeadingViewVertically) {
    return;
  }
  _centerLeadingViewVertically = centerLeadingViewVertically;

  self.leadingContainerTopConstraint.active = NO;
  self.leadingContainerCenterYConstraint.active = NO;
  if (_centerLeadingViewVertically) {
    self.leadingContainerCenterYConstraint.active = YES;
  } else {
    self.leadingContainerTopConstraint.active = YES;
  }

  [self setNeedsLayout];
}

#pragma mark - Typography/Dynamic Type Support

- (MDCTypographyScheme *)defaultTypographyScheme {
  return [MDCTypographyScheme new];
}

-(void)setTypographyScheme:(MDCTypographyScheme *)typographyScheme {
  _typographyScheme = typographyScheme;
  self.overlineLabel.font = _typographyScheme.overline ?: self.overlineLabel.font;
  self.titleLabel.font = _typographyScheme.body1 ?: self.titleLabel.font;
  self.detailLabel.font = _typographyScheme.body2 ?: self.detailLabel.font;
  [self adjustFontsForContentSizeCategory];
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }

  [self adjustFontsForContentSizeCategory];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self adjustFontsForContentSizeCategory];
}

- (void)adjustFontsForContentSizeCategory {
  UIFont *overlineFont = self.overlineLabel.font ?: self.typographyScheme.overline;
  UIFont *titleFont = self.titleLabel.font ?: self.typographyScheme.body1;
  UIFont *detailFont = self.detailLabel.font ?: self.typographyScheme.body2;
  if (_mdc_adjustsFontForContentSizeCategory) {
    overlineFont =
    [overlineFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleCaption
                             scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    titleFont =
    [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                               scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    detailFont =
    [detailFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                               scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  self.overlineLabel.font = overlineFont;
  self.titleLabel.font = titleFont;
  self.detailLabel.font = detailFont;
  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:
    (UICollectionViewLayoutAttributes *)layoutAttributes {
  UICollectionViewLayoutAttributes *attributes =
      [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  CGPoint origin = attributes.frame.origin;
  CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  CGRect frame = CGRectMake(origin.x, origin.y, size.width, size.height);
  attributes.frame = frame;
  return attributes;
}

@end
