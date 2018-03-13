/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

@class MDCExperimentalColorScheme;

/** A function that will perform drawing operations in @c frame. */
typedef void (*MDCDrawFunc)(CGRect frame, MDCExperimentalColorScheme * colorScheme);

/** Render the drawing operations in @c drawFunc into a new image. */
UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc, MDCExperimentalColorScheme * colorScheme);

/* Draw logo. */
void MDCCatalogDrawMDCLogoDark(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawMDCLogoLight(CGRect frame, MDCExperimentalColorScheme * colorScheme);

/* Draw various tiles. */
void MDCCatalogDrawActivityIndicatorTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawAnimationTimingTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawAppBarTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawBottomAppBarTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawBottomNavTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawBottomSheetTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawButtonBarTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawButtonsTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawCollectionCellsTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawCollectionsTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawDialogsTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawFeatureHighlightTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawFlexibleHeaderTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawHeaderStackViewTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawInkTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawMaskedTransitionTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawMiscTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawNavigationBarTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawOverlayWindow(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawPageControlTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawPalettesTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawProgressViewTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawShadowLayerTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawSliderTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawSnackbarTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawTabsTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawTextFieldTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawThemesTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawTypographyTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
void MDCCatalogDrawTypographyCustomFontsTile(CGRect frame, MDCExperimentalColorScheme * colorScheme);
