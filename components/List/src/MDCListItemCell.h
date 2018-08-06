/*
Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MDCBaseCell.h"

@interface MDCListItemCell : MDCBaseCell

/**
 The UIImageView responsible for displaying the leading image.
 */
@property (nonatomic, strong) UIImageView *leadingImageView;

/**
 The UIImageView responsible for displaying the trailing image.
 */
@property (nonatomic, strong) UIImageView *trailingImageView;

/**
 The UILabel responsible for displaying the title text.
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 The UILabel responsible for displaying the detail text.
 */
@property (nonatomic, strong) UILabel *detailLabel;

/**
 Sets the cell width for the self-sizing cell.
 Note: The self-sizing is only applied to the height, and the width is set using this method.
 */
@property (nonatomic, assign) CGFloat cellWidth;

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
