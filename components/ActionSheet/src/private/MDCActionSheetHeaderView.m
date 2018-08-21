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

#import "MaterialTypography.h"

static const CGFloat kTitleLabelAlpha = 0.87f;
static const CGFloat kMessageLabelAlpha = 0.6f;
static const CGFloat kMessageOnlyPadding = 23.f;
static const CGFloat kLeadingPadding = 16.f;
static const CGFloat kStandardPadding = 16.f;
static const CGFloat kTrailingPadding = 16.f;
static const CGFloat kTitleOnlyPadding = 18.f;
static const CGFloat kMiddlePadding = 8.f;

@interface MDCActionSheetHeaderView ()

@property(nonatomic, nonnull, strong) UIScrollView *scrollView;

@end

@implementation MDCActionSheetHeaderView {
  UILabel *titleLabel;
  UILabel *messageLabel;
}

@synthesize mdc_adjustsFontForContentSizeCategory;

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

- (void)commonMDCActionSheetHeaderViewInit {
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
  messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
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
  boundsSize.width = [self accomodateSafeAreaInWidth:CGRectGetWidth(self.bounds)];

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
  if (self.mdc_adjustsFontForContentSizeCategory) {
    titleLabel.font =
    [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                            scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    titleLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (void)updateMessageFont {
  UIFont *messageFont = _messageFont ?: [[self class] messageFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    messageLabel.font =
    [messageFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                              scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    messageLabel.font = messageFont;
  }

  [self setNeedsLayout];
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  mdc_adjustsFontForContentSizeCategory = adjusts;
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
  contentSize.width = (CGFloat)ceil(boundingWidth);
  contentSize.height = (CGFloat)ceil(contentHeight);
  return contentSize;
}

@end
