// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialButtons+ColorThemer.h"

NSString *kButtonLabel = @"Create";
NSString *kMiniButtonLabel = @"Add";

@interface FloatingButtonExampleViewController : UIViewController
@property(nonatomic, strong) UILabel *iPadLabel;
@property(nonatomic, strong) MDCFloatingButton *miniFloatingButton;
@property(nonatomic, strong) MDCFloatingButton *defaultFloatingButton;
@property(nonatomic, strong) MDCFloatingButton *largeIconFloatingButton;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation FloatingButtonExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];

  UIImage *plusImage =
      [[UIImage imageNamed:@"Plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImage *plusImage36 = [UIImage imageNamed:@"plus_white_36"
                                    inBundle:[NSBundle bundleForClass:[self class]]
               compatibleWithTraitCollection:self.traitCollection];
  plusImage36 = [plusImage36 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.iPadLabel = [[UILabel alloc] init];
  self.iPadLabel.text = @"Try me on an iPad!";

  self.miniFloatingButton = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                               shape:MDCFloatingButtonShapeMini];
  self.miniFloatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.miniFloatingButton setImage:plusImage forState:UIControlStateNormal];
  self.miniFloatingButton.accessibilityLabel = kMiniButtonLabel;
  [self.miniFloatingButton setMinimumSize:CGSizeMake(96, 40)
                                 forShape:MDCFloatingButtonShapeMini
                                   inMode:MDCFloatingButtonModeExpanded];
  [MDCFloatingButtonColorThemer applySemanticColorScheme:self.colorScheme
                                                toButton:self.miniFloatingButton];

  self.defaultFloatingButton = [[MDCFloatingButton alloc] init];
  self.defaultFloatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.defaultFloatingButton setImage:plusImage forState:UIControlStateNormal];
  self.defaultFloatingButton.accessibilityLabel = kButtonLabel;
  [MDCFloatingButtonColorThemer applySemanticColorScheme:self.colorScheme
                                                toButton:self.defaultFloatingButton];

  self.largeIconFloatingButton = [[MDCFloatingButton alloc] init];
  self.largeIconFloatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.largeIconFloatingButton setImage:plusImage36 forState:UIControlStateNormal];
  self.largeIconFloatingButton.accessibilityLabel = kButtonLabel;
  [self.largeIconFloatingButton setContentEdgeInsets:UIEdgeInsetsMake(-6, -6, -6, 0)
                                            forShape:MDCFloatingButtonShapeDefault
                                              inMode:MDCFloatingButtonModeExpanded];
  [MDCFloatingButtonColorThemer applySemanticColorScheme:self.colorScheme
                                                toButton:self.largeIconFloatingButton];

  [self.view addSubview:self.iPadLabel];
  [self.view addSubview:self.miniFloatingButton];
  [self.view addSubview:self.defaultFloatingButton];
  [self.view addSubview:self.largeIconFloatingButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.iPadLabel sizeToFit];
  [self.largeIconFloatingButton sizeToFit];
  [self.defaultFloatingButton sizeToFit];
  [self.miniFloatingButton sizeToFit];

  CGFloat totalUsedHeight = self.iPadLabel.intrinsicContentSize.height +
      self.miniFloatingButton.intrinsicContentSize.height +
      self.defaultFloatingButton.intrinsicContentSize.height +
      self.largeIconFloatingButton.intrinsicContentSize.height;

  CGRect bounds = self.view.bounds;
  if (totalUsedHeight > CGRectGetHeight(bounds)) {
    totalUsedHeight -= self.iPadLabel.intrinsicContentSize.height;
    self.iPadLabel.hidden = YES;
  }

  CGFloat remainingMargins = MAX(0, CGRectGetHeight(bounds) - totalUsedHeight);
  NSInteger interViewGapCount = self.iPadLabel.hidden ? 2 : 3;
  CGFloat interViewSpacing = MIN(20, remainingMargins / interViewGapCount);
  CGFloat viewYOffset = (remainingMargins - interViewSpacing * interViewGapCount) / 2;

  CGSize miniFabSize = self.miniFloatingButton.intrinsicContentSize;
  CGSize defaultFabSize = self.defaultFloatingButton.intrinsicContentSize;
  CGSize largeIconFabSize = self.largeIconFloatingButton.intrinsicContentSize;

  CGFloat xOffset = CGRectGetMinX(bounds) + 20;
  if (!self.iPadLabel.hidden) {
    self.iPadLabel.center =
        CGPointMake(CGRectGetMidX(bounds),
                    viewYOffset + self.iPadLabel.intrinsicContentSize.height / 2);
    viewYOffset += self.iPadLabel.intrinsicContentSize.height + interViewSpacing;
  }

  self.miniFloatingButton.center =
      CGPointMake(xOffset + miniFabSize.width / 2 + (defaultFabSize.width - miniFabSize.width) / 2,
                  viewYOffset + miniFabSize.height / 2);
  viewYOffset += miniFabSize.height + interViewSpacing;
  self.defaultFloatingButton.center =
      CGPointMake(xOffset + defaultFabSize.width / 2, viewYOffset + defaultFabSize.height / 2);
  viewYOffset += defaultFabSize.height + interViewSpacing;
  self.largeIconFloatingButton.center =
      CGPointMake(xOffset + largeIconFabSize.width / 2, viewYOffset + largeIconFabSize.height / 2);
}

