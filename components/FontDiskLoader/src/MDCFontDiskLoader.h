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

#import <AvailabilityMacros.h>
#import <UIKit/UIKit.h>

/**
 This class loads and registers a custom font by file url.

 This class provides a convenience layer on top of CoreText APIs. Registration occurs by @c fileURL,
 therefore registration state is shared across all instances of MDCFontDiskLoader objects. For
 example if two MDCFontDiskLoader objects have the same fileURL, calling @c load one will also
 alter the state of the second MDCFontDiskLoader object. The same holds true for @c unload.
 This class is thread safe and can be called from any thread.
 */
DEPRECATED_MSG_ATTRIBUTE("Use https://github.com/material-foundation/material-font-disk-loader-ios instead.")
@interface MDCFontDiskLoader : NSObject <NSCopying>

/**
 Designated initializer for the MDCFontDiskLoader.

 @param fontName The font's name as it is defined in the resource file.
 @param fontURL The url location of the font on the file system.
 */
- (nonnull instancetype)initWithFontName:(nonnull NSString *)fontName
                                 fontURL:(nonnull NSURL *)fontURL NS_DESIGNATED_INITIALIZER;

/**
 Convenience initializer for the MDCFontDiskLoader.

 @param fontName The font's name as it is defined in the ttf file.
 @param filename The name of the font file. For example a *.ttf file.
 @param bundleFilename The name of the bundle.
 @param baseBundle The bundle to look in.
 */
- (nonnull instancetype)initWithFontName:(nonnull NSString *)fontName
                                filename:(nonnull NSString *)filename
                          bundleFileName:(nonnull NSString *)bundleFilename
                              baseBundle:(nonnull NSBundle *)baseBundle;

/**
 This class requires a fontURL and fontName therefore init is no longer allowed.
 Please use initWithFontName:fontURL:
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

/** The name of the font within the font resource file. */
@property(nonatomic, readonly, copy, nonnull) NSString *fontName;

/** The URL of the font asset. */
@property(nonatomic, readonly, copy, nonnull) NSURL *fontURL;

/**
 The loaded state of the custom font.

 All instances of MDCFontDiskLoader with the same fontURL have the same value of @c loaded.
 */
@property(nonatomic, readonly, getter=isLoaded) BOOL loaded;

/**
 This flag is true when the registration failed.

 It prevents future attempts at registration. To reset call @c unload.
 */
@property(nonatomic, readonly, getter=hasLoadFailed) BOOL loadFailed;

/**
 Attempts to load the font.

 All instances of MDCFontDiskLoader with the same fontURL will reflect changes from this method.

 The @c loaded and @c loadFailed flags reflect the results of this registration
 attempt. Returns true if the font is loaded. If font registration fails, subsequent calls to
 load will fail unless unload is called first.
 */
- (BOOL)load;

/**
 Attempts to unload the font.

 All instances of MDCFontDiskLoader with the same fontURL will reflect changes from this method.

 Returns true when the font is unloaded. Resets @c loadFailed back to false.
 */
- (BOOL)unload;

/** A convience method for getting a font. */
- (nullable UIFont *)fontOfSize:(CGFloat)fontSize;

@end
