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

#import <XCTest/XCTest.h>

#import "MaterialButtonBar.h"
#import "MaterialNavigationBar.h"
#import "MaterialNavigationBar+TypographyThemer.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kEpsilonAccuracy = (CGFloat)0.001;

@interface MDCNavigationBar (Testing)
@property(nonatomic) UILabel *titleLabel;
- (MDCButtonBar *)leadingButtonBar;
- (MDCButtonBar *)trailingButtonBar;
@end

@interface NavigationBarTests : XCTestCase
@property(nonatomic) MDCNavigationBar *navBar;
@end

@implementation NavigationBarTests

- (void)setUp {
  [super setUp];
  self.navBar = [[MDCNavigationBar alloc] init];
}

- (void)tearDown {
  self.navBar = nil;
  [super tearDown];
}

- (void)setUpNavBarWithTitleViewLayoutBehavior:
    (MDCNavigationBarTitleViewLayoutBehavior)layoutBahavior {
  self.navBar.frame = CGRectMake(0, 0, 300, 25);
  self.navBar.titleView = [[UIView alloc] init];
  self.navBar.titleViewLayoutBehavior = layoutBahavior;
}

- (void)testSettingTextAlignmentToCenterMustCenterTheTitleLabel {
  // Given
  self.navBar.frame = CGRectMake(0, 0, 300, 25);
  self.navBar.title = @"this is a Title";

  // When
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.navBar.titleLabel.center.x, CGRectGetMidX(self.navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testChangingTextOfACenterTextAlignmentMustCenterTheTitleLabel {
  // Given
  self.navBar.frame = CGRectMake(0, 0, 300, 25);
  self.navBar.title = @"this is a Title";
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;

  // When
  self.navBar.title = @"..";
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.navBar.titleLabel.center.x, CGRectGetMidX(self.navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testSettingTextAlignmentToLeftMustLeftAlignTheTitleLabel {
  // Given
  self.navBar.frame = CGRectMake(0, 0, 200, 25);
  self.navBar.title = @"this is a Title";
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentCenter;
  [self.navBar layoutIfNeeded];

  // When
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentLeading;
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertLessThan(self.navBar.titleLabel.center.x, CGRectGetMidX(self.navBar.bounds));
}

- (void)testDefaultTextAlignment {
  // When
  MDCNavigationBarTitleAlignment alignment = self.navBar.titleAlignment;

  // Then
  XCTAssertEqual(alignment, MDCNavigationBarTitleAlignmentCenter);
}

- (void)testTitleViewIsCenteredWithNoButtonsAndFillBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorFill];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.navBar.titleView.center.x, CGRectGetMidX(self.navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testTitleViewShiftedRightWithLeadingButtonsAndFillBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorFill];
  self.navBar.leadingBarButtonItems =
      @[ [[UIBarButtonItem alloc] initWithTitle:@"Button"
                                          style:UIBarButtonItemStylePlain
                                         target:nil
                                         action:nil] ];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertGreaterThan(self.navBar.titleView.center.x, CGRectGetMidX(self.navBar.bounds));
}

- (void)testTitleViewShiftedLeftWithTrailingButtonsAndFillBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorFill];
  self.navBar.trailingBarButtonItems =
      @[ [[UIBarButtonItem alloc] initWithTitle:@"Button"
                                          style:UIBarButtonItemStylePlain
                                         target:nil
                                         action:nil] ];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertLessThan(self.navBar.titleView.center.x, CGRectGetMidX(self.navBar.bounds));
}

- (void)testTitleViewCenteredWithLeadingButtonsAndCenterBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorCenter];
  self.navBar.leadingBarButtonItems =
      @[ [[UIBarButtonItem alloc] initWithTitle:@"Button"
                                          style:UIBarButtonItemStylePlain
                                         target:nil
                                         action:nil] ];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.navBar.titleView.center.x, CGRectGetMidX(self.navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testTitleViewCenteredWithTrailingButtonsAndCenterBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorCenter];
  self.navBar.trailingBarButtonItems =
      @[ [[UIBarButtonItem alloc] initWithTitle:@"Button"
                                          style:UIBarButtonItemStylePlain
                                         target:nil
                                         action:nil] ];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.navBar.titleView.center.x, CGRectGetMidX(self.navBar.bounds),
                             kEpsilonAccuracy);
}

- (void)testTitleViewDefaultInsets {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorCenter];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(16, 0, 268, 25);
  [self helperTestView:self.navBar.titleView withExpectedRect:expectedRect];
}

- (void)testTitleViewWithCustomInsets {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorCenter];

  // When
  self.navBar.titleInsets = UIEdgeInsetsZero;
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(0, 0, 300, 25);
  [self helperTestView:self.navBar.titleView withExpectedRect:expectedRect];
}

