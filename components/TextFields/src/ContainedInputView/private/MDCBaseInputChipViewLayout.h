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

#import "MDCContainedInputAssistiveLabelViewLayout.h"
#import "MDCContainedInputView.h"

@interface MDCBaseInputChipViewLayout : NSObject
@property(nonatomic, assign) CGFloat globalChipRowMinX;
@property(nonatomic, assign) CGFloat globalChipRowMaxX;

@property(nonatomic, strong, nonnull) NSArray<NSValue *> *chipFrames;

@property(nonatomic, assign) CGRect labelFrameFloating;
@property(nonatomic, assign) CGRect labelFrameNormal;

@property(nonatomic, assign) CGRect textFieldFrame;

@property(nonatomic, assign) CGRect assistiveLabelViewFrame;
@property(nonatomic, strong, nonnull)
    MDCContainedInputAssistiveLabelViewLayout *assistiveLabelViewLayout;

@property(nonatomic, assign) CGRect maskedScrollViewContainerViewFrame;
@property(nonatomic, assign) CGRect scrollViewFrame;
@property(nonatomic, assign) CGRect scrollViewContentViewTouchForwardingViewFrame;
@property(nonatomic, assign) CGSize scrollViewContentSize;
@property(nonatomic, assign) CGPoint scrollViewContentOffset;

@property(nonatomic, readonly) CGFloat calculatedHeight;
@property(nonatomic, readonly) CGFloat containerHeight;

@property(nonatomic, strong, nonnull) NSArray<NSNumber *> *verticalGradientLocations;
@property(nonatomic, strong, nonnull) NSArray<NSNumber *> *horizontalGradientLocations;

- (nonnull instancetype)initWithSize:(CGSize)size
                positioningReference:
                    (nonnull id<MDCContainerStyleVerticalPositioningReference>)positioningReference
                                text:(nullable NSString *)text
                         placeholder:(nullable NSString *)placeholder
                                font:(nonnull UIFont *)font
                        floatingFont:(nonnull UIFont *)floatingFont
                               label:(nonnull UILabel *)label
                          labelState:(MDCContainedInputViewLabelState)labelState
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                               chips:(nonnull NSArray<UIView *> *)chips
                      staleChipViews:(nonnull NSArray<UIView *> *)staleChipViews
                           chipsWrap:(BOOL)chipsWrap
                       chipRowHeight:(CGFloat)chipRowHeight
                    interChipSpacing:(CGFloat)interChipSpacing
                  leftAssistiveLabel:(nonnull UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(nonnull UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
            preferredContainerHeight:(CGFloat)preferredContainerHeight
        preferredNumberOfVisibleRows:(CGFloat)preferredNumberOfVisibleRows
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing;
@end
