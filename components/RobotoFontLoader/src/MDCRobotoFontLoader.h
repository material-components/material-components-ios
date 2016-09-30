/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialTypography.h"

/**
 The MDCRobotoFontLoader class provides a central location where the Roboto fonts are lazily loaded.
 */
@interface MDCRobotoFontLoader : NSObject <MDCTypographyFontLoading>

/** Shared singleton instance. */
+ (nonnull MDCRobotoFontLoader *)sharedInstance;

/** This is a singleton: Use sharedInstance instead. */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Returns a lazy-registered Roboto Light font.

 If registration fails then the system font is returned.
 */
- (nonnull UIFont *)lightFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Regular font.

 If registration fails then the system font is returned.
 */
- (nonnull UIFont *)regularFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Medium font.

 If registration fails then the bold system font is returned.
 */
- (nonnull UIFont *)mediumFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Bold font.

 If registration fails then the bold system font is returned.
 */
- (nonnull UIFont *)boldFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Light Italic font.

 If registration fails then the italic system font is returned.
 */
- (nonnull UIFont *)lightItalicFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Regular Italic font.

 If registration fails then the italic system font is returned.
 */
- (nonnull UIFont *)italicFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Medium Italic font.

 If registration fails then the italic system font is returned.
 */
- (nonnull UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize;

/**
 Returns a lazy-registered Roboto Bold Italic font.

 If registration fails then the italic system font is returned.
 */
- (nonnull UIFont *)boldItalicFontOfSize:(CGFloat)fontSize;

@end
