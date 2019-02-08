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

#import "MaterialChips.h"

NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSUInteger, InputChipViewOrien) {
//};


@interface InputChipViewLayout : NSObject

@property (nonatomic, strong) NSArray<NSValue *> *chipFrames;

@property (nonatomic, assign) CGRect textFieldFrame;
@property (nonatomic, assign) CGRect scrollViewContentViewTouchForwardingView;
@property (nonatomic, assign) CGPoint scrollViewContentOffset;
@property (nonatomic, assign) CGPoint scrollViewContentInset;
@property (nonatomic, assign) CGSize scrollViewContentSize;

- (instancetype)initWithBounds:(CGRect)bounds
                         chips:(NSArray<UIView *> *)chips
                staleChipViews:(NSArray<UIView *> *)staleChipViews
                  canChipsWrap:(BOOL)canChipsWrap
                 chipRowHeight:(CGFloat)chipRowHeight
                 textFieldText:(NSString *)textFieldText
                 textFieldFont:(UIFont *)textFieldFont
                 contentInsets:(UIEdgeInsets)contentInsets
                         isRTL:(BOOL)isRTL;
@end

NS_ASSUME_NONNULL_END
