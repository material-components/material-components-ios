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

#import <QuartzCore/QuartzCore.h>

#import "MaterialShadowLayer.h"

@protocol MDCShapeGenerating;

/*
 A shaped and Material-shadowed layer.
 */
@interface MDCShapedShadowLayer : MDCShadowLayer

/*
 Sets the shaped background color of the layer.

 Use shapedBackgroundColor instead of backgroundColor to ensure the background appears correct with
 or without a valid shape.

 @note If you set shapedBackgroundColor, you should not manually write to backgroundColor or
 fillColor.
 */
@property(nonatomic, strong, nullable) UIColor *shapedBackgroundColor;

/*
 Sets the shaped border color of the layer.

 Use shapedBorderColor instead of borderColor to ensure the border appears correct with or without
 a valid shape.

 @note If you set shapedBorderColor, you should not manually write to borderColor.
 */
@property(nonatomic, strong, nullable) UIColor *shapedBorderColor;

/*
 Sets the shaped border width of the layer.

 Use shapedBorderWidth instead of borderWidth to ensure the border appears correct with or without
 a valid shape.

 @note If you set shapedBorderWidth, you should not manually write to borderWidth.
 */
@property(nonatomic, assign) CGFloat shapedBorderWidth;

/*
 The MDCShapeGenerating object used to set the shape's path and shadow path.

 The path will be set upon assignment of this property and whenever layoutSublayers is called.
 */
@property(nonatomic, strong, nullable) id<MDCShapeGenerating> shapeGenerator;

@end
