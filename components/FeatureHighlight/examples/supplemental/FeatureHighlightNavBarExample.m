//
//  FeatureHighlightNavBarExample.m
//  Pods
//
//  Created by Sam Morrison on 10/14/16.
//
//

#import "FeatureHighlightNavBarExample.h"

@interface FeatureHighlightNavBarExample ()

@end

@implementation FeatureHighlightNavBarExample

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UINavigationItem *)navigationItem {
  UINavigationItem *item = [super navigationItem];
//  item.rightBarButtonItem = [[UIBarButtonItem alloc] init
  return item;
}

@end
