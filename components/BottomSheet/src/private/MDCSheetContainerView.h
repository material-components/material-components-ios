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
/**
Whether or not the height of the view should adjust to include extra height for any bottom
 safe area insets. If, for example, this is set to @c YES, and the preferredSheetHeight is
 100 and the screen has a bottom safe area inset of 10, the total height of the displayed bottom
 sheet height would be 110. If set to @c NO, the height would be 100.
 */
@property(nonatomic, assign) BOOL adjustHeightForSafeAreaInsets;
@property(nonatomic) BOOL willBeDismissed;

/**
 A Boolean value that controls whether the height of the keyboard should affect
 the bottom sheet's frame when the keyboard shows on the screen.

 The default value is @c NO.
 */
@property(nonatomic) BOOL ignoreKeyboardHeight;

/**
 When set to false, the bottom sheet controller can't be dismissed by dragging the sheet down.
 */
@property(nonatomic, assign) BOOL dismissOnDraggingDownSheet;

- (nonnull instancetype)initWithFrame:(CGRect)frame
                          contentView:(nonnull UIView *)contentView
                           scrollView:(nullable UIScrollView *)scrollView
             simulateScrollViewBounce:(BOOL)simulateScrollViewBounce NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

@end
