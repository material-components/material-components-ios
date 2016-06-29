#import "MDCSnackbarMessage.h"

/**
 Internal-only methods used by MDCSnackbarMessage and MDCSnackbarManager.
 */
@interface MDCSnackbarMessage ()

/**
 The class of the view which should be instantiated in order to show this message.

 The class returned by this method must be a subclass of MDCSnackbarMessageView.
 */
- (Class)viewClass;

/**
 Executes @c self.completionhandler on the main thread.

 @c completion is called after @c self.completionHandler has executed. If @c self.completionHandler
 is nil, then @c completion fires immediately from the calling thread.
 */
- (void)executeCompletionHandlerWithUserInteraction:(BOOL)userInteraction
                                         completion:(void (^)(void))completion;

/**
 Given @c action, which must be in @c self.actions, this method will call the action handler on
 @c self.targetQueue.

 @c completion is called after the handler has executed. If @c action.handler is nil, then
 @c completion fires immediately from the calling thread. Passing a nil @c action will immediately
 call @c completion.
 */
- (void)executeActionHandler:(MDCSnackbarMessageAction *)action
                  completion:(void (^)(void))completion;

@end
