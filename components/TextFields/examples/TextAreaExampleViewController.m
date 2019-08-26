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

#import "TextAreaExampleViewController.h"

#import "MaterialButtons.h"

#import "MDCBaseTextArea+MaterialTheming.h"
#import "MDCBaseTextArea.h"
#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"

static const CGFloat kSideMargin = (CGFloat)20.0;

@interface TextAreaExampleViewController () <UITextViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) NSArray *scrollViewSubviews;

@property(strong, nonatomic) MDCContainerScheme *containerScheme;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation TextAreaExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] init];
    containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
    self.containerScheme = containerScheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addObservers];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addSubviews];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self layoutScrollView];
  [self layoutScrollViewSubviews];
  [self updateScrollViewContentSize];
  [self updateButtonThemes];
  [self updateLabelColors];
}

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addSubviews {
  self.scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:self.scrollView];
  self.scrollViewSubviews = @[
    [self createToggleErrorButton], [self createResignFirstResponderButton],
    [self createLabelWithText:@"Filled TextArea:"], [self createFilledTextArea],
    //    [self createLabelWithText:@"Outlined TextArea:"],
    //    [self createOutlinedTextArea],
  ];
  for (UIView *view in self.scrollViewSubviews) {
    [self.scrollView addSubview:view];
  }
}

- (void)layoutScrollView {
  CGFloat originX = CGRectGetMinX(self.view.bounds);
  CGFloat originY = CGRectGetMinY(self.view.bounds);
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);
  if (@available(iOS 11.0, *)) {
    originX += self.view.safeAreaInsets.left;
    originY += self.view.safeAreaInsets.top;
    width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
    height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  }
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.scrollView.frame = frame;
}

- (void)layoutScrollViewSubviews {
  CGFloat viewMinX = kSideMargin;
  CGFloat viewMinY = kSideMargin;
  for (UIView *view in self.scrollViewSubviews) {
    CGSize viewSize = view.frame.size;
    CGFloat textFieldWidth = CGRectGetWidth(self.scrollView.frame) - (2 * kSideMargin);
    if ([view isKindOfClass:[MDCBaseTextArea class]]) {
      viewSize = CGSizeMake(textFieldWidth, CGRectGetHeight(view.frame));
    }
    CGRect viewFrame = CGRectMake(viewMinX, viewMinY, viewSize.width, viewSize.height);
    view.frame = viewFrame;
    [view sizeToFit];
    viewMinY = viewMinY + CGRectGetHeight(view.frame) + kSideMargin;
  }
}

- (void)updateScrollViewContentSize {
  CGFloat maxX = CGRectGetWidth(self.scrollView.bounds);
  CGFloat maxY = CGRectGetHeight(self.scrollView.bounds);
  for (UIView *subview in self.scrollView.subviews) {
    CGFloat subViewMaxX = CGRectGetMaxX(subview.frame);
    if (subViewMaxX > maxX) {
      maxX = subViewMaxX;
    }
    CGFloat subViewMaxY = CGRectGetMaxY(subview.frame);
    if (subViewMaxY > maxY) {
      maxY = subViewMaxY;
    }
  }
  self.scrollView.contentSize = CGSizeMake(maxX, maxY + kSideMargin);
}

- (MDCButton *)createResignFirstResponderButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(resignFirstResponderButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

- (MDCButton *)createToggleErrorButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Toggle error" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(toggleErrorButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  return button;
}

- (UILabel *)createLabelWithText:(NSString *)text {
  UILabel *label = [[UILabel alloc] init];
  label.textColor = self.containerScheme.colorScheme.primaryColor;
  label.font = self.containerScheme.typographyScheme.subtitle2;
  label.text = text;
  return label;
}

- (MDCBaseTextArea *)createOutlinedTextArea {
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] init];
  [textArea applyOutlinedThemeWithScheme:self.containerScheme];
  textArea.textView.delegate = self;
  textArea.label.text = @"Stuff";
  textArea.preferredContainerHeight = 150;
  [textArea sizeToFit];
  return textArea;
}

