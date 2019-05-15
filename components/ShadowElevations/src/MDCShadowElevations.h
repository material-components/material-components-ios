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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

#ifdef NS_TYPED_EXTENSIBLE_ENUM  // This macro is introduced in Xcode 9.
#define MDC_SHADOW_ELEVATION_TYPED_EXTENSIBLE_ENUM NS_TYPED_EXTENSIBLE_ENUM
#elif __has_attribute(swift_wrapper)  // Backwards compatibility for Xcode 8.
#define MDC_SHADOW_ELEVATION_TYPED_EXTENSIBLE_ENUM __attribute__((swift_wrapper(struct)))
#else
#define MDC_SHADOW_ELEVATION_TYPED_EXTENSIBLE_ENUM
#endif

/**
 Constants for elevation: the relative depth, or distance, between two surfaces along the z-axis.
 https://material.io/go/design-elevation
 */
NS_SWIFT_NAME(ShadowElevation)
typedef CGFloat MDCShadowElevation MDC_SHADOW_ELEVATION_TYPED_EXTENSIBLE_ENUM;

/** The shadow elevation of the app bar. */
static const MDCShadowElevation MDCShadowElevationAppBar = (CGFloat)4.0;

/** The shadow elevation of the Bottom App Bar. */
static const MDCShadowElevation MDCShadowElevationBottomNavigationBar = (CGFloat)8.0;

/** The shadow elevation of a card in its picked up state. */
static const MDCShadowElevation MDCShadowElevationCardPickedUp = (CGFloat)8.0;

/** The shadow elevation of a card in its resting state. */
static const MDCShadowElevation MDCShadowElevationCardResting = (CGFloat)2.0;

/** The shadow elevation of dialogs. */
static const MDCShadowElevation MDCShadowElevationDialog = (CGFloat)24.0;

/** The shadow elevation of the floating action button in its pressed state. */
static const MDCShadowElevation MDCShadowElevationFABPressed = (CGFloat)12.0;

/** The shadow elevation of the floating action button in its resting state. */
static const MDCShadowElevation MDCShadowElevationFABResting = (CGFloat)6.0;

/** The shadow elevation of a menu. */
static const MDCShadowElevation MDCShadowElevationMenu = (CGFloat)8.0;

/** The shadow elevation of a modal bottom sheet. */
static const MDCShadowElevation MDCShadowElevationModalBottomSheet = (CGFloat)16.0;

/** The shadow elevation of the navigation drawer. */
static const MDCShadowElevation MDCShadowElevationNavDrawer = (CGFloat)16.0;

/** No shadow elevation at all. */
static const MDCShadowElevation MDCShadowElevationNone = (CGFloat)0.0;

/** The shadow elevation of a picker. */
static const MDCShadowElevation MDCShadowElevationPicker = (CGFloat)24.0;

/** The shadow elevation of the quick entry in the scrolled state. */
static const MDCShadowElevation MDCShadowElevationQuickEntry = (CGFloat)3.0;

/** The shadow elevation of the quick entry in the resting state. */
static const MDCShadowElevation MDCShadowElevationQuickEntryResting = (CGFloat)2.0;

/** The shadow elevation of a raised button in the pressed state. */
static const MDCShadowElevation MDCShadowElevationRaisedButtonPressed = (CGFloat)8.0;

/** The shadow elevation of a raised button in the resting state. */
static const MDCShadowElevation MDCShadowElevationRaisedButtonResting = (CGFloat)2.0;

/** The shadow elevation of a refresh indicator. */
static const MDCShadowElevation MDCShadowElevationRefresh = (CGFloat)3.0;

/** The shadow elevation of the right drawer. */
static const MDCShadowElevation MDCShadowElevationRightDrawer = (CGFloat)16.0;

/** The shadow elevation of the search bar in the resting state. */
static const MDCShadowElevation MDCShadowElevationSearchBarResting = (CGFloat)2.0;

/** The shadow elevation of the search bar in the scrolled state. */
static const MDCShadowElevation MDCShadowElevationSearchBarScrolled = (CGFloat)3.0;

/** The shadow elevation of the snackbar. */
static const MDCShadowElevation MDCShadowElevationSnackbar = (CGFloat)6.0;

/** The shadow elevation of a sub menu (+1 for each additional sub menu). */
static const MDCShadowElevation MDCShadowElevationSubMenu = (CGFloat)9.0;

/** The shadow elevation of a switch. */
static const MDCShadowElevation MDCShadowElevationSwitch = (CGFloat)1.0;
