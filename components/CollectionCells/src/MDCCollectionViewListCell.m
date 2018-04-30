//
//  MDCCollectionViewListCell.m
//  MaterialComponents
//
//  Created by yar on 4/9/18.
//

#import "MDCCollectionViewListCell.h"
#import <MDFInternationalization/MDFInternationalization.h>
#import "MDCTypography.h"

@implementation MDCCollectionViewListCell {
  CGPoint _lastTouch;
  UIView *_contentWrapper;
  NSLayoutConstraint *_cellWidthConstraint;
  NSLayoutConstraint *_imageLeftPaddingConstraint;
  NSLayoutConstraint *_imageRightPaddingConstraint;
  NSLayoutConstraint *_imageWidthConstraint;
  NSLayoutConstraint *_imageHeightConstraint;
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
  _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _textLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);

  // Detail text label.
  _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _detailTextLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);

  [self resetMDCCollectionViewListCell];

  [_contentWrapper addSubview:_textLabel];
  [_contentWrapper addSubview:_detailTextLabel];

  // Image view.
  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _imageView.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);
  [self.contentView addSubview:_imageView];

  [self setupConstraints];
}

- (void)resetMDCCollectionViewListCell {
  _textLabel.font = CellDefaultTextFont();
  _textLabel.textColor = [UIColor colorWithWhite:0 alpha:CellDefaultTextOpacity()];
  _textLabel.textAlignment = NSTextAlignmentNatural;
  _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _textLabel.numberOfLines = 1;

  _detailTextLabel.font = CellDefaultDetailTextFont();
  _detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:CellDefaultDetailTextFontOpacity()];
  _detailTextLabel.textAlignment = NSTextAlignmentNatural;
  _detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _detailTextLabel.numberOfLines = 3;
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
  _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _imageView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *views =
      @{@"contentWrapper": _contentWrapper,
        @"textLabel": _textLabel,
        @"detailTextLabel": _detailTextLabel,
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
   [NSLayoutConstraint constraintsWithVisualFormat:@"|[textLabel]|"
                                           options:0
                                           metrics:nil
                                             views:views]];

  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"|[detailTextLabel]|"
                                           options:0
                                           metrics:nil
                                             views:views]];

  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(12)-[textLabel][detailTextLabel]-(12)-|"
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

//  [constraints addObject:
//   [NSLayoutConstraint constraintWithItem:_imageView
//                                attribute:NSLayoutAttributeTop
//                                relatedBy:NSLayoutRelationLessThanOrEqual
//                                   toItem:self.contentView
//                                attribute:NSLayoutAttributeTop
//                               multiplier:1
//                                 constant:0]];
//
//  [constraints addObject:
//   [NSLayoutConstraint constraintWithItem:_imageView
//                                attribute:NSLayoutAttributeBottom
//                                relatedBy:NSLayoutRelationLessThanOrEqual
//                                   toItem:self.contentView
//                                attribute:NSLayoutAttributeBottom
//                               multiplier:1
//                                 constant:0]];

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
  self.textLabel.text = nil;
  self.detailTextLabel.text = nil;

  [self resetMDCCollectionViewListCell];

  [super prepareForReuse];
}

// Default cell fonts.
static inline UIFont *CellDefaultTextFont(void) {
  return [MDCTypography subheadFont];
}

static inline UIFont *CellDefaultDetailTextFont(void) {
  return [MDCTypography body1Font];
}

// Default cell font opacity.
static inline CGFloat CellDefaultTextOpacity(void) {
  return [MDCTypography subheadFontOpacity];
}

static inline CGFloat CellDefaultDetailTextFontOpacity(void) {
  return [MDCTypography captionFontOpacity];
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


@end
