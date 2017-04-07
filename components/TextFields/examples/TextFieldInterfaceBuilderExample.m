//
/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <Foundation/Foundation.h>
#import "TextFieldInterfaceBuilderExampleSupplemental.h"

@import MaterialComponents.MaterialTextFields;

@interface TextFieldInterfaceBuilderExample () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet MDCTextField *firstTextField;
@property(weak, nonatomic) IBOutlet MDCTextField *lastTextField;
@property(weak, nonatomic) IBOutlet MDCTextField *address1TextField;
@property(weak, nonatomic) IBOutlet MDCTextField *address2TextField;

@end

@implementation TextFieldInterfaceBuilderExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"MDCTextFields";

  [self setupExampleViews];
}

@end

@implementation TextFieldInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Storyboard (Objective C)" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TextFieldInterfaceBuilderExample";
}

@end
