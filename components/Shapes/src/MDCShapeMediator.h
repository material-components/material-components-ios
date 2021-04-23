// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol MDCShapeGenerating;

/*
 Shape support addition to a layer.

 This class is used to add Shape support to a given view by providing it with the view's main layer.
 Having shape support means that by setting a shapeGenerator, you are able to have a custom shape
 using a custom path for that view.

 To have your instantiating view's backgroundColor, borderColor, and borderWidth also follow the
 custom shape, your view must have these APIs internally set and get from MDCShapeMediator's
 corresponding shapedBackgroundColor, shapedBorderColor, and shapedBorderWidth properties.

 This class exists to supersede MDCShapedShadowLayer which previously added shape support by
 overriding the layerClass and subclassing MDCShadowLayer, which are both behaviors we want to no
 longer support due to their complexity and constraints.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShapeMediator : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Designated initializer for a view requiring shape support to initialize with the view’s Core
 Animation layer used for rendering (view.layer).

 The MDCShapeMediator class then keeps a weak reference to the layer and adds the required sublayers
 in order to support custom shapes using custom paths. It also updates the layer's properties to
 have the border and background properties as well as its shadow path be up to date with the shape's
 custom path it gets through the shapeGenerator API.
 */
- (nonnull instancetype)initWithViewLayer:(nonnull CALayer *)viewLayer NS_DESIGNATED_INITIALIZER;

/**
 Call this function in layoutSubviews of the viewLayer's view to allow the shape generator to
 generate the proper shape path when the bounds are now apparent.
 */
- (void)layoutShapedSublayers;

/**
 The layer which the shape logic sits on. Assign the parent layer using @c initWithLayer:
 */
@property(nonatomic, readonly, weak, nullable) CALayer *viewLayer;

/*
 Sets the shaped background color of the layer.

 Use shapedBackgroundColor instead of backgroundColor to ensure the background appears correct with
 or without a valid shape.

 @note If you set shapedBackgroundColor, you should not manually write to backgroundColor or
 fillColor.
 */
@property(nonatomic, copy, nullable) UIColor *shapedBackgroundColor;

/*
 Sets the shaped border color of the layer.

 Use shapedBorderColor instead of borderColor to ensure the border appears correct with or without
 a valid shape.

 @note If you set shapedBorderColor, you should not manually write to borderColor.
 */
@property(nonatomic, copy, nullable) UIColor *shapedBorderColor;

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

/*
 The created CAShapeLayer representing the generated shape path for the implementing UIView
 from the shapeGenerator.

 This layer is exposed to easily mask subviews of the implementing UIView so they won't spill
 outside the layer to fit the bounds.
 */
@property(nonatomic, strong, nonnull) CAShapeLayer *shapeLayer;

/*
 A sublayer of @c shapeLayer that is responsible for the background color of the shape layer.

 The colorLayer imitates the path of shapeLayer and is added as a sublayer. It is updated when
 shapedBackgroundColor is set on the layer.
 */
@property(nonatomic, strong, nonnull) CAShapeLayer *colorLayer;

@end
