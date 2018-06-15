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

#import "AutoLayoutListItemCell2.h"

#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kDefaultVerticalMarginMin = 8.0;
static const CGFloat kDefaultVerticalMarginMax = 16.0;
static const CGFloat kDefaultMarginLeading = 16.0;
static const CGFloat kDefaultMarginTrailing = 16.0;
static const CGFloat kMaximumImageWidth = 100;
static const CGFloat kMaximumImageHeight = 56;

@interface AutoLayoutListItemCell2 ()

#pragma mark Configurable Constraints

@property (strong, nonatomic) UIImageView *leadingImageView;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewBottomConstraint;

@property (strong, nonatomic) UIImageView *trailingImageView;
@property (strong, nonatomic) NSLayoutConstraint *trailingImageViewWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingImageViewHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingImageViewTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingImageViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingImageViewBottomConstraint;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSLayoutConstraint *contentViewLeadingTitleLabelLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelTopContentViewTopConstraintRequired;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelTopContentViewTopConstraintHigh;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewCenterYTitleLabelCenterY;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelTrailingTrailingImageViewLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *contentViewCenterYTitleLabelCenterY;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelBottomContentViewBottomConstraint;

@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) NSLayoutConstraint *contentViewLeadingDetailLabelLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelTopContentViewTopConstraintRequired;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelTopContentViewTopConstraintHigh;
@property (strong, nonatomic) NSLayoutConstraint *leadingImageViewCenterYDetailLabelCenterY;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelTrailingTrailingImageViewLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *contentViewCenterYDetailLabelCenterY;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelBottomContentViewBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *detailLabelTopTitleLabelBottomConstraint;

@end

@implementation AutoLayoutListItemCell2

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
  [self setUpLeadingImageViewConstraints];
  [self setUpTrailingImageViewConstraints];
  [self setUpTitleLabelConstraints];
  [self setUpDetailLabelConstraints];
}

#pragma mark UICollectionViewCell Overrides

-(void)prepareForReuse {
  [super prepareForReuse];
  self.titleText = nil;
  self.detailText = nil;
  self.leadingImage = nil;
  self.trailingImage = nil;
  self.typographyScheme = self.defaultTypographyScheme;
}

#pragma mark View Setup

- (void)createSupportingViews {
  // Create leadingImageView
  self.leadingImageView = [[UIImageView alloc] init];
  self.leadingImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:self.leadingImageView];

  // Create trailingImageView
  self.trailingImageView = [[UIImageView alloc] init];
  self.trailingImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:self.trailingImageView];

  // Create titleLabel
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.numberOfLines = 1;
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.textColor = [UIColor blackColor];
  [self.contentView addSubview:self.titleLabel];

  // Create detailLabel
  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.numberOfLines = 0;
  self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.detailLabel.textColor = [UIColor blackColor];
  [self.contentView addSubview:self.detailLabel];
}

- (void)setUpLeadingImageViewConstraints {
  // Constrain width
  self.leadingImageViewWidthConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingImageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.leadingImageViewWidthConstraint.active = YES;

  // Constrain height
  self.leadingImageViewHeightConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingImageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.leadingImageViewHeightConstraint.active = YES;

  // Constrain to leading edge
  self.leadingImageViewLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingImageView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.leadingImageViewLeadingConstraint.active = YES;

  // Constrain to top
  self.leadingImageViewTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingImageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.leadingImageViewTopConstraint.active = YES;

  // Constrain to bottom
  self.leadingImageViewBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.leadingImageView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.leadingImageViewBottomConstraint.active = YES;
}

- (void)setUpTrailingImageViewConstraints {
  self.trailingImageViewWidthConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingImageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.trailingImageViewWidthConstraint.active = YES;

  self.trailingImageViewHeightConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingImageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0.0];
  self.trailingImageViewHeightConstraint.active = YES;

  self.trailingImageViewTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.trailingImageView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.trailingImageViewTrailingConstraint.active = YES;

  self.trailingImageViewTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingImageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.trailingImageViewTopConstraint.active = YES;

  self.trailingImageViewBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.trailingImageView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.trailingImageViewBottomConstraint.active = YES;

}

