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
#import <UIKit/UIKit.h>

#import "MDCChipFieldDelegate.h"
#import "MDCChipView.h"
#import "MDCChipViewDeleteButton.h"
#import <MDFInternationalization/MDFRTL.h>

NSString *const MDCEmptyTextString = @"";
NSString *const MDCChipDelimiterSpace = @" ";
NSString *const MDCChipFieldDidSetTextNotification = @"MDCChipFieldDidSetTextNotification";

/** Key for name of ChipField custom accessibility action that deletes a Chip. */
static NSString *const kAccessibilityActionDeleteNameKey = @"ChipFieldAccessibilityActionDelete";
/** The name of the accessibility table for localizations. */
static NSString *const kLocalizationAccessibilityTableName = @"Chips";
/** The name of the bundle. */
static NSString *const kBundle = @"Chips.bundle";

static const CGFloat MDCChipFieldDefaultFontSize = 14;
static const CGFloat MDCChipFieldHorizontalInset = 15;
static const CGFloat MDCChipFieldVerticalInset = 8;
static const CGFloat MDCChipFieldHorizontalMargin = 8;
static const CGFloat MDCChipFieldVerticalMargin = 8;
static const UIEdgeInsets MDCChipFieldTextFieldTextInsetsDefault = {16, 4, 16, 0};
static const UIKeyboardType MDCChipFieldDefaultKeyboardType = UIKeyboardTypeEmailAddress;

const CGFloat MDCChipFieldDefaultMinTextFieldWidth = 44;
const UIEdgeInsets MDCChipFieldDefaultContentEdgeInsets = {
    MDCChipFieldVerticalInset, MDCChipFieldHorizontalInset, MDCChipFieldVerticalInset,
    MDCChipFieldHorizontalInset};

@protocol MDCChipFieldTextFieldDelegate <NSObject>

- (void)textFieldDidDelete:(UITextField *)textField;

@end

@interface MDCChipFieldTextField : UITextField

@property(nonatomic, weak) id<MDCChipFieldTextFieldDelegate> deletionDelegate;

@property(nonatomic) UIEdgeInsets textFieldTextInsets;

@end

@implementation MDCChipFieldTextField

- (BOOL)isRTL {
  return self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

- (UIEdgeInsets)textEdgeInsets {
  return [self isRTL] ? UIEdgeInsetsMake(_textFieldTextInsets.top, _textFieldTextInsets.right,
                                         _textFieldTextInsets.bottom, _textFieldTextInsets.left)
                      : _textFieldTextInsets;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
  return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, [self textEdgeInsets])];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, [self textEdgeInsets])];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
  return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, [self textEdgeInsets])];
}

#pragma mark UIKeyInput

- (void)deleteBackward {
  if ([self.delegate respondsToSelector:@selector(textFieldDidDelete:)] && self.text.length == 0) {
    [self.deletionDelegate textFieldDidDelete:self];
  }
  [super deleteBackward];
}

- (CGRect)accessibilityFrame {
  CGRect frame = [super accessibilityFrame];
  UIEdgeInsets textEdgeInsets = [self textEdgeInsets];
  return CGRectMake(frame.origin.x + textEdgeInsets.left, frame.origin.y,
                    frame.size.width - textEdgeInsets.left, frame.size.height);
}

- (void)setText:(NSString *)text {
  [super setText:text];

  if (!self.isFirstResponder) {
    [[NSNotificationCenter defaultCenter] postNotificationName:MDCChipFieldDidSetTextNotification
                                                        object:self];
  }
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
  [super setAttributedText:attributedText];

  if (!self.isFirstResponder) {
    [[NSNotificationCenter defaultCenter] postNotificationName:MDCChipFieldDidSetTextNotification
                                                        object:self];
  }
}

@end

@interface MDCChipField () <MDCChipFieldTextFieldDelegate, UITextFieldDelegate>
@property(nullable, nonatomic, copy) NSString *accessibilityActionDeleteChipName;
@end

