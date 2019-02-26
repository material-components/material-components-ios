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

#import "MaterialChips.h"

@class MDCChipTextFieldScrollView;

@protocol MDCChipTextFieldScrollViewDelegate <NSObject, UIScrollViewDelegate>

- (void)chipTextFieldScrollView:(nonnull MDCChipTextFieldScrollView *)scrollView
                 didTapChipView:(nonnull MDCChipView *)chipView;

@end

@protocol MDCChipTextFieldScrollViewDataSource <NSObject>

/**
 The number of chip views in data source.

 @param scrollView The scroll view object requesting this information.
 @return The number of chip views.
 */
- (NSInteger)numberOfChipsInScrollView:(nonnull MDCChipTextFieldScrollView *)scrollView;

/**
 Asks the data source for a chip view in a particular location of the scroll view.

 @param scrollView The scroll view object requesting this information.
 @param index The index
 @return The chip view in the particular location.
 */
- (nullable MDCChipView *)scrollView:(nonnull MDCChipTextFieldScrollView *)scrollView
                        chipForIndex:(NSInteger)index;

@end

@interface MDCChipTextFieldScrollView : UIScrollView

/**
 The object acts as the delegate of the MDCChipTextFieldScrollView that handles
 touch events.
 */
@property(nonatomic, weak, nullable) id<MDCChipTextFieldScrollViewDelegate> touchDelegate;

/**
 The object acts as the chip view source of the MDCChipTextFieldScrollView.
 */
@property(nonatomic, weak, nullable) id<MDCChipTextFieldScrollViewDataSource> dataSource;

/**
 The spacing between chips in this scroll view.
 */
@property(nonatomic) CGFloat chipSpacing;

/**
 Scrolls the scroll view to the left most without animation.
 */
- (void)scrollToLeft;

/**
 Scrolls the scroll view to the right most without animation.
 */
- (void)scrollToRight;

/**
 Append a chipView to the scrollView

 @param chipView The chipView to append
 */
- (void)appendChipView:(nonnull MDCChipView *)chipView;

/**
 Remove a chipView from the scrollView

 @param chipView The chipView to remove
 */
- (void)removeChipView:(nonnull MDCChipView *)chipView;

@end
