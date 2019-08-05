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
#import "MDCContainerStylerBase.h"
#import "MDCTextControlLabelBehavior.h"

@interface MDCContainerStylerBasePositioningDelegate : NSObject <NewPositioningDelegate>

@property(nonatomic, assign, readonly) CGFloat paddingBetweenTopAndFloatingLabel;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenTopAndNormalLabel;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenFloatingLabelAndText;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenTextAndBottom;
@property(nonatomic, assign, readonly) CGFloat paddingAroundAssistiveLabels;
@property(nonatomic, assign, readonly) CGFloat containerHeight;

@property(nonatomic, assign) CGFloat floatingLabelHeight;
@property(nonatomic, assign) CGFloat normalFontLineHeight;
@property(nonatomic, assign) CGFloat textRowHeight;
@property(nonatomic, assign) CGFloat numberOfTextRows;
@property(nonatomic, assign) CGFloat density;
@property(nonatomic, assign) CGFloat preferredContainerHeight;
@property(nonatomic, assign) MDCContainedInputViewLabelState labelState;
@property(nonatomic, assign) MDCTextControlLabelBehavior labelBehavior;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight
                                    labelState:(MDCContainedInputViewLabelState)labelState
                                 labelBehavior:(MDCTextControlLabelBehavior)labelBehavior;

@end
