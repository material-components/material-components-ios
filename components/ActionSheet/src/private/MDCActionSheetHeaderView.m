// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@implementation MDCActionSheetHeaderView

@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:_titleLabel];
    _titleLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;

    [self addSubview:_messageLabel];
    _messageLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleBody1];
    _messageLabel.numberOfLines = 2;
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:MessageLabelAlpha];
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize size = CGRectInfinite.size;
  size.width = CGRectGetWidth(self.bounds);
  CGRect labelFrame = [self frameWithSafeAreaInsets:self.bounds];
  labelFrame = CGRectStandardize(labelFrame);
  labelFrame.size.width = labelFrame.size.width - LeadingPadding - TrailingPadding;
  CGSize titleSize = [self.titleLabel sizeThatFits:labelFrame.size];
  CGSize messageSize = [self.messageLabel sizeThatFits:labelFrame.size];
  CGRect titleFrame = CGRectMake(LeadingPadding + labelFrame.origin.x, TopStandardPadding,
                                 labelFrame.size.width, titleSize.height);
  CGRect messageFrame = CGRectMake(LeadingPadding + labelFrame.origin.x,
                                   CGRectGetMaxY(titleFrame) + MiddlePadding,
                                   labelFrame.size.width, messageSize.height);
  self.titleLabel.frame = titleFrame;
  self.messageLabel.frame = messageFrame;
}

- (CGSize)sizeThatFits:(CGSize)size {
  size.width = size.width - LeadingPadding - TrailingPadding;
  CGSize titleSize = [self.titleLabel sizeThatFits:size];
  CGSize messageSize = [self.messageLabel sizeThatFits:size];
  CGFloat contentHeight;
  BOOL messageExist = (self.message) && (![self.message isEqualToString:@""]);
  BOOL titleExist = (self.title) && (![self.title isEqualToString:@""]);
  if (titleExist && messageExist) {
    contentHeight = titleSize.height + messageSize.height +
        (TopStandardPadding * 2) + MiddlePadding;
  } else if (messageExist) {
    contentHeight = messageSize.height + (MessageOnlyPadding * 2);
  } else if (titleExist) {
    contentHeight = titleSize.height + (TitleOnlyPadding * 2);
  } else {
    contentHeight = 0;
  }
  CGSize contentSize;
  contentSize.width = MDCCeil(size.width);
  contentSize.height = MDCCeil(contentHeight);
  return contentSize;
}

- (CGRect)frameWithSafeAreaInsets:(CGRect)frame {
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    safeAreaInsets = self.safeAreaInsets;
    safeAreaInsets.top = 0.f;
  }
#endif
  return UIEdgeInsetsInsetRect(frame, safeAreaInsets);
}

- (void)setTitle:(NSString *)title {
  self.titleLabel.text = title;
  [self setNeedsLayout];
}

- (NSString *)title {
  return self.titleLabel.text;
}

- (void)setMessage:(NSString *)message {
  self.messageLabel.text = message;
  // If message is empty or nil then the title label's alpha value should be lighter, if there is both
  // then the title label's alpha should be darker.
  if (self.message && ![self.message isEqualToString:@""]) {
    _titleLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:TitleLabelAlpha];
  } else {
    _titleLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:MessageLabelAlpha];
  }
  [self setNeedsLayout];
}

- (NSString *)message {
  return self.messageLabel.text;
}

- (void)setTitleFont:(UIFont *)titleFont {
  self.titleLabel.font = titleFont;
  [self updateTitleFont];
}

- (UIFont *)titleFont {
  return self.titleLabel.font;
}

- (void)setMessageFont:(UIFont *)messageFont {
  self.messageLabel.font = messageFont;
  [self updateMessageFont];
}

- (UIFont *)messageFont {
  return self.messageLabel.font;
}

- (void)updateFonts {
  [self updateTitleFont];
  [self updateMessageFont];
}

- (void)updateTitleFont {
  UIFont *titleFont = self.titleFont ?:
      [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    self.titleLabel.font =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    self.titleLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (void)updateMessageFont {
  UIFont *messageFont = self.messageFont ?:
      [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleBody1];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    self.messageLabel.font =
        [messageFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                                  scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    self.messageLabel.font = messageFont;
  }

  [self setNeedsLayout];
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  if (_mdc_adjustsFontForContentSizeCategory) {
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

- (void)setTitleTextColor:(UIColor *)titleTextColor {
  _titleTextColor = titleTextColor;
  self.titleLabel.textColor = titleTextColor;
}

- (void)setMessageTextColor:(UIColor *)messageTextColor {
  _messageTextColor = messageTextColor;
  self.messageLabel.textColor = messageTextColor;
}

@end
