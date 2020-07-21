// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCChipField.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCChipFieldDelegate.h"
#import "MaterialTextFields.h"
#import "MaterialMath.h"

NSString *const MDCEmptyTextString = @"";
NSString *const MDCChipDelimiterSpace = @" ";

static const CGFloat MDCChipFieldHorizontalInset = 15;
static const CGFloat MDCChipFieldVerticalInset = 8;
static const CGFloat MDCChipFieldIndent = 4;
static const CGFloat MDCChipFieldHorizontalMargin = 8;
static const CGFloat MDCChipFieldVerticalMargin = 8;
static const CGFloat MDCChipFieldClearButtonSquareWidthHeight = 24;
static const CGFloat MDCChipFieldClearImageSquareWidthHeight = 18;
static const UIKeyboardType MDCChipFieldDefaultKeyboardType = UIKeyboardTypeEmailAddress;

const CGFloat MDCChipFieldDefaultMinTextFieldWidth = 44;
const UIEdgeInsets MDCChipFieldDefaultContentEdgeInsets = {
    MDCChipFieldVerticalInset, MDCChipFieldHorizontalInset, MDCChipFieldVerticalInset,
    MDCChipFieldHorizontalInset};

@protocol MDCChipFieldTextFieldDelegate <NSObject>

- (void)textFieldShouldRespondToDeleteBackward:(UITextField *)textField;

@end

@interface MDCChipFieldTextField : MDCTextField

@property(nonatomic, weak) id<MDCChipFieldTextFieldDelegate> deletionDelegate;

@end

@implementation MDCChipFieldTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = [super textRectForBounds:bounds];
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    textRect = MDFRectFlippedHorizontally(textRect, CGRectGetWidth(self.bounds));
    textRect.origin.x += 5;
  }
  return textRect;
}

#pragma mark UIKeyInput

- (void)deleteBackward {
  if (self.text.length == 0) {
    [self.deletionDelegate textFieldShouldRespondToDeleteBackward:self];
  }
  [super deleteBackward];
}

#if MDC_CHIPFIELD_PRIVATE_API_BUG_FIX && \
    !(defined(__IPHONE_8_3) && (__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_3))

// WARNING: This is a private method, see the warning in MDCChipField.h.
// This is only compiled if you explicitly defined MDC_CHIPFIELD_PRIVATE_API_BUG_FIX yourself, and
// you are targeting an iOS version less than 8.3.
- (BOOL)keyboardInputShouldDelete:(UITextField *)textField {
  BOOL shouldDelete = YES;
  if ([UITextField instancesRespondToSelector:_cmd]) {
    // clang-format off
    BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) =
        (BOOL(*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];
    // clang-format on
    if (keyboardInputShouldDelete) {
      shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
      NSOperatingSystemVersion minimumVersion = {8, 0, 0};
      NSOperatingSystemVersion maximumVersion = {8, 3, 0};
      NSProcessInfo *processInfo = [NSProcessInfo processInfo];
      BOOL isIos8 = [processInfo isOperatingSystemAtLeastVersion:minimumVersion];
      BOOL isLessThanIos8_3 = ![processInfo isOperatingSystemAtLeastVersion:maximumVersion];
      if (![textField.text length] && isIos8 && isLessThanIos8_3) {
        [self deleteBackward];
      }
    }
  }
  return shouldDelete;
}

#endif

#pragma mark - UIAccessibility

- (CGRect)accessibilityFrame {
  CGRect frame = [super accessibilityFrame];
  return CGRectMake(frame.origin.x + self.textInsets.left, frame.origin.y,
                    frame.size.width - self.textInsets.left, frame.size.height);
}

@end

@interface MDCChipField () <MDCChipFieldTextFieldDelegate,
                            MDCTextInputPositioningDelegate,
                            UITextFieldDelegate>
@end

