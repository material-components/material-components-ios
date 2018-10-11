// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCAlertActionSemantics.h"
#import "MaterialButtons.h"

@interface MDCAlertControllerView ()

@property(nonatomic, nonnull, strong) UILabel *titleLabel;
@property(nonatomic, nonnull, strong) UILabel *messageLabel;

@property(nonatomic, nullable, strong) UIImageView *titleIconImageView;

@property(nonatomic, nonnull, strong, readonly) NSArray<MDCButton *> *actionButtons;

- (nonnull MDCButton *)addActionButtonTitle:(NSString *_Nonnull)actionTitle
                                   emphasis:(MDCAlertActionEmphasis)emphasis
                                       role:(MDCAlertActionRole)role
                                     target:(nullable id)target
                                   selector:(SEL _Nonnull)selector;

- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize;

- (void)updateFonts;

@end
