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

#import "MDCActionSheetHeaderView.h"

#import "MaterialMath.h"
#import "MaterialTypography.h"

static const CGFloat TitleLabelAlpha = 0.87f;
static const CGFloat MessageLabelAlpha = 0.6f;
static const CGFloat MessageOnlyPadding = 23.f;
static const CGFloat LeadingPadding = 16.f;
static const CGFloat TopStandardPadding = 16.f;
static const CGFloat TrailingPadding = 16.f;
static const CGFloat TitleOnlyPadding = 18.f;
static const CGFloat MiddlePadding = 8.f;

@interface MDCActionSheetHeaderView ()

@property(nonatomic, nonnull, strong) UIScrollView *scrollView;

@end

@implementation MDCActionSheetHeaderView {
  UILabel *_titleLabel;
  UILabel *_messageLabel;
}

@synthesize mdc_adjustsFontForContentSizeCategory;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:_titleLabel];
    _titleLabel.font = [MDCTypography subheadFont];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;

    [self.scrollView addSubview:_messageLabel];
    _messageLabel.font = [MDCTypography body1Font];
    _messageLabel.numberOfLines = 2;
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.alpha = MessageLabelAlpha;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.message == nil || [self.message  isEqualToString:@""]) {
    _titleLabel.alpha = MessageLabelAlpha;
  } else {
    _titleLabel.alpha = TitleLabelAlpha;
  }
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = [self accomodateSafeAreaInWidth:CGRectGetWidth(self.bounds)];

  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  self.scrollView.contentSize = contentSize;

  boundsSize.width = boundsSize.width - LeadingPadding - TrailingPadding;
  CGSize titleSize = [_titleLabel sizeThatFits:boundsSize];
  titleSize.width = boundsSize.width;
  CGSize messageSize = [_messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;
  boundsSize.width = boundsSize.width + LeadingPadding + TrailingPadding;

  CGRect titleFrame = CGRectMake(LeadingPadding, TopStandardPadding,
                                 titleSize.width, titleSize.height);
  CGRect messageFrame = CGRectMake(LeadingPadding, CGRectGetMaxY(titleFrame) + MiddlePadding,
                                   messageSize.width, messageSize.height);
  _titleLabel.frame = titleFrame;
  _messageLabel.frame = messageFrame;

  CGRect scrollViewRect = CGRectZero;
  scrollViewRect.size = self.scrollView.contentSize;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    scrollViewRect.origin.x = scrollViewRect.origin.x + self.safeAreaInsets.left;
  }
#endif

  self.scrollView.frame = scrollViewRect;
  CGRect originalFrame = self.frame;
  originalFrame.size.height = scrollViewRect.size.height;
  self.frame = originalFrame;
}

- (CGFloat)accomodateSafeAreaInWidth:(CGFloat)width {
  CGFloat newWidth = width;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    newWidth = newWidth - self.safeAreaInsets.left - self.safeAreaInsets.right;
  }
#endif
  return newWidth;
}

- (void)setTitle:(NSString *)title {
  _titleLabel.text = title;
  [self setNeedsLayout];
}

- (NSString *)title {
  return _titleLabel.text;
}

- (void)setMessage:(NSString *)message {
  _messageLabel.text = message;
  [self setNeedsLayout];
}

- (NSString *)message {
  return _messageLabel.text;
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
  if (self.mdc_adjustsFontForContentSizeCategory) {
    _titleLabel.font =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    _titleLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (void)updateMessageFont {
  UIFont *messageFont = _messageFont ?: [[self class] messageFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    _messageLabel.font =
        [messageFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                                  scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    _messageLabel.font = messageFont;
  }

  [self setNeedsLayout];
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  mdc_adjustsFontForContentSizeCategory = adjusts;
  if (self.mdc_adjustsFontForContentSizeCategory) {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(updateFonts)
                                                   name:UIContentSizeCategoryDidChangeNotification
                                                 object:nil];
  } else {
      [[NSNotificationCenter defaultCenter] removeObserver:self
                                                      name:UIContentSizeCategoryDidChangeNotification
                                                    object:nil];
  }
  [self updateFonts];
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = [self accomodateSafeAreaInWidth:size.width];

  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  return contentSize;
}

- (CGSize)calculateContentSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - LeadingPadding - TrailingPadding;

  CGSize titleSize = [_titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [_messageLabel sizeThatFits:boundsSize];

  CGFloat contentWidth = MAX(titleSize.width, messageSize.width);
  contentWidth = contentWidth + LeadingPadding + TrailingPadding;

  CGFloat contentHeight;
  BOOL messageCheck = (self.message == nil) || ([self.message  isEqualToString:@""]);
  BOOL titleCheck = (self.title == nil) || ([self.title  isEqualToString:@""]);
  if (titleCheck && messageCheck) {
    contentHeight = 0;
  } else if (titleCheck) {
    contentHeight = messageSize.height + (MessageOnlyPadding * 2);
  } else if (messageCheck) {
    contentHeight = titleSize.height + (TitleOnlyPadding * 2);
  } else {
    contentHeight = titleSize.height + messageSize.height +
    (TopStandardPadding * 2) + MiddlePadding;
  }
  CGSize contentSize;
  contentSize.width = MDCCeil(boundingWidth);
  contentSize.height = MDCCeil(contentHeight);
  return contentSize;
}

@end
