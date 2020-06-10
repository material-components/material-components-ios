// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"
#import "private/MDCSnackbarMessageInternal.h"

static const NSTimeInterval kDefaultDuration = 4;

const NSTimeInterval MDCSnackbarMessageDurationMax = 10;
NSString *const MDCSnackbarMessageBoldAttributeName = @"MDCSnackbarMessageBoldAttributeName";

@interface MDCSnackbarMessage ()

@property(nonatomic, readonly, strong) dispatch_queue_t targetQueue;

@property(nonatomic, assign) BOOL hasSetTextAlignment;

@end

@implementation MDCSnackbarMessage
static BOOL _usesLegacySnackbar = NO;
@synthesize accessibilityIdentifier;
@dynamic text;

+ (instancetype)messageWithText:(NSString *)text {
  MDCSnackbarMessage *message = [[[self class] alloc] init];
  message.text = text;
  return message;
}

+ (instancetype)messageWithAttributedText:(NSAttributedString *)attributedText {
  MDCSnackbarMessage *message = [[[self class] alloc] init];
  message.attributedText = attributedText;
  return message;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _duration = kDefaultDuration;
    _automaticallyDismisses = YES;
  }
  return self;
}

- (Class)viewClass {
  return [MDCSnackbarMessageView class];
}

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCSnackbarMessage *copy = [[[self class] alloc] init];
  copy.attributedText = self.attributedText;
  copy.duration = self.duration;
  copy.category = self.category;
  copy.accessibilityLabel = self.accessibilityLabel;
  copy.accessibilityHint = self.accessibilityHint;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  copy.buttonTextColor = self.buttonTextColor;
#pragma clang diagnostic pop
  copy.enableRippleBehavior = self.enableRippleBehavior;
  copy.focusOnShow = self.focusOnShow;
  copy.elementToFocusOnDismiss = self.elementToFocusOnDismiss;
  copy.automaticallyDismisses = self.automaticallyDismisses;
  copy.presentationHostViewOverride = self.presentationHostViewOverride;
  copy.shouldDismissOnOverlayTap = self.shouldDismissOnOverlayTap;

  // Unfortunately there's not really a concept of 'copying' a block (in the same way you would copy
  // a string, for example). A block's pointer is immutable once it is created and copied to the
  // heap, so we're pretty safe just using the same block.
  copy.completionHandler = self.completionHandler;
  copy.completionHandlerWithError = self.completionHandlerWithError;
  copy.action = self.action;
  copy.snackbarMessageWillPresentBlock = self.snackbarMessageWillPresentBlock;
  copy.error = self.error;

  return copy;
}

- (dispatch_queue_t)targetQueue {
  return dispatch_get_main_queue();
}

- (NSString *)description {
  NSMutableString *description = [[NSMutableString alloc] init];
  [description appendFormat:@"<%@: %p> {\n", [self class], self];
  [description appendFormat:@"  text: \"%@\",\n", self.text];
  if (self.action) {
    [description appendFormat:@"  action: \"%@\",\n", self.action.title];
  }
  [description appendFormat:@"  viewClass: \"%@\",\n", self.viewClass];
  [description appendString:@"}"];
  return [description copy];
}

#pragma mark Text

- (void)setText:(NSString *)text {
  self.attributedText = [[NSAttributedString alloc] initWithString:[text copy]];
}

- (NSString *)text {
  return [self.attributedText string];
}

#pragma mark - Duration

- (void)setDuration:(NSTimeInterval)duration {
  NSAssert(duration <= MDCSnackbarMessageDurationMax,
           @"Duration %g is longer than the maximum allowed: %g.", duration,
           MDCSnackbarMessageDurationMax);
  _duration = MIN(MDCSnackbarMessageDurationMax, duration);
}

#pragma mark - A11y

- (NSString *)voiceNotificationText {
  if ([self.accessibilityLabel length]) {
    return self.accessibilityLabel;
  } else {
    return self.text;
  }
}

#pragma mark - Internal

- (void)executeCompletionHandlerWithUserInteraction:(BOOL)userInteraction
                                         completion:(void (^)(void))completion {
  if (self.completionHandlerWithError || self.completionHandler) {
    dispatch_async(self.targetQueue, ^{
      NSError *error = self.error;
      self.error = nil;  // Break retain cycle.
      if (self.completionHandlerWithError) {
        self.completionHandlerWithError(userInteraction, error);
      }
      if (self.completionHandler) {
        self.completionHandler(userInteraction);
      }
      if (completion) {
        completion();
      }
    });
  } else {
    self.error = nil;  // Break retain cycle.
    if (completion) {
      completion();
    }
  }
}

- (void)executeActionHandler:(MDCSnackbarMessageAction *)action
                  completion:(void (^)(void))completion {
  if (!action || !action.handler) {
    if (completion) {
      completion();
    }
    return;
  }

  // Fire off the action handler.
  dispatch_async(self.targetQueue, ^{
    action.handler();
    if (completion) {
      completion();
    }
  });
}

+ (void)setUsesLegacySnackbar:(BOOL)usesLegacySnackbar {
  _usesLegacySnackbar = usesLegacySnackbar;
}

+ (BOOL)usesLegacySnackbar {
  return _usesLegacySnackbar;
}

@end

@implementation MDCSnackbarMessageAction

@synthesize accessibilityIdentifier;

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCSnackbarMessageAction *copy = [[[self class] alloc] init];
  copy.title = self.title;
  copy.handler = self.handler;  // See the comment on @c completionHandler above.
  copy.accessibilityIdentifier = self.accessibilityIdentifier;
  copy.accessibilityHint = self.accessibilityHint;

  return copy;
}

@end
