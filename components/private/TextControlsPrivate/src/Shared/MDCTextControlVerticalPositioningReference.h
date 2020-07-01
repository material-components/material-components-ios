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

#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlLabelPosition.h"

/**
 Style objects vend objects conforming to this protocol to provide the MDCTextControl's layout
 object with information about the vertical positions of views. This helps achieve the variations in
 floating label and text rect position across the filled and outlined styles, and also allows
 different densities to be possible.
*/
@protocol MDCTextControlVerticalPositioningReference <NSObject>

@property(nonatomic, assign, readonly) CGFloat paddingBetweenContainerTopAndFloatingLabel;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenContainerTopAndNormalLabel;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenFloatingLabelAndEditingText;
@property(nonatomic, assign, readonly) CGFloat paddingBetweenEditingTextAndContainerBottom;
@property(nonatomic, assign, readonly) CGFloat paddingAboveAssistiveLabels;
@property(nonatomic, assign, readonly) CGFloat paddingBelowAssistiveLabels;
@property(nonatomic, assign, readonly) CGFloat containerHeightWithFloatingLabel;
@property(nonatomic, assign, readonly) CGFloat containerHeightWithoutFloatingLabel;
@property(nonatomic, assign, readonly) CGFloat paddingAroundTextWhenNoFloatingLabel;

@end

CGFloat MDCTextControlCalculateContainerHeightWhenNoFloatingLabelWithTextRowHeight(
    CGFloat textRowHeight, CGFloat numberOfTextRows, CGFloat paddingAroundTextWhenNoFloatingLabel);

CGFloat MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
    CGFloat floatingLabelHeight, CGFloat textRowHeight, CGFloat numberOfTextRows,
    CGFloat paddingBetweenContainerTopAndFloatingLabel,
    CGFloat paddingBetweenFloatingLabelAndEditingText,
    CGFloat paddingBetweenEditingTextAndContainerBottom);

CGFloat MDCTextControlClampDensity(CGFloat density);

CGFloat MDCTextControlPaddingValueWithMinimumPadding(CGFloat minimumPadding, CGFloat maximumPadding,
                                                     CGFloat density);

BOOL MDCTextControlShouldLayoutForFloatingLabelWithLabelPosition(
    MDCTextControlLabelPosition labelPosition, MDCTextControlLabelBehavior labelBehavior,
    NSString *labelText);
