/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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
#import "MaterialActivityIndicator.h"

@interface ActivityIndicatorExample ()

@end

@implementation ActivityIndicatorExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Activity Indicator";
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect activityIndicator =
        CGRectMake(0, 0, kActivityIndicatorRadius * 2, kActivityIndicatorRadius * 2);
    _activityIndicator = [[MDCActivityIndicator alloc] initWithFrame:activityIndicator];
    _activityIndicator.delegate = self;
    _activityIndicator.radius = kActivityIndicatorRadius;
    _activityIndicator.strokeWidth = 8.f;

    _activityIndicator.autoresizingMask =
        (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
         UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
    [self.view addSubview:_activityIndicator];

    _activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
    _activityIndicator.progress = kActivityInitialProgress;
    [_activityIndicator startAnimating];
  }
  return self;
}

@end

@implementation ActivityIndicatorExample (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews];
}

#pragma mark - MDCActivityIndicatorDelegate

- (void)activityIndicatorAnimationDidFinish:(nonnull MDCActivityIndicator *)activityIndicator {
  return;
}

@end
