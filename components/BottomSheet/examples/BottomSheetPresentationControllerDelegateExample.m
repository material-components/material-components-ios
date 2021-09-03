#import "BottomSheetPresenterViewController.h"
#import "MaterialBottomSheet.h"
#import "MaterialButtons.h"

/**
 Demonstrates the use of MDCBottomSheetTransitionController.
 */
@interface BottomSheetPresentationControllerDelegateExamplePresentedSheetController
    : UIViewController
@end

@implementation BottomSheetPresentationControllerDelegateExamplePresentedSheetController {
  id<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>
      _transitionController;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    MDCBottomSheetTransitionController *transitionController =
        [[MDCBottomSheetTransitionController alloc] init];
    transitionController.dismissOnBackgroundTap = YES;
    _transitionController = transitionController;
    self.transitioningDelegate = _transitionController;
    self.modalPresentationStyle = UIModalPresentationCustom;

    self.view.backgroundColor = UIColor.purpleColor;
    self.view.isAccessibilityElement = YES;
    self.view.accessibilityLabel = @"Example content";
    self.view.accessibilityIdentifier =
        @"BottomSheetPresentationControllerDelegateExamplePresentedSheetController.view";
  }
  return self;
}

@end

/**
 Demonstrates use of MDCBottomSheetPresentationController functionality.
*/
@interface BottomSheetPresentationControllerDelegateExample
    : BottomSheetPresenterViewController <MDCBottomSheetPresentationControllerDelegate>
@property(nonatomic, strong)
    UILabel *bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel;
@property(nonatomic, strong)
    UILabel *bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel;
@end

@implementation BottomSheetPresentationControllerDelegateExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.button setTitle:@"Present Custom Controller" forState:UIControlStateNormal];

  UIStackView *stackView = [[UIStackView alloc] init];
  stackView.axis = UILayoutConstraintAxisVertical;
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:stackView];

  self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel = [[UILabel alloc] init];
  self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel.accessibilityIdentifier =
      @"BottomSheetPresentationControllerDelegateExample."
      @"bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel";
  self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel.text =
      @"bottomSheetPresentationControllerDidDismissBottomSheet called!";
  self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel.numberOfLines = 0;
  self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel.hidden = YES;
  [stackView
      addArrangedSubview:self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel];

  self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel =
      [[UILabel alloc] init];
  self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel
      .accessibilityIdentifier =
      @"BottomSheetPresentationControllerDelegateExample."
      @"bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel";
  self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel.text =
      @"bottomSheetPresentationControllerDidDismissBottomSheet called!";
  self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel.numberOfLines = 0;
  self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel.hidden = YES;
  [stackView addArrangedSubview:
                 self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel];

  [stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active =
      YES;
  [stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor]
      .active = YES;
  [stackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
      .active = YES;
}

- (void)presentBottomSheet {
  BottomSheetPresentationControllerDelegateExamplePresentedSheetController *sheetController =
      [[BottomSheetPresentationControllerDelegateExamplePresentedSheetController alloc] init];
  MDCBottomSheetPresentationController *presentationController =
      (MDCBottomSheetPresentationController *)sheetController.presentationController;
  presentationController.delegate = self;

  [self presentViewController:sheetController animated:YES completion:nil];
}

- (void)exit {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showBottomSheetPresentationControllerDidDismissBottomSheetCalledLabel {
  self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel.hidden = NO;
  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.bottomSheetPresentationControllerDidDismissBottomSheetCalledLabel.hidden = YES;
      });
}

- (void)showBottomSheetDismissalAnimationCompletedCalledLabel {
  self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel.hidden = NO;
  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.bottomSheetPresentationControllerDismissalAnimationCompletedCalledLabel.hidden = YES;
      });
}

#pragma mark - MDCBottomSheetPresentationControllerDelegate

- (void)bottomSheetDidChangeYOffset:(MDCBottomSheetPresentationController *)bottomSheet
                            yOffset:(CGFloat)yOffset {
  NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (MDCBottomSheetPresentationController *)bottomSheet {
  NSLog(@"%@", NSStringFromSelector(_cmd));
  [self showBottomSheetPresentationControllerDidDismissBottomSheetCalledLabel];
}

- (void)bottomSheetPresentationControllerDismissalAnimationCompleted:
    (MDCBottomSheetPresentationController *)bottomSheet {
  NSLog(@"%@", NSStringFromSelector(_cmd));
  [self showBottomSheetDismissalAnimationCompletedCalledLabel];
}

- (void)bottomSheetWillChangeState:(MDCBottomSheetPresentationController *)bottomSheet
                        sheetState:(MDCSheetState)sheetState {
  NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end

@implementation BottomSheetPresentationControllerDelegateExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Presentation Controller with Custom View Controller" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
