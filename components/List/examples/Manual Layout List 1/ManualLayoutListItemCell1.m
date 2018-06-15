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

#import "ManualLayoutListItemCell1.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialInk.h"
#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kDefaultMarginTop = 12.0;
static const CGFloat kDefaultMarginBottom = 12.0;
static const CGFloat kDefaultMarginLeading = 12.0;
static const CGFloat kDefaultMarginTrailing = 12.0;
static const CGFloat kDefaultVerticalLabelPadding = 6.0;

@interface ManualLayoutListItemCell1 ()

@property (nonatomic, assign) CGPoint lastTouch;
@property (strong, nonatomic, nonnull) MDCInkView *inkView;

@property (strong, nonatomic, nonnull) UIView *textContainer;
@property (strong, nonatomic, nonnull) UILabel *overlineLabel;
@property (strong, nonatomic, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, nonnull) UILabel *detailLabel;

@end

@implementation ManualLayoutListItemCell1
@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

#pragma mark Object Lifecycle

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
    return self;
  }
  return nil;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
    return self;
  }
  return nil;
}

-(instancetype)init {
  self = [super init];
  if (self) {
    [self commonInit];
    return self;
  }
  return nil;
}

#pragma mark Setup

- (void)commonInit {
  [self createInkView];
  [self createTextContentViews];
}

- (void)createInkView {
  self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];
}

- (void)createTextContentViews {
  self.textContainer = [[UIView alloc] init];
  [self.contentView addSubview:self.textContainer];

  self.overlineLabel = [[UILabel alloc] init];
  self.overlineLabel.textColor = [UIColor blackColor];
  [self.textContainer addSubview:self.overlineLabel];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = [UIColor blackColor];
  [self.textContainer addSubview:self.titleLabel];

  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.textColor = [UIColor blackColor];
  [self.textContainer addSubview:self.detailLabel];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
}

