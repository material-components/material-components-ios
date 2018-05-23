//
//  MDCListBaseCell.m
//  CatalogByConvention
//
//  Created by andrewoverton on 5/22/18.
//

#import "MDCListBaseCell.h"
#import <MDFInternationalization/MDFInternationalization.h>
#import "MaterialInk.h"
#import "MaterialTypography.h"


@interface MDCListBaseCell ()

@property (nonatomic, assign) CGPoint lastTouch;
@property (strong, nonatomic) MDCInkView *inkView;
@property (strong, nonatomic) NSLayoutConstraint *cellWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *cellHeightConstraint;


//UIView *_contentWrapper;
//NSLayoutConstraint *_cellWidthConstraint;
//NSLayoutConstraint *_imageLeftPaddingConstraint;
//NSLayoutConstraint *_imageRightPaddingConstraint;
//NSLayoutConstraint *_imageWidthConstraint;
//BOOL _mdc_adjustsFontForContentSizeCategory;


@end

@implementation MDCListBaseCell

#pragma mark Object Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [self baseCommonInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self baseCommonInit];
    return self;
  }
  return nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseCommonInit];
    return self;
  }
  return nil;

}

-(void)setNeedsLayout {
//  CGSize size1 = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//  CGSize size2 = [self.contentView
//                  sizeThatFits:CGSizeMake(self.cellWidthConstraint.constant, 0)];
//  CGSize size3 = [self.contentView
//                  sizeThatFits:CGSizeMake(self.cellWidthConstraint.constant, 50000)];
//
//  NSLog(@"1: %@ %@",@(size1.width), @(size1.height));
//  NSLog(@"2: %@ %@",@(size2.width), @(size2.height));
//  NSLog(@"3: %@ %@",@(size3.width),@(size3.height));
//  self.cellHeightConstraint.constant = size.height;
  [super setNeedsLayout];
}

- (void)baseCommonInit {
  [self initializeInkView];
  self.backgroundColor = [UIColor lightGrayColor];
  
  [self setUpConstraints];
  self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)initializeInkView {
  self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];
}

- (void)setUpConstraints {
  self.cellWidthConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:0];

//  self.cellHeightConstraint =
//      [NSLayoutConstraint constraintWithItem:self.contentView
//                                   attribute:NSLayoutAttributeHeight
//                                   relatedBy:NSLayoutRelationEqual
//                                      toItem:nil
//                                   attribute:NSLayoutAttributeNotAnAttribute
//                                  multiplier:1
//                                    constant:0.0];
//  self.cellHeightConstraint.active = YES;
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                                constant:1.0].active = YES;
  [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                                constant:1.0].active = YES;

}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [_inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [_inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
}

-(void)setCellWidth:(CGFloat)cellWidth {
  if (_cellWidth == cellWidth) {
    return;
  }
  _cellWidth = cellWidth;
  _cellWidthConstraint.constant = _cellWidth;
  _cellWidthConstraint.active = YES;
}

- (void)performAsAtomicUpdateCellUpdate:(void(^)(void))updateBlock {
  @synchronized(self) {
    updateBlock();
  }
}


@end
