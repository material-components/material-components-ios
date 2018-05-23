//
//  MDCListItemCell.m
//  Pods
//
//  Created by andrewoverton on 5/22/18.
//

#import "MDCListItemCell.h"
#import "MDCListBaseCell+Private.h"

//static const CGFloat kImageSideLength = 40.0;
static const CGFloat kDefaultMarginTop = 10.0;
static const CGFloat kDefaultMarginBottom = 10.0;
static const CGFloat kDefaultMarginLeading = 10.0;
static const CGFloat kDefaultMarginTrailing = 10.0;
//static const CGFloat kDefaultInterViewPadding = 10.0;

@interface MDCListItemCell ()

#pragma mark Configurable Constraints

@property (strong, nonatomic) UIView *leadingContainer;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingContainerBottomConstraint;

@property (strong, nonatomic) UIView *trailingContainer;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingContainerBottomConstraint;

@property (strong, nonatomic) UIView *textContainer;
@property (strong, nonatomic) NSLayoutConstraint *textContainerLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textContainerTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textContainerTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textContainerBottomConstraint;



@property (strong, nonatomic) UILabel *overlineLabel;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelTrailingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *overlineLabelBottomConstraint;

@property (strong, nonatomic) UILabel *titleLabel;
//@property (strong, nonatomic) NSLayoutConstraint *leadingContainerLeadingConstraint;
//@property (strong, nonatomic) NSLayoutConstraint *leadingContainerLeadingConstraint;
@property (strong, nonatomic) UILabel *detailLabel;
//@property (strong, nonatomic) NSLayoutConstraint *trailingContainerTrailingConstraint;
//@property (strong, nonatomic) NSLayoutConstraint *trailingContainerWidthConstraint;
//@property (strong, nonatomic) NSLayoutConstraint *trailingContainerHeightConstraint;


#pragma mark Primary Supporting Views
//@property (nonatomic, strong, nullable) UILabel *titleLabel;
//@property (nonatomic, strong, nullable) UILabel *detailLabel;

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
  self.contentView.accessibilityIdentifier = @"contentView";
  [self createSupportingViews];
  [self setUpLeadingViewContainerConstraints];
  [self setUpTrailingViewContainerConstraints];
//  [self setUpTextContainerConstraints];
//  [self setUpTitleLabelConstraints];
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
  
  self.titleText = nil;
  self.detailsText = nil;
}

- (void)createSupportingViews {
  self.leadingContainer = [[UIView alloc] init];
  self.leadingContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.leadingContainer.backgroundColor = [UIColor lightGrayColor];
  self.leadingContainer.accessibilityIdentifier = @"leadingContainer";
  [self.contentView addSubview:self.leadingContainer];

  self.textContainer = [[UIView alloc] init];
  self.textContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.textContainer.backgroundColor = [UIColor redColor];
  self.textContainer.accessibilityIdentifier = @"textContainer";
//  [self.contentView addSubview:self.textContainer];

  self.overlineLabel = [[UILabel alloc] init];
  self.overlineLabel.numberOfLines = 0;
  self.overlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.overlineLabel.backgroundColor = [UIColor yellowColor];
  self.overlineLabel.textColor = [UIColor greenColor];
  self.overlineLabel.accessibilityIdentifier = @"overlineLabel";
//  [self.textContainer addSubview:self.overlineLabel];

//  self.titleLabel = [[UILabel alloc] init];
//  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
//  self.titleLabel.backgroundColor = [UIColor yellowColor];
//  self.titleLabel.textColor = [UIColor redColor];
//  [self.contentView addSubview:self.titleLabel];

  
  self.trailingContainer = [[UIView alloc] init];
  self.trailingContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.trailingContainer.backgroundColor = [UIColor blueColor];
  self.trailingContainer.accessibilityIdentifier = @"trailingContainer";
  [self.contentView addSubview:self.trailingContainer];
//
//
//  self.detailLabel = [[UILabel alloc] init];
//  self.detailLabel.numberOfLines = 2;
//  self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
//  self.detailLabel.backgroundColor = [UIColor redColor];
//  self.detailLabel.textColor = [UIColor yellowColor];
//  [self.contentView addSubview:self.detailLabel];
}

#pragma mark Layout


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
  
  // Constrain to top
  self.leadingContainerTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerTopConstraint.active = YES;

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

  // Constrain to bottom
  self.leadingContainerBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerBottomConstraint.active = YES; // -kDefaultMarginBottom
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
  
  // Constrain to top
  self.trailingContainerTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerTopConstraint.active = YES;
  
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
  
  // Constrain to bottom
  
  self.trailingContainerBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.trailingContainer
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerBottomConstraint.active = YES; // -kDefaultMarginBottom
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
  
  // Constrain to leading edge
  self.textContainerLeadingConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.leadingContainer
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                                constant:0.0];
  self.textContainerLeadingConstraint.active = YES;

  // Constrain to trailing edge
  self.textContainerTrailingConstraint =
  [NSLayoutConstraint constraintWithItem:self.textContainer
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.trailingContainer
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0.0];
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
  self.textContainerBottomConstraint.active = YES; // -kDefaultMarginBottom

  // set up overline label constraints
  
  // Constrain to top
