### Typical use: customizing a shape scheme

You'll typically want to create one default `MDCShapeScheme` instance for your app where all
of the shape properties are set to your desired brand or style.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let shapeScheme = MDCShapeScheme()
// Small Component Shape
shapeScheme.smallComponentShape = MDCShapeCategory(cornersWith: .cut, andSize: 4)

// Medium Component Shape
shapeScheme.mediumComponentShape = MDCShapeCategory(cornersWith: .rounded, andSize: 10)

// Large Component Shape
let largeShapeCategory = MDCShapeCategory()
let rounded50PercentCorner = MDCCornerTreatment.corner(withRadius: 0.5,
                                                       valueType: .percentage)
let cut8PointsCorner = MDCCornerTreatment.corner(withCut: 8)
largeShapeCategory?.topLeftCorner = rounded50PercentCorner
largeShapeCategory?.topRightCorner = rounded50PercentCorner
largeShapeCategory?.bottomLeftCorner = cut8PointsCorner
largeShapeCategory?.bottomRightCorner = cut8PointsCorner
shapeScheme.LargeComponentShape = largeShapeCategory
```

#### Objective-C

```objc
MDCShapeScheme *shapeScheme = [[MDCShapeScheme alloc] init];
// Small Component Shape
shapeScheme.smallComponentShape = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut
                                                                   andSize:4.f];

// Medium Component Shape
shapeScheme.mediumComponentShape = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                                   andSize:10.f];

// Large Component Shape
MDCShapeCategory *largeShapeCategory = [[MDCShapeCategory alloc] init];
MDCCornerTreatment *rounded50PercentCorner =
    [MDCCornerTreatment cornerWithRadius:0.5f valueType:MDCCornerTreatmentValueTypePercentage];
MDCCornerTreatment *cut8PointsCorner = [MDCCornerTreatment cornerWithCut:8.f];
largeShapeCategory.topLeftCorner = rounded50PercentCorner;
largeShapeCategory.topRightCorner = rounded50PercentCorner;
largeShapeCategory.bottomLeftCorner = cut8PointsCorner;
largeShapeCategory.bottomRightCorner = cut8PointsCorner;
shapeScheme.LargeComponentShape = largeShapeCategory;
```
<!--</div>-->
