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
#import "MDCInputViewContainerStyler.h"

#import "MaterialContainerScheme.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputChipView : UIControl

@property (strong, nonatomic, readonly) UITextField *textField;
@property (nonatomic, assign) BOOL canChipsWrap;
@property (nonatomic, assign) CGFloat chipRowHeight;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, assign) MDCInputViewContainerStyle containerStyle;
@property (nonatomic, strong) MDCContainerScheme *containerScheme;

- (void)addChip:(UIView *)chip;

@end

NS_ASSUME_NONNULL_END