- (void)setUpTitleLabelConstraints {
  self.contentViewLeadingTitleLabelLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.contentViewLeadingTitleLabelLeadingConstraint.active = YES;

  self.titleLabelTopContentViewTopConstraintRequired =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:kDefaultVerticalMarginMin];
  self.titleLabelTopContentViewTopConstraintRequired.active = YES;

  self.titleLabelTopContentViewTopConstraintHigh =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0];
  self.titleLabelTopContentViewTopConstraintHigh.active = YES;
  self.titleLabelTopContentViewTopConstraintHigh.priority = UILayoutPriorityDefaultHigh;

  self.leadingImageViewCenterYTitleLabelCenterY =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.leadingImageView
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                                constant:0.0];

  self.titleLabelTrailingTrailingImageViewLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.trailingImageView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.titleLabelTrailingTrailingImageViewLeadingConstraint.active = YES;

  self.titleLabelBottomContentViewBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.titleLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:kDefaultVerticalMarginMin];
  self.titleLabelBottomContentViewBottomConstraint.active = YES;
}

- (void)setUpDetailLabelConstraints {
  self.contentViewLeadingDetailLabelLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.contentViewLeadingDetailLabelLeadingConstraint.active = YES;

  self.detailLabelTopContentViewTopConstraintRequired =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:kDefaultVerticalMarginMin];
  self.detailLabelTopContentViewTopConstraintRequired.active = YES;
  
  self.detailLabelTopContentViewTopConstraintHigh =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0];
  self.detailLabelTopContentViewTopConstraintHigh.active = YES;
  self.detailLabelTopContentViewTopConstraintHigh.priority = UILayoutPriorityDefaultHigh;

  self.leadingImageViewCenterYDetailLabelCenterY =
  [NSLayoutConstraint constraintWithItem:self.leadingImageView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.detailLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];

  self.detailLabelTrailingTrailingImageViewLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.trailingImageView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
  self.detailLabelTrailingTrailingImageViewLeadingConstraint.active = YES;

  self.detailLabelBottomContentViewBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.detailLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:kDefaultVerticalMarginMax];
  self.detailLabelBottomContentViewBottomConstraint.active = YES;

  self.detailLabelTopTitleLabelBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.titleLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:kDefaultVerticalMarginMin];
}

- (CGSize)sizeForImage:(UIImage *)image {
  if (!image || image.size.width <= 0 || image.size.height <= 0) {
    return CGSizeZero;
  }
  CGSize maxSize = CGSizeMake(kMaximumImageWidth, kMaximumImageHeight);
  CGFloat aspectWidth = maxSize.width / image.size.width;
  CGFloat aspectHeight = maxSize.height / image.size.height;
  CGFloat aspectRatio = MIN(aspectWidth, aspectHeight);
  return CGSizeMake(image.size.width * aspectRatio, image.size.height * aspectRatio);
}

- (CGFloat)dynamicTextOffset {
  return
  self.leadingImageViewLeadingConstraint.constant +
  self.leadingImageViewWidthConstraint.constant +
  16;
}

- (CGFloat)verticalMarginForLeadingImageOfSize:(CGSize)size {
  if (size.height <= 24) {
    return kDefaultVerticalMarginMin;
  } else {
    return kDefaultVerticalMarginMax;
  }
}

- (void)updateLeadingImageViewConstraints {
  if (self.leadingImageView.image) {
    CGSize size = [self sizeForImage:self.leadingImage];
    self.leadingImageViewWidthConstraint.constant = size.width;
    self.leadingImageViewHeightConstraint.constant = size.height;
    self.leadingImageViewLeadingConstraint.constant = kDefaultMarginLeading;
    self.leadingImageViewTopConstraint.constant = [self verticalMarginForLeadingImageOfSize:size];
    self.leadingImageViewBottomConstraint.constant = [self verticalMarginForLeadingImageOfSize:size];
  } else {
    self.leadingImageViewWidthConstraint.constant = 0;
    self.leadingImageViewHeightConstraint.constant = 0;
    self.leadingImageViewLeadingConstraint.constant = 0;
    self.leadingImageViewTopConstraint.constant = 0;
    self.leadingImageViewBottomConstraint.constant = 0;
  }
}

