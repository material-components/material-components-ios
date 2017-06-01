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

@class MDCBasicColorScheme;

/** A function that will perform drawing operations in @c frame. */
typedef void (*MDCDrawFunc)(CGRect, MDCBasicColorScheme*);

/** Render the drawing operations in @c drawFunc into a new image. */
UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc, MDCBasicColorScheme *colorScheme);

/* Draw various tiles. */
void MDCCatalogDrawActivityIndicatorTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawAnimationTimingTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawAppBarTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawButtonBarTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawButtonsTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawCollectionCellsTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawCollectionsTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawDialogsTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawFeatureHighlightTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawFlexibleHeaderTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawHeaderStackViewTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawInkTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawMiscTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawNavigationBarTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawOverlayWindow(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawPageControlTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawPalettesTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawProgressViewTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawShadowLayerTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawSliderTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawSnackbarTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawSwitchTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawTabsTile(CGRect frame, MDCBasicColorScheme *colorScheme);
void MDCCatalogDrawTypographyTile(CGRect frame, MDCBasicColorScheme *colorScheme);
