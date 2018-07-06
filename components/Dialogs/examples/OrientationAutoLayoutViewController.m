/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "OrientationAutoLayoutViewController.h"
#import "MaterialButtons.h"
#import "MaterialDialogs.h"
#import "UIApplication+AppExtensions.h"

static CGFloat BlockWidth = 280;
static CGFloat BlockHeight = 173;

static CGFloat currentWindowWidth() {
  return [UIApplication mdc_safeSharedApplication].delegate.window.bounds.size.width;
}

@interface OrientationAutoLayoutContentViewController : UIViewController

@end

@implementation OrientationAutoLayoutContentViewController {
  UIStackView *_muhContent;
  UIView *_centeringView;
  NSMutableArray *_stackContent;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  _stackContent = [NSMutableArray array];

  _centeringView = [[UIView alloc] init];
  _centeringView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_centeringView];

  NSString *label = [NSString stringWithFormat:@"%d\nx\n%d", (int)BlockWidth, (int)BlockHeight];

  UILabel *bottomOrLeftView = [[UILabel alloc] init];
  bottomOrLeftView.text = label;
  bottomOrLeftView.numberOfLines = 0;
  bottomOrLeftView.textAlignment = NSTextAlignmentCenter;
  bottomOrLeftView.backgroundColor = UIColor.blueColor;
  bottomOrLeftView.translatesAutoresizingMaskIntoConstraints = NO;
  [_stackContent addObject:bottomOrLeftView];

  UILabel *topOrRightView = [[UILabel alloc] init];
  topOrRightView.text = label;
  topOrRightView.numberOfLines = 0;
  topOrRightView.textAlignment = NSTextAlignmentCenter;
  topOrRightView.backgroundColor = UIColor.orangeColor;
  topOrRightView.translatesAutoresizingMaskIntoConstraints = NO;
  [_stackContent addObject:topOrRightView];

  UILayoutConstraintAxis axis = [self axisForLayoutInWidth:currentWindowWidth()];
  NSArray *correctOrderedContent = [[self contentEnumeratorForAxis:axis] allObjects];
  _muhContent = [[UIStackView alloc] initWithArrangedSubviews:correctOrderedContent];
  _muhContent.axis = axis;
  _muhContent.alignment = UIStackViewAlignmentCenter;
  _muhContent.translatesAutoresizingMaskIntoConstraints = NO;
  [_centeringView addSubview:_muhContent];

  // Make constraints.
  [NSLayoutConstraint constraintWithItem:topOrRightView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:BlockWidth].active = YES;
  [NSLayoutConstraint constraintWithItem:topOrRightView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:BlockHeight].active = YES;
  [NSLayoutConstraint constraintWithItem:bottomOrLeftView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:BlockWidth].active = YES;
  [NSLayoutConstraint constraintWithItem:bottomOrLeftView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:BlockHeight].active = YES;
  [NSLayoutConstraint constraintWithItem:_muhContent
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:_centeringView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_muhContent
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:_centeringView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_muhContent
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:_centeringView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_muhContent
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:_centeringView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_centeringView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_centeringView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_centeringView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeWidth
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_centeringView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeHeight
                              multiplier:1
                                constant:0].active = YES;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  NSLog(@"transitioning to size %@", NSStringFromCGSize(size));
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  // At this point, my preferredContentSize has been queried and constrained within my parent's new
  // size. If my preferred content size won't fit in my parent, try the other axis.
  UILayoutConstraintAxis axis = [self axisForLayoutInWidth:size.width];
  if (axis != _muhContent.axis) {
    // Change axis and reverse items to keep the orage view in the top-right.
    _muhContent.axis = axis;
    for (UIView *block in [self contentEnumeratorForAxis:axis]) {
      [_muhContent removeArrangedSubview:block];
      [_muhContent addArrangedSubview:block];
    }
  }
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> ctx) {
  } completion:nil];
}

#pragma mark - Helpers

- (CGSize)preferredContentSize {
  // Ask my parent for a size that could fit me in any orientation.
  CGSize verticalSize = [self preferredSizeForVerticalStacking];
  CGSize horizontalSize = [self preferredSizeForHorizontalStacking];
  return CGSizeMake(MAX(verticalSize.width, horizontalSize.width),
                    MAX(verticalSize.height, horizontalSize.height));
}

- (CGSize)preferredSizeForHorizontalStacking {
  return CGSizeMake(2 * BlockWidth, BlockHeight);
}

- (CGSize)preferredSizeForVerticalStacking {
  return CGSizeMake(BlockWidth, 2 * BlockHeight);
}

- (NSEnumerator<UIView *> *)contentEnumeratorForAxis:(UILayoutConstraintAxis)axis {
  if (axis == UILayoutConstraintAxisVertical) {
    return _stackContent.reverseObjectEnumerator;
  } else {
    return _stackContent.objectEnumerator;
  }
}

- (UILayoutConstraintAxis)axisForLayoutInWidth:(CGFloat)width {
  if (width >= [self totalPossibleWidthForAlert]) {
    return UILayoutConstraintAxisHorizontal;
  } else {
    return UILayoutConstraintAxisVertical;
  }
}

- (CGFloat)totalPossibleWidthForAlert {
  return 2 * BlockWidth;
}

@end

@interface OrientationAutoLayoutViewController ()

@property(nonatomic, strong) MDCFlatButton *presentButton;
@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

@end

@implementation OrientationAutoLayoutViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];

  self.view.backgroundColor = [UIColor whiteColor];

  _presentButton = [[MDCFlatButton alloc] initWithFrame:CGRectZero];
  [_presentButton setTitle:@"Present" forState:UIControlStateNormal];
  [_presentButton sizeToFit];
  [_presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  _presentButton.autoresizingMask =
  UIViewAutoresizingFlexibleTopMargin |
  UIViewAutoresizingFlexibleLeftMargin |
  UIViewAutoresizingFlexibleRightMargin |
  UIViewAutoresizingFlexibleBottomMargin;
  [_presentButton addTarget:self
                     action:@selector(didTapPresent:)
           forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:_presentButton];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_presentButton sizeToFit];
  _presentButton.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                      CGRectGetMidY(self.view.bounds));
}

- (IBAction)didTapPresent:(id)sender {
  UIViewController *viewController =
  [[OrientationAutoLayoutContentViewController alloc] initWithNibName:nil bundle:nil];

  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;

  [self presentViewController:viewController animated:YES completion:NULL];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Dialogs", @"AutoLayout Max ContentSize" ];
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end
