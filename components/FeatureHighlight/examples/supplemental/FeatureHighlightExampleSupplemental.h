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

#import <UIKit/UIKit.h>

#import "MaterialCollections.h"
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

@interface FeatureHighlightTypicalUseViewController : UIViewController
@property(nonatomic) UILabel *infoLabel;
@property(nonatomic) UIButton *actionButton;
@property(nonatomic) UIButton *button;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

- (void)didTapButton:(id)sender;

@end

@interface FeatureHighlightColorExample : MDCCollectionViewController
@property(nonatomic) NSArray *colors;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@interface FeatureHighlightCustomFontsExample : UIViewController
@property(nonatomic) UILabel *infoLabel;
@property(nonatomic) UIButton *button;
@end

@interface FeatureHighlightShownViewExample : UIViewController
@property(nonatomic) UIButton *button;
@property(nonatomic) UIButton *actionButton;

@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

- (void)didTapButton:(id)sender;
@end
