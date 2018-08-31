// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBaseCell.h"

/**
 MDCSelfSizingStereoCell is intended to be an easy to use readymade implementation of a basic
 "Stereo" cell. A stereo cell can be thought of as a roughly symmetrical cell with image views on
 either side--like the speakers in an old fashioned boombox stereo.

 The cell is intended to be used with a UICollectionViewFlowLayout with an estimatedItemSize.
 Setting estimatedItemSize on the layout tells the collection view and the layout to query the cell
 for a size that best fits the estimated size. The cell lays out its contents according to the width
 provided in the estimated size and then calculates a height based off the layout. For any given
 width there is only one correct height.

 The client is expected to configure the exposed subviews in any way they like from within
 `-collectionView:cellForItemAtIndexPath:`. If changes that might have ramifications to the cell's
 layout or size are made outside of `-collectionView:cellForItemAtIndexPath:` a call to
 `-setNeedsLayout` is necessary to invalidate previously calculated layouts.

 The client is expected NOT to manually set the frames of the view themselves or manipulate the view
 hierarchy in any way.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCSelfSizingStereoCell : MDCBaseCell

/**
 The UIImageView responsible for displaying the leading image.
 */
@property(nonatomic, strong, readonly) UIImageView *leadingImageView;

/**
 The UIImageView responsible for displaying the trailing image.
 */
@property(nonatomic, strong, readonly) UIImageView *trailingImageView;

/**
 The UILabel responsible for displaying the title text. By default, `numberOfLines` is set to 0 so
 the label wraps and the self-sizing capabilities of the cell are best utilized.
 */
@property(nonatomic, strong, readonly) UILabel *titleLabel;

/**
 The UILabel responsible for displaying the detail text. By default, `numberOfLines` is set to 0 so
 the label wraps and the self-sizing capabilities of the cell are best utilized.
 */
@property(nonatomic, strong, readonly) UILabel *detailLabel;

/**
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.
 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.
 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

@end
