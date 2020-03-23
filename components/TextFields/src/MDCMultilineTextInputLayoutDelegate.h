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

#import <UIKit/UIKit.h>

@protocol MDCMultilineTextInput;

@protocol MDCMultilineTextInputLayoutDelegate <NSObject>

@optional
/**
 Notifies the delegate that the text field's content size changed, requiring the size provided for
 best display.

 If using auto layout, this method is unnecessary; this is a way for views not implementing auto
 layout to know when to grow and shrink height to accomodate changes in content.

 @param multilineTextField  The text field for which the content size changed.
 @param size                The size required by the text view to fit all of its content.
 */
- (void)multilineTextField:(id<MDCMultilineTextInput> _Nonnull)multilineTextField
      didChangeContentSize:(CGSize)size;

@end