- (void)updateTrailingImageViewConstraints {
  if (self.trailingImage) {
    CGSize size = [self sizeForImage:self.trailingImage];
    self.trailingImageViewWidthConstraint.constant = size.width;
    self.trailingImageViewHeightConstraint.constant = size.height;
    self.trailingImageViewTrailingConstraint.constant = kDefaultMarginTrailing;
    self.trailingImageViewTopConstraint.constant = [self verticalMarginForLeadingImageOfSize:size];
    self.trailingImageViewBottomConstraint.constant = [self verticalMarginForLeadingImageOfSize:size];
  } else {
    self.trailingImageViewWidthConstraint.constant = 0;
    self.trailingImageViewHeightConstraint.constant = 0;
    self.trailingImageViewTrailingConstraint.constant = 0;
    self.trailingImageViewTopConstraint.constant = 0;
    self.trailingImageViewBottomConstraint.constant = 0;
  }
}


- (CGFloat)dynamicTextLabelCenterYOffset {
  return 0;
}

- (void)updateTitleLabelConstraints {
  self.titleLabelTrailingTrailingImageViewLeadingConstraint.active = YES;
  if (self.titleText.length > 0) {
    self.contentViewLeadingTitleLabelLeadingConstraint.active = YES;
    self.contentViewLeadingTitleLabelLeadingConstraint.constant = [self dynamicTextOffset];
    self.titleLabelTopContentViewTopConstraintRequired.constant = kDefaultVerticalMarginMin;
    self.titleLabelTopContentViewTopConstraintRequired.active = YES;
    self.titleLabelBottomContentViewBottomConstraint.active = YES;
    if (self.leadingImageView.image) {
      if (self.detailText.length > 0) {
        self.titleLabelTopContentViewTopConstraintHigh.constant = kDefaultVerticalMarginMin;
        self.titleLabelTopContentViewTopConstraintHigh.active = YES;
        self.leadingImageViewCenterYTitleLabelCenterY.active = NO;
      } else {
        self.leadingImageViewCenterYTitleLabelCenterY.active = YES;
        self.leadingImageViewCenterYTitleLabelCenterY.constant = 0;
      }
      self.contentViewCenterYTitleLabelCenterY.active = NO;
      self.titleLabelTopContentViewTopConstraintHigh.active = NO;
    } else {
      self.leadingImageViewCenterYTitleLabelCenterY.active = NO;
      self.contentViewCenterYTitleLabelCenterY.active = YES;
      self.titleLabelTopContentViewTopConstraintHigh.constant = kDefaultVerticalMarginMin;
      self.titleLabelTopContentViewTopConstraintHigh.active = YES;
    }
  } else {
    self.contentViewLeadingTitleLabelLeadingConstraint.active = YES;
    self.contentViewLeadingTitleLabelLeadingConstraint.constant = 0;
    self.titleLabelTopContentViewTopConstraintRequired.active = NO;
    self.titleLabelTopContentViewTopConstraintRequired.constant = 0;
    self.titleLabelTopContentViewTopConstraintHigh.active = YES;
    self.titleLabelTopContentViewTopConstraintHigh.constant = 0;
    self.titleLabelBottomContentViewBottomConstraint.constant = 0;
    self.leadingImageViewCenterYTitleLabelCenterY.active = NO;
    self.contentViewCenterYTitleLabelCenterY.active = NO;
  }
}

