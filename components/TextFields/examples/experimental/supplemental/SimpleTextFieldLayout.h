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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SimpleTextFieldLayoutUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleTextFieldLayout : NSObject

@property(nonatomic, assign) BOOL leftViewHidden;
@property(nonatomic, assign) BOOL rightViewHidden;
@property(nonatomic, assign) BOOL clearButtonHidden;
@property(nonatomic, assign) BOOL placeholderHidden;

@property(nonatomic, assign) CGRect placeholderFrameFloating;
@property(nonatomic, assign) CGRect placeholderFrameNormal;
@property(nonatomic, assign) CGRect textAreaFrame;
@property(nonatomic, assign) CGRect clearButtonFrame;
@property(nonatomic, assign) CGRect leftViewFrame;
@property(nonatomic, assign) CGRect rightViewFrame;
@property(nonatomic, assign) CGRect leftUnderlineLabelFrame;
@property(nonatomic, assign) CGRect rightUnderlineLabelFrame;

@property(nonatomic, readonly) CGFloat calculatedHeight;
@property(nonatomic, assign) CGFloat topRowBottomRowDividerY;

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                       textFieldStyle:(TextFieldStyle)textFieldStyle
                                 text:(NSString *)text
                          placeholder:(NSString *)placeholder
                                 font:(UIFont *)font
              floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                  canPlaceholderFloat:(BOOL)canPlaceholderFloat
                             leftView:(UIView *)leftView
                         leftViewMode:(UITextFieldViewMode)leftViewMode
                            rightView:(UIView *)rightView
                        rightViewMode:(UITextFieldViewMode)rightViewMode
                          clearButton:(UIButton *)clearButton
                      clearButtonMode:(UITextFieldViewMode)clearButtonMode
                   leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                  rightUnderlineLabel:(UILabel *)rightUnderlineLabel
           underlineLabelDrawPriority:(UnderlineLabelDrawPriority)underlineLabelDrawPriority
     customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing;

@end

NS_ASSUME_NONNULL_END
