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
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

// This macro is introduced in Xcode 9.
//#ifndef CF_TYPED_ENUM // What follows is backwards compat for Xcode 8 and below.
//#if __has_attribute(swift_wrapper)
//#define CF_TYPED_ENUM __attribute__((swift_wrapper(enum)))
//#else
//#define CF_TYPED_ENUM
//#endif
//#endif

/**
 Constants for elevation: the relative depth, or distance, between two surfaces along the z-axis.
 https://material.io/guidelines/material-design/elevation-shadows.html
 */
@interface MDCShadowElevation : NSObject

@property(nonatomic, assign) CGFloat value;

+ (CGFloat)appBar;
+ (CGFloat)cardPickedUp;
+ (CGFloat)cardResting;
+ (CGFloat)cardDialog;
+ (CGFloat)fabPressed;
+ (CGFloat)fabResting;
+ (CGFloat)menu;
+ (CGFloat)modalBottomSheet;
+ (CGFloat)navDrawer;
+ (CGFloat)none;
+ (CGFloat)picker;
+ (CGFloat)quickEntry;
+ (CGFloat)quickEntryResting;
+ (CGFloat)raisedButtonPressed;
+ (CGFloat)raisedButtonResting;
+ (CGFloat)refresh;
+ (CGFloat)rightDrawer;
+ (CGFloat)searchBarResting;
+ (CGFloat)searchBarScrolled;
+ (CGFloat)snackbar;
+ (CGFloat)subMenu;
+ (CGFloat)switch;

@end
