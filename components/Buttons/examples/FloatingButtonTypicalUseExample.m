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

#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialContainerScheme.h"

static NSString *const kButtonLabel = @"Create";
static NSString *const kMiniButtonLabel = @"Add";

@interface FloatingButtonTypicalUseExample : UIViewController
@property(nonatomic, strong) UILabel *iPadLabel;
@property(nonatomic, strong) MDCFloatingButton *miniFloatingButton;
@property(nonatomic, strong) MDCFloatingButton *defaultFloatingButton;
@property(nonatomic, strong) MDCFloatingButton *largeIconFloatingButton;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

@implementation FloatingButtonTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    containerScheme.shapeScheme = [[MDCShapeScheme alloc] init];
    _containerScheme = containerScheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];

  UIImage *plusImage =
      [[UIImage imageNamed:@"ic_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImage *plusImage36 = [[UIImage imageNamed:@"ic_add_36pt"]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.iPadLabel = [[UILabel alloc] init];
  self.iPadLabel.text = @"Try me on an iPad!";

  self.miniFloatingButton = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                               shape:MDCFloatingButtonShapeMini];
  [self.miniFloatingButton setImage:plusImage forState:UIControlStateNormal];
  self.miniFloatingButton.accessibilityLabel = kMiniButtonLabel;
  [self.miniFloatingButton setMinimumSize:CGSizeMake(96, 40)
                                 forShape:MDCFloatingButtonShapeMini
                                   inMode:MDCFloatingButtonModeExpanded];
  [self.miniFloatingButton setCenterVisibleArea:YES
                                       forShape:MDCFloatingButtonShapeMini
                                         inMode:MDCFloatingButtonModeNormal];
  [self.miniFloatingButton setCenterVisibleArea:YES
                                       forShape:MDCFloatingButtonShapeMini
                                         inMode:MDCFloatingButtonModeExpanded];

  self.defaultFloatingButton = [[MDCFloatingButton alloc] init];
  [self.defaultFloatingButton setImage:plusImage forState:UIControlStateNormal];
  self.defaultFloatingButton.accessibilityLabel = kButtonLabel;

  self.largeIconFloatingButton = [[MDCFloatingButton alloc] init];
  [self.largeIconFloatingButton setImage:plusImage36 forState:UIControlStateNormal];
  self.largeIconFloatingButton.accessibilityLabel = kButtonLabel;
  [self.largeIconFloatingButton setContentEdgeInsets:UIEdgeInsetsMake(-6, -6, -6, 0)
                                            forShape:MDCFloatingButtonShapeDefault
                                              inMode:MDCFloatingButtonModeExpanded];

  [self applyThemeToAllButtonsWithScheme:self.containerScheme];
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
  // Minimum touch target size (44, 44).
  self.miniFloatingButton.frame = CGRectMake(
      CGRectGetMinX(self.miniFloatingButton.frame), CGRectGetMinY(self.miniFloatingButton.frame),
      MAX(44, CGRectGetWidth(self.miniFloatingButton.frame)),
      MAX(44, CGRectGetHeight(self.miniFloatingButton.frame)));

  CGFloat totalUsedHeight = self.iPadLabel.intrinsicContentSize.height +
                            CGRectGetHeight(self.miniFloatingButton.frame) +
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

  CGSize miniFabSize = self.miniFloatingButton.bounds.size;
  CGSize defaultFabSize = self.defaultFloatingButton.intrinsicContentSize;
  CGSize largeIconFabSize = self.largeIconFloatingButton.intrinsicContentSize;

  CGFloat xOffset = CGRectGetMinX(bounds) + 20;
  if (@available(iOS 11.0, *)) {
    xOffset += self.view.safeAreaInsets.left;
  }

  if (!self.iPadLabel.hidden) {
    self.iPadLabel.center = CGPointMake(
        CGRectGetMidX(bounds), viewYOffset + self.iPadLabel.intrinsicContentSize.height / 2);
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
    [coordinator
        animateAlongsideTransition:^(
            id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
          [self updateFloatingButtonsWhenSizeClassIsRegularRegular:isRegularRegular];
        }
                        completion:nil];
  }
}

- (void)setContainerScheme:(id<MDCContainerScheming>)containerScheme {
  _containerScheme = containerScheme;

  if ([self isViewLoaded]) {
    [self applyThemeToAllButtonsWithScheme:containerScheme];
  }
}

- (void)applyThemeToAllButtonsWithScheme:(id<MDCContainerScheming>)containerScheme {
  [self.miniFloatingButton applySecondaryThemeWithScheme:containerScheme];
  [self.defaultFloatingButton applySecondaryThemeWithScheme:containerScheme];
  [self.largeIconFloatingButton applySecondaryThemeWithScheme:containerScheme];
}

#pragma mark - Catalog by Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Buttons", @"Floating Action Button" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end

@implementation FloatingButtonTypicalUseExample (SnapshotTestingByConvention)

- (void)testDynamic201907ColorScheme {
  // Given
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];

  // When
  self.containerScheme = containerScheme;
}

@end
