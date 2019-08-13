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

#import "MDCContainedInputUnderlineLabelView.h"
#import "MDCContainedInputUnderlineLabelViewLayout.h"
#import "MDCContainedInputView.h"

@protocol MDCContainedInputViewStyler;

@interface MDCInputTextFieldLayout : NSObject

@property(nonatomic, readonly, class) CGFloat clearButtonSideLength;
@property(nonatomic, readonly, class) CGFloat clearButtonImageViewSideLength;

@property(nonatomic, assign) BOOL leftViewHidden;
@property(nonatomic, assign) BOOL rightViewHidden;
@property(nonatomic, assign) BOOL clearButtonHidden;

@property(nonatomic, assign) CGRect floatingLabelFrameFloating;
@property(nonatomic, assign) CGRect floatingLabelFrameNormal;
@property(nonatomic, assign) CGRect placeholderLabelFrameNormal;
@property(nonatomic, assign) CGRect textRect;
@property(nonatomic, assign) CGRect textRectFloatingLabel;
@property(nonatomic, assign) CGRect clearButtonFrame;
@property(nonatomic, assign) CGRect clearButtonFrameFloatingLabel;
@property(nonatomic, assign) CGRect leftViewFrame;
@property(nonatomic, assign) CGRect rightViewFrame;
@property(nonatomic, assign) CGRect underlineLabelViewFrame;
@property(nonnull, nonatomic, strong)
    MDCContainedInputUnderlineLabelViewLayout *underlineLabelViewLayout;

@property(nonatomic, readonly) CGFloat calculatedHeight;
@property(nonatomic, assign) CGFloat topRowBottomRowDividerY;

- (nonnull instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                              containerStyler:
                                  (nonnull id<MDCContainedInputViewStyler>)containerStyler
                                         text:(nonnull NSString *)text
                                  placeholder:(nonnull NSString *)placeholder
                                         font:(nonnull UIFont *)font
                                 floatingFont:(nonnull UIFont *)floatingFont
                                floatingLabel:(nonnull UILabel *)floatingLabel
                        canFloatingLabelFloat:(BOOL)canFloatingLabelFloat
                                     leftView:(nonnull UIView *)leftView
                                 leftViewMode:(UITextFieldViewMode)leftViewMode
                                    rightView:(nonnull UIView *)rightView
                                rightViewMode:(UITextFieldViewMode)rightViewMode
                                  clearButton:(nonnull UIButton *)clearButton
                              clearButtonMode:(UITextFieldViewMode)clearButtonMode
                           leftUnderlineLabel:(nonnull UILabel *)leftUnderlineLabel
                          rightUnderlineLabel:(nonnull UILabel *)rightUnderlineLabel
                   underlineLabelDrawPriority:
                       (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
             customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
               preferredMainContentAreaHeight:(CGFloat)preferredMainContentAreaHeight
            preferredUnderlineLabelAreaHeight:(CGFloat)preferredUnderlineLabelAreaHeight
                                        isRTL:(BOOL)isRTL
                                    isEditing:(BOOL)isEditing;

@end
