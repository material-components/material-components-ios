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

#import "ManualLayoutListBaseCell2.h"

@protocol MDCTypographyScheming;

/**
 An customizable Manual Layout based cell for use in Material Lists.
 */
@interface ManualLayoutListItemCell2 : ManualLayoutListBaseCell2

/**
 Sets the cell width for the self-sizing cell.
 Note: The self-sizing is only applied to the height, and the width is set using this method.
 */
@property (nonatomic, assign) CGFloat cellWidth;

/**
 A convenience accessor for the title text.
 */
@property (nonatomic, copy, nullable) NSString *titleText;

/**
 A convenience accessor for the title text color.
 */
@property (nonatomic, strong, nullable) UIColor *titleLabelTextColor;

/**
 A convenience accessor for the title text font.
 */
@property (nonatomic, strong, nullable) UIFont *titleLabelFont;

/**
 A convenience accessor for the title text font.
 */
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;

/**
 A convenience accessor for the detail text.
 */
@property (nonatomic, copy, nullable) NSString *detailText;

/**
 A convenience accessor for the detail text color.
 */
@property (nonatomic, strong, nullable) UIColor *detailLabelTextColor;

/**
 A convenience accessor for the detail text font.
 */
@property (nonatomic, strong, nullable) UIFont *detailLabelFont;

/**
 A convenience accessor for the detail text font.
 */
@property (nonatomic, assign) NSTextAlignment detailLabelTextAlignment;

/**
 The UIImageview used to display the leading image.
 */
@property (strong, nonatomic, nonnull, readonly) UIImageView *leadingImageView;

/**
 A convenience accessor for the leading image.
 */
@property (strong, nonatomic, nullable) UIImage *leadingImage;

/**
 A convenience accessor for the leading image corner radius.
 */
@property (nonatomic, assign) UIImage *leadingImageCornerRadius;

/**
 A convenience accessor for the trailing image.
 */
@property (strong, nonatomic, nullable) UIImage *trailingImage;

/**
 A convenience accessor for the trailing image corner radius.
 */
@property (nonatomic, assign) UIImage *trailingImageCornerRadius;

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
