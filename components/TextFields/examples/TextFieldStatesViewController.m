/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialTextFields.h"

#import <UIKit/UIKit.h>

@interface TextFieldStatesViewController : UIViewController

@property (nonatomic) Class selectedClass;
@property (nonatomic) NSArray <Class> *classes;

@property (nonatomic) id <MDCTextInputController> enabledController;
@property (nonatomic) MDCTextField *enabled;

@property (nonatomic) id <MDCTextInputController> disabledController;
@property (nonatomic) MDCTextField *disabled;

@property (nonatomic) id <MDCTextInputController> erroredController;
@property (nonatomic) MDCTextField *errored;

@property (nonatomic) id <MDCTextInputController> erroredDisabledController;
@property (nonatomic) MDCTextField *erroredDisabled;

@end

@implementation TextFieldStatesViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Text Field States";
  self.view.backgroundColor = UIColor.whiteColor;

  self.enabled = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.enabled.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.enabled];

  self.disabled = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.disabled.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.disabled];

  self.errored = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.errored.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.errored];

  self.erroredDisabled = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.erroredDisabled.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.erroredDisabled];

  [self setupControllers];

  UIBarButtonItem *styleButton =
      [[UIBarButtonItem alloc] initWithTitle:@"Style"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(styleButtonDidTouch:)];
  self.navigationItem.rightBarButtonItem = styleButton;
}

- (void)setupControllers {
  if (!self.classes) {
    // TODO: (larche) When more classes (other than full width) are added, put them in here so they
    // can be showcased.
    self.classes = @[[MDCTextInputControllerFilled self],
                     [MDCTextInputControllerOutlined self],
                     [MDCTextInputControllerUnderline self]];
    self.selectedClass = self.classes.firstObject;
  }

  if ([self.selectedClass conformsToProtocol:@protocol(MDCTextInputController)]) {
    self.enabledController =
        [(id <MDCTextInputController>)[self.selectedClass alloc] initWithTextInput:self.enabled];
    self.disabledController =
        [(id <MDCTextInputController>)[self.selectedClass alloc] initWithTextInput:self.disabled];
    self.erroredController =
        [(id <MDCTextInputController>)[self.selectedClass alloc] initWithTextInput:self.errored];
    self.erroredDisabledController =
        [(id <MDCTextInputController>)[self.selectedClass alloc] initWithTextInput:self.erroredDisabled];
  }
}

- (void)styleButtonDidTouch:(UIBarButtonItem *)sender {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"Controller Class"
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];

  __weak TextFieldStatesViewController *weakSelf = self;
  for (Class class in self.classes) {
    NSString *title = NSStringFromClass(class);
    title = [title stringByReplacingOccurrencesOfString:@"MDCTextInputController"
                                             withString:@""];
    if ([class isEqual:self.selectedClass]) {
      title = [title stringByAppendingString:@" ✓"];
    }
    UIAlertAction *action =
        [UIAlertAction actionWithTitle:title
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * __unused _Nonnull unusedAction) {
                                 weakSelf.selectedClass = class;
                                 [weakSelf setupControllers];
                               }];
    [alert addAction:action];
  }
  [self presentViewController:alert animated:YES completion:nil];
}

@end

@implementation TextFieldStatesViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"States (Objective-C)" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
