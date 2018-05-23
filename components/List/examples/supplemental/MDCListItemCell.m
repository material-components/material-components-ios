//
//  MDCListItemCell.m
//  Pods
//
//  Created by andrewoverton on 5/22/18.
//

#import "MDCListItemCell.h"
#import "MDCListBaseCell+Private.h"

static const CGFloat kImageSideLength = 40.0;
static const CGFloat kDefaultMarginTop = 10.0;
static const CGFloat kDefaultMarginBottom = 10.0;
//static const CGFloat kDefaultMarginLeading = 10.0;
static const CGFloat kDefaultMarginTrailing = 10.0;
static const CGFloat kDefaultInterViewPadding = 10.0;

@interface MDCListItemCell ()

#pragma mark Configurable Constraints
@property (strong, nonatomic) NSLayoutConstraint *controlContainerWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *controlContainerHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *imageViewSideConstraint;
@property (strong, nonatomic) NSLayoutConstraint *imageViewTitleLabelHorizontalPaddingConstraint;
@property (strong, nonatomic) NSLayoutConstraint
    *titleLabelControlContainerHorizontalPaddingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelDetailLabelVerticalPaddingConstraint;

@property (nonatomic, strong, nullable) UIView *textContainer;
// maybe don't use ^

#pragma mark Primary Supporting Views
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *controlContainer;
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *detailLabel;

@end

@implementation MDCListItemCell

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
  [self createSupportingViews];
  [self setUpImageViewConstraints];
  [self setUpControlContainerConstraints];
  [self setUpTitleLabelConstraints];
//  [self setUpDetailLabelConstraints];
//  [self setUpConstraints];
//  [self setUpTitleLabel];
//  [self setUpTitleLabelConstraints];
//  [self setUpImageView];
}

#pragma mark UIView Overrides

#pragma mark UICollectionViewCell Overrides

-(void)prepareForReuse {
  [super prepareForReuse];
  
  self.control = nil;
  self.image = nil;
  self.titleText = nil;
  self.detailsText = nil;
}

- (void)createSupportingViews {
  self.imageView = [[UIImageView alloc] init];
  self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:self.imageView];

  self.controlContainer = [[UIView alloc] init];
  self.controlContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.controlContainer.backgroundColor = [UIColor blueColor];
  [self.contentView addSubview:self.controlContainer];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.backgroundColor = [UIColor yellowColor];
  self.titleLabel.textColor = [UIColor redColor];
  [self.contentView addSubview:self.titleLabel];
//
//  self.detailLabel = [[UILabel alloc] init];
//  self.detailLabel.numberOfLines = 2;
//  self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
//  self.detailLabel.backgroundColor = [UIColor redColor];
//  self.detailLabel.textColor = [UIColor yellowColor];
//  [self.contentView addSubview:self.detailLabel];
}

#pragma mark Layout


- (void)setUpImageViewConstraints {
  // Retain constraint determining imageView side length
  self.imageViewSideConstraint =
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0];
  self.imageViewSideConstraint.active = YES;
  
  // Constrain aspect ratio
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.imageView
                               attribute:NSLayoutAttributeWidth
                              multiplier:1.0
                                constant:0].active = YES;

  // Constrain to top
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:kDefaultMarginTop].active = YES;

  // Constrain to leading edge
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:kDefaultMarginTrailing].active = YES;

  
  // Constrain to trailing edge - get rid of
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:-kDefaultMarginTrailing].active = YES;

  
  
  
  // Constrain to bottom
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:-kDefaultMarginBottom].active = YES;
}

- (void)setUpControlContainerConstraints {
  // Retain constraint determining controlContainer width
  self.controlContainerWidthConstraint =
  [NSLayoutConstraint constraintWithItem:self.controlContainer
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0];
  self.controlContainerWidthConstraint.active = YES;

  self.controlContainerHeightConstraint =
  [NSLayoutConstraint constraintWithItem:self.controlContainer
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:0];
  self.controlContainerHeightConstraint.active = YES;

  // Center vertically
  [NSLayoutConstraint constraintWithItem:self.controlContainer
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                                constant:0].active = YES;

  // Constrain to top
  [NSLayoutConstraint constraintWithItem:self.controlContainer
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:kDefaultMarginBottom].active = YES;

  // Constrain to bottom
  [NSLayoutConstraint constraintWithItem:self.controlContainer
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:-kDefaultMarginBottom].active = YES;
  // Constrain to trailing edge
  [NSLayoutConstraint constraintWithItem:self.controlContainer
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:-kDefaultMarginTrailing].active = YES;
}

