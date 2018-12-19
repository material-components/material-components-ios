// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextFieldSnapshotTestCase.h"
#import "MaterialTextFields.h"

@interface MDCAbstractTextFieldSnapshotTests : MDCTextFieldSnapshotTestCase

/**
 The text input controller used during testing.
 */
@property(nonatomic, strong) NSObject<MDCTextInputController> *textFieldController;

/**
 A short input text string. When rendered, it should be significantly shorter than the width of the
 text field.
 */
@property(nonatomic, copy) NSString *shortInputText;

/**
 A long input text string. When rendered, it should be significantly longer than the width of the
 text field.
 */
@property(nonatomic, copy) NSString *longInputText;

/**
 A short placeholder string. When rendered, it should be significantly shorter than the width of the
 text field.
 */
@property(nonatomic, copy) NSString *shortPlaceholderText;

/**
 A long placeholder string. When rendered, it should be significantly longer than the width of the
 text field.
 */
@property(nonatomic, copy) NSString *longPlaceholderText;

/**
 A short helper string. When rendered, it should be significantly shorter than the width of the text
 field.
 */
@property(nonatomic, copy) NSString *shortHelperText;

/**
 A long helper string. When rendered, it should be significantly longer than the width of the text
 field.
 */
@property(nonatomic, copy) NSString *longHelperText;

/**
 A short error string. When rendered, it should be significantly shorter than the width of the text
 field.
 */
@property(nonatomic, copy) NSString *shortErrorText;

/**
 A long error string. When rendered, it should be significantly longer than the width of the text
 field.
 */
@property(nonatomic, copy) NSString *longErrorText;

@end
