/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "ActivityIndicatorExampleSupplemental.h"
#import "CatalogStyle.h"
#import "MaterialActivityIndicator.h"

@interface ActivityIndicatorExample ()
@end

@implementation ActivityIndicatorExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Activity Indicator";
  }
  return self;
}

@end

@implementation ActivityIndicatorExample (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Initialize single color progress indicator
  CGRect defaultRect = CGRectMake(0, 0, 32, 32);
  self.activityIndicator1 = [[MDCActivityIndicator alloc] initWithFrame:defaultRect];
  self.activityIndicator1.delegate = self;
  self.activityIndicator1.cycleColors =  @[[CatalogStyle primaryColor]];
  self.activityIndicator1.progress = 0.6f;
  self.activityIndicator1.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.activityIndicator1 sizeToFit];
  [self.activityIndicator1 startAnimating];

  // Initialize indeterminate indicator.
  self.activityIndicator2 = [[MDCActivityIndicator alloc] initWithFrame:defaultRect];
  self.activityIndicator2.delegate = self;
  self.activityIndicator2.cycleColors =  @[[CatalogStyle primaryColor]];
  self.activityIndicator2.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  [self.activityIndicator2 sizeToFit];
  [self.activityIndicator2 startAnimating];

  // Initiatlize multiple color indicator
  self.activityIndicator3 = [[MDCActivityIndicator alloc] initWithFrame:defaultRect];
  self.activityIndicator3.delegate = self;
  self.activityIndicator3.cycleColors =
      @[[CatalogStyle primaryColor], [CatalogStyle secondaryColor]];
  self.activityIndicator3.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  [self.activityIndicator3 sizeToFit];
  [self.activityIndicator3 startAnimating];

  [self setupExampleViews];
}

#pragma mark - MDCActivityIndicatorDelegate

- (void)activityIndicatorAnimationDidFinish:(nonnull MDCActivityIndicator *)activityIndicator {
  return;
}

@end
