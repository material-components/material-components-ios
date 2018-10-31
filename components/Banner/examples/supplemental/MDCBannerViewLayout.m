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

#import "MDCBannerViewLayout.h"

#import "MDCBannerParams.h"
#import "MDCBannerView.h"

@interface MDCBannerViewLayout ()

@property(nonatomic, strong) NSMutableArray *internalButtonFrames;
@property(nonatomic, strong) UIView *imageContainer;
@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, assign) CGSize sizeToFit;

@property(nonatomic, assign) CGSize frameSize;
@property(nonatomic, assign) MDCBannerViewLayoutMode style;

@end

@implementation MDCBannerViewLayout

- (instancetype)initWithSizeToFit:(CGSize)sizeToFit {
  self = [super init];
  if (self) {
    _sizeToFit = sizeToFit;
    _internalButtonFrames = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)reloadData {
  [self reloadViewModelsFromDataSource:self.dataSource];
  [self updateLayoutStyleAndFrameSize];
  [self updateLayoutWithStyle:self.style];
}

- (void)reloadViewModelsFromDataSource:(id<MDCBannerViewLayoutDataSource>)dataSource {
  if (!dataSource) {
    return;
  }
  NSInteger numberOfButtons = [self.dataSource numberOfButtonsForBannerViewLayout:self];
  UIView *imageContainer = nil;
  if ([self.dataSource respondsToSelector:@selector(imageContainerForBannerViewLayout:)]) {
    imageContainer = [self.dataSource imageContainerForBannerViewLayout:self];
  }
  UILabel *textLabel = [self.dataSource textLabelForBannerViewLayout:self];

  self.imageContainer = [[UIView alloc] initWithFrame:imageContainer.frame];
  self.textLabel = [[UILabel alloc] initWithFrame:textLabel.frame];
  self.textLabel.text = textLabel.text;
  self.textLabel.font = textLabel.font;
  self.textLabel.numberOfLines = textLabel.numberOfLines;
  [self.internalButtonFrames removeAllObjects];
  for (NSInteger index = 0; index < numberOfButtons; ++index) {
    UIButton *button = [self.dataSource bannerViewLayout:self buttonAtIndex:index];
    [self.internalButtonFrames addObject:[NSValue valueWithCGRect:button.frame]];
  }
}

- (void)updateLayoutStyleAndFrameSize {
  // TODO: add cache support to partical views for performance

  CGFloat remainingWidth = self.sizeToFit.width;
  remainingWidth -= (kLeadingPadding + kTrailingPadding);
  remainingWidth -= [self buttonsWidthSum];
  remainingWidth -= kHorizontalSpaceBetweenTextLabelAndButton;
  if (self.imageContainer) {
    remainingWidth -= self.imageContainer.frame.size.width;
    remainingWidth -= kSpaceBetweenIconImageAndTextLabel;
  }
  CGSize textLabelSize = CGSizeZero;
  if ([self isAbleToFitTextLabelWithWidthLimit:remainingWidth]) {
    CGFloat singleLineStyleFrameHeight = kTopPaddingSmall + kBottomPadding;
    NSMutableArray *singleLineViews = [[NSMutableArray alloc] init];
    [singleLineViews addObject:self.textLabel];
    if (self.imageContainer) {
      [singleLineViews addObject:self.imageContainer];
    }
    singleLineStyleFrameHeight +=
        MAX([self maximumHeightAmongViews:singleLineViews], [self maximumButtonHeight]);
    self.style = MDCBannerViewLayoutSingleLineStyle;
    textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
    self.frameSize = CGSizeMake(self.sizeToFit.width, singleLineStyleFrameHeight);
  } else {
    CGFloat multiLineStyleFrameHeight = kTopPaddingLarge + kBottomPadding;
    // Handle Buttons
    if ([self buttonsWidthSum] + kLeadingPadding + kTrailingPadding > self.sizeToFit.width) {
      self.style = MDCBannerViewLayoutMultiLineStackedButtonStyle;
      multiLineStyleFrameHeight += [self buttonsHeightSum];
    } else {
      self.style = MDCBannerViewLayoutMultiLineAlignedButtonStyle;
      multiLineStyleFrameHeight += [self maximumButtonHeight];
    }
    // Handle Image and Text
    remainingWidth = self.sizeToFit.width - kLeadingPadding - kTrailingPadding;
    if (self.imageContainer) {
      remainingWidth -= (self.imageContainer.frame.size.width + kSpaceBetweenIconImageAndTextLabel);
      textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
      multiLineStyleFrameHeight +=
          MAX(textLabelSize.height + kVerticalSpaceBetweenButtonAndTextLabelLarge,
              76.0f);  // TODO: remove hard coded value here (Image side + padding)
    } else {
      multiLineStyleFrameHeight += kVerticalSpaceBetweenButtonAndTextLabelSmall;
      textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(remainingWidth, CGFLOAT_MAX)];
      multiLineStyleFrameHeight += textLabelSize.height;
    }
    self.frameSize = CGSizeMake(self.sizeToFit.width, multiLineStyleFrameHeight);
  }
  self.textLabel.frame = CGRectMake(0.0f, 0.0f, remainingWidth, textLabelSize.height);
}

