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

#import "MDCAlertActionManager.h"

@interface MDCAlertActionManager ()

@property(nonatomic, nonnull, strong) NSMapTable<MDCAlertAction *, MDCButton *> *actionButtons;

@end

@implementation MDCAlertActionManager {
  NSMutableArray<MDCAlertAction *> *_actions;
}

@dynamic buttonsInActionOrder;

- (instancetype)init {
  self = [super init];
  if (self) {
    _actions = [[NSMutableArray alloc] init];
    _actionButtons = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                           valueOptions:NSMapTableStrongMemory];
  }
  return self;
}

- (NSArray<MDCButton *> *)buttonsInActionOrder {
  NSMutableArray<MDCButton *> *buttons =
      [[NSMutableArray alloc] initWithCapacity:self.actions.count];
  if ([self.actionButtons count] > 0) {
    for (MDCAlertAction *action in self.actions) {
      MDCButton *button = [self.actionButtons objectForKey:action];
      if (button) {
        [buttons addObject:button];
      }
    }
  }
  return buttons;
}

- (void)addAction:(nonnull MDCAlertAction *)action {
  [_actions addObject:action];
}

- (BOOL)hasAction:(nonnull MDCAlertAction *)action {
  return [_actions indexOfObject:action] != NSNotFound;
}

- (nullable MDCButton *)buttonForAction:(nonnull MDCAlertAction *)action {
  return [self.actionButtons objectForKey:action];
}

- (nullable MDCAlertAction *)actionForButton:(nonnull MDCButton *)button {
  for (MDCAlertAction *action in self.actionButtons) {
    MDCButton *currButton = [self.actionButtons objectForKey:action];
    if (currButton == button) {
      return action;
    }
  }
  return nil;
}

// creating a new buttons and associating it with the given action. the button is not added
// to view hierarchy.
- (nullable MDCButton *)createButtonForAction:(nonnull MDCAlertAction *)action
                                       target:(nullable id)target
                                     selector:(SEL _Nonnull)selector {
  MDCButton *button = [self.actionButtons objectForKey:action];
  if (button == nil) {
    button = [self makeButtonForAction:action target:target selector:selector];
    [self.actionButtons setObject:button forKey:action];
  }
  return button;
}

- (MDCButton *)makeButtonForAction:(MDCAlertAction *)action
                            target:(id)target
                          selector:(SEL)selector {
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [button setTitle:action.title forState:UIControlStateNormal];
  button.accessibilityIdentifier = action.accessibilityIdentifier;
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    button.pointerInteractionEnabled = YES;
  }
#endif
  [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
  return button;
}

@end
