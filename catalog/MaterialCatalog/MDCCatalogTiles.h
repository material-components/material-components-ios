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
typedef void (*MDCDrawFunc)(CGRect frame, NSObject<MDCColorScheme> *colorScheme);

/** Render the drawing operations in @c drawFunc into a new image. */
UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc, NSObject<MDCColorScheme> *colorScheme);

/* Draw various tiles. */
void MDCCatalogDrawActivityIndicatorTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawAnimationTimingTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawAppBarTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawButtonBarTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawButtonsTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawCollectionCellsTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawCollectionsTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawDialogsTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawFeatureHighlightTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawFlexibleHeaderTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawHeaderStackViewTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawInkTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawMiscTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawNavigationBarTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawOverlayWindow(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawPageControlTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawPalettesTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawProgressViewTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawShadowLayerTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawSliderTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawSnackbarTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawSwitchTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawTabsTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawTextFieldTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
void MDCCatalogDrawTypographyTile(CGRect frame, NSObject<MDCColorScheme> *colorScheme);
