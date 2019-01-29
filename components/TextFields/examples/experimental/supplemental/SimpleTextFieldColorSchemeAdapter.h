// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "SimpleTextFieldLayoutUtils.h"
//#import "MDCInputViewContainerStyler.h"

// make NSCopying
@protocol SimpleTextFieldColorScheming <NSObject>
@property(strong, nonatomic, readonly, nonnull) UIColor *textColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *underlineLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *placeholderLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *clearButtonTintColor;
@end

@interface SimpleTextFieldColorScheme : NSObject <SimpleTextFieldColorScheming>
@property(strong, nonatomic) UIColor *textColor;
@property(strong, nonatomic) UIColor *underlineLabelColor;
@property(strong, nonatomic) UIColor *placeholderLabelColor;
@property(strong, nonatomic) UIColor *clearButtonTintColor;
@end


@interface SimpleTextFieldColorSchemeFilled : SimpleTextFieldColorScheme
@property(strong, nonatomic/*, readonly*/) UIColor *filledSublayerFillColor;
@property(strong, nonatomic/*, readonly*/) UIColor *filledSublayerUnderlineFillColor;
@end

@interface SimpleTextFieldColorSchemeOutlined : SimpleTextFieldColorScheme
@property(strong, nonatomic/*, readonly*/) UIColor *outlineColor;
@end
