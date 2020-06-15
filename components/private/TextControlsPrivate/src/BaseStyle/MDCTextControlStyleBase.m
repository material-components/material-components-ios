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

#import "MDCTextControlStyleBase.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MDCTextControl.h"
#import "MDCTextControlVerticalPositioningReferenceBase.h"

static const CGFloat kBaseFloatingLabelScaleFactor = (CGFloat)0.8;

@implementation MDCTextControlStyleBase

- (UIFont *)floatingFontWithNormalFont:(UIFont *)font {
  CGFloat scaleFactor = kBaseFloatingLabelScaleFactor;
  CGFloat floatingFontSize = font.pointSize * scaleFactor;
  return [font fontWithSize:floatingFontSize];
}

- (void)applyStyleToTextControl:(UIView<MDCTextControl> *)textControl
              animationDuration:(NSTimeInterval)animationDuration {
}

- (void)removeStyleFrom:(id<MDCTextControl>)textControl {
}

- (id<MDCTextControlVerticalPositioningReference>)
    positioningReferenceWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                              normalFontLineHeight:(CGFloat)normalFontLineHeight
                                     textRowHeight:(CGFloat)textRowHeight
                                  numberOfTextRows:(CGFloat)numberOfTextRows
                                           density:(CGFloat)density
                          preferredContainerHeight:(CGFloat)preferredContainerHeight {
  return [[MDCTextControlVerticalPositioningReferenceBase alloc]
      initWithFloatingFontLineHeight:floatingLabelHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight];
}

- (MDCTextControlHorizontalPositioningReference *)horizontalPositioningReference {
  return [[MDCTextControlHorizontalPositioningReference alloc] init];
}

@end
