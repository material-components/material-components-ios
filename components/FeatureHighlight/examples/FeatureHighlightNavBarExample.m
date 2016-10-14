//
//  FeatureHighlightNavBarExample.m
//  Pods
//
//  Created by Sam Morrison on 10/14/16.
//
//

#import "FeatureHighlightNavBarExample.h"

#import "MaterialIcons+ic_info.h"

@interface FeatureHighlightNavBarExample ()

@end

@implementation FeatureHighlightNavBarExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Feature Highlight", @"Navigation Bar" ];
}

+ (NSString *)catalogDescription {
  return @"Using Feature Highlight to highlight an item in a navigation bar.";
}

- (UINavigationItem *)navigationItem {
  UINavigationItem *item = [super navigationItem];
  item.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithImage:[MDCIcons pathFor_ic_info]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapAction)];
  return item;
}

- (void)didTapAction {
  NSLog(@"DO ACTION.");
}

@end
