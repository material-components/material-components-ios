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

@optional
- (void)chipTextFieldScrollView:(MDCChipTextFieldScrollView *)scrollView
                 didTapChipView:(MDCChipView *)chipView;

@end

@protocol MDCChipTextFieldScrollViewDataSource <NSObject>

- (NSInteger)numberOfChipsInScrollView:(nonnull MDCChipTextFieldScrollView *)scrollView;
- (nullable MDCChipView *)scrollView:(nonnull MDCChipTextFieldScrollView *)scrollView
                        chipForIndex:(NSInteger)index;

@end

@interface MDCChipTextFieldScrollView : UIScrollView

@property(nonatomic, weak, nullable) id<MDCChipTextFieldScrollViewDelegate> touchDelegate;
@property(nonatomic, weak, nullable) id<MDCChipTextFieldScrollViewDataSource> dataSource;

/**
 The spacing between chips in this scroll view.
 */
@property(nonatomic) CGFloat chipSpacing;

- (void)scrollToLeft;
- (void)scrollToRight;

// TODO: remove these methods if we decide to go with data source. Needs revisit.
- (void)appendChipView:(nonnull MDCChipView *)chipView;
- (void)removeChipView:(nonnull MDCChipView *)chipView;

@end
