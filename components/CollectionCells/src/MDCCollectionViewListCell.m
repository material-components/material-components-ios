//
//  MDCCollectionViewListCell.m
//  MaterialComponents
//
//  Created by yar on 4/9/18.
//

#import "MDCCollectionViewListCell.h"
#import <MDFInternationalization/MDFInternationalization.h>
#import "MaterialTypography.h"

@implementation MDCCollectionViewListCell {
  CGPoint _lastTouch;
  UIView *_contentWrapper;
  NSLayoutConstraint *_cellWidthConstraint;
  NSLayoutConstraint *_imageLeftPaddingConstraint;
  NSLayoutConstraint *_imageRightPaddingConstraint;
  NSLayoutConstraint *_imageWidthConstraint;
  NSLayoutConstraint *_imageHeightConstraint;
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}


- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionViewListCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCCollectionViewListCellInit];
  }
  return self;
}

- (void)commonMDCCollectionViewListCellInit {
  _contentWrapper = [[UIView alloc] initWithFrame:self.contentView.bounds];
  _contentWrapper.autoresizingMask =
  UIViewAutoresizingFlexibleWidth | MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);
  _contentWrapper.clipsToBounds = YES;
  [self.contentView addSubview:_contentWrapper];

  // Text label.
  _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _titleLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);

  // Detail text label.
  _detailsTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _detailsTextLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);

  [self resetMDCCollectionViewListCell];

  [_contentWrapper addSubview:_titleLabel];
  [_contentWrapper addSubview:_detailsTextLabel];

  // Image view.
  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _imageView.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);
  [self.contentView addSubview:_imageView];

  [self setupConstraints];
}

- (void)resetMDCCollectionViewListCell {
  [self updateTitleFont];
  _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:defaultTitleOpacity()];
  _titleLabel.textAlignment = NSTextAlignmentNatural;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.numberOfLines = 1;

  [self updateDetailsFont];
  _detailsTextLabel.textColor = [UIColor colorWithWhite:0 alpha:defaultDetailsOpacity()];
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
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1
                                constant:1].active = YES;
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1
                                constant:1].active = YES;

  _contentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
  _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _detailsTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _imageView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *views =
      @{@"contentWrapper": _contentWrapper,
        @"titleLabel": _titleLabel,
        @"detailsTextLabel": _detailsTextLabel,
        @"imageView": _imageView
        };

  NSMutableArray *constraints = [[NSMutableArray alloc] init];

   _imageLeftPaddingConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                attribute:NSLayoutAttributeLeft
                               multiplier:1
                                 constant:0];
  _imageLeftPaddingConstraint.active = YES;

  _imageRightPaddingConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                attribute:NSLayoutAttributeRight
                                relatedBy:NSLayoutRelationEqual
                                   toItem:_contentWrapper
                                attribute:NSLayoutAttributeLeft
                               multiplier:1
                                 constant:-16];
  _imageRightPaddingConstraint.active = YES;

  [constraints addObject:
   [NSLayoutConstraint constraintWithItem:_contentWrapper
                                attribute:NSLayoutAttributeRight
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                attribute:NSLayoutAttributeRight
                               multiplier:1
                                 constant:-16]];

  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentWrapper]|"
                                              options:0
                                              metrics:nil
                                                views:views]];

  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"|[titleLabel]|"
                                           options:0
                                           metrics:nil
                                             views:views]];

  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"|[detailsTextLabel]|"
                                           options:0
                                           metrics:nil
                                             views:views]];

  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(12)-[titleLabel][detailsTextLabel]-(12)-|"
                                           options:0
                                           metrics:nil
                                             views:views]];

  [constraints addObject:
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1
                                constant:0]];

  [NSLayoutConstraint activateConstraints:constraints];

  _imageWidthConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:0];
  _imageWidthConstraint.active = YES;

  _imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:40];
  _imageHeightConstraint.active = YES;
}

- (void)setCellWidth:(CGFloat)width {
  _cellWidthConstraint.constant = width;
  _cellWidthConstraint.active = YES;
}

- (void)setImage:(UIImage *)image {
  _imageView.image = image;
  _imageView.contentMode = UIViewContentModeScaleAspectFit;
  if (image) {
    _imageWidthConstraint.constant = 40;
    _imageLeftPaddingConstraint.constant = 16;
    _imageRightPaddingConstraint.constant = -12;
//    _imageHeightConstraint.active = YES;
  } else {
    _imageWidthConstraint.constant = 0;
    _imageLeftPaddingConstraint.constant = 0;
    _imageRightPaddingConstraint.constant = -16;
//    _imageHeightConstraint.active = NO;
  }
}

- (void)prepareForReuse {
  [self setImage:nil];
  self.titleLabel.text = nil;
  self.detailsTextLabel.text = nil;

  [self resetMDCCollectionViewListCell];

  [super prepareForReuse];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
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

static inline UIFont *defaultTitleFont(void) {
  return [MDCTypography subheadFont];
}

static inline UIFont *defaultDetailsFont(void) {
  return [MDCTypography body1Font];
}

static inline CGFloat defaultTitleOpacity(void) {
  return [MDCTypography subheadFontOpacity];
}

static inline CGFloat defaultDetailsOpacity(void) {
  return [MDCTypography captionFontOpacity];
}

@end