@implementation MDCChipField {
  NSMutableArray<MDCChipView *> *_chips;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCChipFieldInit];

    _chips = [NSMutableArray array];

    MDCChipFieldTextField *chipFieldTextField =
        [[MDCChipFieldTextField alloc] initWithFrame:self.bounds];
    chipFieldTextField.underline.hidden = YES;
    chipFieldTextField.delegate = self;
    chipFieldTextField.deletionDelegate = self;
    chipFieldTextField.positioningDelegate = self;
    chipFieldTextField.accessibilityTraits = UIAccessibilityTraitNone;
    chipFieldTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    chipFieldTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    chipFieldTextField.keyboardType = MDCChipFieldDefaultKeyboardType;
    // Listen for notifications posted when the text field is the first responder.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:chipFieldTextField];
    // Also listen for notifications posted when the text field is not the first responder.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange)
                                                 name:MDCTextFieldTextDidSetTextNotification
                                               object:chipFieldTextField];
    [self addSubview:chipFieldTextField];
    _textField = chipFieldTextField;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCChipFieldInit];
  }
  return self;
}

- (void)commonMDCChipFieldInit {
  _chips = [NSMutableArray array];
  _delimiter = MDCChipFieldDelimiterDefault;
  _minTextFieldWidth = MDCChipFieldDefaultMinTextFieldWidth;
  _contentEdgeInsets = MDCChipFieldDefaultContentEdgeInsets;
  _showPlaceholderWithChips = YES;
  _chipHeight = 32;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect standardizedBounds = CGRectStandardize(self.bounds);

  BOOL isRTL =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;

  // Calculate the frames for all the chips and set them.
  NSArray *chipFrames = [self chipFramesForSize:standardizedBounds.size];
  for (NSUInteger index = 0; index < _chips.count; index++) {
    MDCChipView *chip = _chips[index];

    CGRect chipFrame = [chipFrames[index] CGRectValue];
    if (isRTL) {
      chipFrame = MDFRectFlippedHorizontally(chipFrame, CGRectGetWidth(self.bounds));
    }
    chip.frame = chipFrame;
  }

  // Get the last chip frame and calculate the text field frame from that.
  CGRect lastChipFrame = [chipFrames.lastObject CGRectValue];
  CGRect textFieldFrame = [self frameForTextFieldForLastChipFrame:lastChipFrame
                                                    chipFieldSize:standardizedBounds.size];
  if (isRTL) {
    textFieldFrame = MDFRectFlippedHorizontally(textFieldFrame, CGRectGetWidth(self.bounds));
  }
  BOOL heightChanged = CGRectGetMinY(textFieldFrame) != CGRectGetMinY(self.textField.frame);
  self.textField.frame = textFieldFrame;

  [self updateTextFieldPlaceholderText];
  [self invalidateIntrinsicContentSize];

  if (heightChanged && [self.delegate respondsToSelector:@selector(chipFieldHeightDidChange:)]) {
    [self.delegate chipFieldHeightDidChange:self];
  }
}

- (void)updateTextFieldPlaceholderText {
  // Place holder label should be hidden if showPlaceholderWithChips is NO and there are chips.
  // MDCTextField sets the placeholderLabel opacity to 0 if the text field has no text.
  self.textField.placeholderLabel.hidden = (!self.showPlaceholderWithChips && self.chips.count > 0);
}