@implementation MDCChipField {
  NSMutableArray<MDCChipView *> *_chips;
  NSAttributedString *_attributedPlaceholder;
  NSAttributedString *_emptyAttributedString;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCChipFieldInit];

    _chips = [NSMutableArray array];

    _emptyAttributedString = [[NSAttributedString alloc] initWithString:@""
                                                             attributes:_placeholderAttributes];

    MDCChipFieldTextField *chipFieldTextField =
        [[MDCChipFieldTextField alloc] initWithFrame:self.bounds];
    chipFieldTextField.adjustsFontForContentSizeCategory = YES;
    UIFont *defaultFont = [UIFont systemFontOfSize:MDCChipFieldDefaultFontSize];
    UIFont *scaledDefaultFont = [UIFontMetrics.defaultMetrics scaledFontForFont:defaultFont];
    chipFieldTextField.font = scaledDefaultFont;
    chipFieldTextField.delegate = self;
    chipFieldTextField.deletionDelegate = self;
    chipFieldTextField.accessibilityTraits = UIAccessibilityTraitNone;
    chipFieldTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    chipFieldTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    chipFieldTextField.keyboardType = MDCChipFieldDefaultKeyboardType;
    chipFieldTextField.textFieldTextInsets = MDCChipFieldTextFieldTextInsetsDefault;
    // Listen for notifications posted when the text field is the first responder.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:chipFieldTextField];
    // Also listen for notifications posted when the text field is not the first responder.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange)
                                                 name:MDCChipFieldDidSetTextNotification
                                               object:chipFieldTextField];
    [self addSubview:chipFieldTextField];
    [self updateTextFieldPlaceholderText];
    _textField = chipFieldTextField;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCChipFieldInit];
    [self updateTextFieldPlaceholderText];
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
  _textFieldLeadingPaddingWhenChipIsAdded = 0;
  _textFieldTextInsets = MDCChipFieldTextFieldTextInsetsDefault;

  [self configureLocalizedAccessibilityActionName];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect standardizedBounds = CGRectStandardize(self.bounds);

  BOOL isRTL =
      self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;

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

  [self invalidateIntrinsicContentSize];

  if (heightChanged && [self.delegate respondsToSelector:@selector(chipFieldHeightDidChange:)]) {
    [self.delegate chipFieldHeightDidChange:self];
  }
}

- (void)updateTextFieldPlaceholderText {
  // There should be no placeholder if showPlaceholderWithChips is NO and there are chips.
  if (!self.showPlaceholderWithChips && self.chips.count > 0) {
    self.textField.attributedPlaceholder = _emptyAttributedString;
  } else if (_attributedPlaceholder) {
    self.textField.attributedPlaceholder = _attributedPlaceholder;
  } else {
    self.textField.placeholder = _placeholder;
  }
  [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize {
  CGFloat minWidth =
      MAX(self.minTextFieldWidth + self.contentEdgeInsets.left + self.contentEdgeInsets.right,
          CGRectGetWidth(self.bounds));
  return [self sizeThatFits:CGSizeMake(minWidth, CGFLOAT_MAX)];
}

- (void)setPlaceholder:(NSString *)string {
  if (string == nil || string.length == 0) {
    _placeholder = nil;
    _attributedPlaceholder = nil;
  } else {
    _placeholder = [string copy];
    // If `placeholderAttributes` is nil, create and set one with a default color.
    if (!_placeholderAttributes) {
      _placeholderAttributes = @{NSForegroundColorAttributeName : UIColor.placeholderTextColor};
    }

    NSAttributedString *attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:string attributes:_placeholderAttributes];
    _attributedPlaceholder = attributedPlaceholder;
  }

  [self updateTextFieldPlaceholderText];
}

- (void)setPlaceholderAttributes:(NSDictionary<NSAttributedStringKey, id> *)placeholderAttributes {
  // If `placeholderAttributes` parameter is not nil, make a mutable copy of it.
  if (placeholderAttributes) {
    NSMutableDictionary<NSAttributedStringKey, id> *mutableAttributes =
        [placeholderAttributes mutableCopy];
    // If no font name is passed in, use the current text field's font name.
    // Other key:value pairs are overwritten by the new placeholder attributes.
    if (!mutableAttributes[NSFontAttributeName]) {
      mutableAttributes[NSFontAttributeName] = _textField.font;
    }
    _placeholderAttributes = mutableAttributes;
  } else {
    _placeholderAttributes = @{NSForegroundColorAttributeName : UIColor.placeholderTextColor};
  }

  if (_placeholder) {
    NSAttributedString *attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:_placeholder attributes:_placeholderAttributes];

    _attributedPlaceholder = attributedPlaceholder;
  }

  _emptyAttributedString = [[NSAttributedString alloc] initWithString:@""
                                                           attributes:_placeholderAttributes];

  [self updateTextFieldPlaceholderText];
}

