// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

/** Test image styles usable for snapshot testing in place of icons. */
typedef NS_ENUM(NSInteger, MDCSnapshotTestImageStyle) {

  /** An alternating pattern of squares like a checkerboard or chessboard. */
  MDCSnapshotTestImageStyleCheckerboard = 0,

  /** Concentric outlined rectangles. */
  MDCSnapshotTestImageStyleRectangles = 1,

  /** Concentric outlined ellipses. */
  MDCSnapshotTestImageStyleEllipses = 2,

  /** Lines arranged at a 45-degree angle. */
  MDCSnapshotTestImageStyleDiagonalLines = 3,

  /** A full-bleed "X" with a rectangular frame. */
  MDCSnapshotTestImageStyleFramedX = 4,
};

@interface UIImage (MDCSnapshot)

/**
 Creates a new image useful for testing with a given size. The image is a repeating pattern of black
 squares on a transparent background.

 @param size The size of the image to create.
 @return a new image of the specified size.
 */
+ (UIImage *)mdc_testImageOfSize:(CGSize)size;

/**
 Creates a new image useful for testing with a given size with a specific style.

 @param size The size of the image to create.
 @param imageStyle The style of the image to create.
 @return a new image of the specified size.
 */
+ (UIImage *)mdc_testImageOfSize:(CGSize)size withStyle:(MDCSnapshotTestImageStyle)imageStyle;

@end
