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

@interface MDCBaseInputChipViewLayout : NSObject
@property(nonatomic, assign) CGFloat globalChipRowMinX;
@property(nonatomic, assign) CGFloat globalChipRowMaxX;

@property(nonatomic, strong) NSArray<NSValue *> *chipFrames;

@property(nonatomic, assign) CGRect labelFrameFloating;
@property(nonatomic, assign) CGRect labelFrameNormal;

@property(nonatomic, assign) CGRect textFieldFrame;

@property(nonatomic, assign) CGRect underlineLabelFrame;
@property(nonatomic, assign) CGRect leftAssistiveLabelFrame;
@property(nonatomic, assign) CGRect rightAssistiveLabelFrame;

@property(nonatomic, assign) CGRect maskedScrollViewContainerViewFrame;
@property(nonatomic, assign) CGRect scrollViewFrame;
@property(nonatomic, assign) CGRect scrollViewContentViewTouchForwardingViewFrame;
@property(nonatomic, assign) CGSize scrollViewContentSize;
@property(nonatomic, assign) CGPoint scrollViewContentOffset;

@property(nonatomic, readonly) CGFloat calculatedHeight;
//@property(nonatomic, readonly) CGFloat minimumHeight;
@property(nonatomic, readonly) CGFloat contentAreaMaxY;

@property(nonatomic, strong) NSArray<NSNumber *> *verticalGradientLocations;
@property(nonatomic, strong) NSArray<NSNumber *> *horizontalGradientLocations;

- (instancetype)initWithSize:(CGSize)size
                      containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                text:(NSString *)text
                         placeholder:(NSString *)placeholder
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                               label:(UILabel *)label
                          labelState:(MDCContainedInputViewLabelState)labelState
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                               chips:(NSArray<UIView *> *)chips
                      staleChipViews:(NSArray<UIView *> *)staleChipViews
                           chipsWrap:(BOOL)chipsWrap
                       chipRowHeight:(CGFloat)chipRowHeight
                    interChipSpacing:(CGFloat)interChipSpacing
                         clearButton:(UIButton *)clearButton
                 clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
            preferredContainerHeight:(CGFloat)preferredContainerHeight
        preferredNumberOfVisibleRows:(CGFloat)preferredNumberOfVisibleRows
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing;
@end
