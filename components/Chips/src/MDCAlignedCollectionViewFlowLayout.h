/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

typedef enum : NSUInteger {
  MDCCollectionHorizontalAlignmentLeading,
  MDCCollectionHorizontalAlignmentTrailing,
  MDCCollectionHorizontalAlignmentLeft,
  MDCCollectionHorizontalAlignmentRight
} MDCCollectionHorizontalAlignment;

/*
 MDCAlignedCollectionViewFlowLayout is an aligned version of UICollectionViewFlowLayout.

 Use exactly as you would a standard UICollectionViewLayout. Set minimumInteritemSpacing to control
 spacing between cells.
 */
@interface MDCAlignedCollectionViewFlowLayout : UICollectionViewFlowLayout

/*
 The horizontal alignment of the layout.

 Defaults to MDCCollectionHorizontalAlignmentLeading.
*/
@property(nonatomic, assign) MDCCollectionHorizontalAlignment horizontalAlignment;

@end
