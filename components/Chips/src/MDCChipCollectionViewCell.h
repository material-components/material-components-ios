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

@class MDCChipView;

/*
 A collection view cell containing a single MDCChipView.
 MDCChipCollectionViewCell manages the state of its chipView based on its own states.
 E.g: setting the state of the cell to selected will automatically apply to its chipView as well.
 */
@interface MDCChipCollectionViewCell : UICollectionViewCell

/*
 The chip view.

 The chip's bounds will be set to fill the collection view cell.
 */
@property(nonatomic, nonnull, strong, readonly) MDCChipView *chipView;

/*
 Animates the chip view every time the bounds change. Defaults to NO.

 Set this to YES to animate chip view when it resizes. If the chip view changes size upon selection
 this should be set to YES.
 */
@property(nonatomic, assign) BOOL alwaysAnimateResize;

/*
 Creates an MDCChipView for use in the collection view cell.

 Override this method to return a custom MDCChipView subclass.
 */
- (nonnull MDCChipView *)createChipView;

@end
