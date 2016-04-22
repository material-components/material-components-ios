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

#import "MDCCollectionViewEditingManager.h"
#import "MDCCollectionViewEditingManagerDelegate.h"
#import "MDCCollectionViewStyleManager.h"
#import "MDCCollectionViewStyleManagerDelegate.h"

/**
 Controller that implements a collection view that adheres to Material design layout
 and animation styling.
 */
@interface MDCCollectionViewController : UICollectionViewController <
                                             /** Allows for editing notifications/permissions. */
                                             MDCCollectionViewEditingManagerDelegate,

                                             /** Allows for styling updates. */
                                             MDCCollectionViewStyleManagerDelegate,

                                             /** Adheres to flow layout. */
                                             UICollectionViewDelegateFlowLayout>

/** The collection view style manager. */
@property(nonatomic, strong, readonly, nonnull) MDCCollectionViewStyleManager *styleManager;

/** The collection view editing manager. */
@property(nonatomic, strong, readonly, nonnull)
    MDCCollectionViewEditingManager *editingManager;

#pragma mark - Subclassing

/**
 The following methods require a call to super in their overriding implementations to allow
 this collection view controller to properly configure the collection view when in editing mode.
 */

- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    shouldSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath NS_REQUIRES_SUPER;

- (BOOL)collectionView:(nonnull UICollectionView *)collectionView
    shouldDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath NS_REQUIRES_SUPER;

- (void)collectionView:(nonnull UICollectionView *)collectionView
    didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath NS_REQUIRES_SUPER;

- (void)collectionView:(nonnull UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath NS_REQUIRES_SUPER;

- (void)collectionViewWillBeginEditing:(nonnull UICollectionView *)collectionView NS_REQUIRES_SUPER;

- (void)collectionViewWillEndEditing:(nonnull UICollectionView *)collectionView NS_REQUIRES_SUPER;

@end
