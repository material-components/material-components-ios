// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

@interface UIView (MDCSnapshot)

/**
 * This method will embed the view in a new larger view with a 10pt inset on all 4 sides.
 *
 * @return The background view that was created.
 */
- (UIView *)mdc_addToBackgroundView;

/**
 * This method will embed the view in a new view with the provided insets.
 *
 * @param insets The insets around the view embedded in a background view.
 * @return The background view that was created.
 */
- (UIView *)mdc_addToBackgroundViewWithInsets:(UIEdgeInsets)insets;

/**
 * This method will layout a view and then find a frame that best fits the view
 * for the given with, using either systemLayoutSizeFittingSize or sizeThatFits
 * and set that frame to the view's frame property.
 *
 * @param width The width to use when sizing the view.
 */
- (void)mdc_layoutAndApplyBestFitFrameWithWidth:(CGFloat)width;

@end
