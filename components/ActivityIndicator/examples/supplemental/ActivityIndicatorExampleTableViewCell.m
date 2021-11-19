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

#import "ActivityIndicatorExampleTableViewCell.h"

@implementation ActivityIndicatorExampleTableViewCell

- (void)accessibilityIncrement {
  if ([self.accessoryView isKindOfClass:[UISlider class]]) {
    UISlider *slider = (UISlider *)self.accessoryView;

    if (slider.value == slider.maximumValue) {
      return;
    }

    float incrementInterval = MIN(1.0, slider.maximumValue / 10.0);
    float valueAfterIncrement = slider.value + incrementInterval;

    [slider setValue:valueAfterIncrement animated:YES];
    [slider sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

- (void)accessibilityDecrement {
  if ([self.accessoryView isKindOfClass:[UISlider class]]) {
    UISlider *slider = (UISlider *)self.accessoryView;

    if (slider.value == slider.minimumValue) {
      return;
    }

    float decrementInterval = MIN(1.0, slider.maximumValue / 10.0);
    float valueAfterDecrement = slider.value - decrementInterval;

    [slider setValue:valueAfterDecrement animated:YES];
    [slider sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

@end
