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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A light-weight representation of a scalable font.

 On iOS 11 and up, this type enables you to describe a custom font and the corresponding
 UIFontMetrics that enable the font to scale in response to Dynamic Type settings.

 Pre iOS 11, this type can only be used to describe unscalable custom fonts.

 ## Usage notes

 This type enables you to pair font descriptors with specific UIFontMetrics. This is most commonly
 used for describing the metrics of a collection of custom fonts. If you just need to create a
 one-off custom font, prefer using a snippet of code like below instead:

 ```
 guard let customFont = UIFont(name: "CustomFont-Light", size: UIFont.labelFontSize) else {
     fatalError("""
         Failed to load the "CustomFont-Light" font.
         Make sure the font file is included in the project and the font name is spelled correctly.
         """
     )
 }
 label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
 label.adjustsFontForContentSizeCategory = true
 ```

 When using this type, the above snippet of code looks like this instead:

 ```
 // Create the type scale.
 let fontDescriptor = UIFontDescriptor(name: "CustomFont-Light", size: UIFont.labelFontSize)
 let scalableFontDescriptor: MDCScalableFontDescriptor
 scalableFontDescriptor = MDCScalableFontDescriptor(
   fontDescriptor: fontDescriptor,
   fontMetrics: UIFontMetrics(forTextStyle: .largeTitle)
 )

 // Use the scalable font descriptor.
 label.font = scalableFontDescriptor.preferredFont(compatibleWith: label.traitCollection)
 label.adjustsFontForContentSizeCategory = true
 ```

 @seealso https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically
 */
__attribute__((objc_subclassing_restricted)) @interface MDCScalableFontDescriptor : NSObject

/**
 A description of the font that will be loaded by baseFont and
 preferredFontCompatibleWithTraitCollection:.
 */
@property(nonnull, nonatomic, readonly) UIFontDescriptor *fontDescriptor;

/**
 A representation of the specific text style that will be used to scale the font.
 */
@property(nonnull, nonatomic, readonly) UIFontMetrics *fontMetrics API_AVAILABLE(ios(11.0));

/**
 Creates a new type scale with the provided font descriptor and font metrics.

 @param fontDescriptor A collection of attributes that describe the desired font.
 @param fontMetrics A representation of the specific text style that will be used to scale the font.
 */
- (nonnull instancetype)initWithFontDescriptor:(nonnull UIFontDescriptor *)fontDescriptor
                                   fontMetrics:(nonnull UIFontMetrics *)fontMetrics
    API_AVAILABLE(ios(11.0));

/**
 Creates a new type scale with the provided font descriptor.

 @param fontDescriptor A collection of attributes that describe the desired font.
 */
- (nonnull instancetype)initWithFontDescriptor:(nonnull UIFontDescriptor *)fontDescriptor
    API_DEPRECATED("Use initWithFontDescriptor:fontMetrics: instead.", ios(9.0, 11.0))
        NS_DESIGNATED_INITIALIZER;

/**
 Returns an unscaled, unscaling font.

 @note If a custom font is defined in @c fontDescriptor, it is the caller's responsibility to ensure
       that the font has been loaded into memory.
 */
- (nonnull UIFont *)baseFont;

/**
 Returns a pre-scaled, scalable font configured with this type scale's fontMetrics.

 If @c traitCollection is @c nil, then the current system content size category is used.

 @note If a custom font is defined in @c fontDescriptor, it is the caller's responsibility to ensure
       that the font has been loaded into memory.
 @param traitCollection The trait collection to use when pre-scaling the font. The returned
                        font is appropriate for use in an interface that adopts the specified
                        traits.
 @return A font that is pre-scaled for the given @c traitCollection.
 */
- (nonnull UIFont *)preferredFontCompatibleWithTraitCollection:
    (nullable UITraitCollection *)traitCollection API_AVAILABLE(ios(11.0));

- (null_unspecified instancetype)init NS_UNAVAILABLE;

@end
