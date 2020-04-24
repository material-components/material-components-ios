#import <XCTest/XCTest.h>

#include "googlemac/iPhone/Shared/GoogleMaterial/catalog/tests/ui/supplemental/GMDCCatalogEarlGreyHelpers.h"
#include "googlemac/iPhone/Shared/GoogleMaterial/catalog/tests/ui/supplemental/GMDCCatalogScubaHelpers.h"
#import "googlemac/iPhone/Shared/Testing/EarlGrey/Contribs/Scuba/EarlGrey+GREYScuba.h"
#import "MaterialChips.h"

@interface MDCChipFieldEarlGreyTests : XCTestCase
/**
 The Scuba library instance for the test.
 */
@property(nonatomic, strong) SCUMobileLibrary *scubaMobileLibrary;
@property(nonatomic, strong) XCUIApplication *application;
@end

@implementation MDCChipFieldEarlGreyTests

+ (void)setUp {
  [super setUp];
  GMDCCatalogEarlGreyHelpers.mainScreenAccessibilityLabel = @"Material Components for iOS";
  GMDCCatalogEarlGreyHelpers.mainDemoButtonAccessibilityIdentifier = @"start.demo";
}

- (void)setUp {
  [super setUp];

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    self.application = [[XCUIApplication alloc] init];
    [self.application launch];
  });

  self.scubaMobileLibrary = [[SCUMobileLibrary alloc] init];
}

- (void)tearDown {
  [self.scubaMobileLibrary assertLazyAssertsPass];

  [super tearDown];
}

- (void)testPlaceholderIsVisibleAfterInputAndRotation {
  // Given
  [GMDCCatalogEarlGreyHelpers openComponentExampleList:@"Chips"];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"CellInput")] performAction:grey_tap()];
  id<GREYInteraction> chipFieldTextFieldElement =
      [EarlGrey selectElementWithMatcher:grey_accessibilityID(@"chip_field_text_field")];
  [chipFieldTextFieldElement performAction:grey_tap()];
  [chipFieldTextFieldElement performAction:grey_typeText(@"some text")];

  // When
  [EarlGrey rotateDeviceToOrientation:UIDeviceOrientationLandscapeLeft error:nil];
  [EarlGrey rotateDeviceToOrientation:UIDeviceOrientationPortrait error:nil];
  [chipFieldTextFieldElement performAction:grey_clearText()];
  [EarlGrey dismissKeyboardWithError:nil];

  // Then
  [self compareScreenshotForSelector:_cmd];
}

- (void)compareScreenshotForSelector:(SEL)selector {
  NSString *goldenKey = [NSString
      stringWithFormat:@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(selector)];
  [GMDCCatalogScubaHelpers compareGoldenImageWithKey:goldenKey
                                   usingScubaLibrary:self.scubaMobileLibrary];
}

@end
