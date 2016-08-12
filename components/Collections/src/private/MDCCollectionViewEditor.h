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

#import "MDCCollectionViewEditing.h"

/**
 The MDCCollectionViewEditingManager class provides an implementation for a UICollectionView to
 set its editing properties.
 */
@interface MDCCollectionViewEditor : NSObject <MDCCollectionViewEditing>

/**
 Initialize the controller with a collection view.

 Designated initializer.

 @param collectionView The controller's collection view.
 */
- (nonnull instancetype)initWithCollectionView:(nullable UICollectionView *)collectionView
    NS_DESIGNATED_INITIALIZER;

/** Use initWithCollectionView: instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/** Use initWithCollectionView: instead. */
- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
