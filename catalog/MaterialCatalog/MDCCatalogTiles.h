// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

@protocol MDCColorScheming;

/** A function that will perform drawing operations in @c frame. */
typedef void (*MDCDrawFunc)(CGRect frame, id<MDCColorScheming> colorScheme);

/** Render the drawing operations in @c drawFunc into a new image. */
UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc, id<MDCColorScheming> colorScheme);

/* Draw logo. */
void MDCCatalogDrawMDCLogoDark(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawMDCLogoLight(CGRect frame, id<MDCColorScheming> colorScheme);

/* Draw various tiles. */
void MDCCatalogDrawActivityIndicatorTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawAnimationTimingTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawAppBarTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawBottomAppBarTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawBottomNavTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawBottomSheetTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawButtonBarTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawButtonsTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawCollectionCellsTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawCollectionsTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawDialogsTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawFeatureHighlightTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawFlexibleHeaderTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawHeaderStackViewTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawInkTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawMaskedTransitionTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawMiscTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawNavigationBarTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawOverlayWindow(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawPageControlTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawPalettesTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawProgressViewTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawShadowLayerTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawSliderTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawSnackbarTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawTabsTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawTextFieldTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawThemesTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawTypographyTile(CGRect frame, id<MDCColorScheming> colorScheme);
void MDCCatalogDrawTypographyCustomFontsTile(CGRect frame, id<MDCColorScheming> colorScheme);