- (void)testTitleViewWithDefaultInsetsAndFillBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorFill];

  // When
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(16, 0, 268, 25);
  [self helperTestView:self.navBar.titleView withExpectedRect:expectedRect];
}

- (void)testTitleViewWithCustomInsetsAndFillBehavior {
  // Given
  [self setUpNavBarWithTitleViewLayoutBehavior:MDCNavigationBarTitleViewLayoutBehaviorFill];

  // When
  self.navBar.titleInsets = UIEdgeInsetsZero;
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(0, 0, 300, 25);
  [self helperTestView:self.navBar.titleView withExpectedRect:expectedRect];
}

- (void)testTitleLabelWithDefaultInsets {
  // Given
  self.navBar.title = @"Foo";

  // When
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(16, 0, 268, 25);
  [self helperTestView:self.navBar.titleLabel withExpectedRect:expectedRect];
}

- (void)testTitleLabelWithCustomInsets {
  // Given
  self.navBar.title = @"Foo";

  // When
  self.navBar.titleInsets = UIEdgeInsetsZero;
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(0, 0, 300, 25);
  [self helperTestView:self.navBar.titleLabel withExpectedRect:expectedRect];
}

- (void)testTitleLabelWithDefaultInsetsAndLeadingAlignment {
  // Given
  self.navBar.title = @"Foo";

  // When
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentLeading;
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(16, 0, 268, 25);
  [self helperTestView:self.navBar.titleLabel withExpectedRect:expectedRect];
}

- (void)testTitleLabelWithCustomInsetsAndLeadingAlignment {
  // Given
  self.navBar.title = @"Foo";

  // When
  self.navBar.titleInsets = UIEdgeInsetsZero;
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentLeading;
  [self.navBar layoutIfNeeded];

  // Then
  CGRect expectedRect = CGRectMake(0, 0, 300, 25);
  [self helperTestView:self.navBar.titleLabel withExpectedRect:expectedRect];
}

- (void)helperTestView:(UIView *)view withExpectedRect:(CGRect)expectedRect {
  CGRect viewRect = CGRectStandardize(view.frame);
  XCTAssertEqualWithAccuracy(viewRect.origin.x, expectedRect.origin.x, 0.001);
  XCTAssertEqualWithAccuracy(viewRect.origin.y, expectedRect.origin.y, 0.001);
  if (![view isKindOfClass:[UILabel class]]) {
    XCTAssertEqualWithAccuracy(viewRect.size.width, expectedRect.size.width, 0.001);
    XCTAssertEqualWithAccuracy(viewRect.size.height, expectedRect.size.height, 0.001);
  }
}

- (void)testTitleFontProperty {
  // Given
  self.navBar.title = @"this is a Title";

  // Then
  XCTAssertNotNil(self.navBar.titleFont);
  XCTAssertEqualObjects(self.navBar.titleLabel.font, self.navBar.titleFont);

  // When
  UIFont *font = [UIFont systemFontOfSize:24];
  self.navBar.titleFont = font;

  // Then
  UIFont *resultFont = self.navBar.titleLabel.font;
  XCTAssertEqualObjects(resultFont.fontName, font.fontName);
  XCTAssertEqualWithAccuracy(resultFont.pointSize, 20, 0.01);

  // When
  NSDictionary<NSString *, NSNumber *> *fontTraits =
      [[font fontDescriptor] objectForKey:UIFontDescriptorTraitsAttribute];
  NSDictionary<NSString *, NSNumber *> *resultTraits =
      [[resultFont fontDescriptor] objectForKey:UIFontDescriptorTraitsAttribute];

  // Then
  XCTAssertEqualObjects(fontTraits, resultTraits);
}

- (void)testTitleFontPropertyWithAllowAnyTitleFontSizeEnabled {
  // Given
  self.navBar.title = @"this is a Title";
  self.navBar.allowAnyTitleFontSize = YES;

  // Then
  XCTAssertNotNil(self.navBar.titleFont);
  XCTAssertEqualObjects(self.navBar.titleLabel.font, self.navBar.titleFont);

  // When
  UIFont *font = [UIFont systemFontOfSize:24];
  self.navBar.titleFont = font;

  // Then
  UIFont *resultFont = self.navBar.titleLabel.font;
  XCTAssertEqualObjects(resultFont.fontName, font.fontName);
  XCTAssertEqualWithAccuracy(resultFont.pointSize, 24, 0.01);

  // When
  NSDictionary<NSString *, NSNumber *> *fontTraits =
      [[font fontDescriptor] objectForKey:UIFontDescriptorTraitsAttribute];
  NSDictionary<NSString *, NSNumber *> *resultTraits =
      [[resultFont fontDescriptor] objectForKey:UIFontDescriptorTraitsAttribute];

  // Then
  XCTAssertEqualObjects(fontTraits, resultTraits);
}

