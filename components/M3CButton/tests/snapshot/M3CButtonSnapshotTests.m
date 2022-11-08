#import <XCTest/XCTest.h>

#import "M3CButton.h"
#import "MDCSnapshotTestCase.h"
#import "UIView+MDCSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

/** General snapshot tests for @c M3CButton. */
@interface M3CButtonSnapshotTests : MDCSnapshotTestCase

@end

@implementation M3CButtonSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view sizeToFit];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)styleButton:(M3CButton *)button {
  button.backgroundColor = [UIColor systemBlueColor];
  button.tintColor = [UIColor whiteColor];
  button.edgeInsetsWithImageAndTitle = UIEdgeInsetsMake(12, 24, 12, 24);
  button.edgeInsetsWithTitleOnly = UIEdgeInsetsMake(12, 24, 12, 24);
  button.edgeInsetsWithImageOnly = UIEdgeInsetsMake(12, 12, 12, 12);

  button.layer.cornerRadius = 4.0;
}

- (void)testButtonWithIcon {
  // Given
  M3CButton *button = [[M3CButton alloc] init];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  [button setImage:[UIImage systemImageNamed:@"plus"] forState:UIControlStateNormal];
  [self styleButton:button];
  if (button.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
  } else {
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -16);
  }
  [button sizeToFit];

  // When
  UIView *finalView = [self layoutView:button];

  // Then
  [self generateSnapshotAndVerifyForView:finalView];
}

- (void)testButtonNoIcon {
  // Given
  M3CButton *button = [[M3CButton alloc] init];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  [self styleButton:button];
  [button sizeToFit];

  // When
  UIView *finalView = [self layoutView:button];

  // Then
  [self generateSnapshotAndVerifyForView:finalView];
}

- (UIView *)layoutView:(UIView *)view {
  CGRect backgroundFrame = CGRectStandardize(view.frame);
  backgroundFrame.size =
      CGSizeMake(backgroundFrame.size.width + 50, backgroundFrame.size.height + 50);
  UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
  backgroundView.frame = backgroundFrame;
  [backgroundView addSubview:view];
  view.center = backgroundView.center;

  return backgroundView;
}

+ (NSOperatingSystemVersion)minimumOSVersion {
  return (NSOperatingSystemVersion){13, 0, 0};
}

@end

NS_ASSUME_NONNULL_END
