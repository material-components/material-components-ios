// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDCContainedInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDCContainedInputViewLabelAnimator : NSObject
- (UIFont *_Nonnull)floatingFontWithFont:(nonnull UIFont *)font
                         containerStyler:(nonnull id<MDCContainedInputViewStyler>)containerStyler;
- (void)layOutPlaceholderLabel:(nonnull UILabel *)placeholderLabel
              placeholderFrame:(CGRect)placeholderFrame
          isPlaceholderVisible:(BOOL)isPlaceholderVisible;
- (void)layOutFloatingLabel:(nonnull UILabel *)floatingLabel
                      state:(MDCContainedInputViewFloatingLabelState)floatingLabelState
                normalFrame:(CGRect)normalFrame
              floatingFrame:(CGRect)floatingFrame
                 normalFont:(nonnull UIFont *)normalFont
               floatingFont:(nonnull UIFont *)floatingFont;
@end

NS_ASSUME_NONNULL_END
