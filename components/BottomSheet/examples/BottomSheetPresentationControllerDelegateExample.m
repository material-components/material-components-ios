#import "BottomSheetPresenterViewController.h"
#import "MaterialBottomSheet.h"

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
  }
  return self;
}

@end

/**
 Demonstrates use of MDCBottomSheetPresentationController functionality.
*/
@interface BottomSheetPresentationControllerDelegateExample
    : BottomSheetPresenterViewController <MDCBottomSheetPresentationControllerDelegate>
@end

@implementation BottomSheetPresentationControllerDelegateExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.button setTitle:@"Present Custom Controller" forState:UIControlStateNormal];
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

#pragma mark - MDCBottomSheetPresentationControllerDelegate

- (void)bottomSheetDidChangeYOffset:(MDCBottomSheetPresentationController *)bottomSheet
                            yOffset:(CGFloat)yOffset {
  NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (MDCBottomSheetPresentationController *)bottomSheet {
  NSLog(@"%@", NSStringFromSelector(_cmd));
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