- (void)updateLayoutWithStyle:(MDCBannerViewLayoutMode)layoutMode {
  CGSize frameSize = self.frameSize;
  switch (layoutMode) {
    case MDCBannerViewLayoutSingleLineStyle: {
      CGFloat currentXAxis = 0.0f;
      currentXAxis += kLeadingPadding;
      if (self.imageContainer) {
        CGRect originalIconimageContainer = self.imageContainer.frame;
        self.imageContainer.frame = CGRectMake(
            currentXAxis, frameSize.height / 2 - originalIconimageContainer.size.height / 2,
            originalIconimageContainer.size.width, originalIconimageContainer.size.height);
        currentXAxis += self.imageContainer.frame.size.width;
        currentXAxis += kSpaceBetweenIconImageAndTextLabel;
      }
      CGRect originalTextLabelFrame = self.textLabel.frame;
      self.textLabel.frame =
          CGRectMake(currentXAxis, frameSize.height / 2 - originalTextLabelFrame.size.height / 2,
                     originalTextLabelFrame.size.width, originalTextLabelFrame.size.height);
      currentXAxis += self.textLabelFrame.size.width;
      for (NSUInteger index = 0; index < self.internalButtonFrames.count; ++index) {
        currentXAxis += kButtonHorizontalIntervalSpace;
        CGRect buttonFrame = [self.internalButtonFrames[index] CGRectValue];
        CGRect newButtonFrame =
            CGRectMake(currentXAxis, frameSize.height / 2 - buttonFrame.size.height / 2,
                       buttonFrame.size.width, buttonFrame.size.height);
        self.internalButtonFrames[index] = [NSValue valueWithCGRect:newButtonFrame];
        currentXAxis += newButtonFrame.size.width;
      }
      break;
    }
    case MDCBannerViewLayoutMultiLineAlignedButtonStyle: {
      CGFloat currentXAxis = 0.0f;
      CGFloat currentYAxis = 0.0f;
      currentYAxis += kTopPaddingLarge;
      currentXAxis += kLeadingPadding;
      if (self.imageContainer) {
        CGSize originalImageSize = self.imageContainerFrame.size;
        self.imageContainer.frame = CGRectMake(currentXAxis, currentYAxis, originalImageSize.width,
                                               originalImageSize.height);
        currentXAxis += self.imageContainerFrame.size.width;
        currentXAxis += kSpaceBetweenIconImageAndTextLabel;
      }
      CGSize originalTextLabelSize = self.textLabelFrame.size;
      self.textLabel.frame = CGRectMake(currentXAxis, currentYAxis, originalTextLabelSize.width,
                                        originalTextLabelSize.height);
      currentXAxis = self.frameSize.width;
      currentYAxis = self.frameSize.height;
      currentXAxis -= kTrailingPadding;
      currentYAxis -= kBottomPadding;
      CGFloat buttonMaximumHeight = [self maximumButtonHeight];
      CGFloat currentYAxisCenter = currentYAxis - buttonMaximumHeight / 2;
      NSUInteger buttonCount = self.internalButtonFrames.count;
      for (NSUInteger index = 0; index <= buttonCount - 1; ++index) {
        CGRect buttonFrame = [self.internalButtonFrames[buttonCount - index - 1] CGRectValue];
        currentXAxis -= buttonFrame.size.width;
        CGRect newButtonFrame =
            CGRectMake(currentXAxis, currentYAxisCenter - buttonFrame.size.height / 2,
                       buttonFrame.size.width, buttonFrame.size.height);
        self.internalButtonFrames[buttonCount - index - 1] =
            [NSValue valueWithCGRect:newButtonFrame];
        currentXAxis -= kButtonHorizontalIntervalSpace;
      }
      break;
    }
    case MDCBannerViewLayoutMultiLineStackedButtonStyle: {
      CGFloat currentXAxis = 0.0f;
      CGFloat currentYAxis = 0.0f;
      currentYAxis += kTopPaddingLarge;
      currentXAxis += kLeadingPadding;
      if (self.imageContainer) {
        CGSize originalIconImageSize = self.imageContainerFrame.size;
        self.imageContainer.frame = CGRectMake(
            currentXAxis, currentYAxis, originalIconImageSize.width, originalIconImageSize.height);
        currentXAxis += self.imageContainerFrame.size.width;
        currentXAxis += kSpaceBetweenIconImageAndTextLabel;
      }
      CGSize originalTextLabelSize = self.textLabelFrame.size;
      self.textLabel.frame = CGRectMake(currentXAxis, currentYAxis, originalTextLabelSize.width,
                                        originalTextLabelSize.height);
      currentXAxis = self.frameSize.width;
      currentYAxis = self.frameSize.height;
      currentXAxis -= kTrailingPadding;
      currentYAxis -= kBottomPadding;
      NSUInteger buttonCount = self.internalButtonFrames.count;
      for (NSUInteger index = 0; index <= buttonCount - 1; ++index) {
        CGRect buttonFrame = [self.internalButtonFrames[buttonCount - index - 1] CGRectValue];
        currentYAxis -= buttonFrame.size.height;
        CGRect newButtonFrame = CGRectMake(currentXAxis - buttonFrame.size.width, currentYAxis,
                                           buttonFrame.size.width, buttonFrame.size.height);
        self.internalButtonFrames[buttonCount - index - 1] =
            [NSValue valueWithCGRect:newButtonFrame];
        currentYAxis -= kButtonVerticalIntervalSpace;
      }
      break;
    }
  }
}

