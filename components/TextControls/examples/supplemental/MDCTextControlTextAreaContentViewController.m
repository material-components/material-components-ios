// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextControlTextAreaContentViewController.h"

#import "MDCTextControlContentViewController.h"
#import "MDCBaseTextArea.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

#import "MDCTextControlLabelBehavior.h"
#import "MDCFilledTextArea.h"
#import "MDCFilledTextArea+MaterialTheming.h"
#import "MDCOutlinedTextArea.h"
#import "MDCOutlinedTextArea+MaterialTheming.h"

@interface MDCTextControlTextAreaContentViewController () <UITextViewDelegate>
@property(nonatomic, assign) BOOL shouldAddDebugBorder;
@property(nonatomic, assign) BOOL shouldAddDebugLeadingView;
@end

@implementation MDCTextControlTextAreaContentViewController

#pragma mark Setup

- (MDCFilledTextArea *)createMaterialFilledTextArea {
  MDCFilledTextArea *textArea = [[MDCFilledTextArea alloc] init];
  textArea.textView.delegate = self;
  textArea.labelBehavior = MDCTextControlLabelBehaviorFloats;
  textArea.label.text = @"This is label text";
  textArea.leadingAssistiveLabel.text = @"This is assistive label text.";
  if (self.shouldAddDebugBorder) {
    [self addBorderToTextArea:textArea];
  }
  if (self.shouldAddDebugLeadingView) {
    [self addLeadingViewToTextArea:textArea];
  }
  [textArea applyThemeWithScheme:self.containerScheme];
  return textArea;
}

- (MDCOutlinedTextArea *)createMaterialOutlinedTextArea {
  MDCOutlinedTextArea *textArea = [[MDCOutlinedTextArea alloc] init];
  textArea.textView.delegate = self;
  textArea.label.text = @"This is label text";
  textArea.leadingAssistiveLabel.text = @"This is assistive label text.";
  if (self.shouldAddDebugBorder) {
    [self addBorderToTextArea:textArea];
  }
  if (self.shouldAddDebugLeadingView) {
    [self addLeadingViewToTextArea:textArea];
  }
  [textArea applyThemeWithScheme:self.containerScheme];
  return textArea;
}

- (MDCBaseTextArea *)createDefaultBaseTextArea {
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] init];
  textArea.textView.delegate = self;
  textArea.label.text = @"This is label text";
  textArea.leadingAssistiveLabel.text = @"This is assistive label text.";
  if (self.shouldAddDebugBorder) {
    [self addBorderToTextArea:textArea];
  }
  if (self.shouldAddDebugLeadingView) {
    [self addLeadingViewToTextArea:textArea];
  }
  return textArea;
}

- (void)textViewDidChange:(UITextView *)textView {
  [self.view setNeedsLayout];
}

- (void)addBorderToTextArea:(MDCBaseTextArea *)textArea {
  textArea.layer.borderColor = UIColor.redColor.CGColor;
  textArea.layer.borderWidth = 1;
}

