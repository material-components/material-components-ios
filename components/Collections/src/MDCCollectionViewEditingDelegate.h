/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <Foundation/Foundation.h>

/**
 A delegate protocol that provides editing notifications for three types of collection view
 gestural interations:

  - Cells that are dragging/moved vertically for reordering.
  - Individual cells being swiped horizontally for dismissal.
  - Entire cell sections being swiped horizontally for dismissal.
 */
@protocol MDCCollectionViewEditingDelegate <NSObject>

@optional

#pragma mark - CollectionView Item Editing

/**
 If YES, the collectionView will allow editing of its items. Permissions for individual
 index paths are set by implementing the delegate -collectionView:canEditItemAtIndexPath method.
 If not implemented, will default to NO.
 */
- (BOOL)collectionViewAllowsEditing:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver when the collection view will begin editing. Typically this method will be
 called from a collection view editor that has had its editing property set to YES.
 This will be called before any animations to editing state will begin.

 @param collectionView The collection view.
 */
- (void)collectionViewWillBeginEditing:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver when the collection view did begin editing. Typically this method will be
 called from a collection view editor that has had its editing property set to YES.
 This is called after animations to editing state have completed.

 @param collectionView The collection view.
 */
- (void)collectionViewDidBeginEditing:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver when the collection view will end editing. Typically this method will be
 called from a collection view editor that has had its editing property set to NO.
 This will be called before any animations from editing state begin.

 @param collectionView The collection view.
 */
- (void)collectionViewWillEndEditing:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver when the collection view did end editing. Typically this method will be
 called from a collection view editor that has had its editing property set to NO.
 This is called after animations from editing state have completed.

 @param collectionView The collection view.
 */
- (void)collectionViewDidEndEditing:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver for permission to edit an item at this collection view index path.
 Returning NO here will prevent editing the designated index path. If not implemented, will
 default to NO.

 @param collectionView The collection view.
 @param indexPath The index path of the collection view.
 @return if the collection view index path can be edited.
 */
- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    canEditItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Sent to the receiver for permission to select an item at this collection view index path
 during collection view editing. Returning NO here will prevent selecting the designated
 index path. If not implemented, will default to NO.


 @param collectionView The collection view.
 @param indexPath The index path of the collection view.
 @return if the collection view index path can be selected.
 */
- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    canSelectItemDuringEditingAtIndexPath:(nonnull NSIndexPath *)indexPath;

#pragma mark - CollectionView Item Moving

/**
 If YES, the collectionView will allow reordering of its items. Permissions for individual
 index paths are be set by the -collectionView:canMoveItemAtIndexPath and/or the
 -collectionView:canMoveItemAtIndexPath:toIndexPath methods. If not implemented, will default
 to NO.

 */
- (BOOL)collectionViewAllowsReordering:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver for permission to move an item at this collection view index path.
 Returning NO here will prevent moving the designated index path. If not implemented, will
 default to NO.

 @param collectionView The collection view.
 @param indexPath The index path of the collection view.
 @return if the collection view index path can be moved.
 */
- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    canMoveItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Sent to the receiver for permission to move an item at this collection view index path to
 a new index path. Returning NO here will prevent moving the designated index path. If not
 implemented, will default to NO.

 @param collectionView The collection view.
 @param indexPath The current index path of the collection view.
 @param newIndexPath The propsed new index path of the collection view.
 @return if the collection view index path can be moved.
 */
- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    canMoveItemAtIndexPath:(nonnull NSIndexPath *)indexPath
               toIndexPath:(nonnull NSIndexPath *)newIndexPath;

