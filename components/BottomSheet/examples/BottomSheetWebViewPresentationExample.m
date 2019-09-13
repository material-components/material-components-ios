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

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "MaterialBottomSheet.h"
#import "supplemental/BottomSheetSupplemental.h"

@interface PresentedWebViewController : UIViewController

@property(nonatomic) WKWebView *webView;

@end

@implementation PresentedWebViewController {
  NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>
      *_transitionController;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _transitionController = [[MDCBottomSheetTransitionController alloc] init];
    self.transitioningDelegate = _transitionController;
    self.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)loadView {
  WKWebView *webView = [[WKWebView alloc] init];
  NSURL *url = [NSURL URLWithString:@"https://nytimes.com/"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [webView loadRequest:request];
  self.view = webView;
}

@end

@implementation BottomSheetWebViewPresentationExample

- (void)presentBottomSheet {
  PresentedWebViewController *viewController = [[PresentedWebViewController alloc] init];

  MDCBottomSheetController *bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:viewController];
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end
