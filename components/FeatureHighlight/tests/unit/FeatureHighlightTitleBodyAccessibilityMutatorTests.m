//
//  FeatureHighlightTitleBodyAccessibilityMutatorTests.m
//  MaterialComponentsUnitTests
//
//  Created by Mohammad Cazi on 3/5/18.
//

#import <XCTest/XCTest.h>
#import "MaterialFeatureHighlight.h"
#import "MDCFeatureHighlightAccessibilityMutator.h"

static NSArray<UIColor *> *testColors(){
  return @[[UIColor whiteColor], [UIColor blackColor], [UIColor redColor], [UIColor orangeColor],
           [UIColor greenColor], [UIColor blueColor], [UIColor grayColor]];
}

@interface FeatureHighlightTitleBodyAccessibilityMutatorTests : XCTestCase

@end

@implementation FeatureHighlightTitleBodyAccessibilityMutatorTests

- (void)testMutatorChangesTextColor {
  for (UIColor *color in testColors()) {
    MDCFeatureHighlightViewController *highlightVC =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:[[UIView alloc] init]
                                                                completion:nil];
    MDCFeatureHighlightView *highlightView = (MDCFeatureHighlightView *)highlightVC.view;

    // Making the background color the same as the title/body color.
    highlightView.outerHighlightColor = color;
    highlightView.titleColor = color;
    highlightView.bodyColor = color;

    [MDCFeatureHighlightAccessibilityMutator
        mutateTitleColorForFeatureHighlightViewControllerIfApplicable:highlightVC];
    [MDCFeatureHighlightAccessibilityMutator
        mutateBodyColorForFeatureHighlightViewControllerIfApplicable:highlightVC];

    XCTAssertNotNil(highlightView.titleColor);
    XCTAssertNotNil(highlightView.bodyColor);
    XCTAssertNotEqualObjects(highlightView.titleColor, color, @"");
    XCTAssertNotEqualObjects(highlightView.bodyColor, color, @"");
  }
}

- (void)testMutatorKeepsAccessibleTextColor {
  NSDictionary* colors = @{ [UIColor redColor]: [UIColor blackColor]};
  for (UIColor *color in colors) {
    MDCFeatureHighlightViewController *highlightVC =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:[[UIView alloc] init]
                                                                completion:nil];
    MDCFeatureHighlightView *highlightView = (MDCFeatureHighlightView *)highlightVC.view;

    // Making the background color accessible with title/body color.
    highlightView.outerHighlightColor = colors[color];
    highlightView.titleColor = color;
    highlightView.bodyColor = color;

    [MDCFeatureHighlightAccessibilityMutator
        mutateTitleColorForFeatureHighlightViewControllerIfApplicable:highlightVC];
    [MDCFeatureHighlightAccessibilityMutator
       mutateBodyColorForFeatureHighlightViewControllerIfApplicable:highlightVC];

    XCTAssertEqualObjects(highlightView.titleColor, color, @"");
    XCTAssertEqualObjects(highlightView.bodyColor, color, @"");
  }
}

- (void)testMutatorSelectsTheRightColorWhenThereIsNoColorSet {
  MDCFeatureHighlightViewController *highlightVC =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:[[UIView alloc] init]
                                                              completion:nil];
  MDCFeatureHighlightView *highlightView = (MDCFeatureHighlightView *)highlightVC.view;

  // Making the background color accessible with title/body color.
  highlightView.outerHighlightColor = [UIColor blackColor];

  [MDCFeatureHighlightAccessibilityMutator
      mutateTitleColorForFeatureHighlightViewControllerIfApplicable:highlightVC];
  [MDCFeatureHighlightAccessibilityMutator
      mutateBodyColorForFeatureHighlightViewControllerIfApplicable:highlightVC];

  XCTAssertNotNil(highlightView.titleColor);
  XCTAssertNotNil(highlightView.bodyColor);
  XCTAssertNotEqualObjects(highlightView.titleColor, [UIColor blackColor], @"");
  XCTAssertNotEqualObjects(highlightView.bodyColor, [UIColor blackColor], @"");
}


@end