/**
 Sent to the receiver when the collection view will move an item from its previous index path
 to the new index path.

 @param collectionView The collection view.
 @param indexPath The previous index path of the collection view.
 @param newIndexPath The new index path of the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    willMoveItemAtIndexPath:(nonnull NSIndexPath *)indexPath
                toIndexPath:(nonnull NSIndexPath *)newIndexPath;

/**
 Sent to the receiver when the collection view did move an item from its previous index path
 to the new index path.

 @param collectionView The collection view.
 @param indexPath The previous index path of the collection view.
 @param newIndexPath The new index path of the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didMoveItemAtIndexPath:(nonnull NSIndexPath *)indexPath
               toIndexPath:(nonnull NSIndexPath *)newIndexPath;

/**
 Sent to the receiver when a collection view item at specified index path will begin dragging.

 @param collectionView The collection view.
 @param indexPath The index path of the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    willBeginDraggingItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Sent to the receiver when a collection view item at specified index path has finished dragging.

 @param collectionView The collection view.
 @param indexPath The index path of the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didEndDraggingItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

#pragma mark - CollectionView Item Deletions

/**
 Sent to the receiver when an array of index paths will be deleted from the collection view.

 @param collectionView The collection view.
 @param indexPaths An array of index paths to be deleted from the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths;

/**
 Sent to the receiver after an array of index paths did get deleted from the collection view.

 @param collectionView The collection view.
 @param indexPaths An array of index paths deleted from the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didDeleteItemsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths;

#pragma mark - CollectionView Section Deletions

/**
 Sent to the receiver when an array of index paths will be deleted from the collection view.

 @param collectionView The collection view.
 @param sections An index set of sections to deleted from the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    willDeleteSections:(nonnull NSIndexSet *)sections;

/**
 Sent to the receiver after an array of index paths did get deleted from the collection view.

 @param collectionView The collection view.
 @param sections An index set of sections deleted from the collection view.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
     didDeleteSections:(nonnull NSIndexSet *)sections;

#pragma mark - CollectionView Swipe To Dismiss Items

/**
 If YES, the collectionView will allow swiping to dismiss an item. If allowed, swiping is enabled
 for all items (excluding headers, and footers). Permissions for individual items can be set by
 implementing the protocol -collectionView:canSwipeToDismissItemAtIndexPath method. If not
 implemented, will default to NO.

 @param collectionView The collection view being swiped for dismissal.
 @return if the collection view can swipe to dismiss an item.
 */
- (BOOL)collectionViewAllowsSwipeToDismissItem:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver when a collection view index path begins to swipe for dismissal. The
 delegate method -collectionViewAllowsSwipeToDismissItem must return true in order for this
 subsequent delegate method to be called. The collection view is NOT required to be in
 edit mode to allow swipe-to-dismiss items. Returning NO here will prevent swiping the
 designated item at index path. If not implemented, will default to NO.


 @param collectionView The collection view being swiped for dismissal.
 @param indexPath The index path of the collection view being swiped for dismissal.
 @return if the collection view index path can be swiped for dismissal.
 */
- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Sent to the receiver when the collection view index path begins to swipe for dismissal.

 @param collectionView The collection view being swiped for dismissal.
 @param indexPath The index path of the collection view being swiped for dismissal.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    willBeginSwipeToDismissItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Sent to the receiver after the collection view item has been dismissed.

 @param collectionView The collection view being swiped for dismissal.
 @param indexPath The index path of the collection view being swiped for dismissal.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didEndSwipeToDismissItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Sent to the receiver when the collection view index path has reset without being dismissed.

 @param collectionView The collection view being swiped for dismissal.
 @param indexPath The index path of the collection view being swiped for dismissal.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didCancelSwipeToDismissItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

#pragma mark - CollectionView Swipe To Dismiss Sections

/**
 If YES, the collectionView will allow swiping to dismiss a section. If allowed, swiping is enabled
 for all section items, headers, and footers. Permissions for individual sections can be
 set by implementing the protocol -collectionView:canSwipeToDismissSection method. If not
 implemented, will default to NO.

 @param collectionView The collection view being swiped for dismissal.
 @return if the collection view can swipe to dismiss a section.
 */
- (BOOL)collectionViewAllowsSwipeToDismissSection:(nonnull UICollectionView *)collectionView;

/**
 Sent to the receiver when a collection view section begins to swipe for dismissal. The
 collection view property @c allowsSwipeToDismissSection must be true in order for this
 subsequent delegate method to be called. The collection view is NOT required to be in
 edit mode to allow swipe-to-dismiss sections. Returning NO here will prevent swiping the
 designated section. If not implemented, will default to NO.

 @param collectionView The collection view being swiped for dismissal.
 @param section The section of the collection view being swiped for dismissal.
 @return if the collection view section can be swiped for dismissal.
 */
- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    canSwipeToDismissSection:(NSInteger)section;

/**
 Sent to the receiver when the collection view section begins to swipe for dismissal.

 @param collectionView The collection view being swiped for dismissal.
 @param section The section of the collection view being swiped for dismissal.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    willBeginSwipeToDismissSection:(NSInteger)section;

/**
 Sent to the receiver after the collection view section has been dismissed.

 @param collectionView The collection view being swiped for dismissal.
 @param section The section of the collection view being swiped for dismissal.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didEndSwipeToDismissSection:(NSInteger)section;

/**
 Sent to the receiver when the collection view section has reset without being dismissed.

 @param collectionView The collection view being swiped for dismissal.
 @param section The section of the collection view being swiped for dismissal.
 */
- (void)collectionView:(nonnull UICollectionView *)collectionView
    didCancelSwipeToDismissSection:(NSInteger)section;

@end
