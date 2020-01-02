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

#import "MDCTraitEnvironmentChangeDelegate.h"
#import "MaterialContainerScheme.h"

/**
This View Controller is a generic content view controller for text control examples. It has a
scrollview with a series of subviews related to configuring text controls as well as some text
controls themselves. Subclasses are repsonsible for adding the text controls of their choice, be
they textfields or chip fields or text areas.
*/
@interface MDCTextControlContentViewController : UIViewController

/**
The MDCTraitEnvironmentChangeDelegate for the class.
*/
@property(nonatomic, weak) id<MDCTraitEnvironmentChangeDelegate> traitEnvironmentChangeDelegate;

/**
The MDCContainerScheming for the class.
*/
@property(strong, nonatomic) id<MDCContainerScheming> containerScheme;

/**
This property is used by the class and any subclasses to specify the scrollview subviews.
*/
@property(strong, nonatomic) NSArray *scrollViewSubviews;

/**
This property indicates whether the view controller should be in an error state.
*/
@property(nonatomic, assign) BOOL isErrored;

/**
This property indicates whether the text controls in the example should be disabled.
*/
@property(nonatomic, assign) BOOL isDisabled;

/**
This readonly property returns the preferred padding between scrollview subviews.
*/
@property(nonatomic, readonly) CGFloat defaultPadding;

/**
This method returns all the scrollview subviews of a given class.
*/
- (NSArray *)allScrollViewSubviewsOfClass:(Class)class;

/**
This method allows both this class and any subclasses to resize any scroll view subviews during the
layout process.
*/
- (UILabel *)createLabelWithText:(NSString *)text;

/**
 This method allows both this class and any subclasses to resize any scroll view subviews during the
 layout process.
 */
- (void)resizeScrollViewSubviews;

/**
This method allows both this class and any subclasses to apply themes to any subviews during the
layout process.
*/
- (void)applyThemesToScrollViewSubviews;

/**
This method allows subclasses to have first responders resign first responder.
*/
- (void)handleResignFirstResponderTapped;

/**
This method allows subclasses to toggle the enabled property on text controls as needed.
*/
- (void)handleDisableButtonTapped;

/**
This method allows subclasses to enforce the use of preferred fonts after the theming extension
applies static fonts.
*/
- (void)enforcePreferredFonts;

/**
This method allows this class and any subclasses to specify which scroll view subviews should be
displayed.
*/
- (void)initializeScrollViewSubviewsArray;

@end
