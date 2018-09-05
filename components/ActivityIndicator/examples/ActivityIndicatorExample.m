// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialActivityIndicator.h"
#import "MaterialActivityIndicator+ColorThemer.h"
#import "MaterialPalettes.h"
#import "supplemental/ActivityIndicatorExampleSupplemental.h"

#define MDC_CATALOG_BLACK [UIColor colorWithWhite:0.1f alpha:1]
#define MDC_CATALOG_GREY  [UIColor colorWithWhite:0.9f alpha:1]
#define MDC_CATALOG_GREEN [UIColor colorWithRed:0 green:0xe6/255.0f blue:0x76/255.0f alpha:1]

@interface ActivityIndicatorExample ()
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation ActivityIndicatorExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Activity Indicator";
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  return self;
}

@end

@implementation ActivityIndicatorExample (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Themed determinate activity indicator
  self.activityIndicator1 = [[MDCActivityIndicator alloc] init];
  [MDCActivityIndicatorColorThemer applySemanticColorScheme:self.colorScheme
                                        toActivityIndicator:self.activityIndicator1];
  self.activityIndicator1.delegate = self;
  self.activityIndicator1.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.activityIndicator1 sizeToFit];

  // Themed indeterminate activity indicator
  self.activityIndicator2 = [[MDCActivityIndicator alloc] init];
  self.activityIndicator2.delegate = self;
  self.activityIndicator2.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [MDCActivityIndicatorColorThemer applySemanticColorScheme:self.colorScheme
                                        toActivityIndicator:self.activityIndicator2];
  [self.activityIndicator2 sizeToFit];

  // Indeterminate activity indicator with custom colors.
  self.activityIndicator3 = [[MDCActivityIndicator alloc] init];
  self.activityIndicator3.delegate = self;
  self.activityIndicator3.indicatorMode = MDCActivityIndicatorModeDeterminate;
  self.activityIndicator3.cycleColors =  @[ [MDCPalette bluePalette].tint500,
                                            [MDCPalette redPalette].tint500,
                                            [MDCPalette greenPalette].tint500,
                                            [MDCPalette yellowPalette].tint500 ];
  [self.activityIndicator3 sizeToFit];

  [self setupExampleViews];
}

#pragma mark - MDCActivityIndicatorDelegate

- (void)activityIndicatorAnimationDidFinish:(nonnull MDCActivityIndicator *)activityIndicator {
  return;
}

@end
