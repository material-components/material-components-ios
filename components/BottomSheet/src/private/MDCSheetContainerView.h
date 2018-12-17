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

#import <UIKit/UIKit.h>
#import "MDCSheetState.h"

@protocol MDCSheetContainerViewDelegate;

@interface MDCSheetContainerView : UIView

@property(nonatomic, weak, nullable) id<MDCSheetContainerViewDelegate> delegate;
@property(nonatomic, readonly) MDCSheetState sheetState;
@property(nonatomic) CGFloat preferredSheetHeight;

- (nonnull instancetype)initWithFrame:(CGRect)frame
                          contentView:(nonnull UIView *)contentView
                           scrollView:(nullable UIScrollView *)scrollView NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

@end

@protocol MDCSheetContainerViewDelegate <NSObject>

- (void)sheetContainerViewDidHide:(nonnull MDCSheetContainerView *)containerView;
- (void)sheetContainerViewWillChangeState:(nonnull MDCSheetContainerView *)containerView
                               sheetState:(MDCSheetState)sheetState;

@end
