/*Copyright 2016-present Google Inc. All Rights Reserved.

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
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@class ExampleInstructionsViewHeaderStackViewTypicalUse;
@class HeaderStackViewTypicalUse;
@class MDCHeaderStackView;
@class MDCNavigationBar;

@interface HeaderStackViewTypicalUse : UIViewController

@property(nonatomic) BOOL toggled;
@property(nonatomic) ExampleInstructionsViewHeaderStackViewTypicalUse *_Nullable exampleView;
@property(nonatomic) MDCHeaderStackView *_Nullable stackView;
@property(nonatomic) MDCNavigationBar *_Nullable navBar;
@property(nonatomic) UIView *_Nullable topView;

@end

@interface HeaderStackViewTypicalUse (Supplemental)

- (void)setupExampleViews;

@end
