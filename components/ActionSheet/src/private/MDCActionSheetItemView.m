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
static const CGFloat kMessageLabelAlpha = 0.54f;
static const CGFloat kImageAlpha = 0.54f;
static const CGFloat kCellLabelAlpha = 0.87f;
static const CGFloat kStandardPadding = 16.f;
static const CGFloat kTitleOnlyPadding = 18.f;
static const CGFloat kMessageOnlyPadding = 23.f;
static const CGFloat kEmptyPadding = 0.f;

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
  _textLabel.text = _itemAction.title;
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
                                constant:18.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-18.f].active = YES;
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

@property(nonatomic, strong) NSLayoutConstraint *topConstraint;
@property(nonatomic, strong) NSLayoutConstraint *middleConstraint;
@property(nonatomic, strong) NSLayoutConstraint *bottomConstraint;

@end

@implementation MDCActionSheetHeaderView {
  UILabel *titleLabel;
  UILabel *messageLabel;
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

- (instancetype)initWithTitle:(NSString *)title {
  return [[MDCActionSheetHeaderView alloc] initWithTitle:title message:nil];
}

- (nonnull instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
  self = [super init];
  if (self) {
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.title = title;
    messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.message = message;
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

-(void)commonMDCActionSheetHeaderViewInit {
  [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:titleLabel];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  } else {
    titleLabel.font = [MDCTypography subheadFont];
  }
  titleLabel.numberOfLines = 0;
  if (self.message == nil || [self.message isEqualToString:@""]) {
    titleLabel.alpha = kMessageLabelAlpha;
  } else {
    titleLabel.alpha = kTitleLabelAlpha;
  }
  [NSLayoutConstraint constraintWithItem:titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:-16.f];
  _topConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                attribute:NSLayoutAttributeTop
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                attribute:NSLayoutAttributeTop
                                               multiplier:1
                                                 constant:0.f];
  _topConstraint.active = YES;

  [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:messageLabel];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    messageLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
  } else {
    messageLabel.font = [MDCTypography body1Font];
  }
  messageLabel.numberOfLines = 2;
  messageLabel.alpha = kMessageLabelAlpha;
  [NSLayoutConstraint constraintWithItem:messageLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:messageLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:-16.f].active = YES;
  _bottomConstraint = [NSLayoutConstraint constraintWithItem:messageLabel
                                                   attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1
                                                    constant:0.f];
  _bottomConstraint.active = YES;

  _middleConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                   attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:messageLabel
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1
                                                    constant:0.f];
  _middleConstraint.active = YES;
  [self layoutCheck];
}

- (void)layoutCheck {
  BOOL addTitle = (titleLabel.text != nil) && (![titleLabel.text  isEqual:@""]);
  BOOL addMessage = (messageLabel.text != nil) && (![messageLabel.text isEqual:@""]);
  if (addTitle && addMessage) {
    _topConstraint.constant = kStandardPadding;
    _middleConstraint.constant = -8.f;
    _bottomConstraint.constant = -kStandardPadding;
  } else if (addTitle) {
    _topConstraint.constant = kTitleOnlyPadding;
    _middleConstraint.constant = 0.f;
    _bottomConstraint.constant = -kTitleOnlyPadding;
  } else if (addMessage) {
    _topConstraint.constant = kMessageOnlyPadding;
    _middleConstraint.constant = 0.f;
    _bottomConstraint.constant = -kMessageOnlyPadding;
  } else {
    _topConstraint.constant = kEmptyPadding;
    _middleConstraint.constant = 0.f;
    _bottomConstraint.constant = kEmptyPadding;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self layoutCheck];
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

@end
