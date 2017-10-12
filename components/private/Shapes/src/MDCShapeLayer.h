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

#import "MDCShapeGenerating.h"

/*
 A CAShapeLayer with the path controlled by an MDCShapeGenerating object.

 @note Do not set @c path manually.
 */
@interface MDCShapeLayer : CAShapeLayer

/*
 The shape generator used to set the @c path.

 The path will be set upon assignment of this property and every time layoutSublayers is called.
 */
@property(nonatomic, strong, nullable) id<MDCShapeGenerating> shapeGenerator;

@end
