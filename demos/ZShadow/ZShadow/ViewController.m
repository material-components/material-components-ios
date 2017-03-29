//
//  ViewController.m
//  ZShadow
//
//  Created by Ian Gordon on 3/29/17.
//  Copyright © 2017 Google. All rights reserved.
//

#import "ViewController.h"

#import "MaterialShadowedView.h"
#import "VanillaShadowedView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MaterialShadowedView *greenTappable;
@property (weak, nonatomic) IBOutlet MaterialShadowedView *greenBanner;

@property (weak, nonatomic) IBOutlet VanillaShadowedView *blueTappable;
@property (weak, nonatomic) IBOutlet VanillaShadowedView *blueBanner;

@property (nonatomic) NSLayoutConstraint *greenBannerLeadingConstraintCollapsed;
@property (nonatomic) NSLayoutConstraint *blueBannerLeadingConstraintCollapsed;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.greenBannerLeadingConstraintCollapsed =
      [[self.greenBanner trailingAnchor] constraintEqualToAnchor:self.greenTappable.trailingAnchor];
  self.greenBannerLeadingConstraintCollapsed.active = NO;

  self.blueBannerLeadingConstraintCollapsed =
      [[self.blueBanner trailingAnchor] constraintEqualToAnchor:self.blueTappable.trailingAnchor];
  self.blueBannerLeadingConstraintCollapsed.active = NO;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)viewTapped:(id)sender {
  self.greenBannerLeadingConstraintCollapsed.active = !self.greenBannerLeadingConstraintCollapsed.active;
  self.blueBannerLeadingConstraintCollapsed.active = !self.blueBannerLeadingConstraintCollapsed.active;

  [UIView animateWithDuration:5 animations:^{
    [self.view layoutIfNeeded];
  }];
}

@end
