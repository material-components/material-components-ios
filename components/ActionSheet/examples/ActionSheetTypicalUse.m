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

#import "ActionSheetTypicalUse.h"

#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"

@interface ActionSheetTypicalUse ()

@end

@implementation ActionSheetTypicalUse {
  MDCButton *_button;
  MDCActionSheetController *_actionSheet;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _button = [[MDCButton alloc] initWithFrame:CGRectZero];
    [_button setTitle:@"Show action sheet" forState:UIControlStateNormal];
    [_button sizeToFit];
    CGFloat width = CGRectGetWidth(_button.frame);
    _button.frame = CGRectMake(self.view.center.x - (width / 2.f),
                               self.view.center.y - 24.f,
                               width,
                               48.f);
    MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
    [MDCContainedButtonThemer applyScheme:buttonScheme toButton:_button];
    [_button addTarget:self
                action:@selector(presentActionSheet)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

-(void)presentActionSheet {
  NSString *messageString = @"The supporting message for this action sheet this can be mutliple lines but never more than two";
  _actionSheet =
      [MDCActionSheetController actionSheetControllerWithTitle:@"Action sheet"
                                                       message:messageString];
  MDCActionSheetAction *homeAction = [MDCActionSheetAction actionWithTitle:@"Home"
                                                                 image:[UIImage imageNamed:@"Home"]
                                                               handler:nil];
  MDCActionSheetAction *favoriteAction =
      [MDCActionSheetAction actionWithTitle:@"Favorite"
                                      image:[UIImage imageNamed:@"Favorite"]
                                    handler:^(MDCActionSheetAction *action){
                                      NSLog(@"Favorite Action");
                                    }];
  [_actionSheet addAction:homeAction];
  [_actionSheet addAction:favoriteAction];
  [self presentViewController:_actionSheet animated:YES completion:^(void){
    NSLog(@"Complete");
  }];
}

@end

@implementation ActionSheetTypicalUse (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Action Sheet", @"Action Sheet"];
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
