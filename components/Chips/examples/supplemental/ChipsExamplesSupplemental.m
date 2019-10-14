// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "ChipsExamplesSupplemental.h"

#import "MaterialChips.h"

#import "ChipsExampleAssets.h"

@implementation ExampleChipCollectionViewController {
  BOOL _popRecognizerDelaysTouches;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  _popRecognizerDelaysTouches =
      self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan;
  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan =
      _popRecognizerDelaysTouches;
}

@end

@interface ChipsCollectionExampleViewController (Supplemental)
@end

@implementation ChipsCollectionExampleViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Collections" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation ChipsFilterExampleViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Filter" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end

@implementation ChipsFilterAnimatedExampleViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Filter Animated" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@interface ChipsInputExampleViewController (Supplemental)
@end

@implementation ChipsInputExampleViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Input" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end

@implementation ChipsSizingExampleViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Sizing" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation ChipsTypicalUseViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Chips" ],
    @"description" : @"Chips are compact elements that represent an input, attribute, or action.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation ChipsShapingExampleViewController (Supplemental)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Shaped Chip" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
