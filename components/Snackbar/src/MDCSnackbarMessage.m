#import "MDCSnackbarMessage.h"
#import "private/MDCSnackbarMessageInternal.h"
#import "private/MDCSnackbarMessageView.h"

static const NSTimeInterval kDefaultDuration = 4.0f;

const NSTimeInterval MDCSnackbarMessageDurationMax = 10;
NSString *const MDCSnackbarMessageBoldAttributeName = @"MDCSnackbarMessageBoldAttributeName";

@interface MDCSnackbarMessage ()

@property(nonatomic, readonly, strong) dispatch_queue_t targetQueue;

@property(nonatomic, assign) BOOL hasSetTextAlignment;

@end

@implementation MDCSnackbarMessage

@synthesize accessibilityIdentifier;
@dynamic text;

+ (instancetype)messageWithText:(NSString *)text {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = text;
  return message;
}

+ (instancetype)messageWithAttributedText:(NSAttributedString *)attributedText {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.attributedText = attributedText;
  return message;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _duration = kDefaultDuration;
  }
  return self;
}

- (Class)viewClass {
  return [MDCSnackbarMessageView class];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCSnackbarMessage *copy = [[[self class] alloc] init];
  copy.attributedText = self.attributedText;
  copy.duration = self.duration;
  copy.category = self.category;
  copy.accessibilityLabel = self.accessibilityLabel;
  copy.buttonTextColor = self.buttonTextColor;
  copy.highlightedButtonTextColor = self.highlightedButtonTextColor;

  // Unfortunately there's not really a concept of 'copying' a block (in the same way you would copy
  // a string, for example). A block's pointer is immutable once it is created and copied to the
  // heap, so we're pretty safe just using the same block.
  copy.completionHandler = self.completionHandler;
  copy.action = self.action;

  return copy;
}

- (dispatch_queue_t)targetQueue {
  return dispatch_get_main_queue();
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
  if (self.completionHandler) {
    dispatch_async(self.targetQueue, ^{
      self.completionHandler(userInteraction);
      if (completion) {
        completion();
      }
    });
  } else {
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

@end

@implementation MDCSnackbarMessageAction

@synthesize accessibilityIdentifier;

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCSnackbarMessageAction *copy = [[[self class] alloc] init];
  copy.title = self.title;
  copy.handler = self.handler;  // See the comment on @c completionHandler above.
  copy.accessibilityIdentifier = self.accessibilityIdentifier;

  return copy;
}

@end
