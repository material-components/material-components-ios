/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCShapeGenerating.h"

@class MDCCornerTreatment;
@class MDCEdgeTreatment;

/**
 An MDCShapeGenerating for creating shaped rectanglular CGPaths.

 By default MDCRectangleShapeGenerator creates rectanglular CGPaths. Set the corner and edge
 treatments to shape parts of the generated path.
 */
@interface MDCRectangleShapeGenerator : NSObject <MDCShapeGenerating>

/**
 The corner treatments to apply to each corner.
 */
@property(nonatomic, strong) MDCCornerTreatment *topLeftCorner;
@property(nonatomic, strong) MDCCornerTreatment *topRightCorner;
@property(nonatomic, strong) MDCCornerTreatment *bottomLeftCorner;
@property(nonatomic, strong) MDCCornerTreatment *bottomRightCorner;

/**
 The offsets to apply to each corner.
 */
@property(nonatomic, assign) CGPoint topLeftCornerOffset;
@property(nonatomic, assign) CGPoint topRightCornerOffset;
@property(nonatomic, assign) CGPoint bottomLeftCornerOffset;
@property(nonatomic, assign) CGPoint bottomRightCornerOffset;

/**
 The edge treatments to apply to each edge.
 */
@property(nonatomic, strong) MDCEdgeTreatment *topEdge;
@property(nonatomic, strong) MDCEdgeTreatment *rightEdge;
@property(nonatomic, strong) MDCEdgeTreatment *bottomEdge;
@property(nonatomic, strong) MDCEdgeTreatment *leftEdge;

/**
 Convenience to set all corners to the same MDCCornerTreatment instance.
 */
- (void)setCorners:(MDCCornerTreatment *)cornerShape;

/**
 Conveninece to set all edge treatments to the same MDCEdgeTreatment instance.
 */
- (void)setEdges:(MDCEdgeTreatment *)edgeShape;

@end
