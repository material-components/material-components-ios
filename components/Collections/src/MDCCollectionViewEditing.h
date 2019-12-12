// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

@protocol MDCCollectionViewEditingDelegate;

/** The MDCCollectionViewEditing protocol defines the editing state for a UICollectionView. */
@protocol MDCCollectionViewEditing <NSObject>

/** The associated collection view. */
@property(nonatomic, readonly, weak, nullable) UICollectionView *collectionView;

/** The delegate will be informed of editing state changes. */
@property(nonatomic, weak, nullable) id<MDCCollectionViewEditingDelegate> delegate;

/** The index path of the cell being moved or reordered, if any. */
@property(nonatomic, readonly, strong, nullable) NSIndexPath *reorderingCellIndexPath;

/** The index path of the cell being dragged for dismissal, if any. */
@property(nonatomic, readonly, strong, nullable) NSIndexPath *dismissingCellIndexPath;

/** The index of the section being dragged for dismissal, or NSNotFound if none. */
@property(nonatomic, readonly, assign) NSInteger dismissingSection;

/**
  Sets the minimum press duration in seconds that will trigger the dragging behaviour.
  By default, the long press recognizer sets this to 0.5s.
 */
@property(nonatomic, assign) NSTimeInterval minimumPressDuration;

/**
 A Boolean value indicating whether the a visible cell within the collectionView is being
 edited.

 When set, all rows show or hide editing controls without animation. To animate the state change see
 @c setEditing:animated:. Setting the editing state of this class does not propagate to the parent
 view controller's editing state.
 */
@property(nonatomic, getter=isEditing) BOOL editing;

/**
 Set the editing state with optional animations.

 When set, row shows or hides editing controls with/without animation. Setting the editing
 state of this class does not propagate to the parent view controller's editing state.

 @param editing YES if editing; otherwise, NO.
 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

/**
 Updates the position of the cell being reordered to match the user's touch location. This method
 is a no-op if a cell is not currently being reordered.

 While the reordering cell's location is updated automatically to match the user's touch location,
 this method allows for the explicit update of the cell's position which may be required when the
 cell's location changes due to a layout update (such as performing collection view changes while
 the user is reordering).

 For example, you can call this in the MDCCollectionViewEditingDelegate's implementation of
 -collectionView:willBeginDraggingItemAtIndexPath: after performing updates to the collection view
 in preparation for the user's move of an item.
 */
- (void)updateReorderCellPosition;

@end
