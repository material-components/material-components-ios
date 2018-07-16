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

#import "MDCActionSheetController.h"
#import "MDCBottomSheetController.h"
#import "MDCSheetContainerView.h"

@interface MDCActionSheetAction ()

@property(nonatomic, nullable, copy) MDCActionSheetHandler completionHandler;

@end

@implementation MDCActionSheetAction

+ (instancetype)actionWithTitle:(nonnull NSString *)title
                          image:(nonnull UIImage *)image
                          handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
    return [[MDCActionSheetAction alloc] initWithTitle:title
                                                 image:image
                                               handler:handler];
}

- (instancetype)initWithTitle:(nonnull NSString *)title
                        image:(nonnull UIImage *)image
                      handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
  self = [super init];
  if (self) {
    _title = [title copy];
    _image = [image copy];
    _completionHandler = [handler copy];
  }
  return self;
}

-(id)copyWithZone:(NSZone *)zone {
  MDCActionSheetAction *action = [[self class] actionWithTitle:self.title
                                                         image:self.image
                                                       handler:self.completionHandler];
  return action;
}

@end

@implementation MDCActionSheetController {
  NSMutableArray<MDCActionSheetAction *> *_actions;
  UIViewController *contentViewController;
  MDCBottomSheetController *bottomSheet;
}

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title {
  MDCActionSheetController *actionController =
      [[MDCActionSheetController alloc] initWithTitle:title];
  return actionController;
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _actions = [[NSMutableArray alloc] init];
    contentViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    contentViewController.view.backgroundColor = [UIColor whiteColor];
    bottomSheet =
        [[MDCBottomSheetController alloc] initWithContentViewController:contentViewController];
  }
  return self;
}

- (NSArray<MDCActionSheetAction *> *)actions {
  return [_actions copy];
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_actions addObject:[action copy]];
  [self addActionToActionSheet:action];
}

- (void)addActionToActionSheet:(MDCActionSheetAction *)action {
  /*if (self.tableView) {

  }*/
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor greenColor];
  [self addChildViewController:bottomSheet];
}

@end

/*@interface MDCActionSheetPresentationController ()
@end

@implementation MDCActionSheetPresentationController {
  UIView *_scrimView;
  MDCSheetContainerView *_sheetView;
}

@synthesize delegate;

- (UIView *)presentedView {
  return _sheetView;
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  if (!completed) {
    [_scrimView removeFromSuperview];
  }
}

- (void)dismissalTransitionWillBegin {

}

@end*/








