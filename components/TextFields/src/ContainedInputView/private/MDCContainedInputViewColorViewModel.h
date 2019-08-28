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

/**
 This protocol represents a set of colors that are semantically meaningful and specific to
 MDCContainedInputView. Each property corresponds to the color of one or more views that an
 MDCContainedInputView manages at a given point of time.
 */
@protocol MDCContainedInputViewColorScheming <NSObject>
/**
 The color of the contained input view's text.
 */
@property(strong, nonatomic, nonnull) UIColor *textColor;
/**
 The color of the contained input view's underline label.
 */
@property(strong, nonatomic, nonnull) UIColor *assistiveLabelColor;
/**
 The color of the contained input view's label when it's floating.
 */
@property(strong, nonatomic, nonnull) UIColor *floatingLabelColor;
/**
 The color of the contained input view's label when it's in its normal, i.e. not floating, state.
 */
@property(strong, nonatomic, nonnull) UIColor *normalLabelColor;
/**
 The color of the contained input view's placeholder label.
 */
@property(strong, nonatomic, nonnull) UIColor *placeholderColor;
@end
