// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>

#import "MDCChipViewDeleteButton.h"

static const CGFloat MDCChipFieldClearButtonSquareWidthHeight = 24.0f;
static const CGFloat MDCChipFieldClearImageSquareWidthHeight = 18.0f;

@implementation MDCChipViewDeleteButton

- (instancetype)init {
  CGFloat clearButtonWidthAndHeight = MDCChipFieldClearButtonSquareWidthHeight;
  CGRect frame = CGRectMake(0, 0, clearButtonWidthAndHeight, clearButtonWidthAndHeight);
  return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCChipViewDeleteButtonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCChipViewDeleteButtonInit];
  }
  return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(MDCChipFieldClearButtonSquareWidthHeight,
                    MDCChipFieldClearButtonSquareWidthHeight);
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(MDCChipFieldClearButtonSquareWidthHeight,
                    MDCChipFieldClearButtonSquareWidthHeight);
}

- (void)commonMDCChipViewDeleteButtonInit {
  CGFloat clearButtonWidthAndHeight = MDCChipFieldClearButtonSquareWidthHeight;
  self.frame = CGRectMake(0, 0, clearButtonWidthAndHeight, clearButtonWidthAndHeight);
  self.layer.cornerRadius = clearButtonWidthAndHeight / 2;
  UIImageView *clearImageView = [[UIImageView alloc] initWithImage:[self drawClearButton]];
  CGFloat widthAndHeight = MDCChipFieldClearImageSquareWidthHeight;
  CGFloat padding =
      (MDCChipFieldClearButtonSquareWidthHeight - MDCChipFieldClearImageSquareWidthHeight) / 2;
  clearImageView.frame = CGRectMake(padding, padding, widthAndHeight, widthAndHeight);
  self.tintColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6];
  [self addSubview:clearImageView];
}

- (UIImage *)drawClearButton {
  CGSize clearButtonSize =
      CGSizeMake(MDCChipFieldClearImageSquareWidthHeight, MDCChipFieldClearImageSquareWidthHeight);

  CGRect bounds = CGRectMake(0, 0, clearButtonSize.width, clearButtonSize.height);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0);
  [UIColor.grayColor setFill];
  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

static inline UIBezierPath *MDCPathForClearButtonImageFrame(CGRect frame) {
  // This code was generated very long ago and then copied over from MDCChipField .

  CGRect innerBounds = CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2,
                                  floor((frame.size.width - 2) * (CGFloat)0.90909 + (CGFloat)0.5),
                                  floor((frame.size.height - 2) * (CGFloat)0.90909 + (CGFloat)0.5));
  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) +
                                             (CGFloat)0.50000 * innerBounds.size.width,
                                         CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path closePath];
  [ic_clear_path
      moveToPoint:CGPointMake(
                      CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                      CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.45367 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.45367 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.54800 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.54800 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

+ (CGFloat)imageSideLength {
  return MDCChipFieldClearImageSquareWidthHeight;
}

@end
