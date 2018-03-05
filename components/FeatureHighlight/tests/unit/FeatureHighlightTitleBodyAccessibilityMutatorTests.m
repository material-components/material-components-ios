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

- (void)testMutateChangesTextColor {
  for (UIColor *color in testColors()) {
    // Given
    MDCFeatureHighlightViewController *highlightVC =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:[UIView new]
                                                                completion:nil];
    MDCFeatureHighlightView *highlightView = (MDCFeatureHighlightView *)highlightVC.view;

    // Making the background color the same as the title/body color.
    highlightView.outerHighlightColor = color;
    highlightView.titleColor = color;
    highlightView.bodyColor = color;

    // When
    [MDCFeatureHighlightAccessibilityMutator
        changeTitleAndBodyColorForFeatureHighlightViewControllerIfApplicable:highlightVC];

    // Then
    XCTAssertNotEqualObjects(highlightView.titleColor, color, @"Not same color");
    XCTAssertNotEqualObjects(highlightView.bodyColor, color, @"Not same color");
  }
}

- (void)testMutateKeepsAccessibleTextColor {
  NSDictionary* colors = @{ [UIColor redColor]: [UIColor blackColor]};
  for (UIColor *color in colors) {
 // Given
  MDCFeatureHighlightViewController *highlightVC =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:[UIView new]
                                                              completion:nil];
  MDCFeatureHighlightView *highlightView = (MDCFeatureHighlightView *)highlightVC.view;

  // Making the background color accessible with title/body color.
  highlightView.outerHighlightColor = colors[color];
  highlightView.titleColor = color;
  highlightView.bodyColor = color;

  // When
  [MDCFeatureHighlightAccessibilityMutator
      changeTitleAndBodyColorForFeatureHighlightViewControllerIfApplicable:highlightVC];

  // Then
  XCTAssertEqualObjects(highlightView.titleColor, color, @"Same color");
  XCTAssertEqualObjects(highlightView.bodyColor, color, @"Same color");
  }
}

@end
