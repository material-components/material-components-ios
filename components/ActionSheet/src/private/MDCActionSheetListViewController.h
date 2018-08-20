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

#import <UIKit/UIKit.h>
#import "MDCActionSheetController.h"
#import "MDCActionSheetItemTableViewCell.h"

@interface MDCActionSheetDataSource : NSObject <UITableViewDataSource>

- (nonnull instancetype)initWithActions:(NSArray<MDCActionSheetAction *> *)actions;

/**
 Adds an action to the table view.

 @param action Will be added to the table view.
*/
- (void)addAction:(nonnull MDCActionSheetAction *)action;

/**
 The actions that the table will display
*/
@property(nonatomic, readwrite, strong) NSMutableArray<MDCActionSheetAction *> *actions;

@property (nonatomic, nonnull, strong) UIFont *actionsFont;

@property (nonatomic, nonnull, strong) UIColor *backgroundColor;

@end
