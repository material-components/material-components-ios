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

#import "MDCContainedInputView.h"
#import "MDCContainedInputViewStyleBase.h"
#import "MDCTextControlLabelBehavior.h"

@interface MDCContainedInputViewStyleFilled : NSObject <MDCContainedInputViewStyle>
- (nonnull UIColor *)underlineColorForState:(MDCContainedInputViewState)state;
- (void)setUnderlineColor:(nonnull UIColor *)underlineColor
                 forState:(MDCContainedInputViewState)state;
- (nonnull UIColor *)filledBackgroundColorForState:(MDCContainedInputViewState)state;
- (void)setFilledBackgroundColor:(nonnull UIColor *)filledBackgroundColor
                        forState:(MDCContainedInputViewState)state;
@end
