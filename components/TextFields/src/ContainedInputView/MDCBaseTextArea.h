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

#import "MDCTextControlLabelBehavior.h"
#import "MaterialContainerScheme.h"

@interface MDCBaseTextArea : UIControl

/**
 This property determines the behavior of the textfield's label during editing.
 @note The default is MDCTextControlLabelBehaviorFloats.
 */
@property(nonatomic, assign) MDCTextControlLabelBehavior labelBehavior;

@property(strong, nonatomic, readonly) UITextView *textView;
@property(strong, nonatomic, readonly) UILabel *label;
@property(nonatomic, assign) NSInteger numberOfVisibleLines;
@property(nonatomic, assign) CGFloat preferredContainerHeight;
@property(nonatomic, assign) CGFloat preferredNumberOfVisibleRows;

/**
 Indicates whether the text field should automatically update its font when the device’s
 UIContentSizeCategory is changed.
 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.
 Defaults value is NO.
 */
@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

@end
