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

#import <Foundation/Foundation.h>

#ifndef MDC_SUBCLASSING_RESTRICTED
#if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#define MDC_SUBCLASSING_RESTRICTED __attribute__((objc_subclassing_restricted))
#else
#define MDC_SUBCLASSING_RESTRICTED
#endif
#endif  // #ifndef MDC_SUBCLASSING_RESTRICTED

/**
 Information about the Material Components library.
 */
MDC_SUBCLASSING_RESTRICTED
@interface MDCLibraryInfo: NSObject

/**
 The version of the MDC-iOS library.
 
 The version string will always have the form "X.Y.Z", where
 - X is the major version number of the library.
 - Y is the minor version number of the library.
 - Z is the patch version number of the library.
 */
@property(class, nonatomic, nonnull, readonly) NSString *versionString;

@end
