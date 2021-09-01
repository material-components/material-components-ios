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

#import "MaterialNavigationBar+ColorThemer.h"
#import "MaterialNavigationBar.h"
#import "MaterialTextFields.h"
#import "MaterialColorScheme.h"

@interface NavigationBarLayoutExample : UIViewController <UITextFieldDelegate>

@property(nonatomic, strong) MDCNavigationBar *navigationBar;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *leadingItemController;
@property(nonatomic, strong) MDCTextField *leadingItemField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *trailingItemController;
@property(nonatomic, strong) MDCTextField *trailingItemField;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *titleController;
@property(nonatomic, strong) MDCTextField *titleField;
@property(nonatomic, weak) UIBarButtonItem *trailingBarButtonItem;
@property(nonatomic, weak) UIBarButtonItem *leadingBarButtonItem;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;

@end
@implementation NavigationBarLayoutExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Title";
  self.view.backgroundColor = UIColor.whiteColor;

  self.navigationBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.navigationBar observeNavigationItem:self.navigationItem];
  [self.view addSubview:self.navigationBar];

  [MDCNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toNavigationBar:self.navigationBar];

  UIBarButtonItem *leadingButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"L"
                                       style:UIBarButtonItemStylePlain
                                      target:nil
                                      action:nil];
  UIBarButtonItem *trailingButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"T"
                                       style:UIBarButtonItemStylePlain
                                      target:nil
                                      action:nil];

  self.leadingBarButtonItem = leadingButtonItem;
  self.trailingBarButtonItem = trailingButtonItem;
  self.navigationItem.hidesBackButton = NO;
  self.navigationItem.leftBarButtonItems = @[ leadingButtonItem ];
  self.navigationItem.rightBarButtonItem = trailingButtonItem;

  self.leadingItemField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.leadingItemField.translatesAutoresizingMaskIntoConstraints = NO;
  self.leadingItemField.delegate = self;
  self.leadingItemField.text = @"L";

  self.leadingItemController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.leadingItemField];

  self.trailingItemField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.trailingItemField.translatesAutoresizingMaskIntoConstraints = NO;
  self.trailingItemField.delegate = self;
  self.trailingItemField.text = @"T";
  self.trailingItemController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.trailingItemField];

  self.titleField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.titleField.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleField.delegate = self;
  self.titleField.text = self.title;
  self.titleController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.titleField];

  [self.view addSubview:self.leadingItemField];
  [self.view addSubview:self.trailingItemField];
  [self.view addSubview:self.titleField];

  [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.navigationBar.topAnchor]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.navigationBar
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.leadingItemField
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.leadingItemField
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.titleField
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.titleField
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.trailingItemField
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0]
      .active = YES;

  NSDictionary *viewsBindings = NSDictionaryOfVariableBindings(_navigationBar, _leadingItemField,
                                                               _titleField, _trailingItemField);
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navigationBar]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsBindings]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-16-[_leadingItemField]-16-|"
                                                  options:0
                                                  metrics:nil
                                                    views:viewsBindings]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-16-[_titleField]-16-|"
                                                  options:0
                                                  metrics:nil
                                                    views:viewsBindings]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-16-[_trailingItemField]-16-|"
                                                  options:0
                                                  metrics:nil
                                                    views:viewsBindings]];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didTapBackButton {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *finishedString = [textField.text stringByReplacingCharactersInRange:range
                                                                     withString:string];

  // MDCNavigationBar doesn't handle BarButtonItems with no image and zero-length strings
  if (finishedString.length == 0) {
    finishedString = @" ";
  }
  if (textField == self.leadingItemField) {
    NSMutableArray<UIBarButtonItem *> *leadingItems =
        [self.navigationItem.leftBarButtonItems mutableCopy];
    [leadingItems removeLastObject];
    [leadingItems addObject:[[UIBarButtonItem alloc] initWithTitle:finishedString
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil]];
    self.navigationItem.leftBarButtonItems = leadingItems;
  } else if (textField == self.trailingItemField) {
    // We need to allocate and reassign because MDCNavigationBar does not adjust its layout
    // when the existing items change their title
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:finishedString
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
  } else if (textField == self.titleField) {
    self.title = finishedString;
  }
  return YES;
}

@end

@implementation NavigationBarLayoutExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Navigation Bar", @"Navigation Bar Item Layout" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
