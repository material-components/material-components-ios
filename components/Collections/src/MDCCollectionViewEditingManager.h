/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

@protocol MDCCollectionViewEditingManagerDelegate;

/**
 The MDCCollectionViewEditingManager class provides an implementation for a UICollectionView to
 set its editing properties.
 */
@interface MDCCollectionViewEditingManager : NSObject

/** Unavailable superclass initializers. */
- (nonnull instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Initialize the controller with a collection view.

 Designated initializer.

 @param collectionView The controller's collection view.
 */
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView
    NS_DESIGNATED_INITIALIZER;

/** The controller's collection view. */
@property(nonatomic, readonly, weak, nullable) UICollectionView *collectionView;

/**
 A delegate through which the MDCCollectionViewEditingManager may inform of changes in status.
 */
@property(nonatomic, weak, nullable) id<MDCCollectionViewEditingManagerDelegate> delegate;

/**
 The index path of a cell that is currently being moved/reordered within a collection View.
 */
@property(nonatomic, readonly, strong, nullable) NSIndexPath *reorderingCellIndexPath;

/**
 The index path of a cell that is currently being dragged for dismissal within a collection View.
 */
@property(nonatomic, readonly, strong, nullable) NSIndexPath *dismissingCellIndexPath;

/** The section being dragged for dismissal within a collection View. */
@property(nonatomic, readonly, assign) NSInteger dismissingSection;

/**
 A boolean value indicating whether the a visible cell within the collectionView is being
 edited. When set, all rows show or hide editing controls without animation. To animate the
 state change see @c setEditing:animated:. Setting the editing state of this class does not
 propagate to the parent view controller's editing state.
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

@end
