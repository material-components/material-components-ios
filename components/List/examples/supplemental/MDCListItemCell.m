//
//  MDCListItemCell.m
//  Pods
//
//  Created by andrewoverton on 5/22/18.
//

#import "MDCListItemCell.h"
#import "MDCListBaseCell+Private.h"

static const CGFloat kDefaultMarginTop = 10.0;
static const CGFloat kDefaultMarginBottom = 10.0;
static const CGFloat kDefaultMarginLeading = 10.0;
static const CGFloat kDefaultMarginTrailing = 10.0;
static const CGFloat kDefaultViewPadding = 10.0;

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
  [self setUpTextContainerConstraints];
  [self setUpOverlineLabelConstraints];
  [self setUpTitleLabelConstraints];
  [self setUpDetailLabelConstraints];
}

#pragma mark UIView Overrides

#pragma mark UICollectionViewCell Overrides

-(void)prepareForReuse {
  [super prepareForReuse];
  
  self.overlineText = nil;
  self.titleText = nil;
  self.detailText = nil;
}

- (void)createSupportingViews {
  // Create leadingContainer
  self.leadingContainer = [[UIView alloc] init];
  self.leadingContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.leadingContainer.backgroundColor = [UIColor lightGrayColor];
  self.leadingContainer.accessibilityIdentifier = @"leadingContainer";
  [self.contentView addSubview:self.leadingContainer];

  // Create trailingContainer
  self.trailingContainer = [[UIView alloc] init];
  self.trailingContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.trailingContainer.backgroundColor = [UIColor blueColor];
  self.trailingContainer.accessibilityIdentifier = @"trailingContainer";
  [self.contentView addSubview:self.trailingContainer];

  // Create textContainer
  self.textContainer = [[UIView alloc] init];
  self.textContainer.translatesAutoresizingMaskIntoConstraints = NO;
  self.textContainer.backgroundColor = [UIColor redColor];
  self.textContainer.accessibilityIdentifier = @"textContainer";
  [self.contentView addSubview:self.textContainer];

  // Create overlineLabel
  self.overlineLabel = [[UILabel alloc] init];
  self.overlineLabel.numberOfLines = 0;
  self.overlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.overlineLabel.backgroundColor = [UIColor yellowColor];
  self.overlineLabel.textColor = [UIColor greenColor];
  self.overlineLabel.accessibilityIdentifier = @"overlineLabel";
  [self.textContainer addSubview:self.overlineLabel];

  // Create titleLabel
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.backgroundColor = [UIColor blackColor];
  self.titleLabel.textColor = [UIColor whiteColor];
  self.titleLabel.accessibilityIdentifier = @"titleLabel";
  [self.textContainer addSubview:self.titleLabel];

  // Create detailLabel
  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.numberOfLines = 0;
  self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.detailLabel.backgroundColor = [UIColor redColor];
  self.detailLabel.textColor = [UIColor yellowColor];
  [self.contentView addSubview:self.detailLabel];
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
//  self.leadingContainerWidthConstraint.priority = UILayoutPriorityDefaultHigh;
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
//  self.leadingContainerHeightConstraint.priority = UILayoutPriorityDefaultHigh;
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
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.leadingContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.leadingContainerBottomConstraint.active = YES;
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
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self.trailingContainer
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0.0];
  self.trailingContainerBottomConstraint.active = YES;
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



-(void)setTextOffset:(CGFloat)textOffset {
  if (textOffset == _textOffset) {
    return;
  }
  _textOffset = textOffset;
  self.contentViewTextContainerLeadingConstraint.constant = textOffset;
  [self setNeedsLayout];
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
    self.leadingContainerBottomConstraint.constant = kDefaultMarginBottom;
    _leadingView.accessibilityIdentifier = @"leadingView";
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
  
  if (_overlineText.length > 0) {
    self.overlineLabelTopConstraint.constant = kDefaultViewPadding;
  } else {
    self.overlineLabelTopConstraint.constant = 0;
  }
  
  [self setNeedsLayout];
}

-(void)setTitleText:(NSString *)titleText {
  if (titleText == _titleText) {
    return;
  }
  _titleText = titleText;
  self.titleLabel.text = _titleText;

  if (_titleText.length > 0) {
    self.titleLabelTopConstraint.constant = kDefaultViewPadding;
  } else {
    self.titleLabelTopConstraint.constant = 0;
  }

  [self setNeedsLayout];
}

-(void)setDetailText:(NSString *)detailText {
  if (detailText == _detailText) {
    return;
  }
  _detailText = detailText;
  self.detailLabel.text = _detailText;
  
  if (_detailText.length > 0) {
    self.detailLabelTopConstraint.constant = kDefaultViewPadding;
  } else {
    self.detailLabelTopConstraint.constant = 0;
  }

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

-(void)setNeedsLayout {
//  CGSize size5 = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//  self.cellHeightConstraint.constant = size5.height;
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
//  self.leadingViewTextContainerLeadingConstraint.constant = self.leadingView ?
//  if (!self.leadingView) {
//    self.leadingViewTextContainerLeadingConstraint.constant = 50;
//  }
  
  [super layoutSubviews];
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  return attributes;
}

@end
