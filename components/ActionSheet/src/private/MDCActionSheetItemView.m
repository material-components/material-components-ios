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

#import "MDCActionSheetItemView.h"
#import "MaterialTypography.h"

static const CGFloat kTitleLabelAlpha = 0.87f;
static const CGFloat kMessageLabelAlpha = 0.6f;
static const CGFloat kImageAlpha = 0.54f;
static const CGFloat kCellLabelAlpha = 0.87f;
static const CGFloat kStandardPadding = 16.f;
static const CGFloat kTitleOnlyPadding = 18.f;
static const CGFloat kMessageOnlyPadding = 23.f;
static const CGFloat kLeadingPadding = 16.f;
static const CGFloat kTrailingPadding = 16.f;
static const CGFloat kMiddlePadding = 8.f;
static const CGFloat kActionItemTitleVerticalPadding = 18.f;

@interface MDCActionSheetItemView ()
@end


@implementation MDCActionSheetItemView {
  MDCActionSheetAction *_itemAction;
  UILabel *_textLabel;
  UIImageView *_imageView;
  MDCInkTouchController *_inkTouchController;
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

- (instancetype)initWithAction:(MDCActionSheetAction *)action
               reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    _itemAction = action;
    [self commonMDCActionSheetItemViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetItemViewInit {
  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.accessibilityTraits = UIAccessibilityTraitButton;
  _textLabel = [[UILabel alloc] init];
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.hyphenationFactor = 1.f;
  NSDictionary<NSAttributedStringKey, id> *dict = @{ NSParagraphStyleAttributeName : paragraphStyle };
  NSMutableAttributedString *attrString =
      [[NSMutableAttributedString alloc] initWithString:_itemAction.title attributes:dict];
  _textLabel.attributedText = attrString;
  [_textLabel sizeToFit];
  [self.contentView addSubview:_textLabel];
  _textLabel.numberOfLines = 0;
  [_textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    _textLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  } else {
    _textLabel.font = [MDCTypography subheadFont];
  }
  _textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _textLabel.alpha = kCellLabelAlpha;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:kActionItemTitleVerticalPadding].active = YES;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-kActionItemTitleVerticalPadding].active = YES;
  CGFloat leadingConstant;
  if (_itemAction.image == nil) {
    leadingConstant = 16.f;
  } else {
    leadingConstant = 72.f;
  }
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:leadingConstant].active = YES;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:-16.f].active = YES;
  if (!_inkTouchController) {
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];
  }
  if (_itemAction.image == nil) {
    return;
  }
  _imageView = [[UIImageView alloc] init];
  [self.contentView addSubview:_imageView];
  [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  _imageView.image = _itemAction.image;
  _imageView.alpha = kImageAlpha;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:24.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:24.f].active = YES;
}

- (void)setAction:(MDCActionSheetAction *)action {
  if (_itemAction != action) {
    _itemAction = [action copy];
    [self setNeedsLayout];
  }
}

- (MDCActionSheetAction *)action {
  return _itemAction;
}

- (void)setActionsFont:(UIFont *)actionsFont {
  _actionsFont = actionsFont;
  [self updateTitleFont];
}

+ (UIFont *)titleFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  }
  return [MDCTypography subheadFont];
}

- (void)updateTitleFont {
  UIFont *titleFont = _actionsFont ?: [[self class] titleFontDefault];
  if (_mdc_adjustsFontForContentSizeCategory) {
    _textLabel.font =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    _textLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateTitleFont];
}

@end

@interface MDCActionSheetHeaderView ()

@property(nonatomic, nonnull, strong) UIScrollView *scrollView;

@end

