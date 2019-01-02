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

//TODO: delegate methods to handle touch event

@end

@protocol MDCChipTextFieldScrollViewDataSource <NSObject>

- (NSInteger)numberOfChipsOnScrollView:(MDCChipTextFieldScrollView *)scrollView;
- (MDCChipView *)scrollView:(MDCChipTextFieldScrollView *)scrollView chipForIndex:(NSInteger)index;

@end

@interface MDCChipTextFieldScrollView : UIScrollView

@property (nonatomic, weak, nullable) id <MDCChipTextFieldScrollViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <MDCChipTextFieldScrollViewDataSource> dataSource;

@property(nonatomic) CGFloat chipSpacing;
@property(nonatomic) CGFloat contentHorizontalOffset;
@property(nonatomic) CGFloat contentWidthConstant;

// TODO: remove these methods
- (void)appendChipView:(MDCChipView *)chipView;
- (void)removeChipView:(MDCChipView *)chipView;

@end

