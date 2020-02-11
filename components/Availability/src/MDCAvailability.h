// Copyright 2020-present the Material Components for iOS authors. All Rights
// Reserved.
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

#ifndef MDC_AVAILABILITY
#define MDC_AVAILABILITY

#include <Availability.h>

/*
  A header to be used in conjunction with Availability.h to conditionally
  compile OS sensitive code.

  MDC_AVAILABLE_SDK_IOS(_ios) evaluates to true when the maximum target SDK is
  greater than equal to the given value. This will only prevent code from
  compiling when built with a maximum SDK version lower than the version
  specified. A runtime check may still be necessary. Example:

  #if MDC_AVAILABLE_SDK_IOS(13_0)
    // iOS 13 specific code.
  #endif
 */

#define MDC_AVAILABLE_SDK_IOS(_ios) \
  ((__IPHONE_##_ios != 0) &&        \
   (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_##_ios))

#endif  // MDC_AVAILABILITY
