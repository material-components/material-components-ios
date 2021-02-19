// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialChips.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

/*
 An example to demonstrate the bug described in b/133136148
 To reproduce, repeatedly tap on the chip in this example.

 Expected: The chip returns to its starting state once re-enabled
 Actual:   The chip continues to get darker and darker as it is tapped
 */
@interface ChipsDisablingExampleViewController : UIViewController
@property(nonatomic, strong) MDCChipView *chipView;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

@implementation ChipsDisablingExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  self.chipView = [[MDCChipView alloc] init];
  self.chipView.titleLabel.text = @"I'm a chip";
  self.chipView.frame = CGRectMake(20, 100, 200, 50);
  [self.chipView addTarget:self
                    action:@selector(onChipTapped:)
          forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:self.chipView];
}

- (void)onChipTapped:(MDCChipView *)chipView {
  chipView.enabled = NO;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   chipView.enabled = YES;
                 });
}

@end

@implementation ChipsDisablingExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Disabling" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