#pragma mark UICollectionViewCell Overrides

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [_inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [_inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:
    (UICollectionViewLayoutAttributes *)layoutAttributes {
  UICollectionViewLayoutAttributes *attributes =
      [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  [self assignFrames];
  CGPoint origin = attributes.frame.origin;
  CGFloat cellHeight = [self calculateHeight];
  CGRect frame = CGRectMake(origin.x, origin.y, self.cellWidth, cellHeight);
  attributes.frame = frame;
  return attributes;
}

-(void)prepareForReuse {
  [super prepareForReuse];
  self.overlineLabel.text = nil;
  self.titleLabel.text = nil;
  self.detailLabel.text = nil;
  self.leadingView = nil;
  self.trailingView = nil;
  self.automaticallySetTextOffset = NO;
  self.centerLeadingViewVertically = NO;
  self.centerTrailingViewVertically = NO;
  self.typographyScheme = self.defaultTypographyScheme;
}
#pragma mark Accessors

- (void)setLeadingView:(UIView *)leadingView {
  if (leadingView == _leadingView) {
    return;
  }
  [_leadingView removeFromSuperview];
  _leadingView = leadingView;
  [self addSubview:_leadingView];
}

- (void)setTrailingView:(UIView *)trailingView {
  if (trailingView == _trailingView) {
    return;
  }
  [_trailingView removeFromSuperview];
  _trailingView = trailingView;
  [self addSubview:_trailingView];
}

#pragma mark Layout

- (void)assignFrames {
  [self assignLeadingViewFrame];
  [self assignTrailingViewFrame];
  [self assignTextContainerFrame];
}

- (void)assignLeadingViewFrame {
  CGSize size = self.leadingView.bounds.size;
  CGFloat leadingPadding = 0;
  CGFloat topPadding = 0;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    leadingPadding = kDefaultMarginLeading;
    topPadding = kDefaultMarginTop;
  }
  CGPoint origin = CGPointMake(leadingPadding, topPadding);
  CGRect rect = CGRectZero;
  rect.origin = origin;
  rect.size = size;
  self.leadingView.frame = rect;
}

- (void)assignTrailingViewFrame {
  CGSize size = self.trailingView.bounds.size;
  CGFloat trailingPadding = 0;
  CGFloat topPadding = 0;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    trailingPadding = kDefaultMarginTrailing;
    topPadding = kDefaultMarginTop;
  }
  CGFloat originX = self.cellWidth - trailingPadding - size.width;
  CGPoint origin = CGPointMake(originX, topPadding);
  CGRect rect = CGRectZero;
  rect.origin = origin;
  rect.size = size;
  self.trailingView.frame = rect;
}

- (void)assignTextContainerFrame {
  if (![self containsText]) {
    self.textContainer.frame = CGRectZero;
  }

  CGFloat padding = kDefaultMarginTop;
  CGFloat leadingContainerMaxX = self.leadingView ? CGRectGetMaxX(self.leadingView.frame) : 0;
  CGFloat textContainerMinX = leadingContainerMaxX + kDefaultMarginLeading;
  CGFloat trailingViewMinX = self.trailingView ? CGRectGetMinX(self.trailingView.frame) :
      self.cellWidth;
  CGFloat textContainerMaxX = trailingViewMinX - kDefaultMarginTrailing;
  CGFloat textContainerMinY = padding;
  CGFloat textContainerWidth = textContainerMaxX - textContainerMinX;
  CGFloat textContainerHeight = 0;

  CGFloat labelMinX = 0;
  CGFloat labelMinY = 0;

  CGSize fittingSize = CGSizeMake(textContainerWidth, 50000);
  CGSize overlineSize = [self.overlineLabel sizeThatFits:fittingSize];
  if (overlineSize.width > textContainerWidth) {
    overlineSize.width = textContainerWidth;
  }
  CGPoint overlineOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect overlineFrame = CGRectZero;
  overlineFrame.origin = overlineOrigin;
  overlineFrame.size = overlineSize;
  self.overlineLabel.frame = overlineFrame;

  labelMinY = CGRectGetMaxY(overlineFrame) + kDefaultVerticalLabelPadding;

  CGSize titleSize = [self.titleLabel sizeThatFits:fittingSize];
  if (titleSize.width > textContainerWidth) {
    titleSize.width = textContainerWidth;
  }
  CGPoint titleOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect titleFrame = CGRectZero;
  titleFrame.origin = titleOrigin;
  titleFrame.size = titleSize;
  self.titleLabel.frame = titleFrame;

  labelMinY = CGRectGetMaxY(titleFrame) + kDefaultVerticalLabelPadding;

  CGSize detailSize = [self.detailLabel sizeThatFits:fittingSize];
  if (detailSize.width > textContainerWidth) {
    detailSize.width = textContainerWidth;
  }
  CGPoint detailOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect detailFrame = CGRectZero;
  detailFrame.origin = detailOrigin;
  detailFrame.size = detailSize;
  self.detailLabel.frame = detailFrame;

  textContainerHeight = CGRectGetMaxY(self.detailLabel.frame) + kDefaultMarginBottom;

  CGRect textContainerFrame = CGRectZero;
  CGPoint textContainerOrigin = CGPointMake(textContainerMinX, textContainerMinY);
  CGSize textContainerSize = CGSizeMake(textContainerWidth, textContainerHeight);
  textContainerFrame.origin = textContainerOrigin;
  textContainerFrame.size = textContainerSize;
  self.textContainer.frame = textContainerFrame;
}

- (CGFloat)calculateHeight {
  CGFloat maxHeight = 0;
  if (self.leadingView && CGRectGetMaxY(self.leadingView.frame) > maxHeight) {
    maxHeight = CGRectGetMaxY(self.leadingView.frame);
  }
  if (self.trailingView && CGRectGetMaxY(self.trailingView.frame) > maxHeight) {
    maxHeight = CGRectGetMaxY(self.trailingView.frame);
  }
  if (self.textContainer && CGRectGetMaxY(self.textContainer.frame) > maxHeight) {
    maxHeight = CGRectGetMaxY(self.textContainer.frame);
  }
  return maxHeight;
}

#pragma mark Misc Private Methods

- (BOOL)containsText {
  return
  self.overlineLabel.text.length > 0 ||
  self.titleLabel.text.length > 0 ||
  self.detailLabel.text.length > 0;
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
  [self assignFrames];
}

@end
