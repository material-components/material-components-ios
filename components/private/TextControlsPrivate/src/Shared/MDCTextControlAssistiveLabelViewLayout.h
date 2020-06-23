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

#import "MDCTextControl.h"
#import "MDCTextControlAssistiveLabelDrawPriority.h"

/**
 MDCTextControlAssistiveLabelViewLayout objects tell MDCAssistiveLabelViews where to position their
 assistive labels. Instantiating one of these classes is tantamount to calculating a layout.
 Instances of this class are applied to MDCAssistiveLabelViews when MDCTextControls apply their own
 layouts.
 */
@interface MDCTextControlAssistiveLabelViewLayout : NSObject

@property(nonatomic, assign, readonly) CGRect leadingAssistiveLabelFrame;
@property(nonatomic, assign, readonly) CGRect trailingAssistiveLabelFrame;
@property(nonatomic, assign, readonly) CGFloat calculatedHeight;

- (instancetype)initWithWidth:(CGFloat)superviewWidth
               leadingAssistiveLabel:(UILabel *)leadingAssistiveLabel
              trailingAssistiveLabel:(UILabel *)trailingAssistiveLabel
          assistiveLabelDrawPriority:
              (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                  leadingEdgePadding:(CGFloat)leadingEdgePadding
                 trailingEdgePadding:(CGFloat)trailingEdgePadding
         paddingAboveAssistiveLabels:(CGFloat)paddingAboveAssistiveLabels
         paddingBelowAssistiveLabels:(CGFloat)paddingBelowAssistiveLabels
                               isRTL:(BOOL)isRTL;

@end
