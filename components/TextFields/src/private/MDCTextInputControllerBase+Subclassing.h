// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextInputControllerBase.h"

@interface MDCTextInputControllerBase (Subclassing)

@property(nonatomic, assign, readonly, getter=isDisplayingCharacterCountError)
    BOOL displayingCharacterCountError;
@property(nonatomic, assign, readonly, getter=isDisplayingErrorText) BOOL displayingErrorText;

/** Refreshes the layout and style of the border view. Called within updateLayout. */
- (void)updateBorder;

/** Refreshes the geometry and style of the component. */
- (void)updateLayout;

/**
 Refreshes the layout and style of the placeholder label. Called within updateLayout.

 Note: The [Design guidance](https://material.io/components/text-fields/#anatomy) changed and treats
 placeholder as distinct from `label text`. The placeholder-related properties of this class most
 closely align with the "label text" as described in the guidance.
 */
- (void)updatePlaceholder;

/**
 Refreshes the layout and style of the border view. Called within updateLayout.

 Note: The [Design guidance](https://material.io/components/text-fields/#anatomy) changed and treats
 placeholder as distinct from `label text`. The placeholder-related properties of this class most
 closely align with the "label text" as described in the guidance.
 */
- (BOOL)isPlaceholderUp;

/** Calculates the actual number of lines for the label provded. */
+ (NSUInteger)calculatedNumberOfLinesForLeadingLabel:(UILabel *)label
                                  givenTrailingLabel:(UILabel *)trailingLabel
                                              insets:(UIEdgeInsets)insets
                                           widthHint:(CGFloat)widthHint;

@end
