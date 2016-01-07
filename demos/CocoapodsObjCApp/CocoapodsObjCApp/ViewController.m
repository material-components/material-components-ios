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

#import "ViewController.h"

#import <MaterialPageControl.h>
#import <MaterialSlider.h>
#import <MaterialScrollViewDelegateMultiplexer.h>
#import <MaterialShadowLayer.h>
#import <MaterialSpritedAnimationView.h>
#import <MaterialTypography.h>
#import <MaterialInk.h>

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Testing build and linking so all we need to do is touch the component objects.
#pragma mark Slider

  MDCSlider *slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [self.view addSubview:slider];
  slider.center = CGPointMake(100, 45);

#pragma mark Typography

  NSAssert([MDCTypography subheadFont], @"expecting valid object");

#pragma mark Ink

  NSAssert([[MDCInkTouchController alloc] initWithView:self.view], @"expecting valid object");

#pragma mark ScrollViewDelegateMultiplexer

  NSAssert([[MDCScrollViewDelegateMultiplexer alloc] init], @"expecting valid object");

#pragma mark ShadowLayer

  NSAssert([[MDCShadowLayer alloc] init], @"expecting valid object");

#pragma mark SpritedAnimation

  NSAssert([[MDCSpritedAnimationView alloc] init], @"expecting valid object");

#pragma mark PageControl

  MDCPageControl *pageControl = [[MDCPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  pageControl.numberOfPages = 3;
  [self.view addSubview:pageControl];
  pageControl.center = CGPointMake(100, 145);
}

@end
