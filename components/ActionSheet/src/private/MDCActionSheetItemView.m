/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCActionSheetItemView.h"
#import "MaterialTypography.h"

//static const CGFloat TitleLabelAlpha = 0.54f;
//static const CGFloat TitleLabelLeadingPadding = 16.f;
//static const CGFloat TitleLabelVerticalPadding = 18.f;
//
//static const CGFloat LabelLeadingPadding = 72.f;
//static const CGFloat LabelTrailingPadding = 16.f;
///// This comes from design, a cell should be 56pt tall and the baseline for a single
///// line list item should be centered. Standard font is 20pt tall so that leaves 36pt
///// to support dynamic type we have 36pt / 2 = 18pt.
///// If we change the standard font this will need to be changed.
//static const CGFloat LabelVerticalPadding = 18.f;
//static const CGFloat LabelAlpha = 0.87f;
//
//static const CGFloat ImageLeadingPadding = 16.f;
//static const CGFloat ImageTopPadding = 16.f;
//static const CGFloat ImageAlpha = 0.54f;

@interface MDCActionSheetItemView ()

@end


@implementation MDCActionSheetItemView {
}

@end

@implementation MDCActionSheetHeaderView

- (instancetype)initWithTitle:(NSString *)title {
  return [[MDCActionSheetHeaderView alloc] initWithTitle:title message:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
  self = [super init];
  if (self) {
    _title = title;
    _message = message;
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

-(void)commonMDCActionSheetHeaderViewInit {
  return;
}


@end