#pragma mark - Accessibility

- (void)testNavigationBarIsNotAccessibilityElement {
  // Then
  XCTAssertFalse(self.navBar.isAccessibilityElement);
}

- (void)testAccessibilityItemsCountWithNoTitle {
  // Then
  const NSInteger elementsCount = 3;  // Leading bar, titleLabel, trailing bar
  XCTAssertEqual(elementsCount, self.navBar.accessibilityElementCount);
}

- (void)testAccessibilityItemsCountWithTitleView {
  // When
  self.navBar.titleView = [[UIView alloc] init];

  // Then
  const NSInteger elementsCount = 3;  // Leading bar, titleView, trailing bar
  XCTAssertEqual(elementsCount, self.navBar.accessibilityElementCount);
}

- (void)testAccessibilityItemAtIndexDefault {
  // Then
  XCTAssertTrue([[self.navBar accessibilityElementAtIndex:0] isKindOfClass:[MDCButtonBar class]]);
  XCTAssertEqual(self.navBar.titleLabel, [self.navBar accessibilityElementAtIndex:1]);
  XCTAssertTrue([[self.navBar accessibilityElementAtIndex:2] isKindOfClass:[MDCButtonBar class]]);
}

- (void)testIndexOfAccessibilityElementDefault {
  // Then
  XCTAssertEqual(1, [self.navBar indexOfAccessibilityElement:self.navBar.titleLabel]);
  XCTAssertEqual(NSNotFound,
                 [self.navBar indexOfAccessibilityElement:self.navBar.leftBarButtonItem]);
}

- (void)testIndexOfAccessibilityElementWithTitleView {
  // When
  self.navBar.titleView = [[UIView alloc] init];

  // Then
  XCTAssertEqual(1, [self.navBar indexOfAccessibilityElement:self.navBar.titleView]);
  XCTAssertEqual(NSNotFound, [self.navBar indexOfAccessibilityElement:self.navBar.titleLabel]);
}