- (void)setTextFieldTextInsets:(UIEdgeInsets)textFieldTextInsets {
  _textFieldTextInsets = textFieldTextInsets;
  if ([_textField isKindOfClass:[MDCChipFieldTextField class]]) {
    ((MDCChipFieldTextField *)self.textField).textFieldTextInsets = _textFieldTextInsets;
  }
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
  if (self.showChipsDeleteButton) {
    [self addClearButtonToChip:chip];

    // Set Chip's accessibilityTraits to `UIAccessibilityTraitNone` if there is a `clearButton`.
    // A11y compliance is handled by a UIAccessibilityCustomAction.
    chip.accessibilityTraits = UIAccessibilityTraitNone;

    __weak __typeof__(self) weakSelf = self;
    __weak MDCChipView *weakChip = chip;

    UIAccessibilityCustomActionHandler actionHandler =
        ^BOOL(UIAccessibilityCustomAction *__unused customAction) {
          __typeof__(self) strongSelf = weakSelf;
          MDCChipView *strongChip = weakChip;
          if (strongSelf) {
            [strongSelf removeChip:strongChip];
          }
          return YES;
        };

    UIAccessibilityCustomAction *action =
        [[UIAccessibilityCustomAction alloc] initWithName:_accessibilityActionDeleteChipName
                                            actionHandler:actionHandler];

    chip.accessibilityCustomActions = @[ action ];
  }

  [_chips addObject:chip];
  [self addChipSubview:chip];
  if ([self.delegate respondsToSelector:@selector(chipField:didAddChip:)]) {
    [self.delegate chipField:self didAddChip:chip];
  }

  [self updateTextFieldPlaceholderText];
  [self.textField setNeedsLayout];
  [self setNeedsLayout];
}

