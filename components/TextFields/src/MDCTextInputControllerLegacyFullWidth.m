// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextInputControllerLegacyFullWidth.h"

#import "MDCIntrinsicHeightTextView.h"
#import "MDCMultilineTextField.h"
#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"
#import "private/MDCTextInputArt.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

static const CGFloat MDCTextInputControllerLegacyFullWidthClearButtonImageSquareWidthHeight = 24.f;

@interface MDCTextInputControllerFullWidth ()
- (void)setupInput;
@end
@implementation MDCTextInputControllerLegacyFullWidth


- (void)setupInput {
  [super setupInput];
  if (!self.textInput) {
    return;
  }

  [self setupClearButton];
}

- (void)setupClearButton {
  UIImage *image = [self
      drawnClearButtonImage:[UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]]];
  [self.textInput.clearButton setImage:image forState:UIControlStateNormal];
}

#pragma mark - Clear Button Customization

- (UIImage *)drawnClearButtonImage:(UIColor *)color {
  CGSize clearButtonSize =
      CGSizeMake(MDCTextInputControllerLegacyFullWidthClearButtonImageSquareWidthHeight,
                 MDCTextInputControllerLegacyFullWidthClearButtonImageSquareWidthHeight);

  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, clearButtonSize.width * scale, clearButtonSize.height * scale);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [color setFill];

  [MDCPathForClearButtonLegacyImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

@end
