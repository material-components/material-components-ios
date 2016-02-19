/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCBuildTestViewController.h"

#import <MaterialButtons.h>
#import <MaterialInk.h>
#import <MaterialPageControl.h>
#import <MaterialScrollViewDelegateMultiplexer.h>
#import <MaterialShadowElevations.h>
#import <MaterialShadowLayer.h>
#import <MaterialSlider.h>
#import <MaterialSpritedAnimationView.h>
#import <MaterialTypography.h>

@implementation MDCBuildTestViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

// Testing build and linking so all we need to do is touch the component objects.
#pragma mark Slider

  MDCSlider *slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [self.view addSubview:slider];
  slider.center = CGPointMake(100, 45);
  NSAssert(slider, @"Expecting to find a valid object for MDCSlider.");

#pragma mark Typography

  NSAssert([MDCTypography subheadFont], @"Expecting to find a valid object for MDCTypography.");

#pragma mark Ink

  NSAssert([[MDCInkTouchController alloc] initWithView:self.view],
           @"Expecting to find a valid object for MDCInkTouchController.");

#pragma mark ScrollViewDelegateMultiplexer

  NSAssert([[MDCScrollViewDelegateMultiplexer alloc] init],
           @"Expecting to find a valid object for MDCScrollViewDelegateMultiplexer.");

#pragma mark ShadowLayer

  NSAssert([[MDCShadowLayer alloc] init], @"Expecting to find a valid object for MDCShadowLayer.");

#pragma mark SpritedAnimation

  NSAssert([[MDCSpritedAnimationView alloc] init],
           @"Expecting to find a valid object for MDCSpritedAnimationView.");

#pragma mark PageControl

  MDCPageControl *pageControl = [[MDCPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  pageControl.numberOfPages = 3;
  [self.view addSubview:pageControl];
  pageControl.center = CGPointMake(100, 145);
  NSAssert(pageControl, @"Expecting to find a valid object for MDCPageControl.");

#pragma mark Buttons

  NSAssert([[MDCButton alloc] init], @"Expecting to find a valid object for MDCButton.");
}

@end
