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

/**
 * A transient view that mimics a system dialog/popup view. This view may be used as is or
 * subclassed. Do not add subviews directly to this view, but to its content view.
 */
@interface MDCBottomNavigationSystemDialogView : UIView

/**
 * The view that hosts all the content of the dialog. Add all subviews to this view. Layout subviews
 * within the @c contentView relative to the contentView's layout margins.
 */
@property(nonatomic, readonly, nonnull) UIView *contentView;

@end
