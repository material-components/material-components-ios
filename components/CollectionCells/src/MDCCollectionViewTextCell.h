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

#import "MDCCollectionViewCell.h"

/** Default cell height for single line of text. Defaults to 48.0f. */
extern const CGFloat MDCCellDefaultOneLineHeight;

/** Default cell height for single line of text with avatar. Defaults to 56.0f. */
extern const CGFloat MDCCellDefaultOneLineWithAvatarHeight;

/** Default cell height for two lines of text. Defaults to 72.0f. */
extern const CGFloat MDCCellDefaultTwoLineHeight;

/** Default cell height for three lines of text. Defaults to 88.0f. */
extern const CGFloat MDCCellDefaultThreeLineHeight;

/**
 The MDCCollectionViewTextCell class provides an implementation of UICollectionViewCell that
 supports Material Design layout and styling. It provides two labels for text as well as an
 image view. The default layout specifications can be found at the following link.

 @see https://material.io/go/design-lists#lists-specs
 */
@interface MDCCollectionViewTextCell : MDCCollectionViewCell

/**
 A text label. Typically this will be the first line of text in the cell.

 Default text label properties:
  - text            defaults to nil.
  - font            defaults to [MDCTypography subheadFont].
  - textColor       defaults to [UIColor colorWithWhite:0 alpha:MDCTypography subheadFontOpacity]].
  - shadowColor     defaults to nil.
  - shadowOffset    defaults to CGSizeZero.
  - textAlignment   defaults to NSTextAlignmentNatural.
  - lineBreakMode   defaults to NSLineBreakByTruncatingTail.
  - numberOfLines   defaults to 1.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *textLabel;

/**
 A detail text label. Typically this will be the second line of text in the cell.

 Default detail text label properties:
 - text            defaults to nil.
 - font            defaults to [MDCTypography body1Font].
 - textColor       defaults to [UIColor colorWithWhite:0 alpha:MDCTypography captionFontOpacity]].
 - shadowColor     defaults to nil.
 - shadowOffset    defaults to CGSizeZero.
 - textAlignment   defaults to NSTextAlignmentNatural.
 - lineBreakMode   defaults to NSLineBreakByTruncatingTail.
 - numberOfLines   defaults to 1.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *detailTextLabel;

/**
 An image view on the leading side of cell. Default leading padding is 16.0f.
 */
@property(nonatomic, readonly, strong, nullable) UIImageView *imageView;

@end
