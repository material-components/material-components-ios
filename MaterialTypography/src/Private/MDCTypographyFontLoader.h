/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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


#import <Foundation/Foundation.h>

@interface MDCTypographyFontLoader : NSObject
/**
 * @internal
 * This class provides conveince methods to grab roboto fonts.
 *
 * @ingroup Typography
 */

// fonts in the spec
+ (void)tryToLoadRobotoLightFont;
+ (void)tryToLoadRobotoRegularFont;
+ (void)tryToLoadRobotoMediumFont;

// others
+ (void)tryToLoadRobotoBoldFont;
+ (void)tryToLoadRobotoRegularItalicFont;
+ (void)tryToLoadRobotoBoldItalicFont;
+ (void)tryToLoadRobotoMediumItalicFont;
+ (void)tryToLoadRobotoLightItalicFont;

@end
