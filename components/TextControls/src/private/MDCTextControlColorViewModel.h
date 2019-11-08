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

#import "MDCTextControlState.h"

/**
 This object represents a group of colors that are applied on a state by state basis to
 MDCTextControls. Each property corresponds to a Contained Input View specific subview.
 */
@interface MDCTextControlColorViewModel : NSObject
/**
 The color of the contained input view's text.
 */
@property(strong, nonatomic, nonnull) UIColor *textColor;
/**
 The color of the contained input view's leading assistive label.
 */
@property(strong, nonatomic, nonnull) UIColor *leadingAssistiveLabelColor;
/**
 The color of the contained input view's trailing assistive label.
 */
@property(strong, nonatomic, nonnull) UIColor *trailingAssistiveLabelColor;
/**
 The color of the contained input view's label when it's floating.
 */
@property(strong, nonatomic, nonnull) UIColor *floatingLabelColor;
/**
 The color of the contained input view's label when it's in its normal, i.e. not floating, state.
 */
@property(strong, nonatomic, nonnull) UIColor *normalLabelColor;

/**
 This initializer returns an instance for a given state with a nonnull value for each property.
 */
- (nonnull instancetype)initWithState:(MDCTextControlState)state NS_DESIGNATED_INITIALIZER;

@end
