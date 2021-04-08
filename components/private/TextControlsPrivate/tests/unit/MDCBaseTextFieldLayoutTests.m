// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextControlLabelBehavior.h"
#import "MaterialTextControlsPrivate+BaseStyle.h"
#import "MDCTextControlAssistiveLabelDrawPriority.h"
#import "MaterialTextControlsPrivate+Shared.h"
#import "MaterialTextControlsPrivate+TextFields.h"

@interface MDCBaseTextFieldLayout (Testing)
- (CGFloat)textHeightWithFont:(UIFont *)font;
@end

@interface MDCBaseTextFieldLayoutTests : XCTestCase
@end

@implementation MDCBaseTextFieldLayoutTests

#pragma mark Helpers

- (UIView *)createSideView {
  UIView *sideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  sideView.backgroundColor = [UIColor blueColor];
  return sideView;
}

- (MDCBaseTextFieldLayout *)createLayoutWithSideViewsAndViewMode:(UITextFieldViewMode)viewMode
                                                       isEditing:(BOOL)isEditing {
  CGSize textFieldSize = CGSizeMake(100, 30);
  UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  UIFont *floatingFont = [font fontWithSize:(font.pointSize * (CGFloat)0.5)];

  MDCTextControlAssistiveLabelView *assistiveLabelView =
      [[MDCTextControlAssistiveLabelView alloc] init];
  MDCTextControlVerticalPositioningReferenceBase *positioningReference =
      [[MDCTextControlVerticalPositioningReferenceBase alloc] init];
  MDCBaseTextFieldLayout *layout = [[MDCBaseTextFieldLayout alloc]
                 initWithTextFieldSize:textFieldSize
                  positioningReference:positioningReference
        horizontalPositioningReference:[[MDCTextControlHorizontalPositioningReference alloc] init]
                                  text:@"Text"
                                  font:font
                          floatingFont:floatingFont
                                 label:[[UILabel alloc] init]
                         labelPosition:MDCTextControlLabelPositionFloating
                         labelBehavior:MDCTextControlLabelBehaviorFloats
                     sideViewAlignment:MDCTextControlTextFieldSideViewAlignmentCenteredInContainer
                           leadingView:[self createSideView]
                       leadingViewMode:viewMode
                          trailingView:[self createSideView]
                      trailingViewMode:viewMode
                 clearButtonSideLength:19
                       clearButtonMode:viewMode
                 leadingAssistiveLabel:assistiveLabelView.leadingAssistiveLabel
                trailingAssistiveLabel:assistiveLabelView.trailingAssistiveLabel
            assistiveLabelDrawPriority:MDCTextControlAssistiveLabelDrawPriorityTrailing
      customAssistiveLabelDrawPriority:0
                                 isRTL:NO
                             isEditing:isEditing];
  return layout;
}

#pragma mark Tests

- (void)testTextHeightWithFont {
  // Given
  MDCBaseTextFieldLayout *emptyLayout = [[MDCBaseTextFieldLayout alloc] init];
  UIFont *systemFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];

  // When
  CGFloat ceiledLineHeight = (CGFloat)ceil((double)systemFont.lineHeight);
  CGFloat calculatedTextHeight = [emptyLayout textHeightWithFont:systemFont];

  // Then
  XCTAssertEqual(ceiledLineHeight, calculatedTextHeight);
}

- (void)testLeftAndRightViewsWithViewModeAlways {
  // Given
  MDCBaseTextFieldLayout *nonEditingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeAlways isEditing:NO];
  MDCBaseTextFieldLayout *editingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeAlways isEditing:YES];

  // Then
  XCTAssertTrue(nonEditingLayout.displaysLeadingView);
  XCTAssertTrue(nonEditingLayout.displaysTrailingView);
  XCTAssertTrue(editingLayout.displaysLeadingView);
  XCTAssertTrue(editingLayout.displaysTrailingView);
}

- (void)testLeftAndRightViewsWithViewModeWhileEditing {
  // Given
  MDCBaseTextFieldLayout *nonEditingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeWhileEditing isEditing:NO];
  MDCBaseTextFieldLayout *editingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeWhileEditing isEditing:YES];

  // Then
  XCTAssertFalse(nonEditingLayout.displaysLeadingView);
  XCTAssertFalse(nonEditingLayout.displaysTrailingView);
  XCTAssertTrue(editingLayout.displaysLeadingView);
  XCTAssertTrue(editingLayout.displaysTrailingView);
}

- (void)testLeftAndRightViewsWithViewModeUnlessEditing {
  // Given
  MDCBaseTextFieldLayout *nonEditingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeUnlessEditing isEditing:NO];
  MDCBaseTextFieldLayout *editingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeUnlessEditing isEditing:YES];

  // Then
  XCTAssertTrue(nonEditingLayout.displaysLeadingView);
  XCTAssertTrue(nonEditingLayout.displaysTrailingView);
  XCTAssertFalse(editingLayout.displaysLeadingView);
  XCTAssertFalse(editingLayout.displaysTrailingView);
}

- (void)testLeftAndRightViewsWithViewModeNever {
  // Given
  MDCBaseTextFieldLayout *nonEditingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeNever isEditing:NO];
  MDCBaseTextFieldLayout *editingLayout =
      [self createLayoutWithSideViewsAndViewMode:UITextFieldViewModeNever isEditing:YES];

  // Then
  XCTAssertFalse(nonEditingLayout.displaysLeadingView);
  XCTAssertFalse(nonEditingLayout.displaysTrailingView);
  XCTAssertFalse(editingLayout.displaysLeadingView);
  XCTAssertFalse(editingLayout.displaysTrailingView);
}

- (void)testLabelFrameWithLabelPosition {
  // Given
  MDCBaseTextFieldLayout *layout = [[MDCBaseTextFieldLayout alloc] init];

  // When
  layout.labelFrameNormal = CGRectMake(5, 5, 100, 20);
  layout.labelFrameFloating = CGRectMake(5, 0, 100, 20);

  // Then
  CGRect labelFrameWithLabelPositionFloating =
      [layout labelFrameWithLabelPosition:MDCTextControlLabelPositionFloating];
  CGRect labelFrameWithLabelPositionNormal =
      [layout labelFrameWithLabelPosition:MDCTextControlLabelPositionNormal];
  CGRect labelFrameWithLabelPositionNone =
      [layout labelFrameWithLabelPosition:MDCTextControlLabelPositionNone];
  XCTAssertTrue(CGRectEqualToRect(labelFrameWithLabelPositionFloating, layout.labelFrameFloating));
  XCTAssertTrue(CGRectEqualToRect(labelFrameWithLabelPositionNormal, layout.labelFrameNormal));
  XCTAssertTrue(CGRectEqualToRect(labelFrameWithLabelPositionNone, CGRectZero));
}

@end
