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

/**
 This protocol allows child view controllers to tell parent view controllers that conform to this
 protocol that they would like their content size categories changed. The methods accept buttons so
 that the parent can disable the appropriate button when either the smallest or largest content size
 category is adopted.
 */
@protocol MDCTraitEnvironmentChangeDelegate
- (void)
    childViewControllerDidRequestPreferredContentSizeCategoryDecrement:
        (UIViewController *)childViewController
                                                        decreaseButton:(UIButton *)decreaseButton
                                                        increaseButton:(UIButton *)increaseButton;
- (void)
    childViewControllerDidRequestPreferredContentSizeCategoryIncrement:
        (UIViewController *)childViewController
                                                        decreaseButton:(UIButton *)decreaseButton
                                                        increaseButton:(UIButton *)increaseButton;

- (void)childViewControllerDidRequestUserInterfaceStyle:(UIViewController *)childViewController
                                     userInterfaceStyle:(UIUserInterfaceStyle)userInterfaceStyle
    API_AVAILABLE(ios(12.0));

- (void)childViewControllerDidRequestLayoutDirection:(UIViewController *)childViewController
                                     layoutDirection:
                                         (UITraitEnvironmentLayoutDirection)layoutDirection
    API_AVAILABLE(ios(10.0));

@end
