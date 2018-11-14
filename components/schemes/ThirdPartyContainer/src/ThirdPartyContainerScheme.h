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

#import <Foundation/Foundation.h>

#import "MaterialContainerScheme.h"

@protocol ThirdPartyContainerScheming <MDCContainerScheming>

#pragma mark - Today

// Overrides the parent type.
@property(nonatomic, strong, nullable, readonly) id<ThirdPartyColorScheming> colorScheme;

@end

__attribute__((objc_subclassing_restricted)) @interface ThirdPartyContainerScheme
    : NSObject<ThirdPartyContainerScheming>

#pragma mark - Today

@property(nonatomic, strong, nullable) ThirdPartyColorScheme *colorScheme;
@property(nonatomic, strong, nullable) MDCTypographyScheme *typographyScheme;

@property(nonatomic, strong, nullable) MDCShapeScheme *shapeScheme;

#pragma mark - With a new subsystem

@property(nonatomic, strong, nullable) MDCMotionScheme *motionScheme;

@end
