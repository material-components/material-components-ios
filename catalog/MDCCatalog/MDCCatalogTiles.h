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

/** A function that will perform drawing operations in @c frame. */
typedef void (*MDCDrawFunc)(CGRect);

/** Render the drawing operations in @c drawFunc into a new image. */
UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc);

/* Draw various tiles. */
void MDCCatalogDrawActivityIndicatorTile(CGRect frame);
void MDCCatalogDrawAppBarTile(CGRect frame);
void MDCCatalogDrawButtonBarTile(CGRect frame);
void MDCCatalogDrawButtonsTile(CGRect frame);
void MDCCatalogDrawCollectionsTile(CGRect frame);
void MDCCatalogDrawDialogsTile(CGRect frame);
void MDCCatalogDrawFlexibleHeaderTile(CGRect frame);
void MDCCatalogDrawHeaderStackViewTile(CGRect frame);
void MDCCatalogDrawInkTile(CGRect frame);
void MDCCatalogDrawMiscTile(CGRect frame);
void MDCCatalogDrawNavigationBarTile(CGRect frame);
void MDCCatalogDrawPageControlTile(CGRect frame);
void MDCCatalogDrawShadowLayerTile(CGRect frame);
void MDCCatalogDrawSliderTile(CGRect frame);
void MDCCatalogDrawSnackbarTile(CGRect frame);
void MDCCatalogDrawSpritedAnimationViewTile(CGRect frame);
void MDCCatalogDrawSwitchTile(CGRect frame);
void MDCCatalogDrawTypographyTile(CGRect frame);
