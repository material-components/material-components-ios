// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 * Allows `UICollectionViewLayout` subclasses to inform `MDCBaseCell` what size the cell can be.
 *
 * Conform your `UICollectionViewLayoutAttributes` subclass to this protocol.
 */
@protocol MDCSelfSizingLayoutAttributes <NSObject>

@optional

/**
 * Whether the cell has a fixed horizontal size.
 *
 * Return YES to inform the cell it won't be allowed to resize horizontally. Default is NO.
 */
@property(nonatomic, readonly) BOOL isFixedWidth;

/**
 * Whether the cell has a fixed vertical size.
 *
 * Return YES to inform the cell it won't be allowed to resize vertically. Default is NO.
 */
@property(nonatomic, readonly) BOOL isFixedHeight;

@end
