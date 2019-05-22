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

#import "MDCOutlinedTextField.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStylerOutlined.h"
#import "MDCInputTextField+Private.h"

@interface MDCOutlinedTextFieldPositioningDelegate
    : NSObject <MDCContainedInputViewStylerPositioningDelegate>
@end

@interface MDCOutlinedTextField ()
@end

@implementation MDCOutlinedTextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCOutlinedTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCOutlinedTextFieldInit];
  }
  return self;
}

- (void)commonMDCOutlinedTextFieldInit {
  MDCOutlinedTextFieldPositioningDelegate *positioningDelegate =
      [[MDCOutlinedTextFieldPositioningDelegate alloc] init];
  MDCContainerStylerOutlined *outlinedStyle =
      [[MDCContainerStylerOutlined alloc] initWithPositioningDelegate:positioningDelegate];
  self.containerStyler = outlinedStyle;
}

@end

@implementation MDCOutlinedTextFieldPositioningDelegate
@synthesize verticalDensity = _verticalDensity;

- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingPlaceholderHeight {
  return (CGFloat)0 - ((CGFloat)0.5 * floatingPlaceholderHeight);
}

- (CGFloat)contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:
    (CGFloat)floatingPlaceholderMaxY {
  CGFloat minYAddition = 3;
  CGFloat maxYAddition = 15;
  CGFloat difference = maxYAddition - minYAddition;
  return floatingPlaceholderMaxY + (minYAddition + (difference * (1 - self.verticalDensity)));
}

- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:(CGFloat)floatingPlaceholderMaxY {
  return [self contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:floatingPlaceholderMaxY];
}

@end
