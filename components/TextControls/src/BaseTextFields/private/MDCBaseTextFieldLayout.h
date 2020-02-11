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

#import "MaterialTextControlsPrivate+Shared.h"

@interface MDCBaseTextFieldLayout : NSObject

@property(nonatomic, assign) BOOL leftViewHidden;
@property(nonatomic, assign) BOOL rightViewHidden;

@property(nonatomic, assign) CGRect clearButtonFrameFloating;
@property(nonatomic, assign) CGRect clearButtonFrameNormal;
@property(nonatomic, assign) CGRect labelFrameFloating;
@property(nonatomic, assign) CGRect labelFrameNormal;
@property(nonatomic, assign) CGRect textRectNormal;
@property(nonatomic, assign) CGRect textRectFloating;
@property(nonatomic, assign) CGRect leftViewFrame;
@property(nonatomic, assign) CGRect rightViewFrame;
@property(nonatomic, assign) CGRect assistiveLabelViewFrame;
@property(nonatomic, strong, nonnull)
    MDCTextControlAssistiveLabelViewLayout *assistiveLabelViewLayout;

@property(nonatomic, readonly) CGFloat calculatedHeight;
@property(nonatomic, assign) CGFloat containerHeight;

/**
  Initializing an MDCBaseTextFieldLayout object with this initializer is tantamount to calculating a
  layout for a TextField. The admittedly long parameter list includes everything that might impact
  the layout of the textfield. Providing the object with everything that it needs to calculate a
  layout allows it to do so all in one place, in isolation, and in a top down fashion. The inability
  of other objects to interfere with this process helps ensure that the resulting layout is correct
  and reliable.
 */
- (nonnull instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                         positioningReference:
                             (nonnull id<MDCTextControlVerticalPositioningReference>)
                                 positioningReference
                                         text:(nullable NSString *)text
                                         font:(nonnull UIFont *)font
                                 floatingFont:(nonnull UIFont *)floatingFont
                                        label:(nonnull UILabel *)label
                                     leftView:(nullable UIView *)leftView
                                 leftViewMode:(UITextFieldViewMode)leftViewMode
                                    rightView:(nullable UIView *)rightView
                                rightViewMode:(UITextFieldViewMode)rightViewMode
                        clearButtonSideLength:(CGFloat)clearButtonSideLength
                              clearButtonMode:(UITextFieldViewMode)clearButtonMode
                        leadingAssistiveLabel:(nonnull UILabel *)leftAssistiveLabel
                       trailingAssistiveLabel:(nonnull UILabel *)rightAssistiveLabel
                   assistiveLabelDrawPriority:
                       (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
             customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                                        isRTL:(BOOL)isRTL
                                    isEditing:(BOOL)isEditing;

- (CGRect)labelFrameWithLabelState:(MDCTextControlLabelState)labelState;

@end