- (void)updateFloatingButtonsWhenSizeClassIsRegularRegular:(BOOL)isRegularRegular {
  if (isRegularRegular) {
    self.miniFloatingButton.mode = MDCFloatingButtonModeExpanded;
    [self.miniFloatingButton setTitle:kMiniButtonLabel forState:UIControlStateNormal];
    self.defaultFloatingButton.mode = MDCFloatingButtonModeExpanded;
    [self.defaultFloatingButton setTitle:kButtonLabel forState:UIControlStateNormal];
    self.largeIconFloatingButton.mode = MDCFloatingButtonModeExpanded;
    [self.largeIconFloatingButton setTitle:kButtonLabel forState:UIControlStateNormal];
  } else {
    self.miniFloatingButton.mode = MDCFloatingButtonModeNormal;
    [self.miniFloatingButton setTitle:nil forState:UIControlStateNormal];
    self.defaultFloatingButton.mode = MDCFloatingButtonModeNormal;
    [self.defaultFloatingButton setTitle:nil forState:UIControlStateNormal];
    self.largeIconFloatingButton.mode = MDCFloatingButtonModeNormal;
    [self.largeIconFloatingButton setTitle:nil forState:UIControlStateNormal];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  UIUserInterfaceSizeClass horizontalSizeClass = self.traitCollection.horizontalSizeClass;
  UIUserInterfaceSizeClass verticalSizeClass = self.traitCollection.verticalSizeClass;
  if (horizontalSizeClass == UIUserInterfaceSizeClassRegular &&
      verticalSizeClass == UIUserInterfaceSizeClassRegular) {
    [self updateFloatingButtonsWhenSizeClassIsRegularRegular:YES];
  } else {
    [self updateFloatingButtonsWhenSizeClassIsRegularRegular:NO];
  }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];

  UITraitCollection *currentTraits = self.traitCollection;
  BOOL sizeClassChanged = currentTraits.horizontalSizeClass != newCollection.horizontalSizeClass ||
      currentTraits.verticalSizeClass != newCollection.verticalSizeClass;
  if (sizeClassChanged) {
    BOOL isRegularRegular = newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular &&
        newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
      [self updateFloatingButtonsWhenSizeClassIsRegularRegular:isRegularRegular];
    } completion:nil];
  }
}

#pragma mark - Catalog by Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Buttons", @"Floating Action Button" ],
    @"primaryDemo": @NO,
    @"presentable": @YES,
  };
}

@end
