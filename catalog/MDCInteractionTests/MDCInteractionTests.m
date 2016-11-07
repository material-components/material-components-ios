@import EarlGrey;
#import <XCTest/XCTest.h>

@interface MDCInteractionTests : XCTestCase
@end

@implementation MDCInteractionTests

/**
 Placeholder EarlGrey test to verify things are working.

 @see https://github.com/google/EarlGrey/blob/master/docs/install-and-run.md
 */
- (void)testPresenceOfKeyWindow {
  [[EarlGrey selectElementWithMatcher:grey_keyWindow()]
      assertWithMatcher:grey_sufficientlyVisible()];
}

@end
