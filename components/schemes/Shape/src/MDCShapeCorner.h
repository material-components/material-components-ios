// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import "MaterialShapeLibrary.h"

typedef NS_ENUM(NSInteger, MDCShapeFamily) {
  MDCShapeFamilyRoundedCorner,
  MDCShapeFamilyAngledCorner
};

@interface MDCShapeCorner : NSObject

@property(assign, nonatomic) MDCShapeFamily shapeFamily;
@property(assign, nonatomic) BOOL isPercentage;
@property(assign, nonatomic) CGFloat shapeValue;

- (instancetype)initWithShapeFamily:(MDCShapeFamily)shapeFamily andValue:(CGFloat)shapeValue;

- (MDCCornerTreatment *)cornerTreatmentValue;
- (MDCCornerTreatment *)cornerTreatmentValueWithViewBounds:(CGRect)bounds;
@end
