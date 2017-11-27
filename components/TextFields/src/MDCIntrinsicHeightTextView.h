/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

/**
 This differs from UITextView in only one way: the intrinsicContentSize's height will never be
 UIViewNoIntrinsicMetric (-1). If [super intrinsicContentSize].height == -1, return the
 contentSize's height.

 NOTE: UITextView is a subclass of UIScrollView. That's why it has a contentSize.
 */

@interface MDCIntrinsicHeightTextView : UITextView

@end