#pragma mark - Internal Layout Value Helpers

- (CGFloat)buttonsWidthSum {
  CGFloat buttonsWidthSum = 0.0f;
  for (NSValue *buttonFrame in self.internalButtonFrames) {
    buttonsWidthSum += [buttonFrame CGRectValue].size.width;
  }
  if (self.internalButtonFrames.count > 0) {
    buttonsWidthSum += (self.internalButtonFrames.count - 1) * kButtonHorizontalIntervalSpace;
  }
  return buttonsWidthSum;
}

- (CGFloat)buttonsHeightSum {
  CGFloat buttonsHeightSum = 0.0f;
  for (NSValue *buttonFrame in self.internalButtonFrames) {
    buttonsHeightSum += [buttonFrame CGRectValue].size.height;
  }
  if (self.internalButtonFrames.count > 0) {
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
    maximumHeight = MAX(maximumHeight, view.frame.size.height);
  }
  return maximumHeight;
}

- (CGFloat)maximumButtonHeight {
  CGFloat maximumHeight = 0.0f;
  for (NSValue *buttonFrame in self.internalButtonFrames) {
    maximumHeight = MAX(maximumHeight, [buttonFrame CGRectValue].size.height);
  }
  return maximumHeight;
}

#pragma mark - APIs

- (NSArray *)buttonFrames {
  return [self.internalButtonFrames copy];
}

- (CGRect)imageContainerFrame {
  return self.imageContainer.frame;
}

- (CGRect)textLabelFrame {
  return self.textLabel.frame;
}

@end
