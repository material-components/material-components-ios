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
#ifndef CF_TYPED_ENUM // What follows is backwards compat for Xcode 8 and below.
#if __has_attribute(swift_wrapper)
#define CF_TYPED_ENUM __attribute__((swift_wrapper(enum)))
#else
#define CF_TYPED_ENUM
#endif
#endif

/**
 Constants for elevation: the relative depth, or distance, between two surfaces along the z-axis.
 https://material.io/guidelines/material-design/elevation-shadows.html
 */
NS_SWIFT_NAME(ShadowElevation)
typedef CGFloat MDCShadowElevation CF_TYPED_ENUM;

/** The shadow elevation of the app bar. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationAppBar NS_SWIFT_NAME(appBar);

/** The shadow elevation of a card in its picked up state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationCardPickedUp
    NS_SWIFT_NAME(cardPickedUp);

/** The shadow elevation of a card in its resting state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationCardResting NS_SWIFT_NAME(cardResting);

/** The shadow elevation of dialogs. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationDialog NS_SWIFT_NAME(dialog);

/** The shadow elevation of the floating action button in its pressed state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationFABPressed NS_SWIFT_NAME(fabPressed);

/** The shadow elevation of the floating action button in its resting state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationFABResting NS_SWIFT_NAME(fabResting);

/** The shadow elevation of a menu. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationMenu NS_SWIFT_NAME(menu);

/** The shadow elevation of a modal bottom sheet. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationModalBottomSheet
    NS_SWIFT_NAME(modalBottomSheet);

/** The shadow elevation of the navigation drawer. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationNavDrawer NS_SWIFT_NAME(navDrawer);

/** No shadow elevation at all. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationNone NS_SWIFT_NAME(none);

/** The shadow elevation of a picker. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationPicker NS_SWIFT_NAME(picker);

/** The shadow elevation of the quick entry in the scrolled state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationQuickEntry NS_SWIFT_NAME(quickEntry);

/** The shadow elevation of the quick entry in the resting state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationQuickEntryResting
    NS_SWIFT_NAME(quickEntryResting);

/** The shadow elevation of a raised button in the pressed state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationRaisedButtonPressed NS_SWIFT_NAME(raisedButtonPressed);

/** The shadow elevation of a raised button in the resting state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationRaisedButtonResting NS_SWIFT_NAME(raisedButtonResting);

/** The shadow elevation of a refresh indicator. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationRefresh NS_SWIFT_NAME(refresh);

/** The shadow elevation of the right drawer. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationRightDrawer NS_SWIFT_NAME(rightDrawer);

/** The shadow elevation of the search bar in the resting state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationSearchBarResting
    NS_SWIFT_NAME(searchBarResting);

/** The shadow elevation of the search bar in the scrolled state. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationSearchBarScrolled
    NS_SWIFT_NAME(searchBarScrolled);

/** The shadow elevation of the snackbar. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationSnackbar NS_SWIFT_NAME(snackbar);

/** The shadow elevation of a sub menu (+1 for each additional sub menu). */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationSubMenu NS_SWIFT_NAME(subMenu);

/** The shadow elevation of a switch. */
FOUNDATION_EXPORT const MDCShadowElevation MDCShadowElevationSwitch NS_SWIFT_NAME(switch);