//  self.overlineLabelTopConstraint =
//  [NSLayoutConstraint constraintWithItem:self.overlineLabel
//                               attribute:NSLayoutAttributeTop
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:self.textContainer
//                               attribute:NSLayoutAttributeTop
//                              multiplier:1.0
//                                constant:0.0];
//  self.overlineLabelTopConstraint.active = YES;
//
//  // Constrain to leading edge
//  self.overlineLabelLeadingConstraint =
//  [NSLayoutConstraint constraintWithItem:self.overlineLabel
//                               attribute:NSLayoutAttributeLeading
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:self.textContainer
//                               attribute:NSLayoutAttributeLeading
//                              multiplier:1.0
//                                constant:0.0];
//  self.overlineLabelLeadingConstraint.active = YES;
//
//  // Constrain to trailing edge
//  self.overlineLabelTrailingConstraint =
//  [NSLayoutConstraint constraintWithItem:self.overlineLabel
//                               attribute:NSLayoutAttributeTrailing
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:self.textContainer
//                               attribute:NSLayoutAttributeTrailing
//                              multiplier:1.0
//                                constant:0.0];
//  self.overlineLabelTrailingConstraint.active = YES;
//
//  // Constrain to bottom
//  self.textContainerBottomConstraint =
//  [NSLayoutConstraint constraintWithItem:self.overlineLabel
//                               attribute:NSLayoutAttributeBottom
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:self.textContainer
//                               attribute:NSLayoutAttributeBottom
//                              multiplier:1.0
//                                constant:0.0];
//  self.textContainerBottomConstraint.active = YES; // -kDefaultMarginBottom

  
  
  
}

- (void)setUpOverlineLabelConstraints {
  // Constrain to top
  self.overlineLabelTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.overlineLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerTopConstraint.active = YES;

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
  
  // Constrain to bottom
  self.leadingContainerBottomConstraint =
  [NSLayoutConstraint constraintWithItem:self.leadingContainer
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerBottomConstraint.active = YES; // -kDefaultMarginBottom
}


-(void)setUpTitleLabelConstraints {
}

- (void)setUpDetailLabelConstraints {
}

#pragma mark Accessors

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
    self.leadingContainerBottomConstraint.constant = -kDefaultMarginBottom;
    [NSLayoutConstraint constraintWithItem:_leadingView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_leadingContainer
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_leadingView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_leadingContainer
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0].active = YES;
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
    self.trailingContainerBottomConstraint.constant = -kDefaultMarginBottom;
    [NSLayoutConstraint constraintWithItem:_trailingView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_trailingContainer
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_trailingView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_trailingContainer
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0].active = YES;
  } else {
    self.trailingContainerWidthConstraint.constant = 0;
    self.trailingContainerHeightConstraint.constant = 0;
    self.trailingContainerTrailingConstraint.constant = 0;
    self.trailingContainerTopConstraint.constant = 0;
    self.trailingContainerBottomConstraint.constant = 0;
  }
  
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

-(void)setOverlineText:(NSString *)overlineText {
  if (overlineText == _overlineText) {
    return;
  }
  _overlineText = overlineText;
//  self.overlineLabel.text = _overlineText;
//  [self setNeedsLayout];
}



-(void)setNeedsLayout {
//    CGSize size1 = [self.textContainer systemLayoutSizeFittingSize:CGSizeMake(self.textContainer.frame.size.width, 50000)];
//    CGSize size2 = [self.textContainer
//                    sizeThatFits:CGSizeMake(self.textContainer.frame.size.width, 0)];
//    CGSize size3 = [self.textContainer
//                    sizeThatFits:CGSizeMake(self.textContainer.frame.size.width, 50000)];
//
//    NSLog(@"1: %@ %@",@(size1.width), @(size1.height));
//    NSLog(@"2: %@ %@",@(size2.width), @(size2.height));
//    NSLog(@"3: %@ %@",@(size3.width),@(size3.height));
  
  [super setNeedsLayout];
}

-(void)layoutSubviews {
//  self.textContainerLeadingConstraint.constant = self.leadingView ?
//  if (!self.leadingView) {
//    self.textContainerLeadingConstraint.constant = 50;
//  }
  
  [super layoutSubviews];
}

@end
