// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MDCTextControlContentViewController.h"
#import "MDCTraitEnvironmentChangeDelegate.h"
#import "MaterialContainerScheme.h"

/**
 This view controller manages a child view controller that contains the actual example content. It
 overrides the child view controller's trait collection based off the user's behavior.
 */
@interface MDCTextControlConfiguratorExample : UIViewController <MDCTraitEnvironmentChangeDelegate>

/**
The MDCContainerScheming for the class.
*/
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

/**
The text control content view controller for this class. It will be a subclass of
MDCTextControlContentViewController devoted either to textfields, chip fields, or text areas.
*/
@property(nonatomic, strong) MDCTextControlContentViewController *contentViewController;

/**
This method is overriden by subclasses to specify which content view controller should be used.
*/
- (void)initializeContentViewController;

@end
