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

#import "MDCCollectionViewStyling.h"

/**
 The MDCCollectionViewStyler class provides a default implementation for a UICollectionView to set
 its style properties.
 */
@interface MDCCollectionViewStyler : NSObject <MDCCollectionViewStyling>

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes and returns a newly allocated styler object with the specified collection view.

 Designated initializer.

 @param collectionView The controller's collection view.
 */
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView
    NS_DESIGNATED_INITIALIZER;

@end
