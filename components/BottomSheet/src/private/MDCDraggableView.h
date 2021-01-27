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

@protocol MDCDraggableViewDelegate;

@interface MDCDraggableView : UIView

/**
 * The @c UIScrollView passed in the initializer.
 */
@property(nonatomic, strong, readonly, nullable) UIScrollView *scrollView;

/**
 When @c scrollView is @c nil , the draggable view simulates the @c UIScrollView bouncing effect.
 When this property is set to @c NO, the simulated bouncing effect is turned off.  When  @c
 scrollView is not @c nil, this property doesn't do anything.
 */
@property(nonatomic, assign) BOOL simulateScrollViewBounce;

/**
 * Delegate for handling drag events.
 */
@property(nonatomic, weak, nullable) id<MDCDraggableViewDelegate> delegate;

/**
 * Initializes a MDCDraggableView.
 *
 * @param frame Initial frame for the view.
 * @param scrollView A @c UIScrollView contained as a subview of this view. The view will block
 *  scrolling of the content in the scrollview when it is being drag-resized. This can be nil.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame
                           scrollView:(nullable UIScrollView *)scrollView NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

@end
