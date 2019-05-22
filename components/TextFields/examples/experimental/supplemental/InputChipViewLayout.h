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

#import <UIKit/UIKit.h>

#import "MDCContainedInputView.h"
#import "MaterialChips.h"

NS_ASSUME_NONNULL_BEGIN

// typedef NS_ENUM(NSUInteger, InputChipViewOrien) {
//};

@interface InputChipViewLayout : NSObject
@property(nonatomic, assign) CGFloat initialChipRowMinY;
@property(nonatomic, assign) CGFloat finalChipRowMaxY;
@property(nonatomic, assign) CGFloat globalChipRowMinX;
@property(nonatomic, assign) CGFloat globalChipRowMaxX;

@property(nonatomic, strong) NSArray<NSValue *> *chipFrames;

@property(nonatomic, assign) CGRect floatingLabelFrameFloating;
@property(nonatomic, assign) CGRect floatingLabelFrameNormal;

@property(nonatomic, assign) CGRect textFieldFrame;

@property(nonatomic, assign) CGRect underlineLabelFrame;
@property(nonatomic, assign) CGRect leftUnderlineLabelFrame;
@property(nonatomic, assign) CGRect rightUnderlineLabelFrame;

@property(nonatomic, assign) CGRect maskedScrollViewContainerViewFrame;
@property(nonatomic, assign) CGRect scrollViewFrame;
@property(nonatomic, assign) CGRect scrollViewContentViewTouchForwardingViewFrame;
@property(nonatomic, assign) CGSize scrollViewContentSize;
@property(nonatomic, assign) CGPoint scrollViewContentOffset;

@property(nonatomic, readonly) CGFloat calculatedHeight;
//@property(nonatomic, readonly) CGFloat minimumHeight;
@property(nonatomic, readonly) CGFloat contentAreaMaxY;

- (instancetype)initWithSize:(CGSize)size
                      containerStyler:(id<MDCContainedInputViewStyler>)containerStyler
                                 text:(NSString *)text
                          placeholder:(NSString *)placeholder
                                 font:(UIFont *)font
                         floatingFont:(UIFont *)floatingFont
                   floatingLabelState:(MDCContainedInputViewFloatingLabelState)floatingLabelState
                                chips:(NSArray<UIView *> *)chips
                       staleChipViews:(NSArray<UIView *> *)staleChipViews
                            chipsWrap:(BOOL)chipsWrap
                        chipRowHeight:(CGFloat)chipRowHeight
                     interChipSpacing:(CGFloat)interChipSpacing
                          clearButton:(UIButton *)clearButton
                  clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                   leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                  rightUnderlineLabel:(UILabel *)rightUnderlineLabel
           underlineLabelDrawPriority:
               (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
     customUnderlineLabelDrawPriority:(CGFloat)normalizedCustomUnderlineLabelDrawPriority
       preferredMainContentAreaHeight:(CGFloat)preferredMainContentAreaHeight
    preferredUnderlineLabelAreaHeight:(CGFloat)preferredUnderlineLabelAreaHeight
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing;
@end

NS_ASSUME_NONNULL_END
