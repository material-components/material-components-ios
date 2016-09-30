#import "UIViewController+MaterialDialogs.h"

#import "MDCDialogPresentationController.h"

@implementation UIViewController (MaterialDialogs)

- (MDCDialogPresentationController *)mdc_dialogPresentationController {
  id presentationController = self.presentationController;
  if ([presentationController isKindOfClass:[MDCDialogPresentationController class]]) {
    return (MDCDialogPresentationController *)presentationController;
  }

  return nil;
}

@end
