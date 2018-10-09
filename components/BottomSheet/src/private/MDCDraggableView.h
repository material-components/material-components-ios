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
 * Delegate for handling drag events.
 */
@property(nonatomic, weak, nullable) id <MDCDraggableViewDelegate> delegate;

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

/**
 * Delegate protocol to control when dragging should be allowed and to respond to dragging events.
 */
@protocol MDCDraggableViewDelegate <NSObject>

/**
 * Allows the delegate to specify a maximum threshold height that the view cannot be dragged above.
 * @param view The draggable view.
 * @return The maximum height this view can be dragged to be.
 */
- (CGFloat)maximumHeightForDraggableView:(nonnull MDCDraggableView *)view;

/**
 * Called when an attempt is made to drag the view up or down.
 * @return NO to prevent a new drag from starting.
 * @param view The draggable view.
 * @param velocity The current velocity of the drag gesture. This only contains a vertical
 *   component.
 */
- (BOOL)draggableView:(nonnull MDCDraggableView *)view
    shouldBeginDraggingWithVelocity:(CGPoint)velocity;

/**
 * Called when a new drag starts.
 * @param view The draggable view.
 */
- (void)draggableViewBeganDragging:(nonnull MDCDraggableView *)view;

/**
 * Called when a drag ends.
 * @param view The draggable view.
 * @param velocity The current velocity of the drag gesture. This only contains a vertical
 *   component.
 */
- (void)draggableView:(nonnull MDCDraggableView *)view draggingEndedWithVelocity:(CGPoint)velocity;

@end
