/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MDCActionMenuOptionView.h"
#import "MDCActionMenuViewController.h"

@class MDCActionMenuOption;

/**
 * A UICollectionViewCell to display a MDCActionMenuOptionView for an Action Menu collection view.
 */
@interface MDCActionMenuCell : UICollectionViewCell

/**
 * The MDCActionMenuOptionView displayed by the cell.
 */
@property(nonatomic, readonly) MDCActionMenuOptionView *optionView;

/**
 * Positions the |optionView| relative to the provided frame.
 *
 * @param frame The frame to position relatively to (usually the primary floating action button's).
 */
- (void)positionRelativeToFrame:(CGRect)frame;

@end