@implementation MDCActionSheetHeaderView {
  UILabel *titleLabel;
  UILabel *messageLabel;
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

- (instancetype)initWithTitle:(NSString *)title {
  return [[MDCActionSheetHeaderView alloc] initWithTitle:title message:nil];
}

- (nonnull instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
  self = [super init];
  if (self) {
    self.title = title;
    self.message = message;
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

-(void)commonMDCActionSheetHeaderViewInit {
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  [self addSubview:self.scrollView];
  [self.scrollView addSubview:titleLabel];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  } else {
    titleLabel.font = [MDCTypography subheadFont];
  }
  titleLabel.numberOfLines = 0;
  titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;

  [self.scrollView addSubview:messageLabel];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    messageLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
  } else {
    messageLabel.font = [MDCTypography body1Font];
  }
  messageLabel.numberOfLines = 2;
  messageLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  messageLabel.alpha = kMessageLabelAlpha;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.message == nil || [self.message isEqualToString:@""]) {
    titleLabel.alpha = kMessageLabelAlpha;
  } else {
    titleLabel.alpha = kTitleLabelAlpha;
  }
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = CGRectGetWidth(self.bounds);

  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  self.scrollView.contentSize = contentSize;

  boundsSize.width = boundsSize.width - kLeadingPadding - kTrailingPadding;
  CGSize titleSize = [titleLabel sizeThatFits:boundsSize];
  titleSize.width = boundsSize.width;
  CGSize messageSize = [messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;
  boundsSize.width = boundsSize.width + kLeadingPadding + kTrailingPadding;

  CGRect titleFrame = CGRectMake(kLeadingPadding, kStandardPadding,
                                 titleSize.width, titleSize.height);
  CGRect messageFrame = CGRectMake(kLeadingPadding, CGRectGetMaxY(titleFrame) + kMiddlePadding,
                                   messageSize.width, messageSize.height);

  titleLabel.frame = titleFrame;
  messageLabel.frame = messageFrame;

  CGRect scrollViewRect = CGRectZero;
  scrollViewRect.size = self.scrollView.contentSize;
  /**

   Check weither scroll views are too tall or not

   */
  self.scrollView.frame = scrollViewRect;
  CGRect originalFrame = self.frame;
  originalFrame.size.height = scrollViewRect.size.height;
  self.frame = originalFrame;
}

- (void)setTitle:(NSString *)title {
  titleLabel.text = title;
  [self setNeedsLayout];
}

- (NSString *)title {
  return titleLabel.text;
}

- (void)setMessage:(NSString *)message {
  messageLabel.text = message;
  [self setNeedsLayout];
}

- (NSString *)message {
  return messageLabel.text;
}

- (void)setTitleFont:(UIFont *)titleFont {
  _titleFont = titleFont;
  [self updateTitleFont];
}

- (void)setMessageFont:(UIFont *)messageFont {
  _messageFont = messageFont;
  [self updateMessageFont];
}

+ (UIFont *)titleFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  }
  return [MDCTypography subheadFont];
}

+ (UIFont *)messageFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleBody1];
  }
  return [MDCTypography body1Font];
}

- (void)updateFonts {
  [self updateTitleFont];
  [self updateMessageFont];
}

- (void)updateTitleFont {
  UIFont *titleFont = _titleFont ?: [[self class] titleFontDefault];
  if (_mdc_adjustsFontForContentSizeCategory) {
    titleLabel.font =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    titleLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (void)updateMessageFont {
  UIFont *messageFont = _messageFont ?: [[self class] messageFontDefault];
  if (_mdc_adjustsFontForContentSizeCategory) {
    messageLabel.font =
        [messageFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                                  scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    messageLabel.font = messageFont;
  }
  
  [self setNeedsLayout];
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateFonts];
}

- (CGSize)calculateContentSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - kLeadingPadding - kTrailingPadding;

  CGSize titleSize = [titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [messageLabel sizeThatFits:boundsSize];

  CGFloat contentWidth = MAX(titleSize.width, messageSize.width);


  contentWidth = contentWidth + kLeadingPadding + kTrailingPadding;

  CGFloat contentHeight;
  BOOL messageCheck = (self.message == nil) || ([self.message isEqualToString:@""]);
  BOOL titleCheck = (self.title == nil) || ([self.title  isEqualToString:@""]);
  if (titleCheck && messageCheck) {
    contentHeight = 0;
  } else if (titleCheck) {
    contentHeight = messageSize.height + (kMessageOnlyPadding * 2);
  } else if (messageCheck) {
    contentHeight = titleSize.height + (kTitleOnlyPadding * 2);
  } else {
    contentHeight = titleSize.height + messageSize.height +
        (kStandardPadding * 2) + kMiddlePadding;
  }
  CGSize contentSize;
  contentSize.width = (CGFloat)ceil(contentWidth);
  contentSize.height = (CGFloat)ceil(contentHeight);
  return contentSize;
}

@end
