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

#import <Availability.h>

#if !defined(__IPHONE_4_1) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_4_1)
#error "This component only supports iOS 4.1 and above."
#endif

/**
 The RobotoFontLoader component provides methods for getting Roboto fonts.

 This header is the umbrella header for the component and should be imported by consumers of the
 RobotoFontLoader component. Please do not directly import other headers. This will allow the
 componet to expand or contract the header file space without consumer modifications.
 */

#import "MDCRobotoFontLoader.h"