-(void)setUpTitleLabelConstraints {
  // Constrain to top
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:kDefaultMarginTop].active = YES;

  // Constrain to leading imageView
  self.imageViewTitleLabelHorizontalPaddingConstraint =
      [NSLayoutConstraint constraintWithItem:self.titleLabel
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.imageView
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:kDefaultInterViewPadding];
  self.imageViewTitleLabelHorizontalPaddingConstraint.active = YES;

  // Constrain to trailing controlContainer
  self.titleLabelControlContainerHorizontalPaddingConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.controlContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:40/*-kDefaultInterViewPadding*/];
  self.titleLabelControlContainerHorizontalPaddingConstraint.active = YES;

  // Constrain to detailLabel
//  self.titleLabelDetailLabelVerticalPaddingConstraint =
//  [NSLayoutConstraint constraintWithItem:self.titleLabel
//                               attribute:NSLayoutAttributeBottom
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:self.detailLabel
//                               attribute:NSLayoutAttributeTop
//                              multiplier:1
//                                constant:kDefaultInterViewPadding];
//  self.titleLabelDetailLabelVerticalPaddingConstraint.active = YES;
}

- (void)setUpDetailLabelConstraints {
  // Constrain leading edge to titleLabel
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.detailLabel
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0].active = YES;

  // Constrain top edge to titleLabel
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.detailLabel
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0].active = YES;

  // Constrain to trailing controlContainer
  self.titleLabelControlContainerHorizontalPaddingConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.controlContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:kDefaultInterViewPadding];
  self.titleLabelControlContainerHorizontalPaddingConstraint.active = YES;

  // Constrain top to bottom of titleView
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.detailLabel
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:-kDefaultInterViewPadding].active = YES;

  // Constrain to bottom of cell
  [NSLayoutConstraint constraintWithItem:self.detailLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-kDefaultInterViewPadding].active = YES;

  
  
}

#pragma mark Accessors

- (void)setImage:(UIImage *)image {
  if (image == _image) {
    return;
  }
  _image = image;
  
  UIImage *imageToDisplay = self.image ?: self.placeholderImage;
  self.imageView.image = imageToDisplay;
  self.imageView.backgroundColor = [UIColor blueColor];
  self.imageViewSideConstraint.constant = self.imageView.image ? kImageSideLength : 0;
  self.imageViewTitleLabelHorizontalPaddingConstraint.constant =
      self.imageView.image ? kDefaultInterViewPadding : 0;
  [self setNeedsLayout];
}

- (void)setTitleText:(NSString *)titleText {
  if (titleText == _titleText) {
    return;
  }
  _titleText = titleText;
  self.titleLabel.text = _titleText;
  
  self.titleLabelControlContainerHorizontalPaddingConstraint.constant =
      self.titleText.length > 0 ? kDefaultInterViewPadding : 0;
  self.titleLabelDetailLabelVerticalPaddingConstraint.constant =
      self.detailsText.length > 0 ? kDefaultInterViewPadding : 0;
  
  [self setNeedsLayout];
}

- (void)setDetailsText:(NSString *)detailsText {
  if (detailsText == _detailsText) {
    return;
  }
  _detailsText = detailsText;
  self.detailLabel.text = _detailsText;
  [self setNeedsLayout];
}

-(void)setControl:(UIControl *)control {
  if (control == _control) {
    return;
  }
  [_control removeFromSuperview];
  _control = control;

  if (_control) {
    [self.controlContainer addSubview:_control];
    self.controlContainerWidthConstraint.constant = _control.intrinsicContentSize.width;
    self.controlContainerHeightConstraint.constant = _control.intrinsicContentSize.height;
    [NSLayoutConstraint constraintWithItem:self.control
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.controlContainer
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.control
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.controlContainer
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0].active = YES;
  } else {
    self.controlContainerWidthConstraint.constant = 0;
    self.controlContainerHeightConstraint.constant = 0;
  }
  
  [self setNeedsLayout];
}

@end
