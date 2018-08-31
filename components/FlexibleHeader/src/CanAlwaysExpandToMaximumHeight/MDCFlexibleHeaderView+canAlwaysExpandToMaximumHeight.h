// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialFlexibleHeader.h"

@interface MDCFlexibleHeaderView ()

/**
 Whether the flexible header is able to expand to its maximum height even when the target scroll
 view content offset is not at the top of the content.

 When enabled, the flexible header will be able to expand to its maximum height even when scrolled
 within the content of the tracking scroll view.

 When disabled, the flexible header will only expand to its maximum height once the scroll view
 reaches the top of its content.

 @note This is an experimental feature. Please do not enable it without first consulting the MDC
 team about your intended use case.

 Default is NO.
 */
@property(nonatomic) BOOL canAlwaysExpandToMaximumHeight;

@end