- (void)removeChip:(MDCChipView *)chip {
  [_chips removeObject:chip];
  [self removeChipSubview:chip];
  if ([self.delegate respondsToSelector:@selector(chipField:didRemoveChip:)]) {
    [self.delegate chipField:self didRemoveChip:chip];
  }
  [self updateTextFieldPlaceholderText];
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

#pragma mark - Chip selection

- (void)didTapChipWithGestureRecognizer:(UITapGestureRecognizer *)gesture {
  if (![gesture.view isKindOfClass:[MDCChipView class]]) {
    return;
  }
  MDCChipView *chipView = (MDCChipView *)gesture.view;
  chipView.selected = !chipView.selected;
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

    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(didTapChipWithGestureRecognizer:)];
    [chip addGestureRecognizer:tapGesture];

    chip.titleLabel.text = strippedTitle;
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
  if (self.deleteButtonImage) {
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    [clearButton setImage:self.deleteButtonImage forState:UIControlStateNormal];
    chip.accessoryView = clearButton;
    [clearButton addTarget:self
                    action:@selector(deleteChip:)
          forControlEvents:UIControlEventTouchUpInside];
  } else {
    MDCChipViewDeleteButton *clearButton = [[MDCChipViewDeleteButton alloc] init];
    chip.accessoryView = clearButton;
    [clearButton addTarget:self
                    action:@selector(deleteChip:)
          forControlEvents:UIControlEventTouchUpInside];
  }
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

- (void)textFieldDidDelete:(UITextField *)textField {
  // If backspacing on an empty text field without a chip selected, select the last chip.
  // If backspacing on an empty text field with a selected chip, delete the selected chip.
  if (textField.text.length == 0) {
    if ([self isAnyChipSelected]) {
      [self removeSelectedChips];
      [self deselectAllChips];
      [self updateTextFieldPlaceholderText];
    } else {
      [self selectLastChip];
    }
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  BOOL shouldBeginEditing = YES;
  if ([self.delegate respondsToSelector:@selector(chipFieldShouldBeginEditing:)]) {
    shouldBeginEditing = [self.delegate chipFieldShouldBeginEditing:self];
  }
  return shouldBeginEditing;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  BOOL shouldEndEditing = YES;
  if ([self.delegate respondsToSelector:@selector(chipFieldShouldEndEditing:)]) {
    shouldEndEditing = [self.delegate chipFieldShouldEndEditing:self];
  }
  return shouldEndEditing;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField == self.textField) {
    [self deselectAllChips];
  }
  if ([self.delegate respondsToSelector:@selector(chipFieldDidBeginEditing:)]) {
    [self.delegate chipFieldDidBeginEditing:self];
  }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  if ((self.delimiter & MDCChipFieldDelimiterDidEndEditing) == MDCChipFieldDelimiterDidEndEditing) {
    if (textField == self.textField) {
      [self commitInput];
    }
  }
  if ([self.delegate respondsToSelector:@selector(chipFieldDidEndEditing:)]) {
    [self.delegate chipFieldDidEndEditing:self];
  }
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
        CGRectGetMidY(self.textField.frame) >= CGRectGetMinY(lastChipFrame) &&
        CGRectGetMidY(self.textField.frame) < CGRectGetMaxY(lastChipFrame);
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

  if (_textField.text.length == 0) {
    [self updateTextFieldPlaceholderText];
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
    originX += CGRectGetMaxX(lastChipFrame) + MDCChipFieldHorizontalMargin +
               _textFieldLeadingPaddingWhenChipIsAdded;
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

  UIFont *font = self.textField.font;
  CGRect desiredRect = [self.textField.text
      boundingRectWithSize:CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric)
                   options:NSStringDrawingUsesLineFragmentOrigin
                attributes:@{
                  NSFontAttributeName : font,
                }
                   context:nil];
  return MAX(placeholderDesiredWidth, CGRectGetWidth(desiredRect) + MDCChipFieldHorizontalMargin +
                                          self.contentEdgeInsets.right +
                                          [MDCChipViewDeleteButton imageSideLength]);
}

- (CGFloat)placeholderDesiredWidth {
  NSString *placeholder = self.textField.placeholder;
  if (!self.showPlaceholderWithChips && self.chips.count > 0) {
    placeholder = nil;
  }

  if (placeholder.length == 0) {
    return self.minTextFieldWidth;
  }

  UIFont *placeholderFont = _placeholderAttributes[NSFontAttributeName];

  if (!placeholderFont) {
    placeholderFont = self.textField.font;
  }

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

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self.textField setNeedsLayout];
  [self setNeedsLayout];
}

// Sets the localized accessibility action name for deleting a Chip.
- (void)configureLocalizedAccessibilityActionName {
  NSBundle *resourceBundle = [[self class] bundle];
  _accessibilityActionDeleteChipName =
      [resourceBundle localizedStringForKey:kAccessibilityActionDeleteNameKey
                                      value:@"Delete"
                                      table:kLocalizationAccessibilityTableName];
}

#pragma mark - Resource Bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCChipField class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}
@end