- (void)testAccessibilityElementsWithNoTitle {
  // Given
  UIBarButtonItem *leadingItem = [[UIBarButtonItem alloc] init];
  leadingItem.title = @"Leading";
  UIBarButtonItem *trailingItem = [[UIBarButtonItem alloc] init];
  trailingItem.title = @"Trailing";

  // When
  self.navBar.leadingBarButtonItem = leadingItem;
  self.navBar.trailingBarButtonItems = @[ leadingItem, trailingItem ];

  // Then
  NSArray *elements = self.navBar.accessibilityElements;
  XCTAssertNotNil(elements);
  XCTAssertEqual(3U, elements.count);
  id firstItem = elements[0];
  XCTAssertTrue([firstItem isKindOfClass:[MDCButtonBar class]]);
  if ([firstItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *leadingButtonBar = (MDCButtonBar *)firstItem;
    XCTAssertEqual(1U, leadingButtonBar.subviews.count);
  }
  XCTAssertEqualObjects(self.navBar.titleLabel, elements[1]);
  id secondItem = elements[2];
  XCTAssertTrue([secondItem isKindOfClass:[MDCButtonBar class]]);
  if ([secondItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *trailingButtonBar = (MDCButtonBar *)secondItem;
    XCTAssertEqual(2U, trailingButtonBar.subviews.count);
  }
}

- (void)testAccessibilityElementsWithTitleView {
  // Given
  UIBarButtonItem *leadingItem = [[UIBarButtonItem alloc] init];
  leadingItem.title = @"Leading";
  UIBarButtonItem *trailingItem = [[UIBarButtonItem alloc] init];
  trailingItem.title = @"Trailing";

  // When
  self.navBar.titleView = [[UIView alloc] init];
  self.navBar.leadingBarButtonItem = leadingItem;
  self.navBar.trailingBarButtonItems = @[ leadingItem, trailingItem ];

  // Then
  NSArray *elements = self.navBar.accessibilityElements;
  XCTAssertNotNil(elements);
  XCTAssertEqual(3U, elements.count);
  id firstItem = elements[0];
  XCTAssertTrue([firstItem isKindOfClass:[MDCButtonBar class]]);
  if ([firstItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *leadingButtonBar = (MDCButtonBar *)firstItem;
    XCTAssertEqual(1U, leadingButtonBar.subviews.count);
  }
  XCTAssertEqualObjects(self.navBar.titleView, elements[1]);
  id secondItem = elements[2];
  XCTAssertTrue([secondItem isKindOfClass:[MDCButtonBar class]]);
  if ([secondItem isKindOfClass:[MDCButtonBar class]]) {
    MDCButtonBar *trailingButtonBar = (MDCButtonBar *)secondItem;
    XCTAssertEqual(2U, trailingButtonBar.subviews.count);
  }
}

#pragma mark - Typography

- (void)testTypographyThemer {
  MDCTypographyScheme *scheme = [[MDCTypographyScheme alloc] init];
  [MDCNavigationBarTypographyThemer applyTypographyScheme:scheme toNavigationBar:self.navBar];

  // To enforce 20 point size we are using fontWithName:size: and for some reason even though the
  // printout looks idential comparing the fonts returns false. (Using fontWithSize: did not work
  // for system font medium, instead it returned a regular font).
  UIFont *titleFont = self.navBar.titleLabel.font;
  XCTAssertEqualObjects(titleFont.fontName, scheme.headline6.fontName);
  XCTAssertEqual(titleFont.pointSize, scheme.headline6.pointSize);

  // Weight for Fonts was not introduced on iOS 8
  // TODO: remove this when we drop iOS 8 support.
#if defined(__IPHONE_9_0) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
  XCTAssertEqual([NavigationBarTests weightForFont:titleFont],
                 [NavigationBarTests weightForFont:scheme.headline6]);
#endif
}

// I really don't like doing this but just to make sure the font has the right weight for the test
// I had to do this. Couldn't find any other way around it. When Apple support FontWithSize:
// properly for all fonts we can get rid of this.
+ (CGFloat)weightForFont:(UIFont *)font {
  // The default font weight is UIFontWeightRegular, which is 0.0.
  CGFloat weight = 0.0;

  NSDictionary *fontTraits = [font.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
  if (fontTraits) {
    NSNumber *weightNumber = fontTraits[UIFontWeightTrait];
    if (weightNumber != nil) {
      weight = [weightNumber floatValue];
    }
  }

  return weight;
}

#pragma mark - Color

- (void)testLeadingButtonBarItemsTintColorDefaultsToNil {
  // Then
  XCTAssertNil(self.navBar.leadingBarItemsTintColor);
}

- (void)testLeadingButtonBarItemsTintColorOverridesButtonBarTintColor {
  // When
  self.navBar.tintColor = UIColor.purpleColor;
  self.navBar.leadingBarItemsTintColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects([self.navBar leadingButtonBar].tintColor, UIColor.orangeColor);
}

- (void)testSetLeadingButtonBarItemsTintColorToNilRevertsToTintColor {
  // Given
  self.navBar.tintColor = UIColor.purpleColor;
  self.navBar.leadingBarItemsTintColor = UIColor.orangeColor;

  // When
  self.navBar.leadingBarItemsTintColor = nil;

  // Then
  XCTAssertEqualObjects([self.navBar leadingButtonBar].tintColor, UIColor.purpleColor);
}

- (void)testTrailingButtonBarItemsTintColorDefaultsToNil {
  // Then
  XCTAssertNil(self.navBar.trailingBarItemsTintColor);
}

- (void)testTrailingButtonBarItemsTintColorOverridesButtonBarTintColor {
  // When
  self.navBar.tintColor = UIColor.cyanColor;
  self.navBar.trailingBarItemsTintColor = UIColor.greenColor;

  // Then
  XCTAssertEqualObjects([self.navBar trailingButtonBar].tintColor, UIColor.greenColor);
}

- (void)testSetTrailingButtonBarItemsTintColorToNilRevertsToTintColor {
  // Given
  self.navBar.tintColor = UIColor.cyanColor;
  self.navBar.trailingBarItemsTintColor = UIColor.greenColor;

  // When
  self.navBar.trailingBarItemsTintColor = nil;

  // then
  XCTAssertEqualObjects([self.navBar trailingButtonBar].tintColor, UIColor.cyanColor);
}

- (void)testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges {
  // Given
  MDCNavigationBar *navigationBar = [[MDCNavigationBar alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  navigationBar.traitCollectionDidChangeBlock =
      ^(MDCNavigationBar *_Nonnull navBar, UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
      };

  // When
  [navigationBar traitCollectionDidChange:nil];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCNavigationBar *navigationBar = [[MDCNavigationBar alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCNavigationBar *passedNavigationBar;
  navigationBar.traitCollectionDidChangeBlock =
      ^(MDCNavigationBar *_Nonnull navBar, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedNavigationBar = navBar;
        [expectation fulfill];
      };

  // When
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [navigationBar traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedNavigationBar, navigationBar);
}

- (void)testDefaultElevations {
  XCTAssertEqualWithAccuracy(self.navBar.mdc_currentElevation, 0, 0.001);
  XCTAssertLessThan(self.navBar.mdc_overrideBaseElevation, 0);
}

- (void)testSettingBaseOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat fakeElevation = 99;

  // When
  self.navBar.mdc_overrideBaseElevation = fakeElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.navBar.mdc_overrideBaseElevation, fakeElevation, 0.001);
}

@end
