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

#import "MaterialScrollViewDelegateMultiplexer.h"
#import "CustomLabel.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController {
  MDCScrollViewDelegateMultiplexer *_multiplexer;
  NSArray *_pageColors;
  UIScrollView *_scrollView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGFloat boundsWidth = CGRectGetWidth(self.view.bounds);
  CGFloat boundsHeight = CGRectGetHeight(self.view.bounds);

  _pageColors = @[[UIColor greenColor], [UIColor blueColor], [UIColor redColor]];

  // Create scrollView.
  _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(boundsWidth * _pageColors.count, boundsHeight);
  _scrollView.minimumZoomScale = 0.5;
  _scrollView.maximumZoomScale = 6.0;
  [self.view addSubview:_scrollView];

  // Add pages to scrollView.
  for (NSInteger i = 0; i < _pageColors.count; i++) {
    CGRect pageFrame = CGRectOffset(self.view.bounds, i * boundsWidth, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    page.text = [NSString stringWithFormat:@"Page %zd", i + 1];
    page.textAlignment = NSTextAlignmentCenter;
    page.backgroundColor = _pageColors[i];
    [_scrollView addSubview:page];
  }

  // Add a custom label.
  CustomLabel *label =
      [[CustomLabel alloc] initWithFrame:CGRectMake(0, boundsHeight - 40, boundsWidth, 20)];
  label.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:label];

  // Create scrollView delegate multiplexer.
  _multiplexer = [[MDCScrollViewDelegateMultiplexer alloc] init];
  _scrollView.delegate = _multiplexer;
  [_multiplexer addObservingDelegate:self];
  [_multiplexer addObservingDelegate:label];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  NSLog(@"scrollViewDidEndDecelerating");
}

@end
