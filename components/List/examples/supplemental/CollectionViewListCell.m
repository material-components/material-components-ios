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

#import "CollectionViewListCell.h"
#import "MaterialInk.h"
#import "MaterialTypography.h"
#import "MaterialTypographyScheme+Scheming.h"
#import <MDFInternationalization/MDFInternationalization.h>

static const CGFloat kImagePadding = 16;
static const CGFloat kImageHeight = 40;
static const CGFloat kWithImageRightPadding = 12;
static const CGFloat kTextVerticalPadding = 12;
static const CGFloat kTitleColorOpacity = (CGFloat)0.87;
static const CGFloat kDetailsColorOpacity = (CGFloat)0.6;

static inline UIFont *defaultTitleFont(void) {
  return [UIFont systemFontOfSize:16];
}

static inline UIFont *defaultDetailsFont(void) {
  return [UIFont systemFontOfSize:14];
}

@implementation CollectionViewListCell {
  CGPoint _lastTouch;
  UIView *_contentWrapper;
  NSLayoutConstraint *_cellWidthConstraint;
  NSLayoutConstraint *_imageLeftPaddingConstraint;
  NSLayoutConstraint *_imageRightPaddingConstraint;
  NSLayoutConstraint *_imageWidthConstraint;
  BOOL _mdc_adjustsFontForContentSizeCategory;
  MDCInkView *_inkView;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonCollectionViewListCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonCollectionViewListCellInit];
  }
  return self;
}

- (void)commonCollectionViewListCellInit {
  _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];

  _contentWrapper = [[UIView alloc] initWithFrame:self.contentView.bounds];
  _contentWrapper.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | MDFTrailingMarginAutoresizingMaskForLayoutDirection(
                                            self.mdf_effectiveUserInterfaceLayoutDirection);
  _contentWrapper.clipsToBounds = YES;
  [self.contentView addSubview:_contentWrapper];

  // Text label.
  _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _titleLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(
      self.mdf_effectiveUserInterfaceLayoutDirection);

  // Detail text label.
  _detailsTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _detailsTextLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(
      self.mdf_effectiveUserInterfaceLayoutDirection);

  [self resetCollectionViewListCell];

  [_contentWrapper addSubview:_titleLabel];
  [_contentWrapper addSubview:_detailsTextLabel];

  // Image view.
  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _imageView.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(
      self.mdf_effectiveUserInterfaceLayoutDirection);
  [self.contentView addSubview:_imageView];

  [self setupConstraints];
}

- (void)resetCollectionViewListCell {
  [self updateTitleFont];
  _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:kTitleColorOpacity];
  _titleLabel.textAlignment = NSTextAlignmentNatural;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.numberOfLines = 1;

  [self updateDetailsFont];
  _detailsTextLabel.textColor = [UIColor colorWithWhite:0 alpha:kDetailsColorOpacity];
  _detailsTextLabel.textAlignment = NSTextAlignmentNatural;
  _detailsTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _detailsTextLabel.numberOfLines = 3;
}

- (void)setupConstraints {
  self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

  _cellWidthConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1
                                                       constant:0];

  _contentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
  _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _detailsTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _imageView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *metrics = @{
    @"kTextVerticalPadding" : @(kTextVerticalPadding),
    @"kImagePadding" : @(kImagePadding),
  };

  NSDictionary *views = @{
    @"contentView" : self.contentView,
    @"contentWrapper" : _contentWrapper,
    @"titleLabel" : _titleLabel,
    @"detailsTextLabel" : _detailsTextLabel,
    @"imageView" : _imageView,
  };

  NSMutableArray *constraints = [[NSMutableArray alloc] init];

  [constraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                  options:0
                                                                  metrics:metrics
                                                                    views:views]];
  [constraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                  options:0
                                                                  metrics:metrics
                                                                    views:views]];

  _imageLeftPaddingConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0];
  _imageLeftPaddingConstraint.active = YES;

  _imageRightPaddingConstraint = [NSLayoutConstraint constraintWithItem:_contentWrapper
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_imageView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1
                                                               constant:kImagePadding];
  _imageRightPaddingConstraint.active = YES;

  _imageWidthConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:0];
  _imageWidthConstraint.active = YES;

  [constraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentWrapper]|"
                                                                  options:0
                                                                  metrics:metrics
                                                                    views:views]];

  [constraints
      addObjectsFromArray:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:[contentWrapper]-(kImagePadding)-|"
                                                  options:0
                                                  metrics:metrics
                                                    views:views]];

  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[titleLabel]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];

  [constraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[detailsTextLabel]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:views]];

  [constraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:
                                                  @"V:|-(kTextVerticalPadding)-[titleLabel]["
                                                  @"detailsTextLabel]-(kTextVerticalPadding)-|"
                                                                  options:0
                                                                  metrics:metrics
                                                                    views:views]];

  [constraints addObject:[NSLayoutConstraint constraintWithItem:_imageView
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.contentView
                                                      attribute:NSLayoutAttributeCenterY
                                                     multiplier:1
                                                       constant:0]];

  [constraints addObject:[NSLayoutConstraint constraintWithItem:_imageView
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1
                                                       constant:kImageHeight]];

  [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setCellWidth:(CGFloat)width {
  _cellWidthConstraint.constant = width;
  _cellWidthConstraint.active = YES;
}

- (void)setImage:(UIImage *)image {
  _imageView.image = image;
  _imageView.contentMode = UIViewContentModeScaleAspectFit;
  if (image) {
    _imageWidthConstraint.constant = kImageHeight;
    _imageLeftPaddingConstraint.constant = kImagePadding;
    _imageRightPaddingConstraint.constant = kWithImageRightPadding;
  } else {
    _imageWidthConstraint.constant = 0;
    _imageLeftPaddingConstraint.constant = 0;
    _imageRightPaddingConstraint.constant = kImagePadding;
  }
}

- (void)prepareForReuse {
  [self setImage:nil];
  self.titleLabel.text = nil;
  self.detailsTextLabel.text = nil;

  [self resetCollectionViewListCell];
  [_inkView cancelAllAnimationsAnimated:NO];

  [super prepareForReuse];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [_inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [_inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}

- (void)applyTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  self.titleFont = typographyScheme.subtitle1;
  self.detailsFont = typographyScheme.body2;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;

  [super touchesBegan:touches withEvent:event];
}

#pragma mark - Dynamic Type Support

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

  [self updateTitleFont];
  [self updateDetailsFont];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateTitleFont];
  [self updateDetailsFont];
}

- (void)setTitleFont:(UIFont *)titleFont {
  _titleFont = titleFont;
  [self updateTitleFont];
}

- (void)updateTitleFont {
  if (!_titleFont) {
    _titleFont = defaultTitleFont();
  }
  if (_mdc_adjustsFontForContentSizeCategory) {
    _titleLabel.font =
        [_titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                 scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    _titleLabel.font = _titleFont;
  }
  [self setNeedsLayout];
}

- (void)setDetailsFont:(UIFont *)detailsFont {
  _detailsFont = detailsFont;
  [self updateDetailsFont];
}

- (void)updateDetailsFont {
  if (!_detailsFont) {
    _detailsFont = defaultDetailsFont();
  }
  if (_mdc_adjustsFontForContentSizeCategory) {
    _detailsTextLabel.font =
        [_detailsFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                                   scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    _detailsTextLabel.font = _detailsFont;
  }
  [self setNeedsLayout];
}

@end
