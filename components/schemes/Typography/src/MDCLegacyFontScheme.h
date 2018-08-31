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

#pragma mark - Soon to be deprecated

/**
 A font scheme comprised of set of UIFonts that are associated with various text styles.

 By apply the scheme to various components using themers one can set fonts on a single instance
 of a components.

 If a font in a scheme is nil, a component should use its default font.

 @warning This class will soon be deprecated. Consider using MDCTypographyScheming instead.
 */
@protocol MDCFontScheme <NSObject>

/** The font-face to be used for Headline 1. */
@property(nonatomic, strong, nullable, readonly) UIFont *headline1;

/** The font-face to be used for Headline 2. */
@property(nonatomic, strong, nullable, readonly) UIFont *headline2;

/** The font-face to be used for Headline 3. */
@property(nonatomic, strong, nullable, readonly) UIFont *headline3;

/** The font-face to be used for Headline 4. */
@property(nonatomic, strong, nullable, readonly) UIFont *headline4;

/** The font-face to be used for Headline 5. */
@property(nonatomic, strong, nullable, readonly) UIFont *headline5;

/** The font-face to be used for Headline 6. */
@property(nonatomic, strong, nullable, readonly) UIFont *headline6;

/** The font-face to be used for Subtitle 1. */
@property(nonatomic, strong, nullable, readonly) UIFont *subtitle1;

/** The font-face to be used for Subtitle 2. */
@property(nonatomic, strong, nullable, readonly) UIFont *subtitle2;

/** The font-face to be used for Body 1. */
@property(nonatomic, strong, nullable, readonly) UIFont *body1;

/** The font-face to be used for Body 2. */
@property(nonatomic, strong, nullable, readonly) UIFont *body2;

/** The font-face to be used for Caption. */
@property(nonatomic, strong, nullable, readonly) UIFont *caption;

/** The font-face to be used for Caption. */
@property(nonatomic, strong, nullable, readonly) UIFont *button;

/** The font-face to be used for Overline. */
@property(nonatomic, strong, nullable, readonly) UIFont *overline;

@end

/**
 A basic font scheme implements the MDCFontScheme protocol.

 @warning This class will soon be deprecated. Consider using MDCTypographyScheme instead.
 */
@interface MDCBasicFontScheme : NSObject <MDCFontScheme>

@property(nonatomic, nullable) UIFont *headline1;
@property(nonatomic, nullable) UIFont *headline2;
@property(nonatomic, nullable) UIFont *headline3;
@property(nonatomic, nullable) UIFont *headline4;
@property(nonatomic, nullable) UIFont *headline5;
@property(nonatomic, nullable) UIFont *headline6;
@property(nonatomic, nullable) UIFont *subtitle1;
@property(nonatomic, nullable) UIFont *subtitle2;
@property(nonatomic, nullable) UIFont *body1;
@property(nonatomic, nullable) UIFont *body2;
@property(nonatomic, nullable) UIFont *caption;
@property(nonatomic, nullable) UIFont *button;
@property(nonatomic, nullable) UIFont *overline;

@end
