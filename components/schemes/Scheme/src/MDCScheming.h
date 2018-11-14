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

#pragma mark - Today

typedef NSString * const MDCSchemeName NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXTERN MDCSchemeName _Nonnull MDCSchemeNameColor;
FOUNDATION_EXTERN MDCSchemeName _Nonnull MDCSchemeNameShape;
FOUNDATION_EXTERN MDCSchemeName _Nonnull MDCSchemeNameTypography;

#pragma mark - With a new subsystem

FOUNDATION_EXTERN const MDCSchemeName _Nonnull MDCSchemeNameMotion;

@protocol MDCScheming <NSObject>
@end
