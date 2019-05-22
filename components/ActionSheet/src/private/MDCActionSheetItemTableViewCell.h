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

#import <MaterialComponents/MaterialInk.h>
#import <UIKit/UIKit.h>
#import "MDCActionSheetController.h"
#import "MaterialInk.h"

@interface MDCActionSheetItemTableViewCell : UITableViewCell
/**
  The action contains the title, image, and handler
  If you need to change any of the three you must pass a new action in.
*/
@property(nonatomic, nonnull) MDCActionSheetAction *action;

@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

@property(nonatomic, nonnull, strong) UIFont *actionFont;

@property(nonatomic, strong, nullable) UIColor *actionTextColor;

@property(nonatomic, strong, nullable) UIColor *inkColor;

@property(nonatomic) UIImageRenderingMode imageRenderingMode;

@end