- (void)addLeadingViewToTextArea:(MDCBaseTextArea *)textArea {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
  imageView.tintColor = self.containerScheme.colorScheme.primaryColor;
  UIImage *image =
      [[UIImage imageNamed:@"ic_cake"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  imageView.image = image;
  textArea.leadingView = imageView;
  textArea.leadingViewMode = UITextFieldViewModeAlways;
}

#pragma mark Overrides

- (void)initializeScrollViewSubviewsArray {
  [super initializeScrollViewSubviewsArray];

  self.shouldAddDebugBorder = NO;
  self.shouldAddDebugLeadingView = NO;

  MDCFilledTextArea *filledTextAreaWithoutFloatingLabel = [self createMaterialFilledTextArea];
  filledTextAreaWithoutFloatingLabel.labelBehavior = MDCTextControlLabelBehaviorDisappears;
  MDCOutlinedTextArea *outlinedTextAreaWithoutFloatingLabel = [self createMaterialOutlinedTextArea];
  outlinedTextAreaWithoutFloatingLabel.labelBehavior = MDCTextControlLabelBehaviorDisappears;
  MDCBaseTextArea *baseTextAreaWithoutFloatingLabel = [self createDefaultBaseTextArea];
  baseTextAreaWithoutFloatingLabel.labelBehavior = MDCTextControlLabelBehaviorDisappears;

  NSArray *textAreaRelatedScrollViewSubviews = @[
    [self createLabelWithText:@"MDCFilledTextArea:"],
    [self createMaterialFilledTextArea],
    [self createLabelWithText:@"MDCFilledTextArea without floating label:"],
    filledTextAreaWithoutFloatingLabel,
    [self createLabelWithText:@"MDCOutlinedTextArea:"],
    [self createMaterialOutlinedTextArea],
    [self createLabelWithText:@"MDCOutlinedTextArea without floating label:"],
    outlinedTextAreaWithoutFloatingLabel,
    [self createLabelWithText:@"MDCBaseTextArea:"],
    [self createDefaultBaseTextArea],
    [self createLabelWithText:@"MDCBaseTextArea without floating label:"],
    baseTextAreaWithoutFloatingLabel,
  ];
  NSMutableArray *mutableScrollViewSubviews = [self.scrollViewSubviews mutableCopy];
  self.scrollViewSubviews =
      [mutableScrollViewSubviews arrayByAddingObjectsFromArray:textAreaRelatedScrollViewSubviews];
}

- (void)applyThemesToScrollViewSubviews {
  [super applyThemesToScrollViewSubviews];

  [self applyThemesToTextAreas];
}

- (void)resizeScrollViewSubviews {
  [super resizeScrollViewSubviews];

  [self resizeTextAreas];
}

- (void)enforcePreferredFonts {
  [super enforcePreferredFonts];

  if (@available(iOS 10.0, *)) {
    [self.allTextAreas
        enumerateObjectsUsingBlock:^(MDCBaseTextArea *textArea, NSUInteger idx, BOOL *stop) {
          textArea.textView.adjustsFontForContentSizeCategory = YES;
          textArea.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody
                                       compatibleWithTraitCollection:textArea.traitCollection];
          textArea.leadingAssistiveLabel.font =
              [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2
                  compatibleWithTraitCollection:textArea.traitCollection];
          textArea.trailingAssistiveLabel.font =
              [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2
                  compatibleWithTraitCollection:textArea.traitCollection];
        }];
  }
}

- (void)handleResignFirstResponderTapped {
  [super handleResignFirstResponderTapped];

  [self.allTextAreas
      enumerateObjectsUsingBlock:^(MDCBaseTextArea *textArea, NSUInteger idx, BOOL *stop) {
        [textArea.textView resignFirstResponder];
      }];
}

- (void)handleDisableButtonTapped {
  [super handleDisableButtonTapped];

  [self.allTextAreas enumerateObjectsUsingBlock:^(MDCBaseTextArea *_Nonnull textArea,
                                                  NSUInteger idx, BOOL *_Nonnull stop) {
    textArea.enabled = !self.isDisabled;
  }];
}

#pragma mark Private helper methods

- (void)resizeTextAreas {
  CGFloat textAreaWidth = CGRectGetWidth(self.view.frame) - (2 * self.defaultPadding);
  [self.allTextAreas
      enumerateObjectsUsingBlock:^(MDCBaseTextArea *textArea, NSUInteger idx, BOOL *stop) {
        CGFloat textAreaMinX = CGRectGetMinX(textArea.frame);
        CGFloat textAreaMinY = CGRectGetMinY(textArea.frame);
        CGFloat viewHeight = CGRectGetHeight(textArea.frame);
        CGRect viewFrame = CGRectMake(textAreaMinX, textAreaMinY, textAreaWidth, viewHeight);
        textArea.frame = viewFrame;
        [textArea sizeToFit];
      }];
}

- (void)applyThemesToTextAreas {
  [self.allTextAreas
      enumerateObjectsUsingBlock:^(MDCBaseTextArea *textArea, NSUInteger idx, BOOL *stop) {
        BOOL isEven = idx % 2 == 0;
        if (self.isErrored) {
          if ([textArea isKindOfClass:[MDCFilledTextArea class]]) {
            MDCFilledTextArea *filledTextArea = (MDCFilledTextArea *)textArea;
            [filledTextArea applyErrorThemeWithScheme:self.containerScheme];
          } else if ([textArea isKindOfClass:[MDCOutlinedTextArea class]]) {
            MDCOutlinedTextArea *outlinedTextArea = (MDCOutlinedTextArea *)textArea;
            [outlinedTextArea applyErrorThemeWithScheme:self.containerScheme];
          }
          if (isEven) {
            textArea.leadingAssistiveLabel.text = @"Suspendisse quam elit, mattis sit amet justo "
                                                  @"vel, venenatis lobortis massa. Donec metus "
                                                  @"dolor.";
          } else {
            textArea.leadingAssistiveLabel.text = @"This is an error.";
          }
        } else {
          if ([textArea isKindOfClass:[MDCFilledTextArea class]]) {
            MDCFilledTextArea *filledTextArea = (MDCFilledTextArea *)textArea;
            [filledTextArea applyThemeWithScheme:self.containerScheme];
          } else if ([textArea isKindOfClass:[MDCOutlinedTextArea class]]) {
            MDCOutlinedTextArea *outlinedTextArea = (MDCOutlinedTextArea *)textArea;
            [outlinedTextArea applyThemeWithScheme:self.containerScheme];
          }
          if (isEven) {
            textArea.leadingAssistiveLabel.text = @"This is helper text.";
          } else {
            textArea.leadingAssistiveLabel.text = nil;
          }
        }
      }];
}

- (NSArray<MDCBaseTextArea *> *)allTextAreas {
  return [self allScrollViewSubviewsOfClass:[MDCBaseTextArea class]];
}

@end
