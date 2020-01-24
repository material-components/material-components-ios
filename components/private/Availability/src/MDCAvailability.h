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

#ifndef MDC_AVAILABILITY
#define MDC_AVAILABILITY

#include "Availability.h"

/*
    A header for to be used in conjunction with Availability.h to conditionally compile OS sensitive
    code. These macros are for Material Components internal use only.

    MDC_AVAILABLE_IOS(_ios) evaluates to true when the target SDK is greater than equal to the given
    value.  Example:

    #if MDC_AVAILABLE_IOS(__IPHONE_13_0)
      // iOS 13 specific code.
    #endif
 */

#define MDC_AVAILABLE_IOS(_ios) _ios != 0 && (__IPHONE_OS_VERSION_MAX_ALLOWED >= _ios)

#endif  // MDC_AVAILABILITY
