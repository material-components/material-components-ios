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

#import "MDCCornerTreatment+CornerTypeInitalizer.h"

#import "MDCCurvedCornerTreatment.h"
#import "MDCCutCornerTreatment.h"
#import "MDCRoundedCornerTreatment.h"

@implementation MDCCornerTreatment (CornerTypeInitalizer)

- (instancetype)initWithCornerType:(MDCCornerType)cornerType andValue:(NSNumber *)value {
    self = [self init];
    switch(cornerType) {
      case MDCCornerTypeCurved: {
        CGSize size = [value CGSizeValue];
        self = [[MDCCurvedCornerTreatment alloc] initWithSize:size];
        break;
      }
      case MDCCornerTypeCut: {
        CGFloat cut = [value floatValue];
        self = [[MDCCutCornerTreatment alloc] initWithCut:cut];
        break;
      }
      case MDCCornerTypeRounded: {
        CGFloat radius = [value floatValue];
        self = [[MDCRoundedCornerTreatment alloc] initWithRadius:radius];
        break;
      }
    }
  return self;
}

@end