- (MDCBaseTextArea *)createFilledTextArea {
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] init];
  [textArea applyFilledThemeWithScheme:self.containerScheme];
  textArea.textView.delegate = self;
  textArea.label.text = @"Stuff";
  textArea.preferredNumberOfVisibleRows = 4;
  [textArea sizeToFit];
  return textArea;
}

#pragma mark Private

- (void)updateButtonThemes {
  [self.allButtons enumerateObjectsUsingBlock:^(MDCButton *button, NSUInteger idx, BOOL *stop) {
    if (self.isErrored) {
      MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
      colorScheme.primaryColor = colorScheme.errorColor;
      MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
      containerScheme.colorScheme = colorScheme;
      [button applyContainedThemeWithScheme:containerScheme];
    } else {
      [button applyOutlinedThemeWithScheme:self.containerScheme];
    }
  }];
}

- (void)updateTextAreaStates {
  [self.allInputTextAreas
      enumerateObjectsUsingBlock:^(MDCBaseTextArea *textArea, NSUInteger idx, BOOL *stop) {
        BOOL isEven = idx % 2 == 0;
        if (self.isErrored) {
          // TODO: Make TextArea respond to error theme selector
          //      if ([textArea respondsToSelector:@selector(applyErrorThemeWithScheme:)]) {
          //        [textArea applyErrorThemeWithScheme:self.containerScheme];
          //      }
          if (isEven) {
            // TODO: Make TextArea expose assistive labels

            //            textArea.leadingAssistiveLabel.text = @"Suspendisse quam elit, mattis sit
            //            amet justo "
            //                                                  @"vel, venenatis lobortis massa.
            //                                                  Donec metus "
            //                                                  @"dolor.";
          } else {
            //            textArea.leadingAssistiveLabel.text = @"This is an error.";
          }
        } else {
          //          if ([textArea respondsToSelector:@selector(applyThemeWithScheme:)]) {
          //            [textArea applyThemeWithScheme:self.containerScheme];
          //          }
          //          if (isEven) {
          //            textArea.leadingAssistiveLabel.text = @"This is helper text.";
          //          } else {
          //            textArea.leadingAssistiveLabel.text = nil;
          //          }
        }
      }];
  [self.view setNeedsLayout];
}

- (void)updateLabelColors {
  [self.allLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
    id<MDCColorScheming> colorScheme = self.containerScheme.colorScheme;
    UIColor *textColor = self.isErrored ? colorScheme.errorColor : colorScheme.primaryColor;
    label.textColor = textColor;
  }];
}

- (NSArray<MDCBaseTextArea *> *)allInputTextAreas {
  return [self allViewsOfClass:[MDCBaseTextArea class]];
}

- (NSArray<MDCButton *> *)allButtons {
  return [self allViewsOfClass:[MDCButton class]];
}

- (NSArray<UILabel *> *)allLabels {
  return [self allViewsOfClass:[UILabel class]];
}

- (NSArray *)allViewsOfClass:(Class)class {
  return [self.scrollViewSubviews
      objectsAtIndexes:[self.scrollViewSubviews indexesOfObjectsPassingTest:^BOOL(
                                                    UIView *view, NSUInteger idx, BOOL *stop) {
        return [view isKindOfClass:class];
      }]];
}

- (void)keyboardWillShow:(NSNotification *)notification {
  CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notification {
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark IBActions

- (void)resignFirstResponderButtonTapped:(UIButton *)button {
  [self.allInputTextAreas
      enumerateObjectsUsingBlock:^(MDCBaseTextArea *textArea, NSUInteger idx, BOOL *stop) {
        [textArea resignFirstResponder];
      }];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  self.isErrored = !self.isErrored;
  [self updateButtonThemes];
  [self updateTextAreaStates];
  [self updateLabelColors];
}

#pragma mark UITextViewDelegate

#pragma mark User Interaction

#pragma mark Catalog By Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"CIV Text Areas" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
