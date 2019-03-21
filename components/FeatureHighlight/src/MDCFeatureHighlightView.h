// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

@interface MDCFeatureHighlightView : UIView

@property(nonatomic, strong, nullable) UIColor *innerHighlightColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *outerHighlightColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong, nullable) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *titleColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong, nullable) UIFont *bodyFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *bodyColor UI_APPEARANCE_SELECTOR;

/*
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

/**
 Enable legacy font scaling curves for Dynamic Type
 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setLegacyFontScaling:) BOOL mdc_legacyFontScaling;

@end