+ (UIFont *)textFieldFont {
  return [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

- (CGSize)intrinsicContentSize {
  CGFloat minWidth =
      MAX(self.minTextFieldWidth + self.contentEdgeInsets.left + self.contentEdgeInsets.right,
          CGRectGetWidth(self.bounds));
  return [self sizeThatFits:CGSizeMake(minWidth, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFits:(CGSize)size {
  NSArray *chipFrames = [self chipFramesForSize:size];
  CGRect lastChipFrame = [chipFrames.lastObject CGRectValue];
  CGRect textFieldFrame = [self frameForTextFieldForLastChipFrame:lastChipFrame chipFieldSize:size];

  // Calculate the required size off the text field.
  // To properly apply bottom inset: Calculate what would be the height if there were a chip
  // instead of the text field. Then add the bottom inset.
  CGFloat height = CGRectGetMaxY(textFieldFrame) + self.contentEdgeInsets.bottom +
                   (self.chipHeight - textFieldFrame.size.height) / 2;
  CGFloat width = MAX(size.width, self.minTextFieldWidth);

  return CGSizeMake(width, height);
}

- (void)clearTextInput {
  self.textField.text = MDCEmptyTextString;
  [self updateTextFieldPlaceholderText];
}

- (void)setChips:(NSArray<MDCChipView *> *)chips {
  if ([_chips isEqual:chips]) {
    return;
  }

  for (MDCChipView *chip in _chips) {
    [self removeChipSubview:chip];
  }

  _chips = [chips mutableCopy];
  for (MDCChipView *chip in _chips) {
    [self addChipSubview:chip];
  }
  [self setNeedsLayout];
}

- (NSArray<MDCChipView *> *)chips {
  return [NSArray arrayWithArray:_chips];
}

- (BOOL)becomeFirstResponder {
  return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
  [super resignFirstResponder];
  return [self.textField resignFirstResponder];
}

- (void)addChip:(MDCChipView *)chip {
  // Note that |chipField:shouldAddChip| is only called in |createNewChipFromInput| when it is
  // necessary to restrict chip creation based on input text generated in the user interface.
  // Clients calling |addChip| directly programmatically are expected to handle such restrictions
  // themselves rather than using |chipField:shouldAddChip| to prevent chips from being added.
  [_chips addObject:chip];
  [self addChipSubview:chip];
  if ([self.delegate respondsToSelector:@selector(chipField:didAddChip:)]) {
    [self.delegate chipField:self didAddChip:chip];
  }

  [self.textField setNeedsLayout];
  [self setNeedsLayout];
}

- (void)removeChip:(MDCChipView *)chip {
  [_chips removeObject:chip];
  [self removeChipSubview:chip];
  if ([self.delegate respondsToSelector:@selector(chipField:didRemoveChip:)]) {
    [self.delegate chipField:self didRemoveChip:chip];
  }
  [self.textField setNeedsLayout];
  [self setNeedsLayout];
}

- (void)removeSelectedChips {
  NSMutableArray *chipsToRemove = [NSMutableArray array];
  for (MDCChipView *chip in self.chips) {
    if (chip.isSelected) {
      [chipsToRemove addObject:chip];
    }
  }
  for (MDCChipView *chip in chipsToRemove) {
    [self removeChip:chip];
  }
}

- (void)selectChip:(MDCChipView *)chip {
  [self deselectAllChipsExceptChip:chip];
  chip.selected = YES;
}

- (void)selectLastChip {
  MDCChipView *lastChip = self.chips.lastObject;
  [self deselectAllChipsExceptChip:lastChip];
  lastChip.selected = YES;
  UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                  [lastChip accessibilityLabel]);
}

- (void)deselectAllChips {
  [self deselectAllChipsExceptChip:nil];
}

- (void)deselectAllChipsExceptChip:(MDCChipView *)chip {
  for (MDCChipView *otherChip in self.chips) {
    if (chip != otherChip) {
      otherChip.selected = NO;
    }
  }
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
  if (!UIEdgeInsetsEqualToEdgeInsets(_contentEdgeInsets, contentEdgeInsets)) {
    _contentEdgeInsets = contentEdgeInsets;
    [self setNeedsLayout];
  }
}

- (void)setMinTextFieldWidth:(CGFloat)minTextFieldWidth {
  if (_minTextFieldWidth != minTextFieldWidth) {
    _minTextFieldWidth = minTextFieldWidth;
    [self setNeedsLayout];
  }
}

- (void)commitInput {
  if (![self isTextFieldEmpty]) {
    [self createNewChipFromInput];
  }
}

- (void)createNewChipFromInput {
  NSString *strippedTitle = [self.textField.text
      stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  if (strippedTitle.length > 0) {
    MDCChipView *chip = [[MDCChipView alloc] init];
    chip.titleLabel.text = strippedTitle;
    if (self.showChipsDeleteButton) {
      [self addClearButtonToChip:chip];
    }
    BOOL shouldAddChip = YES;
    if ([self.delegate respondsToSelector:@selector(chipField:shouldAddChip:)]) {
      shouldAddChip = [self.delegate chipField:self shouldAddChip:chip];
    }
    if (shouldAddChip) {
      [self addChip:chip];
      [self clearTextInput];
    }
  } else {
    [self clearTextInput];
  }
}

- (void)addClearButtonToChip:(MDCChipView *)chip {
  UIControl *clearButton = [[UIControl alloc] init];
  CGFloat clearButtonWidthAndHeight = MDCChipFieldClearButtonSquareWidthHeight;
  clearButton.frame = CGRectMake(0, 0, clearButtonWidthAndHeight, clearButtonWidthAndHeight);
  clearButton.layer.cornerRadius = clearButtonWidthAndHeight / 2;
  UIImageView *clearImageView = [[UIImageView alloc] initWithImage:[self drawClearButton]];
  CGFloat widthAndHeight = MDCChipFieldClearImageSquareWidthHeight;
  CGFloat padding =
      (MDCChipFieldClearButtonSquareWidthHeight - MDCChipFieldClearImageSquareWidthHeight) / 2;
  clearImageView.frame = CGRectMake(padding, padding, widthAndHeight, widthAndHeight);
  clearButton.tintColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6];
  [clearButton addSubview:clearImageView];
  chip.accessoryView = clearButton;
  [clearButton addTarget:self
                  action:@selector(deleteChip:)
        forControlEvents:UIControlEventTouchUpInside];
}

- (UIImage *)drawClearButton {
  CGSize clearButtonSize =
      CGSizeMake(MDCChipFieldClearImageSquareWidthHeight, MDCChipFieldClearImageSquareWidthHeight);

  CGRect bounds = CGRectMake(0, 0, clearButtonSize.width, clearButtonSize.height);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0);
  [UIColor.grayColor setFill];
  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

static inline UIBezierPath *MDCPathForClearButtonImageFrame(CGRect frame) {
  // GENERATED CODE

  CGRect innerBounds =
      CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2,
                 MDCFloor((frame.size.width - 2) * (CGFloat)0.90909 + (CGFloat)0.5),
                 MDCFloor((frame.size.height - 2) * (CGFloat)0.90909 + (CGFloat)0.5));
  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) +
                                             (CGFloat)0.50000 * innerBounds.size.width,
                                         CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path closePath];
  [ic_clear_path
      moveToPoint:CGPointMake(
                      CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                      CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.45367 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.45367 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.54800 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.54800 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

- (void)deleteChip:(id)sender {
  UIControl *deleteButton = (UIControl *)sender;
  MDCChipView *chip = (MDCChipView *)deleteButton.superview;
  [self removeChip:chip];
  [self clearTextInput];
}

- (void)chipTapped:(id)sender {
  BOOL shouldBecomeFirstResponder = YES;
  if ([self.delegate respondsToSelector:@selector(chipFieldShouldBecomeFirstResponder:)]) {
    shouldBecomeFirstResponder = [self.delegate chipFieldShouldBecomeFirstResponder:self];
  }
  if (shouldBecomeFirstResponder) {
    [self becomeFirstResponder];
  }
  MDCChipView *chip = (MDCChipView *)sender;
  if ([self.delegate respondsToSelector:@selector(chipField:didTapChip:)]) {
    [self.delegate chipField:self didTapChip:chip];
  }
}

#pragma mark - MDCChipFieldTextFieldDelegate

- (void)textFieldShouldRespondToDeleteBackward:(UITextField *)textField {
  if ([self isAnyChipSelected]) {
    [self removeSelectedChips];
    [self deselectAllChips];
  } else {
    [self selectLastChip];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  BOOL shouldBeginEditing = YES;
  if ([self.delegate respondsToSelector:@selector(chipFieldShouldBeginEditing:)]) {
    shouldBeginEditing = [self.delegate chipFieldShouldBeginEditing:self];
  }
  if (shouldBeginEditing) {
    if (textField == self.textField) {
      [self deselectAllChips];
    }
    if ([self.delegate respondsToSelector:@selector(chipFieldDidBeginEditing:)]) {
      [self.delegate chipFieldDidBeginEditing:self];
    }
  }
  return shouldBeginEditing;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  if ((self.delimiter & MDCChipFieldDelimiterDidEndEditing) == MDCChipFieldDelimiterDidEndEditing) {
    if (textField == self.textField) {
      [self commitInput];
    }
  }
  if ([self.delegate respondsToSelector:@selector(chipFieldDidEndEditing:)]) {
    [self.delegate chipFieldDidEndEditing:self];
  }
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  BOOL shouldReturn = YES;

  // Chip field content view will handle |chipFieldShouldReturn| if the client is not using chip
  // field directly. If the client uses chip field directly without the content view and has not
  // implemented |chipFieldShouldReturn|, then a chip should always be created.
  if ([self.delegate respondsToSelector:@selector(chipFieldShouldReturn:)]) {
    shouldReturn = [self.delegate chipFieldShouldReturn:self];
  }
  if (shouldReturn) {
    [self createNewChipWithTextField:textField delimiter:MDCChipFieldDelimiterReturn];
  }

  return shouldReturn;
}

- (void)textFieldDidChange {
  [self deselectAllChips];
  [self createNewChipWithTextField:self.textField delimiter:MDCChipFieldDelimiterSpace];

  CGRect lastChipFrame = self.chips.lastObject.frame;
  if (!CGRectIsEmpty(lastChipFrame)) {
    BOOL isTextTooWide = [self textInputDesiredWidth] >= [self availableWidthForTextInput];
    BOOL isTextFieldOnSameLineAsChips =
        CGRectGetMidY(self.textField.frame) == CGRectGetMidY(lastChipFrame);
    if (isTextTooWide && isTextFieldOnSameLineAsChips) {
      // The text is on the same line as the chips and doesn't fit
      // Trigger layout to move the text field down to the next line
      [self setNeedsLayout];
    } else if (!isTextTooWide && !isTextFieldOnSameLineAsChips) {
      // The text is on the line below the chips but can fit on the same line
      // Trigger layout to move the text field up to the previous line
      [self setNeedsLayout];
    }
  }

  if ([self.delegate respondsToSelector:@selector(chipField:didChangeInput:)]) {
    [self.delegate chipField:self didChangeInput:[self.textField.text copy]];
  }
}

#pragma mark - Private

- (void)removeChipSubview:(MDCChipView *)chip {
  [chip removeFromSuperview];
  [chip removeTarget:chip.superview
                action:@selector(chipTapped:)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)addChipSubview:(MDCChipView *)chip {
  if (chip.superview != self) {
    [chip addTarget:self
                  action:@selector(chipTapped:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chip];
  }
}

- (void)createNewChipWithTextField:(UITextField *)textField
                         delimiter:(MDCChipFieldDelimiter)delimiter {
  if ((self.delimiter & delimiter) == delimiter && textField.text.length > 0) {
    if (delimiter == MDCChipFieldDelimiterReturn) {
      [self createNewChipFromInput];
    } else if (delimiter == MDCChipFieldDelimiterSpace) {
      NSString *lastChar = [textField.text substringFromIndex:textField.text.length - 1];
      if ([lastChar isEqualToString:MDCChipDelimiterSpace]) {
        [self createNewChipFromInput];
      }
    }
  }
}

- (BOOL)isAnyChipSelected {
  for (MDCChipView *chip in self.chips) {
    if (chip.isSelected) {
      return YES;
    }
  }
  return NO;
}

- (BOOL)isTextFieldEmpty {
  return self.textField.text.length == 0;
}

#pragma mark - Sizing

- (NSArray<NSValue *> *)chipFramesForSize:(CGSize)size {
  NSMutableArray *chipFrames = [NSMutableArray arrayWithCapacity:self.chips.count];
  CGFloat chipFieldMaxX = size.width - self.contentEdgeInsets.right;
  CGFloat maxWidth = size.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right;
  NSUInteger row = 0;
  CGFloat currentOriginX = self.contentEdgeInsets.left;

  for (MDCChipView *chip in self.chips) {
    CGSize chipSize = [chip sizeThatFits:CGSizeMake(maxWidth, self.chipHeight)];
    chipSize.width = MIN(chipSize.width, maxWidth);

    CGFloat availableWidth = chipFieldMaxX - currentOriginX;
    // Check if the chip will fit on the current line.  If it won't fit and the available width
    // is the maximum width, it won't fit on any line. Put it on the current one and move on.
    if (chipSize.width > availableWidth &&
        availableWidth < (chipFieldMaxX - self.contentEdgeInsets.right)) {
      row++;
      currentOriginX = self.contentEdgeInsets.left;
    }
    CGFloat currentOriginY =
        self.contentEdgeInsets.top + (row * (self.chipHeight + MDCChipFieldVerticalMargin));
    CGRect chipFrame = CGRectMake(currentOriginX, currentOriginY, chipSize.width, chipSize.height);
    [chipFrames addObject:[NSValue valueWithCGRect:chipFrame]];
    currentOriginX = CGRectGetMaxX(chipFrame) + MDCChipFieldHorizontalMargin;
  }
  return [chipFrames copy];
}

- (CGRect)frameForTextFieldForLastChipFrame:(CGRect)lastChipFrame
                              chipFieldSize:(CGSize)chipFieldSize {
  CGFloat availableWidth = [self availableWidthForTextInput];
  CGFloat textFieldHeight = [self.textField sizeThatFits:chipFieldSize].height;
  CGFloat originY = lastChipFrame.origin.y + (self.chipHeight - textFieldHeight) / 2;

  // If no chip exists, make the text field the full width, adjusted for insets.
  if (CGRectIsEmpty(lastChipFrame)) {
    originY += self.contentEdgeInsets.top;
    return CGRectMake(self.contentEdgeInsets.left, originY, availableWidth, textFieldHeight);
  }

  CGFloat originX = 0;
  CGFloat textFieldWidth = 0;
  CGFloat desiredTextWidth = [self textInputDesiredWidth];
  if (availableWidth < desiredTextWidth) {
    // The text field doesn't fit on the line with the last chip.
    originY += self.chipHeight + MDCChipFieldVerticalMargin;
    originX = self.contentEdgeInsets.left;
    textFieldWidth =
        chipFieldSize.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right;
  } else {
    // The text field fits on the line with chips
    originX += CGRectGetMaxX(lastChipFrame) + MDCChipFieldHorizontalMargin;
    textFieldWidth = availableWidth;
  }

  return CGRectMake(originX, originY, textFieldWidth, textFieldHeight);
}

- (CGFloat)availableWidthForTextInput {
  NSArray *chipFrames = [self chipFramesForSize:self.bounds.size];
  CGFloat boundsWidth = CGRectGetWidth(CGRectStandardize(self.bounds));
  if (chipFrames.count == 0) {
    return boundsWidth - (self.contentEdgeInsets.right + self.contentEdgeInsets.left);
  }

  CGRect lastChipFrame = [chipFrames.lastObject CGRectValue];
  return boundsWidth - CGRectGetMaxX(lastChipFrame) - self.contentEdgeInsets.right;
}

// The width of the text input + the clear button.
- (CGFloat)textInputDesiredWidth {
  CGFloat placeholderDesiredWidth = [self placeholderDesiredWidth];
  if (!self.textField.text || [self.textField.text isEqualToString:@""]) {
    return placeholderDesiredWidth;
  }

  UIFont *font = self.textField.placeholderLabel.font;
  CGRect desiredRect = [self.textField.text
      boundingRectWithSize:CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric)
                   options:NSStringDrawingUsesLineFragmentOrigin
                attributes:@{
                  NSFontAttributeName : font,
                }
                   context:nil];
  return MAX(placeholderDesiredWidth, CGRectGetWidth(desiredRect) + MDCChipFieldHorizontalMargin +
                                          self.contentEdgeInsets.right +
                                          MDCChipFieldClearImageSquareWidthHeight);
}

- (CGFloat)placeholderDesiredWidth {
  NSString *placeholder = self.textField.placeholder;
  if (!self.showPlaceholderWithChips && self.chips.count > 0) {
    placeholder = nil;
  }

  if (placeholder.length == 0) {
    return self.minTextFieldWidth;
  }

  UIFont *placeholderFont = self.textField.placeholderLabel.font;
  CGRect placeholderDesiredRect =
      [placeholder boundingRectWithSize:CGRectStandardize(self.bounds).size
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                               NSFontAttributeName : placeholderFont,
                             }
                                context:nil];
  CGFloat placeholderDesiredWidth =
      CGRectGetWidth(placeholderDesiredRect) + self.contentEdgeInsets.right;
  return MAX(placeholderDesiredWidth, self.minTextFieldWidth);
}

#pragma mark - MDCTextInputPositioningDelegate

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets
    withSizeThatFitsWidthHint:(CGFloat)widthHint {
  defaultInsets.left = MDCChipFieldIndent;
  return defaultInsets;
}

#pragma mark - UIAccessibilityContainer

- (BOOL)isAccessibilityElement {
  return NO;
}

- (id)accessibilityElementAtIndex:(NSInteger)index {
  if (index < (NSInteger)self.chips.count) {
    return self.chips[index];
  } else if (index == (NSInteger)self.chips.count) {
    return self.textField;
  }

  return nil;
}

- (NSInteger)accessibilityElementCount {
  return self.chips.count + 1;
}

- (NSInteger)indexOfAccessibilityElement:(id)element {
  if (element == self.textField) {
    return self.chips.count;
  }

  return [self.chips indexOfObject:element];
}

#pragma mark - Accessibility

- (void)focusTextFieldForAccessibility {
  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.textField);
}

@end