- (void)updateDetailLabelConstraints {
  self.detailLabelTrailingTrailingImageViewLeadingConstraint.active = YES;
  if (self.detailText.length > 0) {
    self.contentViewLeadingDetailLabelLeadingConstraint.active = YES;
    self.contentViewLeadingDetailLabelLeadingConstraint.constant = [self dynamicTextOffset];
    self.detailLabelTopContentViewTopConstraintRequired.constant = kDefaultVerticalMarginMin;
    self.detailLabelTopContentViewTopConstraintRequired.active = YES;
    self.detailLabelBottomContentViewBottomConstraint.active = YES;
    if (self.titleText.length > 0) {
      self.detailLabelTopTitleLabelBottomConstraint.active = YES;
      self.detailLabelTopContentViewTopConstraintHigh.active = NO;
      self.leadingImageViewCenterYDetailLabelCenterY.active = NO;
      self.contentViewCenterYDetailLabelCenterY.active = NO;
    } else {
      self.detailLabelTopTitleLabelBottomConstraint.active = NO;
      if (self.leadingImage) {
        self.leadingImageViewCenterYDetailLabelCenterY.active = YES;
        self.contentViewCenterYDetailLabelCenterY.active = NO;
      } else {
        self.leadingImageViewCenterYDetailLabelCenterY.active = NO;
        self.contentViewCenterYDetailLabelCenterY.active = YES;
      }
    }
  } else {
    self.contentViewLeadingDetailLabelLeadingConstraint.active = YES;
    self.contentViewLeadingDetailLabelLeadingConstraint.constant = 0;
    self.detailLabelTopContentViewTopConstraintRequired.active = NO;
    self.detailLabelTopContentViewTopConstraintHigh.active = YES;
    self.detailLabelTopContentViewTopConstraintHigh.constant = 0;
    self.detailLabelTopTitleLabelBottomConstraint.active = NO;
    self.leadingImageViewCenterYDetailLabelCenterY.active = NO;
    self.contentViewCenterYDetailLabelCenterY.active = NO;
  }
}


-(void)updateConstraints {
  [super updateConstraints];
  [self updateLeadingImageViewConstraints];
  [self updateTrailingImageViewConstraints];
  [self updateTitleLabelConstraints];
  [self updateDetailLabelConstraints];
}

#pragma mark Accessors

-(void)setLeadingImage:(UIImage * _Nullable)leadingImage {
  if (leadingImage == _leadingImageView.image) {
    return;
  }
  _leadingImage = leadingImage;
  self.leadingImageView.image = _leadingImage;
  [self setNeedsUpdateConstraints];
  [self setNeedsLayout];
}

-(void)setTrailingImage:(UIImage * _Nullable)trailingImage {
  if (trailingImage == _trailingImage) {
    return;
  }
  _trailingImage = trailingImage;
  self.trailingImageView.image = _trailingImage;
  [self setNeedsUpdateConstraints];
  [self setNeedsLayout];
}

-(void)setTitleText:(NSString *)titleText {
  if ([titleText isEqualToString:_titleText]) {
    return;
  }
  _titleText = [titleText copy];
  self.titleLabel.text = _titleText;

  [self setNeedsUpdateConstraints];
  [self setNeedsLayout];
}

-(void)setDetailText:(NSString *)detailText {
  if ([detailText isEqualToString:_detailText]) {
    return;
  }
  _detailText = [detailText copy];
  self.detailLabel.text = _detailText;

  [self setNeedsUpdateConstraints];
  [self setNeedsLayout];
}

#pragma mark - Typography/Dynamic Type Support

- (MDCTypographyScheme *)defaultTypographyScheme {
  return [MDCTypographyScheme new];
}

-(void)setTypographyScheme:(MDCTypographyScheme *)typographyScheme {
  _typographyScheme = typographyScheme;
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
  UIFont *titleFont = self.titleLabel.font ?: self.typographyScheme.body1;
  UIFont *detailFont = self.detailLabel.font ?: self.typographyScheme.body2;
  if (_mdc_adjustsFontForContentSizeCategory) {
    titleFont =
    [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                            scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    detailFont =
    [detailFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                             scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
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
