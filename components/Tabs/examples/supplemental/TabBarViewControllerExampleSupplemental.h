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
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <UIKit/UIKit.h>

#import "MaterialButtons+ButtonThemer.h"
#import "MaterialColorScheme.h"
#import "MaterialTabs.h"
#import "MaterialTypographyScheme.h"

typedef void (^MDCButtonActionBlock)(void);

@interface TabBarViewControllerExample : MDCTabBarViewController
@property(nonatomic, strong, nullable) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong, nullable) MDCTypographyScheme *typographyScheme;
@end

@interface TabBarViewControllerExample (Supplemental)

- (void)setupTabBarColors;

- (nonnull NSArray *)constructExampleViewControllers;

@end

@interface TBVCSampleViewController : UIViewController

@property(nonatomic, nullable) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, nullable) MDCTypographyScheme *typographyScheme;

+ (nonnull instancetype)sampleWithTitle:(nonnull NSString *)title color:(nonnull UIColor *)color;

- (void)setMDCButtonWithFrame:(CGRect)frame
                 buttonScheme:(nonnull id<MDCButtonScheming>)buttonScheme
                        title:(nonnull NSString *)title
                  actionBlock:(nullable MDCButtonActionBlock)actionBlock;
@end
