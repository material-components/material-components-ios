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

#import <UIKit/UIKit.h>

#import "MDCBannerViewConstants.h"
#import "MDCBannerViewLayout.h"

@interface MDCBannerViewLayout ()

@property(nonatomic, strong) NSMutableArray *internalButtonFrames;
@property(nonatomic, strong) UIView *iconContainer;
@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, assign) CGFloat preferredWidth;

@property(nonatomic, readwrite, assign) MDCBannerViewLayoutStyle style;
@property(nonatomic, readwrite, assign) CGSize size;

@end

@implementation MDCBannerViewLayout

- (instancetype)initWithPreferredWidth:(CGFloat)preferredWidth
                             textLabel:(UILabel *)textLabel
                         iconContainer:(UIView *)iconContainer
                               buttons:(NSArray<__kindof UIButton *> *)buttons {
  self = [super init];
  if (self) {
    _preferredWidth = preferredWidth;
    _internalButtonFrames = [[NSMutableArray alloc] init];

    _iconContainer = [[UIView alloc] initWithFrame:iconContainer.frame];
    _textLabel = [[UILabel alloc] initWithFrame:textLabel.frame];
    _textLabel.text = textLabel.text;
    _textLabel.font = textLabel.font;
    _textLabel.numberOfLines = textLabel.numberOfLines;

    for (NSUInteger index = 0; index < buttons.count; ++index) {
      UIButton *button = buttons[index];
      [button sizeToFit];
      [_internalButtonFrames addObject:[NSValue valueWithCGRect:button.frame]];
    }
    [self layout];
  }
  return self;
}

- (void)layout {
  CGSize sizeToFit = CGSizeMake(self.preferredWidth, 0);
  self.style = [self layoutStyleForSizeToFit:sizeToFit];
  self.size = [self frameSizeForLayoutStyle:self.style withSizeToFit:sizeToFit];
}

- (MDCBannerViewLayoutStyle)layoutStyleForSizeToFit:(CGSize)sizeToFit {
  CGFloat remainingWidth = sizeToFit.width;
  remainingWidth -= (kLeadingPadding + kTrailingPadding);
  if (self.internalButtonFrames.count == 1) {
    CGFloat buttonWidth = [self buttonsWidthSum];
    remainingWidth -= (buttonWidth + kHorizontalSpaceBetweenTextLabelAndButton);
    if (self.iconContainer) {
      remainingWidth -= self.iconContainer.frame.size.width;
      remainingWidth -= kSpaceBetweenIconImageAndTextLabel;
    }
    return [self isAbleToFitTextLabelWithWidthLimit:remainingWidth]
               ? MDCBannerViewLayoutSingleLineStyle
               : MDCBannerViewLayoutMultiLineAlignedButtonStyle;
  } else if (self.internalButtonFrames.count == 2) {
    CGFloat buttonWidth = [self buttonsWidthSum];
    remainingWidth -= buttonWidth;
    return (remainingWidth > 0) ? MDCBannerViewLayoutMultiLineAlignedButtonStyle
                                : MDCBannerViewLayoutMultiLineStackedButtonStyle;
  } else {
    return MDCBannerViewLayoutStyleInvalid;
  }
}

- (CGSize)frameSizeForLayoutStyle:(MDCBannerViewLayoutStyle)style withSizeToFit:(CGSize)sizeToFit {
  CGFloat frameHeight = 0.0f;
  switch (style) {
    case MDCBannerViewLayoutSingleLineStyle: {
      frameHeight += kTopPaddingSmall + kBottomPadding;
      [self.textLabel sizeToFit];
      NSMutableArray *singleLineViews = [[NSMutableArray alloc] init];
      [singleLineViews addObject:self.textLabel];
      if (self.iconContainer) {
        [singleLineViews addObject:self.iconContainer];
      }
      frameHeight +=
          MAX([self maximumHeightAmongViews:singleLineViews], [self maximumButtonHeight]);
      break;
    }
    case MDCBannerViewLayoutMultiLineAlignedButtonStyle: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageAndTextWithSizeToFit:sizeToFit];
      frameHeight += [self maximumButtonHeight];
      break;
    }
    case MDCBannerViewLayoutMultiLineStackedButtonStyle: {
      frameHeight += kTopPaddingLarge + kBottomPadding;
      frameHeight += [self getFrameHeightOfImageAndTextWithSizeToFit:sizeToFit];
      frameHeight += [self buttonsHeightSum];
      break;
    }
    case MDCBannerViewLayoutStyleInvalid: {
      break;
    }
  }
  return CGSizeMake(sizeToFit.width, frameHeight);
}

#pragma mark - Internal Layout Value Helpers

- (CGFloat)getFrameHeightOfImageAndTextWithSizeToFit:(CGSize)sizeToFit {
  CGFloat frameHeight = 0;
  CGFloat remainingWidth = sizeToFit.width - kLeadingPadding - kTrailingPadding;
  CGSize textLabelSize = CGSizeZero;
  if (self.iconContainer) {
    remainingWidth -= (self.iconContainer.frame.size.width + kSpaceBetweenIconImageAndTextLabel);
    textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += MAX(textLabelSize.height, CGRectGetHeight(self.iconContainer.frame));
  } else {
    textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    frameHeight += textLabelSize.height;
  }
  frameHeight += kVerticalSpaceBetweenButtonAndTextLabel;
  return frameHeight;
}

- (CGFloat)buttonsWidthSum {
  CGFloat buttonsWidthSum = 0;
  for (NSValue *buttonFrame in self.internalButtonFrames) {
    buttonsWidthSum += CGRectGetWidth([buttonFrame CGRectValue]);
  }
  if (self.internalButtonFrames.count > 1) {
    buttonsWidthSum += (self.internalButtonFrames.count - 1) * kButtonHorizontalIntervalSpace;
  }
  return buttonsWidthSum;
}

- (CGFloat)buttonsHeightSum {
  CGFloat buttonsHeightSum = 0.0f;
  for (NSValue *buttonFrame in self.internalButtonFrames) {
    buttonsHeightSum += CGRectGetHeight([buttonFrame CGRectValue]);
  }
  if (self.internalButtonFrames.count > 1) {
    buttonsHeightSum += (self.internalButtonFrames.count - 1) * kButtonVerticalIntervalSpace;
  }
  return buttonsHeightSum;
}

- (BOOL)isAbleToFitTextLabelWithWidthLimit:(CGFloat)widthLimit {
  CGSize size =
      [self.textLabel.text sizeWithAttributes:@{NSFontAttributeName : self.textLabel.font}];
  return size.width <= widthLimit;
}

- (CGFloat)maximumHeightAmongViews:(NSArray<__kindof UIView *> *)views {
  CGFloat maximumHeight = 0.0f;
  for (UIView *view in views) {
    maximumHeight = MAX(maximumHeight, CGRectGetHeight(view.frame));
  }
  return maximumHeight;
}

- (CGFloat)maximumButtonHeight {
  CGFloat maximumHeight = 0.0f;
  for (NSValue *buttonFrame in self.internalButtonFrames) {
    maximumHeight = MAX(maximumHeight, CGRectGetHeight([buttonFrame CGRectValue]));
  }
  return maximumHeight;
}

@end
