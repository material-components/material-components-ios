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

@protocol MDCColorScheme;

/** A function that will perform drawing operations in @c frame. */
typedef void (*MDCDrawFunc)(CGRect frame, id<MDCColorScheme> colorScheme);

/** Render the drawing operations in @c drawFunc into a new image. */
UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc, id<MDCColorScheme> colorScheme);

/* Draw logo. */
void MDCCatalogDrawMDCLogoDark(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawMDCLogoLight(CGRect frame, id<MDCColorScheme> colorScheme);

/* Draw various tiles. */
void MDCCatalogDrawActivityIndicatorTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawAnimationTimingTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawAppBarTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawBottomAppBarTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawBottomNavTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawBottomSheetTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawButtonBarTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawButtonsTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawCollectionCellsTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawCollectionsTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawDialogsTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawFeatureHighlightTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawFlexibleHeaderTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawHeaderStackViewTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawInkTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawMaskedTransitionTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawMiscTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawNavigationBarTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawOverlayWindow(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawPageControlTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawPalettesTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawProgressViewTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawShadowLayerTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawSliderTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawSnackbarTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawTabsTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawTextFieldTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawThemesTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawTypographyTile(CGRect frame, id<MDCColorScheme> colorScheme);
void MDCCatalogDrawTypographyCustomFontsTile(CGRect frame, id<MDCColorScheme> colorScheme);
