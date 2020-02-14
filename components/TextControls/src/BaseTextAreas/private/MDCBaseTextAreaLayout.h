// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextControl.h"
#import "MDCTextControlAssistiveLabelView.h"

@interface MDCBaseTextAreaLayout : NSObject

@property(nonatomic, assign, readonly) CGRect labelFrameFloating;
@property(nonatomic, assign, readonly) CGRect labelFrameNormal;

@property(nonatomic, assign, readonly) CGRect textViewFrame;

@property(nonatomic, assign, readonly) CGRect assistiveLabelViewFrame;
@property(nonatomic, strong, nonnull, readonly)
    MDCTextControlAssistiveLabelViewLayout *assistiveLabelViewLayout;

@property(nonatomic, readonly) CGFloat calculatedHeight;
@property(nonatomic, readonly) CGFloat containerHeight;

@property(nonatomic, strong, nonnull, readonly) NSArray<NSNumber *> *verticalGradientLocations;
@property(nonatomic, strong, nonnull, readonly) NSArray<NSNumber *> *horizontalGradientLocations;

- (nonnull instancetype)initWithSize:(CGSize)size
                positioningReference:
                    (nonnull id<MDCTextControlVerticalPositioningReference>)positioningReference
                                text:(nullable NSString *)text
                                font:(nonnull UIFont *)font
                        floatingFont:(nonnull UIFont *)floatingFont
                               label:(nonnull UILabel *)label
                          labelState:(MDCTextControlLabelState)labelState
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
               leadingAssistiveLabel:(nonnull UILabel *)leadingAssistiveLabel
              trailingAssistiveLabel:(nonnull UILabel *)trailingAssistiveLabel
          assistiveLabelDrawPriority:
              (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing;

- (CGRect)labelFrameWithLabelState:(MDCTextControlLabelState)labelState;

@end
