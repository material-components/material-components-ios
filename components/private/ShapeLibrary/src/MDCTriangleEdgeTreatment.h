// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialShapes.h"

typedef enum : NSUInteger {
  MDCTriangleEdgeStyleHandle,
  MDCTriangleEdgeStyleCut,
} MDCTriangleEdgeStyle;

/**
 An edge treatment that adds a triangle-shaped cut or handle to the edge.
 */
@interface MDCTriangleEdgeTreatment : MDCEdgeTreatment

/**
 The size of the triangle shape.
 */
@property(nonatomic, assign) CGFloat size;

/**
 The style of the triangle shape.
 */
@property(nonatomic, assign) MDCTriangleEdgeStyle style;

/**
 Initializes an MDCTriangleEdgeTreatment with a given size and style.
 */
- (nonnull instancetype)initWithSize:(CGFloat)size style:(MDCTriangleEdgeStyle)style
    NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
